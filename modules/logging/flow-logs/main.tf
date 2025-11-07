#--------------------------------------------------------------------------------------------------------
#--------------------------------------VPC Flow Logs----------------------------------------------------- 
# log_destination: replace with your own S3 bucket ARN, CloudWatch log group ARN, or Kinesis Firehose ARN
# iam_role_arn: IAM role must have permissions to write logs to the chosen destination
#--------------------------------------------------------------------------------------------------------
resource "aws_flow_log" "vpc" {
  for_each        = var.enabled ? toset(var.vpc_ids) : []
  vpc_id          = each.value
  traffic_type    = var.traffic_type
  log_destination = var.log_destination
  iam_role_arn    = var.iam_role_arn

  tags = merge(
    var.tags,
    { Name = "flow-log-${each.value}" }
  )
}

