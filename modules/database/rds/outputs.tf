output "db_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "RDS endpoint address"
  value       = aws_db_instance.this.endpoint
}

output "db_port" {
  description = "RDS port"
  value       = aws_db_instance.this.port
}

