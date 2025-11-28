############################################################
# AWS Secrets Manager Module
# Purpose:
#   - Create encrypted secrets using KMS
#   - Use dynamic secret string for DB credentials or API keys
############################################################

resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = var.secret_description
  kms_key_id  = var.kms_key_id

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
    }
  )
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_value
}

