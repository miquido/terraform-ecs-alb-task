provider "aws" {
  region = "us-east-1"
}

module "task" {
  source = "../../"

  name               = "task"
  project            = "example"
  environment        = "test"
  container_image    = "nginx"
  container_port     = 80
  logs_region        = "us-east-1"
  ecs_cluster_arn    = ""
  vpc_id             = ""
  subnet_ids         = []
  security_group_ids = []
}
