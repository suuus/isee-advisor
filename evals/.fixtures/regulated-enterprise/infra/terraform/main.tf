terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

resource "aws_rds_cluster" "phi_db" {
  cluster_identifier      = "healthdata-phi"
  engine                  = "aurora-postgresql"
  engine_version          = "15.4"
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.phi_key.arn
  deletion_protection     = true
  backup_retention_period = 35

  tags = {
    DataClassification = "PHI"
    Compliance         = "HIPAA,SOC2"
  }
}

resource "aws_appautoscaling_target" "db_read" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "cluster:${aws_rds_cluster.phi_db.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
}
