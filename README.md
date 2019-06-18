<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![Miquido][logo]](https://www.miquido.com/)

# miquido-terraform-ecs-alb-task
Provide ECS Service and Task configuration with ALB attachement
---
Terraform Module

BitBucket Repository: https://bitbucket.org/miquido/terraform-ecs-alb-task
## Usage

```hcl
module {
  source = "git::ssh://git@bitbucket.org/miquido/terraform-ecs-alb-task.git?ref=master"
  ...
}
```
## Makefile Targets
```
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_containers | Additional container definitions to include in the task. JSON Map format should be used (see cloudposse/terraform-aws-ecs-container-definition module output: json_map) | list | `<list>` | no |
| assign_public_ip | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false. | string | `false` | no |
| autoscaling_dimension | Dimension to autoscale on (valid options: cpu, memory) | string | `cpu` | no |
| autoscaling_enabled | A boolean to enable/disable Autoscaling policy for ECS Service | string | `false` | no |
| autoscaling_max_capacity | Maximum number of running instances of a Service | string | `2` | no |
| autoscaling_min_capacity | Minimum number of running instances of a Service | string | `1` | no |
| autoscaling_scale_down_adjustment | Scaling adjustment to make during scale down event | string | `-1` | no |
| autoscaling_scale_down_cooldown | Period (in seconds) to wait between scale down events | string | `300` | no |
| autoscaling_scale_up_adjustment | Scaling adjustment to make during scale up event | string | `1` | no |
| autoscaling_scale_up_cooldown | Period (in seconds) to wait between scale up events | string | `60` | no |
| command | The command that is passed to the container | list | `<list>` | no |
| container_image | - | string | `app` | no |
| container_port | The port on the container to associate with the load balancer | string | `80` | no |
| container_tag | - | string | `latest` | no |
| desired_count | The number of instances of the task definition to place and keep running | string | `1` | no |
| ecs_alarms_cpu_utilization_high_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High Alarm action | list | `<list>` | no |
| ecs_alarms_cpu_utilization_high_evaluation_periods | Number of periods to evaluate for the alarm | string | `1` | no |
| ecs_alarms_cpu_utilization_high_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High OK action | list | `<list>` | no |
| ecs_alarms_cpu_utilization_high_period | Duration in seconds to evaluate for the alarm | string | `300` | no |
| ecs_alarms_cpu_utilization_high_threshold | The maximum percentage of CPU utilization average | string | `80` | no |
| ecs_alarms_cpu_utilization_low_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low Alarm action | list | `<list>` | no |
| ecs_alarms_cpu_utilization_low_evaluation_periods | Number of periods to evaluate for the alarm | string | `1` | no |
| ecs_alarms_cpu_utilization_low_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low OK action | list | `<list>` | no |
| ecs_alarms_cpu_utilization_low_period | Duration in seconds to evaluate for the alarm | string | `300` | no |
| ecs_alarms_cpu_utilization_low_threshold | The minimum percentage of CPU utilization average | string | `20` | no |
| ecs_alarms_enabled | A boolean to enable/disable CloudWatch Alarms for ECS Service metrics | string | `false` | no |
| ecs_alarms_memory_utilization_high_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High Alarm action | list | `<list>` | no |
| ecs_alarms_memory_utilization_high_evaluation_periods | Number of periods to evaluate for the alarm | string | `1` | no |
| ecs_alarms_memory_utilization_high_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High OK action | list | `<list>` | no |
| ecs_alarms_memory_utilization_high_period | Duration in seconds to evaluate for the alarm | string | `300` | no |
| ecs_alarms_memory_utilization_high_threshold | The maximum percentage of Memory utilization average | string | `80` | no |
| ecs_alarms_memory_utilization_low_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low Alarm action | list | `<list>` | no |
| ecs_alarms_memory_utilization_low_evaluation_periods | Number of periods to evaluate for the alarm | string | `1` | no |
| ecs_alarms_memory_utilization_low_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low OK action | list | `<list>` | no |
| ecs_alarms_memory_utilization_low_period | Duration in seconds to evaluate for the alarm | string | `300` | no |
| ecs_alarms_memory_utilization_low_threshold | The minimum percentage of Memory utilization average | string | `20` | no |
| ecs_cluster_arn | The ARN of the ECS cluster where service will be provisioned | string | - | yes |
| ecs_cluster_name | The Name of the ECS cluster where service will be provisioned. Required for alarms. | string | `` | no |
| enable_service_discovery | Manages creation of ECS Service Discovery resource for created ECS Service. | string | `false` | no |
| entrypoint | The entry point that is passed to the container | list | `<list>` | no |
| environment | Environment name | string | `` | no |
| envs | The environment variables to pass to the container. This is a list of maps | list | `<list>` | no |
| healthcheck | A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) [docs: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html] | map | `<map>` | no |
| log_retention | Specifies the number of days you want to retain log events in the specified log group. | string | `7` | no |
| logs_region | AWS Logs Region | string | - | yes |
| name | Resource common name | string | - | yes |
| project | Account/Project Name | string | - | yes |
| propagate_tags | Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. | string | `` | no |
| readonly_root_filesystem | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | string | `false` | no |
| security_group_ids | Security group IDs to allow in Service `network_configuration` | list | - | yes |
| subnet_ids | Subnet IDs | list | - | yes |
| tags | Tags to apply on repository | map | `<map>` | no |
| task_cpu | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | string | `256` | no |
| task_memory | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | string | `512` | no |
| vpc_id | The VPC ID where resources are created | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| container_name | ECS task container name |
| ecs_exec_role_policy_id | The ECS service role policy ID, in the form of role_name:role_policy_name |
| ecs_exec_role_policy_name | ECS service role name |
| service_name | ECS Service name |
| service_role_arn | ECS Service role ARN |
| service_security_group_id | Security Group ID of the ECS task |
| task_definition_family | ECS task definition family |
| task_definition_revision | ECS task definition revision |
| task_exec_role_arn | ECS Task exec role ARN |
| task_exec_role_name | ECS Task role name |
| task_role_arn | ECS Task role ARN |
| task_role_name | ECS Task role name |



## Developing

1. Make changes in terraform files

2. Regerate documentation

    ```bash
    bash <(curl -s https://terraform.s3.k.miquido.net/update.sh)
    ```

3. Run lint

    ```
    make lint
    ```

## Copyright

Copyright © 2017-2019 [Miquido](https://miquido.com)



### Contributors

|  [![Konrad Obal][k911_avatar]][k911_homepage]<br/>[Konrad Obal][k911_homepage] |
|---|

  [k911_homepage]: https://github.com/k911
  [k911_avatar]: https://github.com/k911.png?size=150



  [logo]: https://www.miquido.com/img/logos/logo__miquido.svg
  [website]: https://www.miquido.com/
  [github]: https://github.com/miquido
  [bitbucket]: https://bitbucket.org/miquido
