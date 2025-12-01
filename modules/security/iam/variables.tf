############################################################
# Variables for IAM Role Module
############################################################

variable "iam_roles" {
  description = <<EOT
Map of IAM roles to create for multi-tier environment.

Example structure includes:
- app_role: for App Tier EC2s/Lambda accessing DynamoDB, RDS, SQS, etc.
- web_role: for Web Tier EC2s accessing S3, CloudWatch, etc.
- db_role: for DB Tier management (RDS, EC2 scripts, backups)
- bastion_role: for Bastion host with SSM access
EOT
  type = map(object({
    name               = string
    assume_role_policy = string
    managed_policies   = list(string)
  }))
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags for IAM resources"
  type        = map(string)
  default     = {}
}

