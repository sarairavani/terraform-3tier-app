############################################################
# SNS Topic & Subscriptions
############################################################

resource "aws_sns_topic" "this" {
  name = var.name
  tags = merge(var.tags, { Name = var.name })
}

resource "aws_sns_topic_subscription" "email" {
  for_each = toset(var.email_subscription)

  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = each.value
}

