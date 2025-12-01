############################################################
# CloudTrail module variables
############################################################

variable "trail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for storing CloudTrail logs"
  type        = string
}

variable "include_global_service_events" {
  description = "Whether to include global service events (IAM, STS, etc.)"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Enable multi-region CloudTrail to capture events from all AWS regions"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable CloudTrail logging"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ARN for encrypting CloudTrail logs (leave empty to disable encryption"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags to apply to CloudTrail resources"
  type        = map(string)
  default     = {}
}

