output "state_bucket_id" {
  description = "The ID of the S3 bucket created for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.arn
}

output "state_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "encryption_type_used" {
  description = "The server-side encryption algorithm used"
  value       = var.encryption_type
}

output "kms_key_id_used" {
  description = "The KMS key ID used if SSE-KMS is enabled, otherwise empty"
  value       = var.encryption_type == "sse-kms" ? var.kms_key_id : ""
}

