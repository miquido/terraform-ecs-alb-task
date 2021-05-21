module "label" {
  source    = "git::https://github.com/cloudposse/terraform-terraform-label?ref=tags/0.8.0"
  name      = var.name
  namespace = var.project
  stage     = var.environment
  tags      = var.tags
}

locals {
  use_default_log_config = var.log_configuration == null

  default_log_configuration_secrets = length(var.secrets) > 0 ? [
    for key in var.secrets :
    {
      name      = "${lookup(key, "name")}_SECRET"
      valueFrom = lookup(key, "valueFrom")
    }
  ] : var.secrets
}

resource "aws_cloudwatch_log_group" "app" {
  count             = local.use_default_log_config ? 1 : 0
  name              = "/aws/ecs/${module.label.id}"
  tags              = module.label.tags
  retention_in_days = var.log_retention
}

module "container" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition?ref=tags/0.56.0"
  container_name               = module.label.id
  container_image              = "${var.container_image}:${var.container_tag}"
  essential                    = var.essential
  secrets                      = var.secrets
  environment                  = var.envs
  entrypoint                   = var.entrypoint
  command                      = var.command
  healthcheck                  = var.healthcheck
  readonly_root_filesystem     = var.readonly_root_filesystem
  working_directory            = var.working_directory
  container_cpu                = var.container_cpu
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  firelens_configuration       = var.firelens_configuration
  mount_points                 = var.mount_points
  dns_servers                  = var.dns_servers
  ulimits                      = var.ulimits
  repository_credentials       = var.repository_credentials
  volumes_from                 = var.volumes_from
  links                        = var.links
  user                         = var.user
  container_depends_on         = var.container_depends_on
  docker_labels                = var.docker_labels
  start_timeout                = var.start_timeout
  stop_timeout                 = var.stop_timeout
  privileged                   = var.privileged
  system_controls              = var.system_controls
  linux_parameters             = var.linux_parameters
  extra_hosts                  = var.extra_hosts

  port_mappings = concat([
    {
      containerPort = var.container_port
      hostPort      = var.container_port
      protocol      = "tcp"
    },
  ], var.additional_port_mappings)

  log_configuration = local.use_default_log_config ? {
    logDriver     = "awslogs"
    secretOptions = local.default_log_configuration_secrets
    options = {
      awslogs-region        = var.logs_region
      awslogs-group         = join("", aws_cloudwatch_log_group.app.*.name)
      awslogs-stream-prefix = var.name
    }
  } : var.log_configuration
}

locals {
  container_definitions      = compact(concat([module.container.json_map_encoded], var.additional_containers))
  container_definitions_json = "[${join(",", local.container_definitions)}]"

  ecs_default_alb = var.ecs_default_alb_enabled ? [{
    elb_name         = null
    target_group_arn = var.alb_target_group_arn
    container_name   = module.label.id
    container_port   = var.container_port
  }] : []

  ecs_load_balancers = concat(local.ecs_default_alb, var.ecs_load_balancers)
  alb_security_group = var.ingress_security_group_id == null ? var.security_group_ids[0] : var.ingress_security_group_id
}

module "task" {
  source = "git::https://github.com/cloudposse/terraform-aws-ecs-alb-service-task?ref=tags/0.55.0"

  name      = var.name
  namespace = var.project
  stage     = var.environment
  tags      = var.tags

  container_definition_json          = local.container_definitions_json
  ecs_load_balancers                 = local.ecs_load_balancers
  alb_security_group                 = local.alb_security_group
  use_alb_security_group             = var.use_ingress_security_group
  container_port                     = var.container_port
  volumes                            = var.volumes
  launch_type                        = var.launch_type
  network_mode                       = var.network_mode
  task_cpu                           = var.task_cpu
  task_memory                        = var.task_memory
  desired_count                      = var.desired_count
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  ecs_cluster_arn                    = var.ecs_cluster_arn
  propagate_tags                     = var.propagate_tags
  vpc_id                             = var.vpc_id
  proxy_configuration                = var.proxy_configuration
  service_registries                 = var.service_registries
  platform_version                   = var.platform_version
  scheduling_strategy                = var.scheduling_strategy
  ordered_placement_strategy         = var.ordered_placement_strategy
  task_placement_constraints         = var.task_placement_constraints
  service_placement_constraints      = var.service_placement_constraints
  security_group_ids                 = var.security_group_ids
  subnet_ids                         = var.subnet_ids
  assign_public_ip                   = var.assign_public_ip
  ignore_changes_task_definition     = var.ignore_changes_task_definition
  deployment_controller_type         = var.deployment_controller_type
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  capacity_provider_strategies       = var.capacity_provider_strategies
  task_role_arn                      = var.task_role_arn
  exec_enabled                       = var.exec_enabled
}

data "aws_iam_policy_document" "ecs-exec-ssm-secrets" {
  count = var.ssm_secrets_enabled ? 1 : 0

  statement {
    effect    = "Allow"
    resources = var.ssm_secrets_resources
    actions   = ["ssm:GetParameters"]
  }
}

resource "aws_iam_role_policy" "ecs-exec-ssm-secrets" {
  count = var.ssm_secrets_enabled ? 1 : 0

  name   = "${module.task.ecs_exec_role_policy_name}-ssm-secrets"
  policy = data.aws_iam_policy_document.ecs-exec-ssm-secrets[0].json
  role   = module.task.task_exec_role_name
}

locals {
  cpu_utilization_high_alarm_actions    = var.autoscaling_enabled && var.autoscaling_dimension == "cpu" ? module.autoscaling.scale_up_policy_arn : ""
  cpu_utilization_low_alarm_actions     = var.autoscaling_enabled && var.autoscaling_dimension == "cpu" ? module.autoscaling.scale_down_policy_arn : ""
  memory_utilization_high_alarm_actions = var.autoscaling_enabled && var.autoscaling_dimension == "memory" ? module.autoscaling.scale_up_policy_arn : ""
  memory_utilization_low_alarm_actions  = var.autoscaling_enabled && var.autoscaling_dimension == "memory" ? module.autoscaling.scale_down_policy_arn : ""
}

module "ecs-service-alarms" {
  source            = "git::https://github.com/cloudposse/terraform-aws-ecs-cloudwatch-sns-alarms.git?ref=tags/0.12.1"
  enabled           = var.ecs_alarms_enabled
  name              = var.name
  namespace         = var.project
  stage             = var.environment
  tags              = var.tags
  cluster_name      = var.ecs_cluster_name
  service_name      = module.task.service_name
  alarm_description = var.ecs_alarms_alarm_description

  cpu_utilization_high_threshold          = var.ecs_alarms_cpu_utilization_high_threshold
  cpu_utilization_high_evaluation_periods = var.ecs_alarms_cpu_utilization_high_evaluation_periods
  cpu_utilization_high_period             = var.ecs_alarms_cpu_utilization_high_period
  cpu_utilization_high_alarm_actions = compact(
    concat(
      var.ecs_alarms_cpu_utilization_high_alarm_actions,
      [local.cpu_utilization_high_alarm_actions],
    ),
  )
  cpu_utilization_high_ok_actions = var.ecs_alarms_cpu_utilization_high_ok_actions

  cpu_utilization_low_threshold          = var.ecs_alarms_cpu_utilization_low_threshold
  cpu_utilization_low_evaluation_periods = var.ecs_alarms_cpu_utilization_low_evaluation_periods
  cpu_utilization_low_period             = var.ecs_alarms_cpu_utilization_low_period
  cpu_utilization_low_alarm_actions = compact(
    concat(
      var.ecs_alarms_cpu_utilization_low_alarm_actions,
      [local.cpu_utilization_low_alarm_actions],
    ),
  )
  cpu_utilization_low_ok_actions = var.ecs_alarms_cpu_utilization_low_ok_actions

  memory_utilization_high_threshold          = var.ecs_alarms_memory_utilization_high_threshold
  memory_utilization_high_evaluation_periods = var.ecs_alarms_memory_utilization_high_evaluation_periods
  memory_utilization_high_period             = var.ecs_alarms_memory_utilization_high_period
  memory_utilization_high_alarm_actions = compact(
    concat(
      var.ecs_alarms_memory_utilization_high_alarm_actions,
      [local.memory_utilization_high_alarm_actions],
    ),
  )
  memory_utilization_high_ok_actions = var.ecs_alarms_memory_utilization_high_ok_actions

  memory_utilization_low_threshold          = var.ecs_alarms_memory_utilization_low_threshold
  memory_utilization_low_evaluation_periods = var.ecs_alarms_memory_utilization_low_evaluation_periods
  memory_utilization_low_period             = var.ecs_alarms_memory_utilization_low_period
  memory_utilization_low_alarm_actions = compact(
    concat(
      var.ecs_alarms_memory_utilization_low_alarm_actions,
      [local.memory_utilization_low_alarm_actions],
    ),
  )
  memory_utilization_low_ok_actions = var.ecs_alarms_memory_utilization_low_ok_actions
}

module "autoscaling" {
  source    = "git::https://github.com/cloudposse/terraform-aws-ecs-cloudwatch-autoscaling.git?ref=tags/0.7.0"
  enabled   = var.autoscaling_enabled
  name      = var.name
  namespace = var.project
  stage     = var.environment
  tags      = var.tags

  service_name = module.task.service_name
  cluster_name = var.ecs_cluster_name

  min_capacity          = var.autoscaling_min_capacity
  max_capacity          = var.autoscaling_max_capacity
  scale_down_adjustment = var.autoscaling_scale_down_adjustment
  scale_down_cooldown   = var.autoscaling_scale_down_cooldown
  scale_up_adjustment   = var.autoscaling_scale_up_adjustment
  scale_up_cooldown     = var.autoscaling_scale_up_cooldown
}
