# One item per deployment, keyed by the numeric revision id (the trailing
# path segment shared by both `deployments[].id` seen by CI - after the
# "ecs-svc/" prefix - and the lifecycle hook event's
# executionDetails.targetServiceRevisionArn seen by the Lambda). Because
# every deployment gets its own item, there's no shared mutable state to
# race on and no "is this the first invocation" reset logic needed at all.
resource "aws_dynamodb_table" "deploy_approval" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  name         = "${module.label.id}-deploy-approval"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "revision_id"

  attribute {
    name = "revision_id"
    type = "S"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  tags = module.label.tags
}

data "archive_file" "deploy_gate_lambda" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  type        = "zip"
  source_file = "${path.module}/lambda-deploy-gate/handler.py"
  output_path = "${path.module}/lambda-deploy-gate/handler.zip"
}

resource "aws_iam_role" "deploy_gate_lambda_exec" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  name = "${module.label.id}-deploy-gate-exec"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })

  tags = module.label.tags
}

resource "aws_iam_role_policy_attachment" "deploy_gate_lambda_exec" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  role       = aws_iam_role.deploy_gate_lambda_exec[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "deploy_gate_lambda_dynamodb" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  name = "${module.label.id}-deploy-gate-dynamodb"
  role = aws_iam_role.deploy_gate_lambda_exec[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["dynamodb:GetItem"]
      Resource = aws_dynamodb_table.deploy_approval[0].arn
    }]
  })
}

# Lets the hook check whether any OTHER revision of the service is currently
# running, so it can skip the approval gate entirely when there's no prior
# production revision to protect (e.g. the service's first-ever deployment).
resource "aws_iam_role_policy" "deploy_gate_lambda_ecs" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  name = "${module.label.id}-deploy-gate-ecs"
  role = aws_iam_role.deploy_gate_lambda_exec[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ecs:DescribeServices"]
      Resource = module.task.service_arn
    }]
  })
}

resource "aws_lambda_function" "deploy_gate" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  function_name    = "${module.label.id}-deploy-gate"
  role             = aws_iam_role.deploy_gate_lambda_exec[0].arn
  handler          = "handler.handler"
  runtime          = "python3.13"
  timeout          = 15
  filename         = data.archive_file.deploy_gate_lambda[0].output_path
  source_code_hash = data.archive_file.deploy_gate_lambda[0].output_base64sha256

  environment {
    variables = {
      APPROVAL_TABLE_NAME = aws_dynamodb_table.deploy_approval[0].name
    }
  }

  tags = module.label.tags
}

# IAM role ECS assumes to invoke the deploy-gate Lambda as a deployment lifecycle hook.
# Trust policy matches AWS's documented example exactly - no extra conditions:
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/blue-green-permissions.html
data "aws_iam_policy_document" "ecs_lambda_invoke_trust" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_lambda_invoke" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  name               = "${module.label.id}-lambda-invoke"
  assume_role_policy = data.aws_iam_policy_document.ecs_lambda_invoke_trust[0].json
  tags               = module.label.tags
}

resource "aws_iam_role_policy" "ecs_lambda_invoke" {
  count = var.deploy_approval_gate_enabled ? 1 : 0

  name = "${module.label.id}-lambda-invoke"
  role = aws_iam_role.ecs_lambda_invoke[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "lambda:InvokeFunction"
      Resource = [aws_lambda_function.deploy_gate[0].arn]
    }]
  })
}
