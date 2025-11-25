############################################################
# Outputs for SNS module
############################################################

output "this" {
  description = "The SNS topic resource"
  value       = aws_sns_topic.this
}

output "arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.this.arn
}

output "subscriptions" {
  description = "List of SNS email subscriptions"
  value       = [for s in aws_sns_topic_subscription.email : s.endpoint]
}

