resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block

# Needed if you want private DNS hostnames
  enable_dns_hostnames = true

# Needed for DNS resolution inside VPC
  enable_dns_support   = true

  tags = merge(
    var.tags,
    { Name = var.name }
  )
}

# VPC Flow Logs (for monitoring)
resource "aws_flow_log" "vpc" {
  count            = var.enable_flow_logs ? 1 : 0
  log_destination  = var.flow_log_destination
  traffic_type     = "ALL"
  vpc_id           = aws_vpc.this.id
  iam_role_arn     = var.flow_log_iam_role_arn
}

