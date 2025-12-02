# ============================================================
# VPC & Subnet Flow Logs
# Elastic Network Interface
# ============================================================
# This module creates AWS Flow Logs for VPCs and Subnets.
# 
# Important:
# - log_destination: Replace with your own S3 bucket ARN, CloudWatch log group ARN,
#   or Kinesis Firehose ARN.
# - iam_role_arn: The IAM role must have permissions to write logs to the chosen destination.
# - traffic_type: Controls which traffic to capture (ACCEPT, REJECT, ALL).
# - enabled: Boolean flag to enable/disable flow logs.
# ============================================================

# --------------------------
# VPC Flow Logs
# --------------------------
resource "aws_flow_log" "vpc" {
  # Create flow logs only if module is enabled
  for_each = length(var.vpc_ids) > 0 ? toset(var.vpc_ids) : []

  vpc_id          = each.value
  traffic_type    = var.traffic_type
  log_destination = var.log_destination
  iam_role_arn    = var.iam_role_arn

  # Merge common tags with specific name tag
  tags = merge(
    var.tags,
    {
      Name = "flow-log-${each.value}"
    }
  )
}

# --------------------------
# Subnet Flow Logs
# --------------------------
resource "aws_flow_log" "subnet" {
  # Create flow logs only if module is enabled
  for_each = length(var.subnet_ids) > 0 ? toset(var.subnet_ids) : []

  subnet_id       = each.value
  traffic_type    = var.traffic_type
  log_destination = var.log_destination
  iam_role_arn    = var.iam_role_arn

  # Merge common tags with specific name tag
  tags = merge(
    var.tags,
    {
      Name = "flow-log-subnet-${each.value}"
    }
  )
}

# --------------------------
# ENI Flow Logs
# --------------------------
resource "aws_flow_log" "eni" {
  for_each = var.eni_ids

  log_destination_type = "cloud-watch-logs"
  log_group_name       = var.log_group_name
  traffic_type         = "ALL"

  subnet_id       = null
  vpc_id          = null
  iam_role_arn    = null
  eni_id          = each.value

  tags = merge(var.common_tags, {
    FlowType = "ENI"
  })
}

