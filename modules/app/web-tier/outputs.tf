output "web_asg_name" {
  description = "Name of web ASG"
  value       = module.asg_wrapper.asg_names["web"]
}

output "web_asg_arn" {
  description = "ARN of web ASG"
  value       = module.asg_wrapper.asg_arns["web"]
}

