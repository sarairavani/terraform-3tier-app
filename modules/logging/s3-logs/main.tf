############################################################
# S3 Bucket: Production-ready configuration
############################################################
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  acl           = "private"

  tags = merge(var.common_tags, { Name = var.bucket_name })

  versioning {
    enabled = var.enable_versioning
  }
}

##########################################################
# Server-side Encryption Configuration
##########################################################
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = var.enable_encryption ? { "enabled" = true } : {}

  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

##########################################################
# Lifecycle Rules Configuration
##########################################################

locals {
  lifecycle_rules = {
    archive_old_versions = {
      id     = "archive_old_versions"
      status = "Enabled"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  for_each = local.lifecycle_rules

  rule {
    id     = each.value.id
    status = each.value.status

    # Move non-current object versions to Glacier after 30 days
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }

    # Permanently delete non-current object versions after 365 days
    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }
}

############################################################
# Logging Configuration (Optional)
############################################################

locals {
  logging_buckets = var.access_logs_bucket_name != "" ? { "enabled" = var.access_logs_bucket_name } : {}
}

resource "aws_s3_bucket_logging" "this" {
  for_each = local.logging_buckets

  bucket        = aws_s3_bucket.this.id
  target_bucket = each.value
  target_prefix = "logs/"
}

############################################################
# Public Access Block Configuration
############################################################
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
