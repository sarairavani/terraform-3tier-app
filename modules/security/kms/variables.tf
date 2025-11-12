############################################################
# KMS Key Module Variables
############################################################

variable "name" {
  description = "Name of the KMS key"
  type        = string
}

variable "alias_name" {
  description = "Alias for the KMS key"
  type        = string
}

variable "description" {
  description = "Description for the KMS key"
  type        = string
  default     = "KMS key for 3-tier app encryption"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "deletion_window_in_days" {
  description = "Number of days before key deletion is permanent"
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable automatic key rotation"
  type        = bool
  default     = true
}
variable "key_policy" {
  description = "KMS key policy as JSON"
  type        = string
  default     = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowUseOfKey"
        Effect    = "Allow"
        Principal = { AWS = "*" }
        Action    = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:GenerateDataKey",
          "kms:ReEncrypt*"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/Project" = "terraform-3tier-app"
          }
        }
      },
      {
        Sid       = "EnableIAMUserPermissions"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::<YOUR_ACCOUNT_ID>:root" }
        Action    = "kms:*"
        Resource  = "*"
      }
    ]
  })
}

