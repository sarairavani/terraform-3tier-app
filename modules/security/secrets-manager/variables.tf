############################################################
# Secrets Manager Module Variables
############################################################

variable "name" {
  description = "Name of the secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = "Secrets for 3-tier application"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ID or ARN to encrypt the secret"
  type        = string
}

variable "secret_string" {
  description = "JSON string containing secret values"
  type        = string
}

variable "common_tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}

