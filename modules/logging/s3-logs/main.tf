############################################################
# S3 Bucket: Production-ready configuration
############################################################

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = merge(var.common_tags, { Name = var.bucket_name })
}

############################################################
# Versioning Configuration
############################################################

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

############################################################
# Server-side Encryption Configuration
############################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.enable_encryption ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

############################################################
# Lifecycle Rules Configuration
############################################################

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "archive_old_versions"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }
}

############################################################
# Logging Configuration (Optional)
############################################################

resource "aws_s3_bucket_logging" "this" {
  count         = var.access_logs_bucket_name != null && var.access_logs_bucket_name != "" ? 1 : 0
  bucket        = aws_s3_bucket.this.id
  target_bucket = var.access_logs_bucket_name
  target_prefix = "logs/"
}

############################################################
# Public Access Block Configuration
############################################################

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


