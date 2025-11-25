############################################################
# Attach SNS to existing alarms
############################################################

resource "aws_cloudwatch_metric_alarm" "attach_sns" {
  for_each = var.alarm_actions

  alarm_name          = "AttachSNS-${each.key}"
  alarm_actions       = [var.sns_topic_arn]
  # This is a placeholder if you want to attach existing metrics to SNS
}

