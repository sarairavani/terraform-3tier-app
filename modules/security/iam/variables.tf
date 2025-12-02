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
  default = {
    # Placeholder assume_role_policy; attach actual data source in locals
    "app_role" = {
      name               = "app-tier-role"
      assume_role_policy = ""
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }

    "web_role" = {
      name               = "web-tier-role"
      assume_role_policy = ""
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }

    "db_role" = {
      name               = "db-tier-role"
      assume_role_policy = ""
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
        "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }

    "bastion_role" = {
      name               = "bastion-access-role"
      assume_role_policy = ""
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]
    }
  }
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

