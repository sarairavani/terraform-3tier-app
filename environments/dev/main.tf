provider "aws" {
  region = var.aws_region
}

# ------------------------
# VPC Module
# ------------------------
module "vpc" {
  source     = "../../modules/networking/vpc"
  name       = "dev-vpc"
  cidr_block = var.cidr_block
 
}
# ------------------------
# Subnets Module
# ------------------------
module "subnets" {
  source                   = "../../modules/networking/subnets"
  vpc_id                   = module.vpc.vpc_id
  availability_zones        = var.availability_zones
  web_public_subnet_cidrs   = var.web_public_subnet_cidrs
  app_private_subnet_cidrs  = var.app_private_subnet_cidrs
  db_private_subnet_cidrs   = var.db_private_subnet_cidrs
}

# ------------------------
# Flow Logs Module
# ------------------------
# ----------
# VPC Module
# ----------
module "flow_logs" {
  source           = "../../modules/logging/flow-logs"
  vpc_ids          = [module.vpc.vpc_id]
  log_destination  = var.log_destination
  iam_role_arn     = aws_iam_role.flow_logs.arn
  traffic_type     = "ALL"
  enabled          = true
  tags            = var.common_tags
}
# -------------
# Subnet Module
# -------------
module "flow_logs" {
  source          = "../../modules/logging/flow-logs"
  vpc_ids         = [module.vpc.vpc_id]
  subnet_ids      = concat(module.subnets.public_subnet_ids,
                           module.subnets.private_app_subnet_ids,
                           module.subnets.private_db_subnet_ids)
  log_destination = var.log_destination
  iam_role_arn    = aws_iam_role.flow_logs.arn
  traffic_type    = "ALL"
  enabled         = true
  tags            = var.common_tags
}

