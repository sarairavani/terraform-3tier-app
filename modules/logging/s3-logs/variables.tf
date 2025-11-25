variable "name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable server-side encryption (AES256)"
  type        = bool
  default     = true
}

variable "logging_bucket_name" {
  description = "Optional S3 bucket for access logs"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags to apply to the bucket"
  type        = map(string)
  default     = {}
}

