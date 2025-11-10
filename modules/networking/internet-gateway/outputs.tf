############################################################
# Outputs for Internet Gateway Module
############################################################

output "internet_gateway_ids" {
  description = "IDs of created Internet Gateways"
  value       = { for k, igw in aws_internet_gateway.this : k => igw.id }
}

output "internet_gateway_arns" {
  description = "ARNs of created Internet Gateways"
  value       = { for k, igw in aws_internet_gateway.this : k => igw.arn }
}

