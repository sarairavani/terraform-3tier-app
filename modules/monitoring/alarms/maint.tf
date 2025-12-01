############################################################
# Alarms Module - Placeholder for SNS-attached alarms
############################################################

# This module serves as a placeholder for attaching SNS actions
# to existing CloudWatch alarms. The actual alarm definitions
# are created in the cloudwatch module.

# Output for debugging/verification
output "sns_topic_arn" {
  description = "SNS topic ARN for alarm notifications"
  value       = var.sns_topic_arn
}

output "alarm_count" {
  description = "Number of alarms configured"
  value       = length(var.alarm_actions)
}

