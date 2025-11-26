############################
# VPC Outputs
############################
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = var.cidr_block
}

############################
# Flow Logs Outputs
############################
output "flow_logs_status" {
  description = "Indicates if VPC Flow Logs are enabled"
  value       = module.flow_logs_vpc.enabled
}

output "flow_logs_destination" {
  description = "The destination (S3, CloudWatch, etc.) for the flow logs"
  value       = var.log_destination
}

############################
# Subnets Outputs
############################
output "web_public_subnet_ids" {
  description = "List of public subnet IDs for the Web tier"
  value       = module.subnets.web_public_subnet_ids
}

output "app_private_subnet_ids" {
  description = "List of private subnet IDs for the App tier"
  value       = module.subnets.app_private_subnet_ids
}

output "db_private_subnet_ids" {
  description = "List of private subnet IDs for the DB tier"
  value       = module.subnets.db_private_subnet_ids
}

############################
# General Outputs
############################
output "environment" {
  description = "The current environment (e.g., dev, staging, prod)"
  value       = var.environment
}

output "region" {
  description = "AWS region for this environment"
  value       = var.aws_region
}
