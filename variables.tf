variable "environment" {
  default     = ""
  description = "Environment name"
}

variable "name" {
  type        = "string"
  description = "Resource common name"
}

variable "project" {
  type        = "string"
  description = "Account/Project Name"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Tags to apply on repository"
}

variable "container_image" {
  type    = "string"
  default = "app"
}

variable "logs_region" {
  type        = "string"
  description = "AWS Logs Region"
}

variable "container_tag" {
  type    = "string"
  default = "latest"
}

variable "container_port" {
  description = "The port on the container to associate with the load balancer"
  default     = 80
}

variable "envs" {
  type        = "list"
  description = "The environment variables to pass to the container. This is a list of maps"

  default = [
    {
      name  = "TEST_ENV"
      value = "1"
    },
  ]
}

variable "task_cpu" {
  description = "The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 256
}

variable "task_memory" {
  description = "The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = 512
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  default     = 1
}

variable "vpc_id" {
  type        = "string"
  description = "The VPC ID where resources are created"
}

variable "alb_target_group_arn" {
  type        = "string"
  description = "The ALB target group ARN for the ECS service"
}

variable "ecs_cluster_arn" {
  type        = "string"
  description = "The ARN of the ECS cluster where service will be provisioned"
}

variable "ecs_cluster_name" {
  type        = "string"
  default     = ""
  description = "The Name of the ECS cluster where service will be provisioned. Required for alarms."
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = "list"
}

variable "security_group_ids" {
  description = "Security group IDs to allow in Service `network_configuration`"
  type        = "list"
}

variable "health_check_grace_period_seconds" {
  type        = "string"
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers"
  default     = 0
}

variable "assign_public_ip" {
  type        = "string"
  default     = "false"
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false."
}

variable "entrypoint" {
  type        = "list"
  description = "The entry point that is passed to the container"
  default     = [""]
}

variable "command" {
  type        = "list"
  description = "The command that is passed to the container"
  default     = [""]
}

##########
# ALARMS
##########

variable "ecs_alarms_enabled" {
  type        = "string"
  description = "A boolean to enable/disable CloudWatch Alarms for ECS Service metrics"
  default     = "false"
}

variable "ecs_alarms_cpu_utilization_high_threshold" {
  type        = "string"
  description = "The maximum percentage of CPU utilization average"
  default     = "80"
}

variable "ecs_alarms_cpu_utilization_high_evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_cpu_utilization_high_period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_cpu_utilization_high_alarm_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High Alarm action"
  default     = []
}

variable "ecs_alarms_cpu_utilization_high_ok_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High OK action"
  default     = []
}

variable "ecs_alarms_cpu_utilization_low_threshold" {
  type        = "string"
  description = "The minimum percentage of CPU utilization average"
  default     = "20"
}

variable "ecs_alarms_cpu_utilization_low_evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_cpu_utilization_low_period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_cpu_utilization_low_alarm_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low Alarm action"
  default     = []
}

variable "ecs_alarms_cpu_utilization_low_ok_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low OK action"
  default     = []
}

variable "ecs_alarms_memory_utilization_high_threshold" {
  type        = "string"
  description = "The maximum percentage of Memory utilization average"
  default     = "80"
}

variable "ecs_alarms_memory_utilization_high_evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_memory_utilization_high_period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_memory_utilization_high_alarm_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High Alarm action"
  default     = []
}

variable "ecs_alarms_memory_utilization_high_ok_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High OK action"
  default     = []
}

variable "ecs_alarms_memory_utilization_low_threshold" {
  type        = "string"
  description = "The minimum percentage of Memory utilization average"
  default     = "20"
}

variable "ecs_alarms_memory_utilization_low_evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the alarm"
  default     = "1"
}

variable "ecs_alarms_memory_utilization_low_period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the alarm"
  default     = "300"
}

variable "ecs_alarms_memory_utilization_low_alarm_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low Alarm action"
  default     = []
}

variable "ecs_alarms_memory_utilization_low_ok_actions" {
  type        = "list"
  description = "A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low OK action"
  default     = []
}

################
# AUTOSCALLING
###############

variable "autoscaling_enabled" {
  type        = "string"
  description = "A boolean to enable/disable Autoscaling policy for ECS Service"
  default     = "false"
}

variable "autoscaling_dimension" {
  type        = "string"
  description = "Dimension to autoscale on (valid options: cpu, memory)"
  default     = "cpu"
}

variable "autoscaling_min_capacity" {
  type        = "string"
  description = "Minimum number of running instances of a Service"
  default     = "1"
}

variable "autoscaling_max_capacity" {
  type        = "string"
  description = "Maximum number of running instances of a Service"
  default     = "2"
}

variable "autoscaling_scale_up_adjustment" {
  type        = "string"
  description = "Scaling adjustment to make during scale up event"
  default     = "1"
}

variable "autoscaling_scale_up_cooldown" {
  type        = "string"
  description = "Period (in seconds) to wait between scale up events"
  default     = "60"
}

variable "autoscaling_scale_down_adjustment" {
  type        = "string"
  description = "Scaling adjustment to make during scale down event"
  default     = "-1"
}

variable "autoscaling_scale_down_cooldown" {
  type        = "string"
  description = "Period (in seconds) to wait between scale down events"
  default     = "300"
}
