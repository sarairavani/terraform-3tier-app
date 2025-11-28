############################################################
# Bastion Host Outputs
############################################################

output "bastion_instance_id" {
  description = "Bastion EC2 instance ID"
  value       = aws_instance.bastion.id
}

output "bastion_private_ip" {
  description = "Private IP of the bastion instance"
  value       = aws_instance.bastion.private_ip
}

output "bastion_security_group_id" {
  description = "Security group ID for bastion host"
  value       = aws_security_group.bastion_sg.id
}

output "ssm_role_arn" {
  description = "IAM role ARN attached to bastion for SSM"
  value       = aws_iam_role.ssm_role.arn
}

output "eip" {
  description = "Elastic IP associated with bastion (if allocated)"
  value       = aws_eip.bastion_eip[0].public_ip
  condition   = (var.allocate_eip && var.associate_public_ip) ? aws_eip.bastion_eip[0].public_ip : null
}

