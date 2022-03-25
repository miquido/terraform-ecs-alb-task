<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![Miquido][logo]](https://www.miquido.com/)

# miquido-terraform-ecs-alb-task
Provide ECS Service and Task configuration with ALB attachement
---
**Terraform Module**
<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint Terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.7 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_appmesh"></a> [appmesh](#module\_appmesh) | git::ssh://git@gitlab.com/miquido/terraform/terraform-app-mesh-service.git | 1.0.6 |
| <a name="module_autoscaling"></a> [autoscaling](#module\_autoscaling) | git::https://github.com/cloudposse/terraform-aws-ecs-cloudwatch-autoscaling.git | 0.7.3 |
| <a name="module_container"></a> [container](#module\_container) | git::https://github.com/cloudposse/terraform-aws-ecs-container-definition | 0.58.1 |
| <a name="module_ecs-alb-task-envoy-proxy"></a> [ecs-alb-task-envoy-proxy](#module\_ecs-alb-task-envoy-proxy) | git::ssh://git@gitlab.com/miquido/terraform/terraform-ecs-envoy.git | 1.1.7 |
| <a name="module_ecs-service-alarms"></a> [ecs-service-alarms](#module\_ecs-service-alarms) | git::https://github.com/cloudposse/terraform-aws-ecs-cloudwatch-sns-alarms.git | 0.12.2 |
| <a name="module_label"></a> [label](#module\_label) | git::https://github.com/cloudposse/terraform-terraform-label | 0.8.0 |
| <a name="module_task"></a> [task](#module\_task) | git::https://github.com/cloudposse/terraform-aws-ecs-alb-service-task | 0.59.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role_policy.ecs-exec-ssm-secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.ecs-exec-ssm-secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_containers"></a> [additional\_containers](#input\_additional\_containers) | Additional container definitions to include in the task. List of JSON Map formats should be used (see cloudposse/terraform-aws-ecs-container-definition module output: json\_map\_encoded) | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_additional_port_mappings"></a> [additional\_port\_mappings](#input\_additional\_port\_mappings) | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | <pre>list(object({<br>    containerPort = number<br>    hostPort      = number<br>    protocol      = string<br>  }))</pre> | `[]` | no |
| <a name="input_alb_target_group_arn"></a> [alb\_target\_group\_arn](#input\_alb\_target\_group\_arn) | The ALB target group ARN for the ECS service | `string` | `""` | no |
| <a name="input_app_mesh_aws_service_discovery_private_dns_namespace"></a> [app\_mesh\_aws\_service\_discovery\_private\_dns\_namespace](#input\_app\_mesh\_aws\_service\_discovery\_private\_dns\_namespace) | app mesh private DNS namespace | <pre>object({<br>    name        = string<br>    id          = string<br>    hosted_zone = string<br>  })</pre> | `null` | no |
| <a name="input_app_mesh_egress_ignored_ports"></a> [app\_mesh\_egress\_ignored\_ports](#input\_app\_mesh\_egress\_ignored\_ports) | App mesh egress ignored ports | `string` | `""` | no |
| <a name="input_app_mesh_enable"></a> [app\_mesh\_enable](#input\_app\_mesh\_enable) | Should app mesh resources be created for this service | `bool` | `false` | no |
| <a name="input_app_mesh_health_check_path"></a> [app\_mesh\_health\_check\_path](#input\_app\_mesh\_health\_check\_path) | service health check path for app mesh | `string` | `null` | no |
| <a name="input_app_mesh_id"></a> [app\_mesh\_id](#input\_app\_mesh\_id) | app mesh id to create service entry | `string` | `null` | no |
| <a name="input_app_mesh_route53_zone"></a> [app\_mesh\_route53\_zone](#input\_app\_mesh\_route53\_zone) | app\_mesh route zone to create service entry | <pre>object({<br>    id   = string<br>    name = string<br>  })</pre> | `null` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false. | `bool` | `false` | no |
| <a name="input_autoscaling_dimension"></a> [autoscaling\_dimension](#input\_autoscaling\_dimension) | Dimension to autoscale on (valid options: cpu, memory) | `string` | `"cpu"` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | A boolean to enable/disable Autoscaling policy for ECS Service | `bool` | `false` | no |
| <a name="input_autoscaling_max_capacity"></a> [autoscaling\_max\_capacity](#input\_autoscaling\_max\_capacity) | Maximum number of running instances of a Service | `number` | `2` | no |
| <a name="input_autoscaling_min_capacity"></a> [autoscaling\_min\_capacity](#input\_autoscaling\_min\_capacity) | Minimum number of running instances of a Service | `number` | `1` | no |
| <a name="input_autoscaling_scale_down_adjustment"></a> [autoscaling\_scale\_down\_adjustment](#input\_autoscaling\_scale\_down\_adjustment) | Scaling adjustment to make during scale down event | `number` | `-1` | no |
| <a name="input_autoscaling_scale_down_cooldown"></a> [autoscaling\_scale\_down\_cooldown](#input\_autoscaling\_scale\_down\_cooldown) | Period (in seconds) to wait between scale down events | `number` | `300` | no |
| <a name="input_autoscaling_scale_up_adjustment"></a> [autoscaling\_scale\_up\_adjustment](#input\_autoscaling\_scale\_up\_adjustment) | Scaling adjustment to make during scale up event | `number` | `1` | no |
| <a name="input_autoscaling_scale_up_cooldown"></a> [autoscaling\_scale\_up\_cooldown](#input\_autoscaling\_scale\_up\_cooldown) | Period (in seconds) to wait between scale up events | `number` | `60` | no |
| <a name="input_capacity_provider_strategies"></a> [capacity\_provider\_strategies](#input\_capacity\_provider\_strategies) | The capacity provider strategies to use for the service. See `capacity_provider_strategy` configuration block: https://www.terraform.io/docs/providers/aws/r/ecs_service.html#capacity_provider_strategy | <pre>list(object({<br>    capacity_provider = string<br>    weight            = number<br>    base              = number<br>  }))</pre> | `[]` | no |
| <a name="input_circuit_breaker_deployment_enabled"></a> [circuit\_breaker\_deployment\_enabled](#input\_circuit\_breaker\_deployment\_enabled) | Whether to enable the deployment circuit breaker logic for the service | `bool` | `false` | no |
| <a name="input_circuit_breaker_rollback_enabled"></a> [circuit\_breaker\_rollback\_enabled](#input\_circuit\_breaker\_rollback\_enabled) | Whether to enable Amazon ECS to roll back the service if a service deployment fails | `bool` | `false` | no |
| <a name="input_command"></a> [command](#input\_command) | The command that is passed to the container | `list(string)` | `null` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container\_cpu of all containers in a task will need to be lower than the task-level cpu value | `number` | `null` | no |
| <a name="input_container_depends_on"></a> [container\_depends\_on](#input\_container\_depends\_on) | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | <pre>list(object({<br>    containerName = string<br>    condition     = string<br>  }))</pre> | `[]` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The image used to start the container. Images in the Docker Hub registry available by default | `string` | n/a | yes |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container\_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container\_memory of all containers in a task will need to be lower than the task memory value | `number` | `null` | no |
| <a name="input_container_memory_reservation"></a> [container\_memory\_reservation](#input\_container\_memory\_reservation) | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container\_memory hard limit | `number` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port on the container to associate with the load balancer | `number` | `80` | no |
| <a name="input_container_tag"></a> [container\_tag](#input\_container\_tag) | n/a | `string` | `"latest"` | no |
| <a name="input_deployment_controller_type"></a> [deployment\_controller\_type](#input\_deployment\_controller\_type) | Type of deployment controller. Valid values: `CODE_DEPLOY`, `ECS`. | `string` | `"ECS"` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | `list(string)` | `null` | no |
| <a name="input_docker_labels"></a> [docker\_labels](#input\_docker\_labels) | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| <a name="input_ecs_alarms_alarm_description"></a> [ecs\_alarms\_alarm\_description](#input\_ecs\_alarms\_alarm\_description) | The string to format and use as the alarm description. | `string` | `"Average service %v utilization %v last %d minute(s) over %v period(s)"` | no |
| <a name="input_ecs_alarms_cpu_utilization_high_alarm_actions"></a> [ecs\_alarms\_cpu\_utilization\_high\_alarm\_actions](#input\_ecs\_alarms\_cpu\_utilization\_high\_alarm\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High Alarm action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_cpu_utilization_high_evaluation_periods"></a> [ecs\_alarms\_cpu\_utilization\_high\_evaluation\_periods](#input\_ecs\_alarms\_cpu\_utilization\_high\_evaluation\_periods) | Number of periods to evaluate for the alarm | `number` | `1` | no |
| <a name="input_ecs_alarms_cpu_utilization_high_ok_actions"></a> [ecs\_alarms\_cpu\_utilization\_high\_ok\_actions](#input\_ecs\_alarms\_cpu\_utilization\_high\_ok\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High OK action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_cpu_utilization_high_period"></a> [ecs\_alarms\_cpu\_utilization\_high\_period](#input\_ecs\_alarms\_cpu\_utilization\_high\_period) | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| <a name="input_ecs_alarms_cpu_utilization_high_threshold"></a> [ecs\_alarms\_cpu\_utilization\_high\_threshold](#input\_ecs\_alarms\_cpu\_utilization\_high\_threshold) | The maximum percentage of CPU utilization average | `number` | `80` | no |
| <a name="input_ecs_alarms_cpu_utilization_low_alarm_actions"></a> [ecs\_alarms\_cpu\_utilization\_low\_alarm\_actions](#input\_ecs\_alarms\_cpu\_utilization\_low\_alarm\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low Alarm action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_cpu_utilization_low_evaluation_periods"></a> [ecs\_alarms\_cpu\_utilization\_low\_evaluation\_periods](#input\_ecs\_alarms\_cpu\_utilization\_low\_evaluation\_periods) | Number of periods to evaluate for the alarm | `number` | `1` | no |
| <a name="input_ecs_alarms_cpu_utilization_low_ok_actions"></a> [ecs\_alarms\_cpu\_utilization\_low\_ok\_actions](#input\_ecs\_alarms\_cpu\_utilization\_low\_ok\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low OK action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_cpu_utilization_low_period"></a> [ecs\_alarms\_cpu\_utilization\_low\_period](#input\_ecs\_alarms\_cpu\_utilization\_low\_period) | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| <a name="input_ecs_alarms_cpu_utilization_low_threshold"></a> [ecs\_alarms\_cpu\_utilization\_low\_threshold](#input\_ecs\_alarms\_cpu\_utilization\_low\_threshold) | The minimum percentage of CPU utilization average | `number` | `20` | no |
| <a name="input_ecs_alarms_enabled"></a> [ecs\_alarms\_enabled](#input\_ecs\_alarms\_enabled) | A boolean to enable/disable CloudWatch Alarms for ECS Service metrics | `bool` | `false` | no |
| <a name="input_ecs_alarms_memory_utilization_high_alarm_actions"></a> [ecs\_alarms\_memory\_utilization\_high\_alarm\_actions](#input\_ecs\_alarms\_memory\_utilization\_high\_alarm\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High Alarm action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_memory_utilization_high_evaluation_periods"></a> [ecs\_alarms\_memory\_utilization\_high\_evaluation\_periods](#input\_ecs\_alarms\_memory\_utilization\_high\_evaluation\_periods) | Number of periods to evaluate for the alarm | `number` | `1` | no |
| <a name="input_ecs_alarms_memory_utilization_high_ok_actions"></a> [ecs\_alarms\_memory\_utilization\_high\_ok\_actions](#input\_ecs\_alarms\_memory\_utilization\_high\_ok\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High OK action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_memory_utilization_high_period"></a> [ecs\_alarms\_memory\_utilization\_high\_period](#input\_ecs\_alarms\_memory\_utilization\_high\_period) | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| <a name="input_ecs_alarms_memory_utilization_high_threshold"></a> [ecs\_alarms\_memory\_utilization\_high\_threshold](#input\_ecs\_alarms\_memory\_utilization\_high\_threshold) | The maximum percentage of Memory utilization average | `number` | `80` | no |
| <a name="input_ecs_alarms_memory_utilization_low_alarm_actions"></a> [ecs\_alarms\_memory\_utilization\_low\_alarm\_actions](#input\_ecs\_alarms\_memory\_utilization\_low\_alarm\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low Alarm action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_memory_utilization_low_evaluation_periods"></a> [ecs\_alarms\_memory\_utilization\_low\_evaluation\_periods](#input\_ecs\_alarms\_memory\_utilization\_low\_evaluation\_periods) | Number of periods to evaluate for the alarm | `number` | `1` | no |
| <a name="input_ecs_alarms_memory_utilization_low_ok_actions"></a> [ecs\_alarms\_memory\_utilization\_low\_ok\_actions](#input\_ecs\_alarms\_memory\_utilization\_low\_ok\_actions) | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low OK action | `list(string)` | `[]` | no |
| <a name="input_ecs_alarms_memory_utilization_low_period"></a> [ecs\_alarms\_memory\_utilization\_low\_period](#input\_ecs\_alarms\_memory\_utilization\_low\_period) | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| <a name="input_ecs_alarms_memory_utilization_low_threshold"></a> [ecs\_alarms\_memory\_utilization\_low\_threshold](#input\_ecs\_alarms\_memory\_utilization\_low\_threshold) | The minimum percentage of Memory utilization average | `number` | `20` | no |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | The ARN of the ECS cluster where service will be provisioned | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | The Name of the ECS cluster where service will be provisioned. Required for alarms. | `string` | `""` | no |
| <a name="input_ecs_default_alb_enabled"></a> [ecs\_default\_alb\_enabled](#input\_ecs\_default\_alb\_enabled) | Whether to create default load balancer configuration with attached provided ALB Target group to main container. Requires setting `alb_target_group_arn` variable. | `bool` | `true` | no |
| <a name="input_ecs_load_balancers"></a> [ecs\_load\_balancers](#input\_ecs\_load\_balancers) | A list of load balancer config objects for the ECS service; see `load_balancer` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html | <pre>list(object({<br>    container_name   = string<br>    container_port   = number<br>    elb_name         = string<br>    target_group_arn = string<br>  }))</pre> | `[]` | no |
| <a name="input_enable_ecs_managed_tags"></a> [enable\_ecs\_managed\_tags](#input\_enable\_ecs\_managed\_tags) | Specifies whether to enable Amazon ECS managed tags for the tasks within the service | `bool` | `true` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | The entry point that is passed to the container | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `""` | no |
| <a name="input_envs"></a> [envs](#input\_envs) | The environment variables to pass to the container. This is a list of maps | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `true` | no |
| <a name="input_exec_enabled"></a> [exec\_enabled](#input\_exec\_enabled) | Specifies whether to enable Amazon ECS Exec for the tasks within the service | `bool` | `false` | no |
| <a name="input_extra_hosts"></a> [extra\_hosts](#input\_extra\_hosts) | A list of hostnames and IP address mappings to append to the /etc/hosts file on the container. This is a list of maps | <pre>list(object({<br>    ipAddress = string<br>    hostname  = string<br>  }))</pre> | `null` | no |
| <a name="input_firelens_configuration"></a> [firelens\_configuration](#input\_firelens\_configuration) | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html | <pre>object({<br>    type    = string<br>    options = map(string)<br>  })</pre> | `null` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Enable to force a new task deployment of the service. | `bool` | `false` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers | `string` | `0` | no |
| <a name="input_healthcheck"></a> [healthcheck](#input\_healthcheck) | A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | <pre>object({<br>    command     = list(string)<br>    retries     = number<br>    timeout     = number<br>    interval    = number<br>    startPeriod = number<br>  })</pre> | `null` | no |
| <a name="input_ignore_changes_task_definition"></a> [ignore\_changes\_task\_definition](#input\_ignore\_changes\_task\_definition) | Whether to ignore changes in container definition and task definition in the ECS service | `bool` | `true` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service. Valid values are `EC2` and `FARGATE` | `string` | `"FARGATE"` | no |
| <a name="input_links"></a> [links](#input\_links) | List of container names this container can communicate with without port mappings | `list(string)` | `null` | no |
| <a name="input_linux_parameters"></a> [linux\_parameters](#input\_linux\_parameters) | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html | <pre>object({<br>    capabilities = object({<br>      add  = list(string)<br>      drop = list(string)<br>    })<br>    devices = list(object({<br>      containerPath = string<br>      hostPath      = string<br>      permissions   = list(string)<br>    }))<br>    initProcessEnabled = bool<br>    maxSwap            = number<br>    sharedMemorySize   = number<br>    swappiness         = number<br>    tmpfs = list(object({<br>      containerPath = string<br>      mountOptions  = list(string)<br>      size          = number<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | <pre>object({<br>    logDriver = string<br>    options   = map(string)<br>    secretOptions = list(object({<br>      name      = string<br>      valueFrom = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Specifies the number of days you want to retain log events in the specified log group. Option has no effect when custom "log\_configuration" variable is specified. | `number` | `7` | no |
| <a name="input_logs_region"></a> [logs\_region](#input\_logs\_region) | AWS Logs Region | `string` | n/a | yes |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`. The `readOnly` key is optional. | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Resource common name | `string` | n/a | yes |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` | `string` | `"awsvpc"` | no |
| <a name="input_ordered_placement_strategy"></a> [ordered\_placement\_strategy](#input\_ordered\_placement\_strategy) | Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered\_placement\_strategy blocks is 5. See `ordered_placement_strategy` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#ordered_placement_strategy-1 | <pre>list(object({<br>    type  = string<br>    field = string<br>  }))</pre> | `[]` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | The platform version on which to run your service. Only applicable for launch\_type set to FARGATE. More information about Fargate platform versions can be found in the AWS ECS User Guide. | `string` | `"1.4.0"` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type. Due to how Terraform type casts booleans in json it is required to double quote this value | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | Account/Project Name | `string` | n/a | yes |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK\_DEFINITION. | `string` | `"SERVICE"` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments | <pre>object({<br>    type           = string<br>    container_name = string<br>    properties     = map(string)<br>  })</pre> | `null` | no |
| <a name="input_readonly_root_filesystem"></a> [readonly\_root\_filesystem](#input\_readonly\_root\_filesystem) | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `false` | no |
| <a name="input_repository_credentials"></a> [repository\_credentials](#input\_repository\_credentials) | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | `map(string)` | `null` | no |
| <a name="input_scheduling_strategy"></a> [scheduling\_strategy](#input\_scheduling\_strategy) | The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Note that Fargate tasks do not support the DAEMON scheduling strategy. | `string` | `"REPLICA"` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The Security Group description. | `string` | `"ECS service Security Group"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs to allow in Service `network_configuration` | `list(string)` | n/a | yes |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A list of maps of Security Group rules.<br>The values of map is fully complated with `aws_security_group_rule` resource.<br>To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule . | `list(any)` | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow all outbound traffic",<br>    "from_port": 0,<br>    "protocol": -1,<br>    "to_port": 0,<br>    "type": "egress"<br>  },<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Enables ping command from anywhere, see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html#sg-rules-ping",<br>    "from_port": 8,<br>    "protocol": "icmp",<br>    "to_port": 0,<br>    "type": "ingress"<br>  }<br>]</pre> | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Whether to create a default Security Group with unique name beginning with the normalized prefix. | `bool` | `false` | no |
| <a name="input_service_placement_constraints"></a> [service\_placement\_constraints](#input\_service\_placement\_constraints) | The rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. See `placement_constraints` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#placement_constraints-1 | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | The service discovery registries for the service. The maximum number of service\_registries blocks is 1. The currently supported service registry is Amazon Route 53 Auto Naming Service - `aws_service_discovery_service`; see `service_registries` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#service_registries-1 | <pre>list(object({<br>    registry_arn   = string<br>    port           = number<br>    container_name = string<br>    container_port = number<br>  }))</pre> | `[]` | no |
| <a name="input_ssm_secrets_enabled"></a> [ssm\_secrets\_enabled](#input\_ssm\_secrets\_enabled) | Adds IAM Policy for reading secrets from Systems Manager Paramameter Store (use 'ssm\_secrets\_resources' to limit access to the SSM resources) | `bool` | `false` | no |
| <a name="input_ssm_secrets_resources"></a> [ssm\_secrets\_resources](#input\_ssm\_secrets\_resources) | Limit access to the SSM Parameters when 'enable\_secrets\_from\_ssm' is enabled. By default no resources are allowed to be read. | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_start_timeout"></a> [start\_timeout](#input\_start\_timeout) | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | `number` | `30` | no |
| <a name="input_stop_timeout"></a> [stop\_timeout](#input\_stop\_timeout) | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `30` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs | `list(string)` | n/a | yes |
| <a name="input_system_controls"></a> [system\_controls](#input\_system\_controls) | A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = "", value = ""} | `list(map(string))` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply on repository | `map(string)` | `{}` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `256` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `512` | no |
| <a name="input_task_placement_constraints"></a> [task\_placement\_constraints](#input\_task\_placement\_constraints) | A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. See `placement_constraints` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#placement-constraints-arguments | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services | `string` | `""` | no |
| <a name="input_ulimits"></a> [ulimits](#input\_ulimits) | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    name      = string<br>    hardLimit = number<br>    softLimit = number<br>  }))</pre> | `null` | no |
| <a name="input_user"></a> [user](#input\_user) | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group | `string` | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | Task volume definitions as list of configuration objects | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_volumes_from"></a> [volumes\_from](#input\_volumes\_from) | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume) | <pre>list(object({<br>    sourceContainer = string<br>    readOnly        = bool<br>  }))</pre> | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where resources are created | `string` | n/a | yes |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | The working directory to run commands inside the container | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_mesh_service_dns"></a> [app\_mesh\_service\_dns](#output\_app\_mesh\_service\_dns) | Service DNS available inside app mesh |
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | ECS task container name |
| <a name="output_ecs_exec_role_policy_id"></a> [ecs\_exec\_role\_policy\_id](#output\_ecs\_exec\_role\_policy\_id) | The ECS service role policy ID, in the form of role\_name:role\_policy\_name |
| <a name="output_ecs_exec_role_policy_name"></a> [ecs\_exec\_role\_policy\_name](#output\_ecs\_exec\_role\_policy\_name) | ECS service role name |
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | The Amazon Resource Name (ARN) specifying the log group |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The name of the log group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security Group ID of the ECS task |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | ECS Service name |
| <a name="output_service_role_arn"></a> [service\_role\_arn](#output\_service\_role\_arn) | ECS Service role ARN |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | ECS task definition family |
| <a name="output_task_definition_revision"></a> [task\_definition\_revision](#output\_task\_definition\_revision) | ECS task definition revision |
| <a name="output_task_exec_role_arn"></a> [task\_exec\_role\_arn](#output\_task\_exec\_role\_arn) | ECS Task exec role ARN |
| <a name="output_task_exec_role_name"></a> [task\_exec\_role\_name](#output\_task\_exec\_role\_name) | ECS Task role name |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | ECS Task role ARN |
| <a name="output_task_role_name"></a> [task\_role\_name](#output\_task\_role\_name) | ECS Task role name |
<!-- markdownlint-restore -->


## Developing

1. Make changes in terraform files

2. Regenerate documentation

    ```bash
    bash <(git archive --remote=git@gitlab.com:miquido/terraform/terraform-readme-update.git master update.sh | tar -xO)
    ```

3. Run lint

    ```
    make lint
    ```

## Copyright

Copyright © 2017-2022 [Miquido](https://miquido.com)



### Contributors

|  [![Konrad Obal][k911_avatar]][k911_homepage]<br/>[Konrad Obal][k911_homepage] |
|---|

  [k911_homepage]: https://github.com/k911
  [k911_avatar]: https://github.com/k911.png?size=150



  [logo]: https://www.miquido.com/img/logos/logo__miquido.svg
  [website]: https://www.miquido.com/
  [gitlab]: https://gitlab.com/miquido
  [github]: https://github.com/miquido
  [bitbucket]: https://bitbucket.org/miquido

