import os

import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["APPROVAL_TABLE_NAME"])
ecs = boto3.client("ecs")


def revision_id_from_event(event):
    # Same numeric id as the "ecs-svc/<id>" deployment id CI sees from
    # update-service - one item per deployment, so there's nothing to reset
    # or race: the row simply doesn't exist until the deploy step creates it.
    revision_arn = event["executionDetails"]["targetServiceRevisionArn"]
    return revision_arn.rsplit("/", 1)[-1]


def has_prior_revision_running(service_arn, candidate_revision_id):
    # service_arn: arn:aws:ecs:region:account:service/cluster-name/service-name
    _, cluster_name, service_name = service_arn.split(":")[-1].split("/")
    service = ecs.describe_services(cluster=cluster_name, services=[service_name])["services"][0]
    return any(
        d["id"].rsplit("/", 1)[-1] != candidate_revision_id and d.get("runningCount", 0) > 0
        for d in service["deployments"]
    )


def handler(event, context):
    """ECS deployment lifecycle hook: pauses (via IN_PROGRESS polling) until a
    human flips this deployment's DynamoDB item to APPROVED or REJECTED.

    If no other revision of the service is currently running (e.g. the
    service's first-ever deployment), there's no existing production traffic
    to protect, so the gate is pointless - skip straight to SUCCEEDED.

    See: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/lambda-lifecycle-hooks.html
    """
    stage = event.get("lifecycleStage")
    revision_id = revision_id_from_event(event)

    if not has_prior_revision_running(event["executionDetails"]["serviceArn"], revision_id):
        print(f"[{stage}] revision {revision_id}: no other revision running, nothing to protect - auto-approving")
        return {"hookStatus": "SUCCEEDED"}

    item = table.get_item(Key={"revision_id": revision_id}).get("Item")
    status = item["status"] if item else "PENDING"
    print(f"[{stage}] revision {revision_id} status={status}")

    if status == "APPROVED":
        return {"hookStatus": "SUCCEEDED"}
    if status == "REJECTED":
        return {"hookStatus": "FAILED"}

    return {"hookStatus": "IN_PROGRESS", "callBackDelay": 30}
