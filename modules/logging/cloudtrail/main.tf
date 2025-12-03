############################################################
# CloudTrail main configuration
# This resource creates a CloudTrail trail in AWS.
# CloudTrail records API activity in your AWS account.
############################################################

resource "aws_cloudtrail" "this" {
  # Name of the trail
  name = var.trail_name

  # S3 bucket to store CloudTrail logs
  s3_bucket_name = var.s3_bucket_name

  # Include global service events like IAM, STS, etc.
  include_global_service_events = var.include_global_service_events

  # Enable multi-region trail to capture events from all AWS regions
  is_multi_region_trail = var.is_multi_region_trail

  # Start or stop logging
  enable_logging = var.enable_logging

  # Optional KMS key for encrypting CloudTrail logs
  kms_key_id = var.kms_key_id != "" ? var.kms_key_id : null

  # Tags for cost allocation and resource management
  tags = merge(var.common_tags, { Name = var.trail_name })
}

############################################################
# Optional: S3 bucket for CloudTrail logs
# This bucket is only created if s3_bucket_name variable is empty.
# Ensures logs are encrypted and private.
############################################################
resource "aws_s3_bucket" "cloudtrail_bucket" {
  for_each = var.s3_bucket_name == "" ? { "${var.trail_name}-logs" = var.trail_name } : {}

  bucket = each.key

  tags = merge(var.common_tags, { Name = each.key })
}

resource "aws_s3_bucket_acl" "cloudtrail_bucket_acl" {
  for_each = aws_s3_bucket.cloudtrail_bucket

  bucket = each.value.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_bucket_sse" {
  for_each = aws_s3_bucket.cloudtrail_bucket

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

