provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "../../modules/networking/vpc"
  name       = "dev-vpc"
  cidr_block = var.cidr_block
  tags = {
    Environment =  var.environment
  }
}

module "flow_logs" {
  source           = "../../modules/logging/flow-logs"
  vpc_ids          = [module.vpc.vpc_id]
  log_destination  = var.log_destination
  iam_role_arn     = aws_iam_role.flow_logs.arn
  traffic_type     = "ALL"
  enabled          = true
  tags = {
    Environment =  var.environment
  }
}

