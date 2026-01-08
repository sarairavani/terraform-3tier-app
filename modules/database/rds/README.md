# RDS Database Module

This module creates an AWS RDS database instance with best practices for security, monitoring, and high availability.

## Features

- ✅ Encryption at rest with KMS
- ✅ Multi-AZ deployment support
- ✅ Automated backups with configurable retention
- ✅ Performance Insights enabled
- ✅ Enhanced monitoring
- ✅ CloudWatch Logs export
- ✅ Deletion protection
- ✅ Final snapshot on destroy
- ✅ Automatic minor version upgrades

## Usage

```hcl
module "rds" {
  source = "../../modules/database/rds"

  instance_identifier     = "dev-rds"
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t3.medium"
  multi_az                = true
  allocated_storage       = 20
  storage_type            = "gp3"
  db_subnet_group_name    = module.db_subnet_group.name
  vpc_security_group_ids  = [module.security_groups.db_sg_id]
  master_username         = "admin"
  master_password         = var.db_password  # Use Secrets Manager
  db_name                 = "mydb"
  backup_retention_period = 7
  kms_key_id              = module.kms.key_arn

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Best Practices

- Always use encrypted storage
- Enable Multi-AZ for production
- Set appropriate backup retention period (7-35 days)
- Use strong passwords from Secrets Manager
- Enable deletion protection for production
- Monitor with CloudWatch and Performance Insights

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
