############################################################
# Outputs for Flow Logs Module
############################################################

output "vpc_flow_log_ids" {
  description = "IDs of VPC flow logs"
  value       = { for k, v in aws_flow_log.vpc : k => v.id }
}

output "subnet_flow_log_ids" {
  description = "IDs of subnet flow logs"
  value       = { for k, v in aws_flow_log.subnet : k => v.id }
}

output "eni_flow_log_ids" {
  description = "IDs of ENI flow logs"
  value       = { for k, v in aws_flow_log.eni : k => v.id }
}

output "enabled" {
  description = "Whether flow logs are enabled"
  value       = var.enabled
}
