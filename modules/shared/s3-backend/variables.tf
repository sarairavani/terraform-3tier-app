variable "state_bucket_name" {
  description = "Name of the S3 bucket to store Terraform state files"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = { 
           Environment = "dev"}
}

variable "encryption_type" {
  description = "Type of server-side encryption: sse-s3 (AES256) or sse-kms"
  type        = string
  default     = "sse-s3"
  validation {
    condition     = contains(["sse-s3", "sse-kms"], var.encryption_type)
    error_message = "Encryption type must be 'sse-s3' or 'sse-kms'."
  }
}

variable "kms_key_id" {
  description = "KMS key ID to use for encryption when encryption_type is sse-kms"
  type        = string
  default     = ""
}

