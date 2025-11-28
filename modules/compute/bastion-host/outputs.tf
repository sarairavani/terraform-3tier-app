############################################################
# Bastion Host Outputs
############################################################

output "bastion_instance_id" {
  description = "EC2 instance ID of the bastion host"
  value       = aws_instance.bastion.id
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion instance"
  value       = aws_instance.bastion.private_ip
}

output "bastion_security_group_id" {
  description = "Security group ID for the bastion host"
  value       = aws_security_group.bastion_sg.id
}

output "bastion_ssm_role_arn" {
  description = "IAM role ARN attached to bastion for SSM access"
  value       = aws_iam_role.ssm_role.arn
}

output "bastion_elastic_ip" {
  description = "Elastic IP associated with bastion (if allocated)"
  value       = var.allocate_elastic_ip && var.associate_public_ip ? try(aws_eip.bastion_eip[0].public_ip, null) : null
}

