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

variable "private_subnet_ids" {
  description = "Private subnet IDs"
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
