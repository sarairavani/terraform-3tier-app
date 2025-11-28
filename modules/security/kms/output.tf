############################################################
# Outputs for KMS Key Module
############################################################

output "kms_key_id" {
  description = "The unique identifier of the KMS key"
  value       = aws_kms_key.this.id
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the KMS key"
  value       = aws_kms_key.this.arn
}

output "kms_key_alias" {
  description = "The full alias name of the KMS key (including 'alias/' prefix)"
  value       = aws_kms_alias.this.name
}

