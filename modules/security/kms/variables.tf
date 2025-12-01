############################################################
# KMS Key Module Variables
############################################################

variable "key_name" {
  description = "Name of the KMS key for identification and tagging"
  type        = string
}
variable "key_alias" {
  description = "Alias name for the KMS key (without the 'alias/' prefix)"
  type        = string
}
variable "key_description" {
  description = "Description for the KMS key explaining its purpose"
  type        = string
  default     = "KMS key for 3-tier app encryption"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "deletion_window_in_days" {
  description = "Number of days to wait before permanent key deletion (7-30 days)"
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable automatic yearly key rotation for the KMS key"
  type        = bool
  default     = true
}

variable "key_policy" {
  description = "KMS key policy document in JSON format. If not provided, default AWS managed policy will be used."
  type        = string
  default     = null
}

variable "common_tags" {
  description = "Common tags to apply to KMS resources"
  type        = map(string)
  default     = {}
}

