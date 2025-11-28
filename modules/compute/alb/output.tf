############################################################
# ALB Outputs
############################################################

# Application Load Balancer ARN
output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

# ALB DNS Name
output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

# Web Tier Target Group ARN
output "web_target_group_arn" {
  description = "ARN of the Web Target Group"
  value       = aws_lb_target_group.web.arn
}

# App Tier Target Group ARN
output "app_target_group_arn" {
  description = "ARN of the App Target Group"
  value       = aws_lb_target_group.app.arn
}

# Web Target Group Name (Optional)
output "web_target_group_name" {
  description = "Name of the Web Target Group"
  value       = aws_lb_target_group.web.name
}

# App Target Group Name (Optional)
output "app_target_group_name" {
  description = "Name of the App Target Group"
  value       = aws_lb_target_group.app.name
}

