############################################################
# Outputs for Alarms module
############################################################

output "sns_topic_arn" {
  description = "SNS topic ARN for alarm notifications"
  value       = var.sns_topic_arn
}

output "alarm_actions" {
  description = "List of alarm actions"
  value       = var.alarm_actions
}

