############################################################
# Alarms Module - Placeholder for SNS-attached alarms
############################################################

# This module serves as a placeholder for attaching SNS actions
# to existing CloudWatch alarms. The actual alarm definitions
# are created in the cloudwatch module

resource "aws_cloudwatch_metric_alarm" "attach_sns" {
  for_each = toset(var.alarm_actions)
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1

  alarm_name    = "AttachSNS-${each.key}"
  alarm_actions = [var.sns_topic_arn]
  # This is a placeholder if you want to attach existing metrics to SNS
}

