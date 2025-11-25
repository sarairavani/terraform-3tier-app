############################################################
# CloudWatch Alarms
############################################################

resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = { for m in var.metrics : "${m.namespace}-${m.metric_name}" => m }

  alarm_name          = "${var.environment}-${each.value.metric_name}-alarm"
  namespace           = each.value.namespace
  metric_name         = each.value.metric_name
  statistic           = each.value.statistic
  period              = each.value.period
  evaluation_periods  = each.value.evaluation_periods
  threshold           = each.value.threshold
  comparison_operator = each.value.comparison_operator
  alarm_description   = "Alarm for ${each.value.metric_name} in ${var.environment} environment"
  actions_enabled     = true

  tags = merge(var.tags, { Environment = var.environment })
}

