variable "environment" {
  type        = string
  default     = ""
  description = "Environment name"
}

variable "name" {
  type        = string
  description = "Resource common name"
}

variable "project" {
  type        = string
  description = "Account/Project Name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply on repository"
}

variable "container_image" {
  type    = string
  default = "app"
}

variable "logs_region" {
  type        = string
  description = "AWS Logs Region"
}

variable "container_tag" {
  type    = string
  default = "latest"
}

variable "container_port" {
  type        = number
  description = "The port on the container to associate with the load balancer"
  default     = 80
}

variable "secrets" {
  type        = list(map(string))
  description = "The secrets to pass to the container. This is a list of maps"
  default     = []
}

variable "envs" {
  type        = list(map(string))
  description = "The environment variables to pass to the container. This is a list of maps"

  default = [
    {
      name  = "TEST_ENV"
      value = "1"
    },
  ]
}

variable "task_cpu" {
  type        = number
  description = "The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 256
}

variable "task_memory" {
  type        = number
  description = "The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 512
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  default     = 1
  type        = number
}

variable "ssm_secrets_enabled" {
  type        = bool
  default     = false
  description = "Adds IAM Policy for reading secrets from Systems Manager Paramameter Store (use 'ssm_secrets_resources' to limit access to the SSM resources)"
}

variable "ssm_secrets_resources" {
  type        = list(string)
  default     = ["*"]
  description = "Limit access to the SSM Parameters when 'enable_secrets_from_ssm' is enabled. By default no resources are allowed to be read."
}

variable "deployment_controller_type" {
  type        = string
  description = "Type of deployment controller. Valid values: `CODE_DEPLOY`, `ECS`."
  default     = "ECS"
}

variable "deployment_maximum_percent" {
  type        = number
  description = "The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment"
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  description = "The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment"
  default     = 100
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where resources are created"
}

variable "alb_target_group_arn" {
  type        = string
  default     = ""
  description = "The ALB target group ARN for the ECS service"
}

variable "ingress_security_group_id" {
  type        = string
  default     = ""
  description = "Default ingress security group. Usually default LB security group. If not set, it defaults to first security group id in `security_groups_ids` variable."
}

variable "ecs_default_alb_enabled" {
  default     = true
  type        = bool
  description = "Whether to create default load balancer configuration with attached provided ALB Target group to main container. Requires setting `alb_target_group_arn` variable."
}

variable "propagate_tags" {
  type        = string
  default     = "SERVICE"
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION."
}

variable "ecs_load_balancers" {
  default     = []
  type        = list(map(any))
  description = "A list of load balancer config objects for the ECS service; see `load_balancer` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html"
}

variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of the ECS cluster where service will be provisioned"
}

variable "ecs_cluster_name" {
  type        = string
  default     = ""
  description = "The Name of the ECS cluster where service will be provisioned. Required for alarms."
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to allow in Service `network_configuration`"
  type        = list(string)
}

variable "health_check_grace_period_seconds" {
  type        = string
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers"
  default     = 0
}

variable "assign_public_ip" {
  type        = string
  default     = "false"
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false."
}

variable "entrypoint" {
  type        = list(string)
  description = "The entry point that is passed to the container"
  default     = [""]
}

variable "command" {
  type        = list(string)
  description = "The command that is passed to the container"
  default     = [""]
}

variable "additional_containers" {
  type        = list(string)
  description = "Additional container definitions to include in the task. JSON Map format should be used (see cloudposse/terraform-aws-ecs-container-definition module output: json_map)"
  default     = [""]
}

variable "ignore_changes_task_definition" {
  type        = bool
  description = "Whether to ignore changes in container definition and task definition in the ECS service"
  default     = true
}

##########
# ALARMS
##########

variable "ecs_alarms_enabled" {
  type        = string
  description = "A boolean to enable/disable CloudWatch Alarms for ECS Service metrics"
  default     = "false"
}

variable "ecs_alarms_cpu_utilization_high_threshold" {
  type        = string
  description = "The maximum percentage of CPU utilization average"
  default     = "80"
}

variable "ecs_alarms_cpu_utilization_high_evaluation_periods" {
  type        = string
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_cpu_utilization_high_period" {
  type        = string
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_cpu_utilization_high_alarm_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High Alarm action"
  default     = []
}

variable "ecs_alarms_cpu_utilization_high_ok_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High OK action"
  default     = []
}

variable "ecs_alarms_cpu_utilization_low_threshold" {
  type        = string
  description = "The minimum percentage of CPU utilization average"
  default     = "20"
}

variable "ecs_alarms_cpu_utilization_low_evaluation_periods" {
  type        = string
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_cpu_utilization_low_period" {
  type        = string
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_cpu_utilization_low_alarm_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low Alarm action"
  default     = []
}

variable "ecs_alarms_cpu_utilization_low_ok_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low OK action"
  default     = []
}

variable "ecs_alarms_memory_utilization_high_threshold" {
  type        = string
  description = "The maximum percentage of Memory utilization average"
  default     = "80"
}

variable "ecs_alarms_memory_utilization_high_evaluation_periods" {
  type        = string
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_memory_utilization_high_period" {
  type        = string
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_memory_utilization_high_alarm_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High Alarm action"
  default     = []
}

variable "ecs_alarms_memory_utilization_high_ok_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High OK action"
  default     = []
}

variable "ecs_alarms_memory_utilization_low_threshold" {
  type        = string
  description = "The minimum percentage of Memory utilization average"
  default     = "20"
}

variable "ecs_alarms_memory_utilization_low_evaluation_periods" {
  type        = string
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_memory_utilization_low_period" {
  type        = string
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_memory_utilization_low_alarm_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low Alarm action"
  default     = []
}

variable "ecs_alarms_memory_utilization_low_ok_actions" {
  type        = list(string)
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low OK action"
  default     = []
}

################
# AUTOSCALLING
###############

variable "autoscaling_enabled" {
  type        = string
  description = "A boolean to enable/disable Autoscaling policy for ECS Service"
  default     = "false"
}

variable "autoscaling_dimension" {
  type        = string
  description = "Dimension to autoscale on (valid options: cpu, memory)"
  default     = "cpu"
}

variable "autoscaling_min_capacity" {
  type        = string
  description = "Minimum number of running instances of a Service"
  default     = "1"
}

variable "autoscaling_max_capacity" {
  type        = string
  description = "Maximum number of running instances of a Service"
  default     = "2"
}

variable "autoscaling_scale_up_adjustment" {
  type        = string
  description = "Scaling adjustment to make during scale up event"
  default     = "1"
}

variable "autoscaling_scale_up_cooldown" {
  type        = string
  description = "Period (in seconds) to wait between scale up events"
  default     = "60"
}

variable "autoscaling_scale_down_adjustment" {
  type        = string
  description = "Scaling adjustment to make during scale down event"
  default     = "-1"
}

variable "autoscaling_scale_down_cooldown" {
  type        = string
  description = "Period (in seconds) to wait between scale down events"
  default     = "300"
}

variable "log_retention" {
  default     = "7"
  type        = string
  description = "Specifies the number of days you want to retain log events in the specified log group."
}

variable "healthcheck" {
  type = object({
    command     = list(string)
    retries     = number
    timeout     = number
    interval    = number
    startPeriod = number
  })

  description = "A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"

  default = {
    command     = []
    retries     = null
    timeout     = null
    interval    = null
    startPeriod = null
  }
}

variable "readonly_root_filesystem" {
  type        = string
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = "false"
}

