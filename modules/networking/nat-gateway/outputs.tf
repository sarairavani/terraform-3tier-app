############################################################
# Outputs for NAT Gateway Module
############################################################

output "nat_gateway_ids" {
  description = "IDs of created NAT Gateways"
  value       = { for k, nat in aws_nat_gateway.this : k => nat.id }
}

output "nat_gateway_eips" {
  description = "Elastic IPs associated with each NAT Gateway"
  value       = { for k, eip in aws_eip.nat_eip : k => eip.public_ip }
}

output "nat_gateway_subnet_map" {
  description = "Mapping of AZs to NAT Gateway IDs"
  value       = { for k, nat in aws_nat_gateway.this : k => {
    az              = var.public_subnet_map[k].az
    nat_gateway_id  = nat.id
  }}
}

