############################################################
# RDS Instance
############################################################

resource "aws_db_instance" "this" {
  identifier              = var.name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  multi_az                = var.multi_az
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  username                = var.username
  password                = var.password
  backup_retention_period = var.backup_retention_period
  publicly_accessible     = false
  skip_final_snapshot     = false
  deletion_protection     = true
  storage_encrypted       = true
  kms_key_id              = var.kms_key_id != "" ? var.kms_key_id : null

  tags = merge(
    var.tags,
    { Name = var.name }
  )

  lifecycle {
    create_before_destroy = true
  }
}

