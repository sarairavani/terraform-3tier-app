############################################################
# Variables for S3 Logging Module
############################################################

# Name of the S3 bucket
variable "name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string

  validation {
    condition     = length(var.name) > 3
    error_message = "Bucket name must be longer than 3 characters."
  }
}

# Enable versioning
variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

# Enable AES256 server-side encryption
variable "enable_encryption" {
  description = "Enable AES256 server-side encryption"
  type        = bool
  default     = true
}

# Optional logging bucket for storing access logs
variable "logging_bucket_name" {
  description = "Name of the S3 bucket to store access logs. Leave empty to disable logging."
  type        = string
  default     = ""
}

# Common tags
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

