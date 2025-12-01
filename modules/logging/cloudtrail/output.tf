############################################################
# Outputs cloudtrail for S3 Logging Module
############################################################
output "cloudtrail_name" {
  description = "CloudTrail name"
  value       = aws_cloudtrail.this.name
}

output "cloudtrail_arn" {
  description = "CloudTrail ARN"
  value       = aws_cloudtrail.this.arn
}

output "s3_bucket_name" {
  description = "S3 bucket used for CloudTrail logs"
  value       = var.s3_bucket_name
}

