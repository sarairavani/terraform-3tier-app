output "app_asg_name" {
  description = "Name of app ASG"
  value       = module.asg_wrapper.asg_names["app"]
}

output "app_asg_arn" {
  description = "ARN of app ASG"
  value       = module.asg_wrapper.asg_arns["app"]
}

