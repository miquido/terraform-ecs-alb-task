module "default_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=0.2.1"
  attributes = "${var.attributes}"
  delimiter  = "${var.delimiter}"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  tags       = "${var.tags}"
}

module "task_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=0.2.1"
  attributes = ["${compact(concat(var.attributes, list("task")))}"]
  delimiter  = "${var.delimiter}"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  tags       = "${var.tags}"
}

module "service_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=0.2.1"
  attributes = ["${compact(concat(var.attributes, list("service")))}"]
  delimiter  = "${var.delimiter}"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  tags       = "${var.tags}"
}

module "exec_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=0.2.1"
  attributes = ["${compact(concat(var.attributes, list("exec")))}"]
  delimiter  = "${var.delimiter}"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  tags       = "${var.tags}"
}

resource "aws_ecs_task_definition" "default" {
  family                   = "${module.default_label.id}"
  container_definitions    = "${var.container_definition_json}"
  requires_compatibilities = ["${var.launch_type}"]
  network_mode             = "${var.network_mode}"
  cpu                      = "${var.task_cpu}"
  memory                   = "${var.task_memory}"
  execution_role_arn       = "${aws_iam_role.ecs_exec.arn}"
  task_role_arn            = "${aws_iam_role.ecs_task.arn}"
  tags                     = "${module.default_label.tags}"
  volume                   = "${var.volumes}"
}

# IAM
data "aws_iam_policy_document" "ecs_task" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task" {
  name               = "${module.task_label.id}"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_task.json}"
  tags               = "${module.task_label.tags}"
}

data "aws_iam_policy_document" "ecs_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_service" {
  name               = "${module.service_label.id}"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_service.json}"
  tags               = "${module.service_label.tags}"
}

data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress",
    ]
  }
}

resource "aws_iam_role_policy" "ecs_service" {
  name   = "${module.service_label.id}"
  policy = "${data.aws_iam_policy_document.ecs_service_policy.json}"
  role   = "${aws_iam_role.ecs_service.id}"
}

# IAM role that the Amazon ECS container agent and the Docker daemon can assume
data "aws_iam_policy_document" "ecs_task_exec" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_exec" {
  name               = "${module.exec_label.id}"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_task_exec.json}"
  tags               = "${module.exec_label.tags}"
}

data "aws_iam_policy_document" "ecs_exec" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role_policy" "ecs_exec" {
  name   = "${module.exec_label.id}"
  policy = "${data.aws_iam_policy_document.ecs_exec.json}"
  role   = "${aws_iam_role.ecs_exec.id}"
}

# Service
## Security Groups
resource "aws_security_group" "ecs_service" {
  vpc_id      = "${var.vpc_id}"
  name        = "${module.service_label.id}"
  description = "Allow ALL egress from ECS service"
  tags        = "${module.service_label.tags}"
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs_service.id}"
}

resource "aws_security_group_rule" "allow_icmp_ingress" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs_service.id}"
}

resource "aws_service_discovery_service" "default" {
  count = "${var.enable_service_discovery == "true" ? 1 : 0}"

  name = "${module.default_label.id}"

  dns_config {
    namespace_id = "${var.service_discovery_dns_namespace_id}"

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = "${var.service_discovery_health_check_failure_threshold}"
  }
}

resource "aws_ecs_service" "service_discovery" {
  count = "${var.enable_service_discovery == "true" ? 1 : 0}"

  name                               = "${module.default_label.id}"
  task_definition                    = "${aws_ecs_task_definition.default.family}:${aws_ecs_task_definition.default.revision}"
  desired_count                      = "${var.desired_count}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  launch_type                        = "${var.launch_type}"
  cluster                            = "${var.ecs_cluster_arn}"
  tags                               = "${module.default_label.tags}"
  propagate_tags                     = "${var.propagate_tags}"

  network_configuration {
    security_groups  = ["${var.security_group_ids}", "${aws_security_group.ecs_service.id}"]
    subnets          = ["${var.subnet_ids}"]
    assign_public_ip = "${var.assign_public_ip}"
  }

  service_registries {
    registry_arn   = "${join("", aws_service_discovery_service.default.*.arn)}"
    container_name = "${var.container_name}"
  }

  lifecycle {
    ignore_changes = ["task_definition", "desired_count"]
  }
}

resource "aws_ecs_service" "default" {
  count = "${var.enable_service_discovery == "true" ? 0 : 1}"

  name                               = "${module.default_label.id}"
  task_definition                    = "${aws_ecs_task_definition.default.family}:${aws_ecs_task_definition.default.revision}"
  desired_count                      = "${var.desired_count}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  launch_type                        = "${var.launch_type}"
  cluster                            = "${var.ecs_cluster_arn}"
  tags                               = "${module.default_label.tags}"
  propagate_tags                     = "${var.propagate_tags}"

  network_configuration {
    security_groups  = ["${var.security_group_ids}", "${aws_security_group.ecs_service.id}"]
    subnets          = ["${var.subnet_ids}"]
    assign_public_ip = "${var.assign_public_ip}"
  }

  lifecycle {
    ignore_changes = ["task_definition", "desired_count"]
  }
}
