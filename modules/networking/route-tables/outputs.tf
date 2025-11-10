############################################################
# Outputs for Route Tables Module
############################################################

output "public_route_table_ids" {
  description = "IDs of public route tables"
  value       = { for k, rt in aws_route_table.public : k => rt.id }
}

output "private_route_table_ids" {
  description = "IDs of private route tables"
  value       = { for k, rt in aws_route_table.private : k => rt.id }
}

