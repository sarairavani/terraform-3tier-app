############################################################
# Outputs for Alarms module
############################################################

output "alarms" {
  description = "List of CloudWatch alarm names attached to SNS"
  value       = [for a in aws_cloudwatch_metric_alarm.attach_sns : a.alarm_name]
}

