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

locals {
  vpc_map = { for idx, v in var.vpc_ids : "vpc${idx}" => v }
  subnet_map = { for idx, v in var.subnet_ids : "subnet${idx}" => v }
}

# --------------------------
# VPC Flow Logs
# --------------------------
resource "aws_flow_log" "vpc" {
  # Create flow logs only if module is enabled
  for_each = local.vpc_map
  
  vpc_id               = each.value
  traffic_type         = var.traffic_type
  log_destination_type = "cloud-watch-logs"
  log_destination      = var.log_destination
  iam_role_arn         = var.iam_role_arn

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
  for_each = local.subnet_map

  subnet_id            = each.value
  traffic_type         = var.traffic_type
  log_destination_type = "cloud-watch-logs"
  log_destination      = var.log_destination
  iam_role_arn         = var.iam_role_arn

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
  for_each = toset(var.eni_ids)

  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = var.log_destination
  eni_id               = each.value

  tags = merge(var.tags, {
    FlowType = "ENI"
  })
}

