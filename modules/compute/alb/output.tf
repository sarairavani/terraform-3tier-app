output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.this.dns_name
}

output "target_group_arns" {
  description = "Map of Target Group ARNs"
  value       = { for k, tg in aws_lb_target_group.this : k => tg.arn }
}

output "http_listener_arn" {
  description = "ARN of HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  description = "ARN of HTTPS listener if enabled"
  value       = var.enable_https ? aws_lb_listener.https[0].arn : ""
}

output "listener_rule_arns" {
  description = "Map of Listener Rule ARNs"
  value       = { for k, r in aws_lb_listener_rule.this : k => r.arn }
}

