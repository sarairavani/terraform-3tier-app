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

############################
# VPC Outputs
############################
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = var.vpc_cidr_block
}

############################
# Flow Logs Outputs
############################
output "flow_logs_status" {
  description = "Indicates if VPC Flow Logs are enabled"
  value       = length(module.flow_logs_subnets.flow_log_id) > 0
}

output "flow_logs_vpc_id" {
  description = "Flow Logs for the entire VPC"
  value       = module.flow_logs_vpc.flow_log_id
}

output "flow_logs_subnets_id" {
  description = "Flow Logs for all subnets (public + private app + private db)"
  value       = module.flow_logs_subnets.flow_log_id
}

output "flow_logs_eni_id" {
  description = "Flow Logs for specific ENIs"
  value       = module.flow_logs_eni.flow_log_id
}

output "flow_logs_destination" {
  description = "The destination (S3, CloudWatch, etc.) for the flow logs"
  value       = var.log_destination
}

############################
# Subnets Outputs
############################
output "public_subnet_ids" {
  description = "List of public subnet IDs for the Web tier"
  value       = module.subnets.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "List of private subnet IDs for the App tier"
  value       = module.subnets.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "List of private subnet IDs for the DB tier"
  value       = module.subnets.private_db_subnet_ids
}

