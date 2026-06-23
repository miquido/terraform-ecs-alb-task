# 1.0.0 (2026-06-23)


### Bug Fixes

* Added full name for appmesh service ([fa469af](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/fa469afbfc5375da248b39d4e3d14663f39f8f6a))
* **alarms:** Make "ecs_cluster_name" optional ([50a605f](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/50a605f9f1d0919cda101b4cf227f280b794c58f))
* app mesh redis address ([bf439e3](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/bf439e361f7027caf506a2dbe4737502b0d3ec8f))
* bump tags ([425350e](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/425350e228ce68c28dd059107c5d86655c70a17a))
* bump tags ([225fd7a](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/225fd7a80bae25e095d95704f61d60178c7cc5f3))
* cicd ([8a1ccb6](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/8a1ccb677789e102bd4a560bd6a7318694678583))
* cicd ([ae0045c](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/ae0045ce28fd462ae240c6e911f4b0ac706bb70f))
* cicd ([66e1769](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/66e1769617845edbe31ed1fd986f5e3b93d85c8c))
* cicd ([8e027ed](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/8e027ed909c488523528ff46e0f26f8af13e4191))
* **cloudwatch:** Add outputs "log_group_name" and "log_group_arn" ([5982fc9](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/5982fc9747ba49b4a41611ffd7359efeab4bbc8b))
* **cloudwatch:** Add prefix "/aws/ecs/" to created log group to keep consistency across terraform mo ([b021b37](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/b021b375f8fd7314ef2aac234ade19d4514c8dc6))
* **container:** Set container cpu, memory and memory reservation to 0 ([d9baae7](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/d9baae7e3e603eb5a518b27cb2fb03745e27307d))
* **deps:** rollback to 0.57.0 version of task module as it's already using it ([073e126](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/073e126530945586df3682bb632e68e556e823d1))
* **docs:** Improved additional containers input documentation ([8afc694](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/8afc6943b641132e23e35bcf0430f243bdaa0056))
* ecs_load_balancers.elb_name should be optional ([0cebb09](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/0cebb0903efdaaa51d3ec679a029880bc294996a))
* **ecs:** fixed default secret options for log configuration ([0b77c04](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/0b77c0468daa50597158b92a74a7cdaa9eb85be1))
* **ecs:** update mount_points to be empty list by default ([6bf1cfe](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/6bf1cfef051efdce6712e04f34148630fe775d80))
* **envoy-proxy:** pass correct awslogs-group value when not using use_default_log_config ([42dffc2](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/42dffc2e7aabaeb2a3249e30f6367d17ac569de6))
* fmt ([bfd454a](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/bfd454adce6c5446765b0b5a9dcf721ab861a9f0))
* **ssh:** Windows has problems with ssh. Changed to https ([990bf35](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/990bf352b566f7982d3872f118c808e495e52ce2))
* **vars:** secrets length(null) ([c9958bf](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/c9958bf5d644243ccb7039eea1a0556be03f7907))


### Features

* Add "additional_containers" variable to provide way of adding additional containers to the sam ([1ed4dab](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/1ed4daba144077ecf557ffacc603e11550898727))
* Add service_arn output ([b854700](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/b85470053634128d3c700f3a0c3d8f2230265388))
* Add variables to define container healtcheck and readonly file system ([cbaa56d](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/cbaa56da559d82838870c5e7ac00760bd6e8b627))
* Added container_definition variable ([cfabdc8](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/cfabdc89913b6833f734330c8d8b62bcab03ea3f))
* Added container_definition variable ([3d4ced0](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/3d4ced02e5e3a2de6e8efc0fe4c742145287fb06))
* Added health check period for envoy container ([01704ea](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/01704eaf86d32e857e1e39f5afb8cc82db511fa8))
* Added optional basic auth using traefik ([f62c609](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/f62c6095806bf8b86120a6e23eaafb5be6e4577a))
* **alarms:** Configure alerting to SNS topics and CloudWatch ([f2a0bdf](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/f2a0bdfa61ad23c388fab45a6f4d3906246ea5d7))
* Allow configuration of auto assign IP ([5a39b59](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/5a39b59821f72789fd516134e99f6505098ef50c))
* **app mesh:** Added appmesh ([1350c60](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/1350c607fcd38ff5e9aee71d2007c219653998d0))
* **autoscalling:** Add configuration ([2aecd99](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/2aecd99d638652d49b724aadf88af8cd78d6985c))
* Backport features from upstream ([51b73b6](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/51b73b65a9d278c698e263b9034104abdd89bd85)), closes [#2](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/issues/2)
* Backport upstream features ([d220822](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/d220822d802998dfb931a9c85ea09e5a38245f0d)), closes [#5](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/issues/5)
* Backport upstream features ([799d881](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/799d881c3bcf867899689228ca9dbb7aa1e091b5))
* Change to Terraform 0.12 ([04235c0](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/04235c0407b2df69a988554e2b0741988709b2fa))
* **ci:** Dependabot ([0770072](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/077007255464b56ff6d29308e19c55309a4d5d54))
* **ci:** docs ([b1a0cbe](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/b1a0cbee5fa107f3360c43a1d90b9f82ab51ed80))
* **cloudposse:** bump cloudposse module versions to newest ([cc380f5](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/cc380f57b01bea01d6d0d9fcb147e127465e04fd))
* **container:** Add "command" and "entrypoint" variables to configure executable and CLI args of container ([5f5ca91](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/5f5ca91ec106f753bb397e51ae63e27e132b3b70))
* Create module ([2049a74](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/2049a74f055a2fffbb1f6301ad4281f695a9d8b4))
* **ecs:** add  exec_enabled variable ([c063639](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/c0636394b5c26cfa9144ecdcf35032be8752c60a))
* **ecs:** adde extra_hosts parameter ([ce0473e](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/ce0473ec8799d51f7a867824e367c3e8c5fdaceb))
* **ecs:** default to 1.4.0 ECS platform version and bump cloudposse modules ([441aa22](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/441aa227fe359c6783ff039bf4282c7dcc8c5f45))
* **ecs:** Exposing "ignore_changes_task_definition" parameter. ([62cbb13](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/62cbb13b2e40d353fe722efef0e616fc4eab2b7d))
* **ecs:** introduce new variable force_new_deployment for automatic task deployment ([8fede45](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/8fede45b0d67b40976785b4c77b95ddfe69a18a2))
* **ecs:** set envs for container as empty list by default ([ca95953](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/ca95953acf77d9075d47e9607c1edec131e55a7e))
* enable secrets manager permissions ([9733cc8](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/9733cc86fdf9a55889ee2f94bc41fadb0fdf0099))
* **log:** Add default log retention ([71e81b8](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/71e81b86c7a2b72de81903c812f3057779ad0827))
* **log:** automatically add defined secrets to log_configuration option for cloudwatch ([61c3515](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/61c3515d085b276609229eb578986c2c76c460e0))
* missing name in additional_port_mappings variable ([ec2b101](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/ec2b101f51374f28eed41a16a904f1dd9a72710a))
* moved submodules to open source ([5fd2373](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/5fd2373e4163a8c5df6fac8774d4e7b8140a4c32))
* **output:** add task definition arn output ([965962d](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/965962d5ecf8cdbcea801fe9de875cb0e62ca7c8))
* Parametrized protocol ([78b9573](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/78b957344bce9060d1c0c1f834c70f85727539cc))
* **provider:** lock AWS provider to version 3.x ([e081535](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/e0815354359595ac51c0da79db226eb434f7580d))
* Removed Appmesh and replaced it by service_connect_configurations ([de0367c](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/de0367ca548b5f97b0c12eb59a741160ce71aa1e))
* service_security_group_id ([c11cb68](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/c11cb681fa47fc87d0c16625e2a9c931be8d124d))
* Support AWS Capacity Providers ([eef805d](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/eef805d480f3b5cfadf77b0e725f28c50c6a46e0)), closes [#6](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/issues/6)
* **task:** support passing task_role_arn parameter ([dcf01d2](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/dcf01d2f4937abdab35bd9b546e6776ef98f6f5f))
* **terraform:** update to terraform 0.13.5 ([2adb6d9](https://gitlab.miquido.com/miquido/terraform/terraform-ecs-alb-task/commit/2adb6d92cb3ee6d9b26a96c2aaf814aab3afd132))


### BREAKING CHANGES

* New required input variable added: alb_security_group

Approved-by: Konrad Obal <konrad.obal@miquido.com>
