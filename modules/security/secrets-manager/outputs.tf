############################################################
# Outputs for Secrets Manager Module
############################################################

output "secret_arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_id" {
  description = "ID of the created secret"
  value       = aws_secretsmanager_secret.this.id
}

