output "vpc_flow_log_ids" {
  description = "IDs of created VPC flow logs"
  value       = [for f in aws_flow_log.vpc : f.id]
}

output "subnet_flow_log_ids" {
  description = "IDs of created subnet flow logs"
  value       = [for f in aws_flow_log.subnet : f.id]
}

output "eni_flow_log_ids" {
  description = "IDs of created ENI flow logs"
  value       = [for f in aws_flow_log.eni : f.id]
}

