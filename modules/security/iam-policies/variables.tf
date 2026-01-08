variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "web_assets_bucket" {
  description = "S3 bucket name for web tier assets"
  type        = string
  default     = "web-assets-placeholder"
}

variable "app_data_bucket" {
  description = "S3 bucket name for app tier data"
  type        = string
  default     = "app-data-placeholder"
}

variable "db_secret_arn" {
  description = "ARN of the database secrets in Secrets Manager"
  type        = string
  default     = "arn:aws:secretsmanager:*:*:secret:*"
}

variable "kms_key_arn" {
  description = "ARN of the KMS key for encryption"
  type        = string
  default     = "arn:aws:kms:*:*:key/*"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
