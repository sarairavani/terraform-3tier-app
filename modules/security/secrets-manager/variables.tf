############################################################
# Secrets Manager Module Variables
############################################################

variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  type        = string
}

variable "secret_description" {
  description = "escription of the secret's purpose"
  type        = string
  default     = "Secrets for 3-tier application"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ID or ARN to encrypt the secret"
  type        = string
}

variable "secret_value" {
  description = "JSON-formatted string containing the secret key-value pairs"
  type        = string
  sensitive   = true
}

variable "common_tags" {
  description = "Common tags to apply to all Secrets Manager resourcesCommon tags to apply to all Secrets Manager resources"
  type        = map(string)
  default     = {}
}

