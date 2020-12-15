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
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_containers | Additional container definitions to include in the task. JSON Map format should be used (see cloudposse/terraform-aws-ecs-container-definition module output: json\_map) | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| additional\_port\_mappings | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | <pre>list(object({<br>    containerPort = number<br>    hostPort      = number<br>    protocol      = string<br>  }))</pre> | `[]` | no |
| alb\_target\_group\_arn | The ALB target group ARN for the ECS service | `string` | `""` | no |
| assign\_public\_ip | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false. | `bool` | `false` | no |
| autoscaling\_dimension | Dimension to autoscale on (valid options: cpu, memory) | `string` | `"cpu"` | no |
| autoscaling\_enabled | A boolean to enable/disable Autoscaling policy for ECS Service | `bool` | `false` | no |
| autoscaling\_max\_capacity | Maximum number of running instances of a Service | `number` | `2` | no |
| autoscaling\_min\_capacity | Minimum number of running instances of a Service | `number` | `1` | no |
| autoscaling\_scale\_down\_adjustment | Scaling adjustment to make during scale down event | `number` | `-1` | no |
| autoscaling\_scale\_down\_cooldown | Period (in seconds) to wait between scale down events | `number` | `300` | no |
| autoscaling\_scale\_up\_adjustment | Scaling adjustment to make during scale up event | `number` | `1` | no |
| autoscaling\_scale\_up\_cooldown | Period (in seconds) to wait between scale up events | `number` | `60` | no |
| capacity\_provider\_strategies | The capacity provider strategies to use for the service. See `capacity_provider_strategy` configuration block: https://www.terraform.io/docs/providers/aws/r/ecs_service.html#capacity_provider_strategy | <pre>list(object({<br>    capacity_provider = string<br>    weight            = number<br>    base              = number<br>  }))</pre> | `[]` | no |
| command | The command that is passed to the container | `list(string)` | `null` | no |
| container\_cpu | The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container\_cpu of all containers in a task will need to be lower than the task-level cpu value | `number` | `null` | no |
| container\_depends\_on | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | <pre>list(object({<br>    containerName = string<br>    condition     = string<br>  }))</pre> | `null` | no |
| container\_image | The image used to start the container. Images in the Docker Hub registry available by default | `string` | n/a | yes |
| container\_memory | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container\_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container\_memory of all containers in a task will need to be lower than the task memory value | `number` | `null` | no |
| container\_memory\_reservation | The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container\_memory hard limit | `number` | `null` | no |
| container\_port | The port on the container to associate with the load balancer | `number` | `80` | no |
| container\_tag | n/a | `string` | `"latest"` | no |
| deployment\_controller\_type | Type of deployment controller. Valid values: `CODE_DEPLOY`, `ECS`. | `string` | `"ECS"` | no |
| deployment\_maximum\_percent | The upper limit of the number of tasks (as a percentage of `desired_count`) that can be running in a service during a deployment | `number` | `200` | no |
| deployment\_minimum\_healthy\_percent | The lower limit (as a percentage of `desired_count`) of the number of tasks that must remain running and healthy in a service during a deployment | `number` | `100` | no |
| desired\_count | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| dns\_servers | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | `list(string)` | `null` | no |
| docker\_labels | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| ecs\_alarms\_alarm\_description | The string to format and use as the alarm description. | `string` | `"Average service %v utilization %v last %d minute(s) over %v period(s)"` | no |
| ecs\_alarms\_cpu\_utilization\_high\_alarm\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High Alarm action | `list(string)` | `[]` | no |
| ecs\_alarms\_cpu\_utilization\_high\_evaluation\_periods | Number of periods to evaluate for the alarm | `number` | `1` | no |
| ecs\_alarms\_cpu\_utilization\_high\_ok\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization High OK action | `list(string)` | `[]` | no |
| ecs\_alarms\_cpu\_utilization\_high\_period | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| ecs\_alarms\_cpu\_utilization\_high\_threshold | The maximum percentage of CPU utilization average | `number` | `80` | no |
| ecs\_alarms\_cpu\_utilization\_low\_alarm\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low Alarm action | `list(string)` | `[]` | no |
| ecs\_alarms\_cpu\_utilization\_low\_evaluation\_periods | Number of periods to evaluate for the alarm | `number` | `1` | no |
| ecs\_alarms\_cpu\_utilization\_low\_ok\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on CPU Utilization Low OK action | `list(string)` | `[]` | no |
| ecs\_alarms\_cpu\_utilization\_low\_period | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| ecs\_alarms\_cpu\_utilization\_low\_threshold | The minimum percentage of CPU utilization average | `number` | `20` | no |
| ecs\_alarms\_enabled | A boolean to enable/disable CloudWatch Alarms for ECS Service metrics | `bool` | `false` | no |
| ecs\_alarms\_memory\_utilization\_high\_alarm\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High Alarm action | `list(string)` | `[]` | no |
| ecs\_alarms\_memory\_utilization\_high\_evaluation\_periods | Number of periods to evaluate for the alarm | `number` | `1` | no |
| ecs\_alarms\_memory\_utilization\_high\_ok\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization High OK action | `list(string)` | `[]` | no |
| ecs\_alarms\_memory\_utilization\_high\_period | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| ecs\_alarms\_memory\_utilization\_high\_threshold | The maximum percentage of Memory utilization average | `number` | `80` | no |
| ecs\_alarms\_memory\_utilization\_low\_alarm\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low Alarm action | `list(string)` | `[]` | no |
| ecs\_alarms\_memory\_utilization\_low\_evaluation\_periods | Number of periods to evaluate for the alarm | `number` | `1` | no |
| ecs\_alarms\_memory\_utilization\_low\_ok\_actions | A list of ARNs (i.e. SNS Topic ARN) to notify on Memory Utilization Low OK action | `list(string)` | `[]` | no |
| ecs\_alarms\_memory\_utilization\_low\_period | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| ecs\_alarms\_memory\_utilization\_low\_threshold | The minimum percentage of Memory utilization average | `number` | `20` | no |
| ecs\_cluster\_arn | The ARN of the ECS cluster where service will be provisioned | `string` | n/a | yes |
| ecs\_cluster\_name | The Name of the ECS cluster where service will be provisioned. Required for alarms. | `string` | `""` | no |
| ecs\_default\_alb\_enabled | Whether to create default load balancer configuration with attached provided ALB Target group to main container. Requires setting `alb_target_group_arn` variable. | `bool` | `true` | no |
| ecs\_load\_balancers | A list of load balancer config objects for the ECS service; see `load_balancer` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html | <pre>list(object({<br>    container_name   = string<br>    container_port   = number<br>    elb_name         = string<br>    target_group_arn = string<br>  }))</pre> | `[]` | no |
| enable\_ecs\_managed\_tags | Specifies whether to enable Amazon ECS managed tags for the tasks within the service | `bool` | `true` | no |
| entrypoint | The entry point that is passed to the container | `list(string)` | `null` | no |
| environment | Environment name | `string` | `""` | no |
| envs | The environment variables to pass to the container. This is a list of maps | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| essential | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `true` | no |
| extra\_hosts | A list of hostnames and IP address mappings to append to the /etc/hosts file on the container. This is a list of maps | <pre>list(object({<br>    ipAddress = string<br>    hostname  = string<br>  }))</pre> | `null` | no |
| firelens\_configuration | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html | <pre>object({<br>    type    = string<br>    options = map(string)<br>  })</pre> | `null` | no |
| health\_check\_grace\_period\_seconds | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 7200. Only valid for services configured to use load balancers | `string` | `0` | no |
| healthcheck | A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | <pre>object({<br>    command     = list(string)<br>    retries     = number<br>    timeout     = number<br>    interval    = number<br>    startPeriod = number<br>  })</pre> | `null` | no |
| ignore\_changes\_task\_definition | Whether to ignore changes in container definition and task definition in the ECS service | `bool` | `true` | no |
| ingress\_security\_group\_id | Default ingress security group. Usually default LB security group. If not set, it defaults to first security group id in `security_groups_ids` variable. | `string` | `null` | no |
| launch\_type | The launch type on which to run your service. Valid values are `EC2` and `FARGATE` | `string` | `"FARGATE"` | no |
| links | List of container names this container can communicate with without port mappings | `list(string)` | `null` | no |
| linux\_parameters | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html | <pre>object({<br>    capabilities = object({<br>      add  = list(string)<br>      drop = list(string)<br>    })<br>    devices = list(object({<br>      containerPath = string<br>      hostPath      = string<br>      permissions   = list(string)<br>    }))<br>    initProcessEnabled = bool<br>    maxSwap            = number<br>    sharedMemorySize   = number<br>    swappiness         = number<br>    tmpfs = list(object({<br>      containerPath = string<br>      mountOptions  = list(string)<br>      size          = number<br>    }))<br>  })</pre> | `null` | no |
| log\_configuration | Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | <pre>object({<br>    logDriver = string<br>    options   = map(string)<br>    secretOptions = list(object({<br>      name      = string<br>      valueFrom = string<br>    }))<br>  })</pre> | `null` | no |
| log\_retention | Specifies the number of days you want to retain log events in the specified log group. Option has no effect when custom "log\_configuration" variable is specified. | `number` | `7` | no |
| logs\_region | AWS Logs Region | `string` | n/a | yes |
| mount\_points | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`. The `readOnly` key is optional. | `list` | `[]` | no |
| name | Resource common name | `string` | n/a | yes |
| network\_mode | The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` | `string` | `"awsvpc"` | no |
| ordered\_placement\_strategy | Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered\_placement\_strategy blocks is 5. See `ordered_placement_strategy` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#ordered_placement_strategy-1 | <pre>list(object({<br>    type  = string<br>    field = string<br>  }))</pre> | `[]` | no |
| platform\_version | The platform version on which to run your service. Only applicable for launch\_type set to FARGATE. More information about Fargate platform versions can be found in the AWS ECS User Guide. | `string` | `"LATEST"` | no |
| privileged | When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type. Due to how Terraform type casts booleans in json it is required to double quote this value | `string` | `null` | no |
| project | Account/Project Name | `string` | n/a | yes |
| propagate\_tags | Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK\_DEFINITION. | `string` | `"SERVICE"` | no |
| proxy\_configuration | The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments | <pre>object({<br>    type           = string<br>    container_name = string<br>    properties     = map(string)<br>  })</pre> | `null` | no |
| readonly\_root\_filesystem | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `false` | no |
| repository\_credentials | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | `map(string)` | `null` | no |
| scheduling\_strategy | The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Note that Fargate tasks do not support the DAEMON scheduling strategy. | `string` | `"REPLICA"` | no |
| secrets | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| security\_group\_ids | Security group IDs to allow in Service `network_configuration` | `list(string)` | n/a | yes |
| service\_placement\_constraints | The rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. See `placement_constraints` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#placement_constraints-1 | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |
| service\_registries | The service discovery registries for the service. The maximum number of service\_registries blocks is 1. The currently supported service registry is Amazon Route 53 Auto Naming Service - `aws_service_discovery_service`; see `service_registries` docs https://www.terraform.io/docs/providers/aws/r/ecs_service.html#service_registries-1 | <pre>list(object({<br>    registry_arn   = string<br>    port           = number<br>    container_name = string<br>    container_port = number<br>  }))</pre> | `[]` | no |
| ssm\_secrets\_enabled | Adds IAM Policy for reading secrets from Systems Manager Paramameter Store (use 'ssm\_secrets\_resources' to limit access to the SSM resources) | `bool` | `false` | no |
| ssm\_secrets\_resources | Limit access to the SSM Parameters when 'enable\_secrets\_from\_ssm' is enabled. By default no resources are allowed to be read. | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| start\_timeout | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | `number` | `30` | no |
| stop\_timeout | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `30` | no |
| subnet\_ids | Subnet IDs | `list(string)` | n/a | yes |
| system\_controls | A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = "", value = ""} | `list(map(string))` | `null` | no |
| tags | Tags to apply on repository | `map(string)` | `{}` | no |
| task\_cpu | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `256` | no |
| task\_memory | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `512` | no |
| task\_placement\_constraints | A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. See `placement_constraints` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#placement-constraints-arguments | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |
| task\_role\_arn | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services | `string` | `""` | no |
| ulimits | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    name      = string<br>    hardLimit = number<br>    softLimit = number<br>  }))</pre> | `null` | no |
| use\_ingress\_security\_group | Whether to use ingress security group. When turned on use `ingress_security_group_id` to configure default ingress security group id. | `bool` | `false` | no |
| user | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group | `string` | `null` | no |
| volumes | Task volume definitions as list of configuration objects | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| volumes\_from | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume) | <pre>list(object({<br>    sourceContainer = string<br>    readOnly        = bool<br>  }))</pre> | `null` | no |
| vpc\_id | The VPC ID where resources are created | `string` | n/a | yes |
| working\_directory | The working directory to run commands inside the container | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| container\_name | ECS task container name |
| ecs\_exec\_role\_policy\_id | The ECS service role policy ID, in the form of role\_name:role\_policy\_name |
| ecs\_exec\_role\_policy\_name | ECS service role name |
| log\_group\_arn | The Amazon Resource Name (ARN) specifying the log group |
| log\_group\_name | The name of the log group |
| service\_name | ECS Service name |
| service\_role\_arn | ECS Service role ARN |
| service\_security\_group\_id | Security Group ID of the ECS task |
| task\_definition\_family | ECS task definition family |
| task\_definition\_revision | ECS task definition revision |
| task\_exec\_role\_arn | ECS Task exec role ARN |
| task\_exec\_role\_name | ECS Task role name |
| task\_role\_arn | ECS Task role ARN |
| task\_role\_name | ECS Task role name |

<!-- markdownlint-restore -->


## Developing

1. Make changes in terraform files

2. Regenerate documentation

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
  [gitlab]: https://gitlab.com/miquido
  [github]: https://github.com/miquido
  [bitbucket]: https://bitbucket.org/miquido

