############################################################
# CloudTrail module variables
############################################################

variable "name" {
  description = "Name of the CloudTrail"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket for storing CloudTrail logs"
  type        = string
}

variable "include_global_service_events" {
  description = "Whether to include global service events"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Enable multi-region CloudTrail"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable CloudTrail logging"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key for encrypting CloudTrail logs"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags for CloudTrail"
  type        = map(string)
  default     = {}
}

