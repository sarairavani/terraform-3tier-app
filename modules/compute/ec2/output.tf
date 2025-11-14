############################################################
# EC2 Outputs
############################################################

output "instance_ids" {
  description = "EC2 Instance IDs for all tiers"
  value = { for k, inst in aws_instance.this : k => inst.id }
}

output "private_ips" {
  description = "Private IPs for all EC2 instances"
  value = { for k, inst in aws_instance.this : k => inst.private_ip }
}

output "public_ips" {
  description = "Public IPs (only for Bastion/Web if enabled)"
  value = { for k, inst in aws_instance.this : k => inst.public_ip }
}

