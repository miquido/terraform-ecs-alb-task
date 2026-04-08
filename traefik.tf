locals {
  traefik_dynamic_config = var.basic_auth != null ? join("\n", concat(
    ["http:", "  routers:"],
    flatten([for i, path in var.basic_auth.ignore_auth_paths : [
      "    path${i}:",
      "      entryPoints: [web]",
      "      rule: \"PathPrefix(`${path}`)\"",
      "      service: app",
      "      priority: 100"
    ]]),
    [
      "    main:",
      "      entryPoints: [web]",
      "      rule: \"PathPrefix(`/`)\"",
      "      service: app",
      "      middlewares: [basic-auth]",
      "  middlewares:",
      "    basic-auth:",
      "      basicAuth:",
      "        usersFile: /tmp/users.htpasswd",
      "  services:",
      "    app:",
      "      loadBalancer:",
      "        servers:",
      "          - url: \"http://localhost:${var.container_port}\""
    ]
  )) : ""

  traefik_dynamic_config_b64 = var.basic_auth != null ? base64encode(local.traefik_dynamic_config) : ""
}

module "traefik" {
  count  = var.basic_auth != null ? 1 : 0
  source = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=0.61.1"

  command = [
    "sh", "-c",
    <<-EOT
      echo "$TRAEFIK_BASIC_AUTH_USERS" > /tmp/users.htpasswd && \
      echo '${local.traefik_dynamic_config_b64}' | base64 -d > /tmp/dynamic.yml && \
      traefik
    EOT
  ]

  container_image = "traefik:v3"
  container_name  = "traefik"
  essential       = true

  secrets = [
    {
      name      = "TRAEFIK_BASIC_AUTH_USERS"
      valueFrom = aws_ssm_parameter.traefik_basic_auth_users[0].arn
    }
  ]

  environment = [
    {
      name  = "TRAEFIK_ENTRYPOINTS_WEB_ADDRESS"
      value = ":80"
    },
    {
      name  = "TRAEFIK_ENTRYPOINTS_TRAEFIK_ADDRESS"
      value = ":8080"
    },
    {
      name  = "TRAEFIK_PING"
      value = "true"
    },
    {
      name  = "TRAEFIK_PROVIDERS_FILE_FILENAME"
      value = "/tmp/dynamic.yml"
    }
  ]

  log_configuration = {
    logDriver     = "awslogs"
    secretOptions = []
    options = {
      awslogs-region        = var.logs_region
      awslogs-group         = join("", aws_cloudwatch_log_group.app.*.name)
      awslogs-stream-prefix = "traefik"
    }
  }

  port_mappings = [
    {
      containerPort = 80
      protocol      = "tcp"
    }
  ]

  healthcheck = {
    command     = ["CMD-SHELL", "wget -qO- http://localhost:8080/ping || exit 1"]
    interval    = 60
    retries     = 5
    startPeriod = 20
    timeout     = 4
  }
}

resource "aws_ssm_parameter" "traefik_basic_auth_users" {
  count = var.basic_auth != null ? 1 : 0
  name  = "/${var.project}-${var.environment}/${var.name}/traefik-auth"
  type  = "SecureString"
  value = "${var.basic_auth.user}:${bcrypt(var.basic_auth.password)}"
  lifecycle {
    ignore_changes = [value]
  }
}

data "aws_iam_policy_document" "traefik_ssm" {
  count = var.basic_auth != null ? 1 : 0
  statement {
    effect    = "Allow"
    resources = [aws_ssm_parameter.traefik_basic_auth_users[0].arn]
    actions   = ["ssm:GetParameters"]
  }
}

resource "aws_iam_role_policy" "traefik_ssm" {
  count  = var.basic_auth != null ? 1 : 0
  name   = "${module.task.ecs_exec_role_policy_name}-traefik-ssm"
  policy = data.aws_iam_policy_document.traefik_ssm[0].json
  role   = module.task.task_exec_role_name
}
