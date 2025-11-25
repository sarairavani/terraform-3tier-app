output "alarms" {
  description = "CloudWatch alarms created"
  value       = [for a in aws_cloudwatch_metric_alarm.this : a.alarm_name]
}

