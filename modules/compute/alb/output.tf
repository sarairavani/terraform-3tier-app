output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.this.arn
}

output "web_target_group_arn" {
  description = "Web Target Group ARN"
  value       = aws_lb_target_group.web.arn
}

output "app_target_group_arn" {
  description = "App Target Group ARN"
  value       = aws_lb_target_group.app.arn
}

output "http_listener_arn" {
  description = "ARN of HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  description = "ARN of HTTPS listener if enabled"
  value       = var.enable_https ? aws_lb_listener.https["https"].arn : ""
}

