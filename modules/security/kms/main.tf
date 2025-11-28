############################################################
# KMS Key Module
# Purpose:
#   - Create a KMS symmetric key for encrypting S3, RDS, and Secrets Manager
#   - Supports automatic rotation and tagging
############################################################

resource "aws_kms_key" "this" {
  description             = var.key_description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation

  policy = var.key_policy

  tags = merge(
    var.common_tags,
    {
      Name        = var.key_name
      Environment = var.environment
    }
  )
}

############################################################
# KMS Alias for easier reference
############################################################
resource "aws_kms_alias" "this" {
  name          = "alias/${var.key_alias}"
  target_key_id = aws_kms_key.this.key_id
}

