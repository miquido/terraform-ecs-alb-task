module "label" {
  source    = "git@github.com:cloudposse/terraform-terraform-label?ref=0.2.1"
  name      = "${var.name}"
  namespace = "${var.project}"
  stage     = "${var.environment}"
  tags      = "${var.tags}"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "${module.label.id}"
  tags = "${module.label.tags}"
}

# see https://github.com/cloudposse/terraform-aws-ecs-container-definition/blob/master/variables.tf
module "container" {
  source          = "git@github.com:cloudposse/terraform-aws-ecs-container-definition?ref=0.10.0"
  container_name  = "${module.label.id}"
  container_image = "${var.container_image}:${var.container_tag}"
  environment     = "${var.envs}"

  container_cpu                = ""
  container_memory             = ""
  container_memory_reservation = ""

  port_mappings = [{
    "containerPort" = "${var.container_port}"
    "hostPort"      = "${var.container_port}"
    "protocol"      = "tcp"
  }]

  log_options = {
    "awslogs-region"        = "${var.logs_region}"
    "awslogs-group"         = "${aws_cloudwatch_log_group.app.name}"
    "awslogs-stream-prefix" = "${var.name}"
  }
}

module "task" {
  source                            = "git@github.com:cloudposse/terraform-aws-ecs-alb-service-task?ref=0.11.0"
  name                              = "${var.name}"
  namespace                         = "${var.project}"
  stage                             = "${var.environment}"
  tags                              = "${var.tags}"
  container_definition_json         = "${module.container.json}"
  container_name                    = "${module.label.id}"
  container_port                    = "${var.container_port}"
  launch_type                       = "FARGATE"
  task_cpu                          = "${var.task_cpu}"
  task_memory                       = "${var.task_memory}"
  desired_count                     = "${var.desired_count}"
  health_check_grace_period_seconds = "${var.health_check_grace_period_seconds}"
  alb_target_group_arn              = "${var.alb_target_group_arn}"
  ecs_cluster_arn                   = "${var.ecs_cluster_arn}"
  vpc_id                            = "${var.vpc_id}"
  security_group_ids                = "${var.security_group_ids}"
  subnet_ids                        = "${var.subnet_ids}"
  assign_public_ip                  = "${var.assign_public_ip}"
}
