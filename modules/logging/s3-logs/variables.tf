############################################################
# Variables for S3 Logging Module
############################################################

# Name of the S3 bucket
variable "bucket_name" {
  description = "Name of the S3 bucket for storing logs (must be globally unique)"
  type        = string

  validation {
    condition     = length(var.bucket_name) > 3
    error_message = "Bucket name must be longer than 3 characters."
  }
}

# Enable versioning
variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket to support object recovery"
  type        = bool
  default     = true
}

# Enable AES256 server-side encryption
variable "enable_encryption" {
  description = "Enable AES256 server-side encryption for objects in the bucket"
  type        = bool
  default     = true
}

# Optional logging bucket for storing access logs
variable "access_logs_bucket_name" {
  description = "Name of the S3 bucket to store access logs. Leave empty to disable logging."
  type        = string
  default     = ""
}

# Force destroy bucket
variable "force_destroy" {
  description = "Allow destruction of bucket even if it contains objects"
  type        = bool
  default     = false
}

# Common tags
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

