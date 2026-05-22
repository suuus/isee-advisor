terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

resource "aws_db_instance" "orders" {
  identifier     = "orderflow-db"
  engine         = "postgres"
  instance_class = "db.t3.medium"
  allocated_storage = 20
  username       = "admin"
  password       = var.db_password

  # TODO: enable encryption
  storage_encrypted = false
  
  # No backup configured
  # No deletion protection
}

resource "aws_ecs_service" "api" {
  name            = "orderflow-api"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 2

  # No autoscaling
  # No health check grace period configured
}
