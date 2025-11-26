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
  description = "KMS key policy as JSON string. If not provided, AWS default policy is used."
  type        = string
  default     = null
}

variable "common_tags" {
  description = "Common tags for KMS resources"
  type        = map(string)
  default     = {}
}

