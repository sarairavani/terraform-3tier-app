############################################################
# RDS Instance
############################################################

resource "aws_db_instance" "this" {
  identifier              = var.instance_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  multi_az                = var.multi_az
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  username                = var.master_username
  password                = var.master_password
  db_name                 = var.db_name
  backup_retention_period = var.backup_retention_period
  publicly_accessible     = false

  # Snapshot and deletion protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.instance_identifier}-final-${replace(timestamp(), ":", "-")}"
  deletion_protection       = var.deletion_protection

  # Encryption
  storage_encrypted = true
  kms_key_id        = var.kms_key_id != "" ? var.kms_key_id : null

  # Backup window (UTC time)
  backup_window      = var.backup_window
  maintenance_window = var.maintenance_window

  # Enhanced monitoring
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  monitoring_interval             = var.monitoring_interval
  monitoring_role_arn             = var.monitoring_role_arn

  # Performance Insights
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_enabled && var.kms_key_id != "" ? var.kms_key_id : null

  # Auto minor version upgrade during maintenance window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  tags = merge(
    var.tags,
    { Name = var.instance_identifier }
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      final_snapshot_identifier # Ignore changes to avoid recreating on timestamp change
    ]
  }
}

