############################################################
# Outputs for Alarms module
############################################################

output "alarms" {
  description = "List of alarm names referenced"
  value       = var.alarm_actions
}

output "sns_topic_arn" {
  description = "SNS topic ARN for alarm notifications"
  value       = var.sns_topic_arn
}

output "alarm_count" {
  description = "Number of alarms configured"
  value       = length(var.alarm_actions)
}
