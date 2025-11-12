############################################################
# Outputs for IAM Role Module
############################################################

output "iam_role_arns" {
  description = "Map of IAM Role ARNs"
  value       = { for k, role in aws_iam_role.this : k => role.arn }
}

output "iam_role_names" {
  description = "Map of IAM Role names"
  value       = { for k, role in aws_iam_role.this : k => role.name }
}

