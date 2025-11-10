output "web_public_subnet_ids" {
  description = "IDs of web tier public subnets"
  value       = [for s in aws_subnet.web_public_subnet : s.id]
}

output "app_private_subnet_ids" {
  description = "IDs of app tier private subnets"
  value       = [for s in aws_subnet.app_private_subnet : s.id]
}

output "db_private_subnet_ids" {
  description = "IDs of database tier private subnets"
  value       = [for s in aws_subnet.db_private_subnet : s.id]
}

output "web_public_subnet_cidrs" {
  description = "CIDR blocks of web tier public subnets"
  value       = [for s in aws_subnet.web_public_subnet : s.cidr_block]
}

