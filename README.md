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
  lint                                Lint Terraform code

```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_containers | Additional container definitions to include in the task. JSON Map format should be used (see cloudposse/terraform-aws-ecs-container-definition module output: json_map) | list(string) | `<list>` | no |
| additional_port_mappings | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | object | `<list>` | no |
| alb_target_group_arn | The ALB target group ARN for the ECS service | string | `` | no |
| assign_public_ip | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false. | bool | `false` | no |
| autoscaling_dimension | Dimension to autoscale on (valid options: cpu, memory) | string | `cpu` | no |
| autoscaling_enabled | A boolean to enable/disable Autoscaling policy for ECS Service | bool | `false` | no |
| autoscaling_max_capacity | Maximum number of running instances of a Service | number | `2` | no |
| autoscaling_min_capacity | Minimum number of running instances of a Service | number | `1` | no |
| autoscaling_scale_down_adjustment | Scaling adjustment to make during scale down event | number | `-1` | no |
| autoscaling_scale_down_cooldown | Period (in seconds) to wait between scale down events | number | `300` | no |
| autoscaling_scale_up_adjustment | Scaling adjustment to make during scale up event | number | `1` | no |
| autoscaling_scale_up_cooldown | Period (in seconds) to wait between scale up events | number | `60` | no |
| capacity_provider_strategies | The capacity provider strategies to use for the service. See `capacity_provider_strategy` configuration block: https://www.terraform.io/docs/providers/aws/r/ecs_service.html#capacity_provider_strategy | object | `<list>` | no |
| command | The command that is passed to the container | list(string) | `null` | no |
| container_cpu | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value | number | `null` | no |
| container_depends_on | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | object | `null` | no |
| container_image | The image used to start the container. Images in the Docker Hub registry available by default | string | - | yes |
| container_memory | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value | number | `null` | no |
| container_memory_reservation | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit | number | `null` | no |
| container_port | The port on the container to associate with the load balancer | number | `80` | no |
| container_tag | - | string | `latest` | no |
| deployment_controller_type | Type of deployment controller. Valid values: `CODE_DEPLOY`, `ECS`. | string | `ECS` | no |
| deployment_maximum_percent | The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment | number | `200` | no |
| deployment_minimum_healthy_percent | The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment | number | `100` | no |
| desired_count | The number of instances of the task definition to place and keep running | number | `1` | no |
| dns_servers | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | list(string) | `null` | no |
| docker_labels | The configuration options to send to the `docker_labels` | map(string) | `null` | no |
| ecs_alarms_alarm_description | The string to format and use as the alarm description. | string | `Average service %v utilization %v last %d minute(s) over %v period(s)` | no |
| ecs_alarms_cpu_utilization_high_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High Alarm action | list(string) | `<list>` | no |
| ecs_alarms_cpu_utilization_high_evaluation_periods | Number of periods to evaluate for the alarm | number | `1` | no |
| ecs_alarms_cpu_utilization_high_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High OK action | list(string) | `<list>` | no |
| ecs_alarms_cpu_utilization_high_period | Duration in seconds to evaluate for the alarm | number | `300` | no |
| ecs_alarms_cpu_utilization_high_threshold | The maximum percentage of CPU utilization average | number | `80` | no |
| ecs_alarms_cpu_utilization_low_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low Alarm action | list(string) | `<list>` | no |
| ecs_alarms_cpu_utilization_low_evaluation_periods | Number of periods to evaluate for the alarm | number | `1` | no |
| ecs_alarms_cpu_utilization_low_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low OK action | list(string) | `<list>` | no |
| ecs_alarms_cpu_utilization_low_period | Duration in seconds to evaluate for the alarm | number | `300` | no |
| ecs_alarms_cpu_utilization_low_threshold | The minimum percentage of CPU utilization average | number | `20` | no |
| ecs_alarms_enabled | A boolean to enable/disable CloudWatch Alarms for ECS Service metrics | bool | `false` | no |
| ecs_alarms_memory_utilization_high_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High Alarm action | list(string) | `<list>` | no |
| ecs_alarms_memory_utilization_high_evaluation_periods | Number of periods to evaluate for the alarm | number | `1` | no |
| ecs_alarms_memory_utilization_high_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High OK action | list(string) | `<list>` | no |
| ecs_alarms_memory_utilization_high_period | Duration in seconds to evaluate for the alarm | number | `300` | no |
| ecs_alarms_memory_utilization_high_threshold | The maximum percentage of Memory utilization average | number | `80` | no |
| ecs_alarms_memory_utilization_low_alarm_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low Alarm action | list(string) | `<list>` | no |
| ecs_alarms_memory_utilization_low_evaluation_periods | Number of periods to evaluate for the alarm | number | `1` | no |
| ecs_alarms_memory_utilization_low_ok_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low OK action | list(string) | `<list>` | no |
| ecs_alarms_memory_utilization_low_period | Duration in seconds to evaluate for the alarm | number | `300` | no |
| ecs_alarms_memory_utilization_low_threshold | The minimum percentage of Memory utilization average | number | `20` | no |
| ecs_cluster_arn | The ARN of the ECS cluster where service will be provisioned | string | - | yes |
| ecs_cluster_name | The Name of the ECS cluster where service will be provisioned. Required for alarms. | string | `` | no |
| ecs_default_alb_enabled | Whether to create default load balancer configuration with attached provided ALB Target group to main container. Requires setting `alb_target_group_arn` variable. | bool | `true` | no |
| ecs_load_balancers | A list of load balancer config objects for the ECS service; see `load_balancer` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html | object | `<list>` | no |
| enable_ecs_managed_tags | Specifies whether to enable Amazon ECS managed tags for the tasks within the service | bool | `true` | no |
| entrypoint | The entry point that is passed to the container | list(string) | `null` | no |
| environment | Environment name | string | `` | no |
| envs | The environment variables to pass to the container. This is a list of maps | object | `null` | no |
| essential | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | bool | `true` | no |
| firelens_configuration | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html | object | `null` | no |
| health_check_grace_period_seconds | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers | string | `0` | no |
| healthcheck | A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | object | `null` | no |
| ignore_changes_task_definition | Whether to ignore changes in container definition and task definition in the ECS service | bool | `true` | no |
| ingress_security_group_id | Default ingress security group. Usually default LB security group. If not set, it defaults to first security group id in `security_groups_ids` variable. | string | `null` | no |
| launch_type | The launch type on which to run your service. Valid values are `EC2` and `FARGATE` | string | `FARGATE` | no |
| links | List of container names this container can communicate with without port mappings | list(string) | `null` | no |
| linux_parameters | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html | object | `null` | no |
| log_configuration | Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | object | `null` | no |
| log_retention | Specifies the number of days you want to retain log events in the specified log group. Option has no effect when custom "log_configuration" variable is specified. | number | `7` | no |
| logs_region | AWS Logs Region | string | - | yes |
| mount_points | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume` | object | `null` | no |
| name | Resource common name | string | - | yes |
| network_mode | The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` | string | `awsvpc` | no |
| ordered_placement_strategy | Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. See `ordered_placement_strategy` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#ordered_placement_strategy-1 | object | `<list>` | no |
| platform_version | The platform version on which to run your service. Only applicable for launch_type set to FARGATE. More information about Fargate platform versions can be found in the AWS ECS User Guide. | string | `LATEST` | no |
| privileged | When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type. Due to how Terraform type casts booleans in json it is required to double quote this value | string | `null` | no |
| project | Account/Project Name | string | - | yes |
| propagate_tags | Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. | string | `SERVICE` | no |
| proxy_configuration | The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments | object | `null` | no |
| readonly_root_filesystem | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | bool | `false` | no |
| repository_credentials | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | map(string) | `null` | no |
| scheduling_strategy | The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Note that Fargate tasks do not support the DAEMON scheduling strategy. | string | `REPLICA` | no |
| secrets | The secrets to pass to the container. This is a list of maps | object | `null` | no |
| security_group_ids | Security group IDs to allow in Service `network_configuration` | list(string) | - | yes |
| service_placement_constraints | The rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. See `placement_constraints` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#placement_constraints-1 | object | `<list>` | no |
| service_registries | The service discovery registries for the service. The maximum number of service_registries blocks is 1. The currently supported service registry is Amazon Route 53 Auto Naming Service - `aws_service_discovery_service`; see `service_registries` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#service_registries-1 | object | `<list>` | no |
| ssm_secrets_enabled | Adds IAM Policy for reading secrets from Systems Manager Paramameter Store (use 'ssm_secrets_resources' to limit access to the SSM resources) | bool | `false` | no |
| ssm_secrets_resources | Limit access to the SSM Parameters when 'enable_secrets_from_ssm' is enabled. By default no resources are allowed to be read. | list(string) | `<list>` | no |
| start_timeout | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | number | `30` | no |
| stop_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | number | `30` | no |
| subnet_ids | Subnet IDs | list(string) | - | yes |
| system_controls | A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = "", value = ""} | list(map(string)) | `null` | no |
| tags | Tags to apply on repository | map(string) | `<map>` | no |
| task_role_arn | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services | string | `""` | no |
| task_cpu | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | number | `256` | no |
| task_memory | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | number | `512` | no |
| task_placement_constraints | A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. See `placement_constraints` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#placement-constraints-arguments | object | `<list>` | no |
| ulimits | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | object | `null` | no |
| use_ingress_security_group | Whether to use ingress security group. When turned on use `ingress_security_group_id` to configure default ingress security group id. | bool | `false` | no |
| user | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group | string | `null` | no |
| volumes | Task volume definitions as list of configuration objects | object | `<list>` | no |
| volumes_from | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume) | object | `null` | no |
| vpc_id | The VPC ID where resources are created | string | - | yes |
| working_directory | The working directory to run commands inside the container | string | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| container_name | ECS task container name |
| ecs_exec_role_policy_id | The ECS service role policy ID, in the form of role_name:role_policy_name |
| ecs_exec_role_policy_name | ECS service role name |
| log_group_arn | The Amazon Resource Name (ARN) specifying the log group |
| log_group_name | The name of the log group |
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

Copyright © 2017-2020 [Miquido](https://miquido.com)



### Contributors

|  [![Konrad Obal][k911_avatar]][k911_homepage]<br/>[Konrad Obal][k911_homepage] |
|---|

  [k911_homepage]: https://github.com/k911
  [k911_avatar]: https://github.com/k911.png?size=150



  [logo]: https://www.miquido.com/img/logos/logo__miquido.svg
  [website]: https://www.miquido.com/
  [github]: https://github.com/miquido
  [bitbucket]: https://bitbucket.org/miquido
