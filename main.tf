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
  source          = "git@github.com:cloudposse/terraform-aws-ecs-container-definition?ref=0.14.0"
  container_name  = "${module.label.id}"
  container_image = "${var.container_image}:${var.container_tag}"
  environment     = "${var.envs}"
  entrypoint      = "${var.entrypoint}"
  command         = "${var.command}"

  container_cpu                = 0
  container_memory             = 0
  container_memory_reservation = 0

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
  source    = "git@github.com:cloudposse/terraform-aws-ecs-alb-service-task?ref=0.11.0"
  name      = "${var.name}"
  namespace = "${var.project}"
  stage     = "${var.environment}"
  tags      = "${var.tags}"

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

locals {
  cpu_utilization_high_alarm_actions    = "${var.autoscaling_enabled == "true" && var.autoscaling_dimension == "cpu" ? module.autoscaling.scale_up_policy_arn : ""}"
  cpu_utilization_low_alarm_actions     = "${var.autoscaling_enabled == "true" && var.autoscaling_dimension == "cpu" ? module.autoscaling.scale_down_policy_arn : ""}"
  memory_utilization_high_alarm_actions = "${var.autoscaling_enabled == "true" && var.autoscaling_dimension == "memory" ? module.autoscaling.scale_up_policy_arn : ""}"
  memory_utilization_low_alarm_actions  = "${var.autoscaling_enabled == "true" && var.autoscaling_dimension == "memory" ? module.autoscaling.scale_down_policy_arn : ""}"
}

module "ecs-service-alarms" {
  source       = "git@github.com:cloudposse/terraform-aws-ecs-cloudwatch-sns-alarms.git?ref=0.4.1"
  enabled      = "${var.ecs_alarms_enabled}"
  name         = "${var.name}"
  namespace    = "${var.project}"
  stage        = "${var.environment}"
  tags         = "${var.tags}"
  cluster_name = "${var.ecs_cluster_name}"
  service_name = "${module.task.service_name}"

  cpu_utilization_high_threshold          = "${var.ecs_alarms_cpu_utilization_high_threshold}"
  cpu_utilization_high_evaluation_periods = "${var.ecs_alarms_cpu_utilization_high_evaluation_periods}"
  cpu_utilization_high_period             = "${var.ecs_alarms_cpu_utilization_high_period}"
  cpu_utilization_high_alarm_actions      = "${compact(concat(var.ecs_alarms_cpu_utilization_high_alarm_actions, list(local.cpu_utilization_high_alarm_actions)))}"
  cpu_utilization_high_ok_actions         = "${var.ecs_alarms_cpu_utilization_high_ok_actions}"

  cpu_utilization_low_threshold          = "${var.ecs_alarms_cpu_utilization_low_threshold}"
  cpu_utilization_low_evaluation_periods = "${var.ecs_alarms_cpu_utilization_low_evaluation_periods}"
  cpu_utilization_low_period             = "${var.ecs_alarms_cpu_utilization_low_period}"
  cpu_utilization_low_alarm_actions      = "${compact(concat(var.ecs_alarms_cpu_utilization_low_alarm_actions, list(local.cpu_utilization_low_alarm_actions)))}"
  cpu_utilization_low_ok_actions         = "${var.ecs_alarms_cpu_utilization_low_ok_actions}"

  memory_utilization_high_threshold          = "${var.ecs_alarms_memory_utilization_high_threshold}"
  memory_utilization_high_evaluation_periods = "${var.ecs_alarms_memory_utilization_high_evaluation_periods}"
  memory_utilization_high_period             = "${var.ecs_alarms_memory_utilization_high_period}"
  memory_utilization_high_alarm_actions      = "${compact(concat(var.ecs_alarms_memory_utilization_high_alarm_actions, list(local.memory_utilization_high_alarm_actions)))}"
  memory_utilization_high_ok_actions         = "${var.ecs_alarms_memory_utilization_high_ok_actions}"

  memory_utilization_low_threshold          = "${var.ecs_alarms_memory_utilization_low_threshold}"
  memory_utilization_low_evaluation_periods = "${var.ecs_alarms_memory_utilization_low_evaluation_periods}"
  memory_utilization_low_period             = "${var.ecs_alarms_memory_utilization_low_period}"
  memory_utilization_low_alarm_actions      = "${compact(concat(var.ecs_alarms_memory_utilization_low_alarm_actions, list(local.memory_utilization_low_alarm_actions)))}"
  memory_utilization_low_ok_actions         = "${var.ecs_alarms_memory_utilization_low_ok_actions}"
}

module "autoscaling" {
  source    = "git@github.com:cloudposse/terraform-aws-ecs-cloudwatch-autoscaling.git?ref=0.1.0"
  enabled   = "${var.autoscaling_enabled}"
  name      = "${var.name}"
  namespace = "${var.project}"
  stage     = "${var.environment}"
  tags      = "${var.tags}"

  service_name = "${module.task.service_name}"
  cluster_name = "${var.ecs_cluster_name}"

  min_capacity          = "${var.autoscaling_min_capacity}"
  max_capacity          = "${var.autoscaling_max_capacity}"
  scale_down_adjustment = "${var.autoscaling_scale_down_adjustment}"
  scale_down_cooldown   = "${var.autoscaling_scale_down_cooldown}"
  scale_up_adjustment   = "${var.autoscaling_scale_up_adjustment}"
  scale_up_cooldown     = "${var.autoscaling_scale_up_cooldown}"
}
