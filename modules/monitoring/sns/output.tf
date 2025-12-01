############################################################
# Outputs for SNS module
############################################################

output "sns_topic" {
  description = "The SNS topic resource"
  value       = aws_sns_topic.this
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.this.arn
}

output "email_subscriptions" {
  description = "List of SNS email subscriptions"
  value       = [for s in aws_sns_topic_subscription.email : s.endpoint]
}

