############################################################
# Outputs for S3 Logging Module
############################################################

# Bucket name
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket
}

# Bucket ARN
output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

# Bucket domain name
output "bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket_domain_name
}

# Bucket website endpoint (if static hosting enabled)
output "bucket_website_endpoint" {
  description = "The website endpoint of the bucket (if website hosting is enabled)"
  value       = aws_s3_bucket.this.website_endpoint
}

# Bucket ID (internal Terraform ID)
output "bucket_id" {
  description = "The internal ID of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

