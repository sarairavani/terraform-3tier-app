############################################################
# Auto Scaling Outputs
############################################################

output "asg_names" {
  description = "Names of created Auto Scaling Groups"
  value       = { for k, v in aws_autoscaling_group.asg : k => v.name }
}

output "asg_arns" {
  description = "ARNs of created Auto Scaling Groups"
  value       = { for k, v in aws_autoscaling_group.asg : k => v.arn }
}

