resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.encryption_type == "sse-s3" ? "AES256" : "aws:kms"
        kms_master_key_id = var.encryption_type == "sse-kms" ? var.kms_key_id : null
      }
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

