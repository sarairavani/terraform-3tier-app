############################################################
# S3 Bucket: Production-ready configuration
############################################################

resource "aws_s3_bucket" "this" {
  # Name of the bucket
  bucket = var.bucket_name

  # Private ACL ensures bucket is not public
  acl = "private"

  ##########################################################
  # Versioning
  # Enables versioning for object recovery
  ##########################################################
  versioning {
    enabled = var.enable_versioning
  }

  ##########################################################
  # Server-side encryption
  # Encrypts objects in the bucket using AES256
  ##########################################################
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.enable_encryption ? "AES256" : null
      }
    }
  }

  ##########################################################
  # Lifecycle rules
  # Automatically transition non-current object versions to Glacier and delete old versions
  ##########################################################
  lifecycle_rule {
    id      = "archive_old_versions"
    enabled = true

    # Move old versions to Glacier after 30 days
    noncurrent_version_transition {
      days          = 30
      storage_class = "GLACIER"
    }

    # Delete old versions after 365 days
    noncurrent_version_expiration {
      days = 365
    }
  }

  ##########################################################
  # Logging
  # Optional: store access logs in another bucket
  ##########################################################
  logging {
    target_bucket = var.access_logs_bucket_name != "" ? var.access_logs_bucket_name : null
    target_prefix = "logs/"
  }

  ##########################################################
  # Public access block (AWS recommended)
  # Prevents public exposure of the bucket
  ##########################################################
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  ##########################################################
  # Tags
  # Merge common tags with a Name tag
  ##########################################################
  tags = merge(var.common_tags, { Name = var.bucket_name })
}

