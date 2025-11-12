############################################################
# Outputs for Security Groups Module
############################################################

output "security_group_ids" {
  description = "Map of security group IDs by key"
  value       = { for k, sg in aws_security_group.this : k => sg.id }
}

output "security_group_names" {
  description = "Map of security group names by key"
  value       = { for k, sg in aws_security_group.this : k => sg.name }
}

