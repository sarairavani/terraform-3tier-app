############################################################
# CloudTrail main configuration
# This resource creates a CloudTrail trail in AWS.
# CloudTrail records API activity in your AWS account.
############################################################

resource "aws_cloudtrail" "this" {
  # Name of the trail
  name = var.name

  # S3 bucket to store CloudTrail logs
  # If empty, we will create a bucket dynamically (see below)
  s3_bucket_name = var.s3_bucket_name != "" ? var.s3_bucket_name : aws_s3_bucket.cloudtrail_bucket["${var.name}-logs"].bucket

  # Include global service events like IAM, STS, etc.
  include_global_service_events = var.include_global_service_events

  # Enable multi-region trail to capture events from all AWS regions
  is_multi_region_trail = var.is_multi_region_trail

  # Start or stop logging
  enable_logging = var.enable_logging

  # Optional KMS key for encrypting CloudTrail logs
  # If kms_key_id is empty string, set null
  kms_key_id = var.kms_key_id != "" ? var.kms_key_id : null

  # Tags for cost allocation and resource management
  tags = merge(var.common_tags, { Name = var.name })

  depends_on = [aws_s3_bucket.cloudtrail_bucket]
}

############################################################
# Optional: S3 bucket for CloudTrail logs
# This bucket is only created if s3_bucket_name variable is empty.
############################################################

resource "aws_s3_bucket" "cloudtrail_bucket" {
  for_each = var.s3_bucket_name == "" ? { "${var.name}-logs" = var.name } : {}

  bucket = each.key
  tags   = merge(var.common_tags, { Name = each.key })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_bucket" {
  for_each = var.s3_bucket_name == "" ? { "${var.name}-logs" = var.name } : {}

  bucket = aws_s3_bucket.cloudtrail_bucket[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "cloudtrail_bucket" {
  for_each = var.s3_bucket_name == "" ? { "${var.name}-logs" = var.name } : {}

  bucket = aws_s3_bucket.cloudtrail_bucket[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

