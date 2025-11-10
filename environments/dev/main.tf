#########################################################
# Provider Configuration
#########################################################
provider "aws" {
  region = var.aws_region
}

#########################################################
# ************** Networking Modules **********************
# Context:
#   - Architecture: 3-tier application (Web, App, DB)
#   - Public Subnets: Host web servers, internet-facing
#   - Private App Subnets: Access internet via NAT Gateway
#   - Private DB Subnets: Fully isolated (no internet)
#   - VPC designed for high availability across AZs
#########################################################
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
# Internet Gateway
# ------------------------
module "internet_gateway" {
  source = "../../modules/networking/internet-gateway"
  vpc_id = module.vpc.vpc_id
  environment_name = var.environment
  tags            = var.common_tags

}
# ----------------------
# Nat Gateway
# ----------------------
module "nat_gateway" {
  source = "../../modules/networking/nat-gateway"

  public_subnet_map = {
    "az1" = {
      public_subnet_id  = module.subnets.public_subnet_ids["az1"]
      az                = "ca-central-1a"
      environment_name  = var.environment
    }
    "az2" = {
      public_subnet_id  = module.subnets.public_subnet_ids["az2"]
      az                = "ca-central-1b"
      environment_name  = var.environment
    }
  }

  common_tags = {
    Project     = "terraform-3tier-app"
    Environment = "dev"
    Region      = "ca-central-1"
  }
}
##################################################################
# ********************* Logging Modules ***********************
# Context:
#   - Capture network traffic at VPC and Subnet levels and ENI
#   - Send logs to centralized destination (S3, CW Logs, or Firehose)
#   - Useful for security monitoring and auditing network activity
##################################################################

# ------------------------
# VPC Flow Logs Module
# ------------------------
# Captures traffic logs for all VPC-level network activity.
module "flow_logs" {
  source           = "../../modules/logging/flow-logs"
  vpc_ids          = [module.vpc.vpc_id]
  log_destination  = var.log_destination
  iam_role_arn     = aws_iam_role.flow_logs.arn
  traffic_type     = "ALL"
  enabled          = true
  tags            = var.common_tags
}
# ------------------------
# VPC Flow Logs Module
# ------------------------
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
# ------------------------
# ENI Flow Logs Module
# ------------------------
module "flow_logs_eni" {
  source          = "../../modules/logging/flow-logs"
  vpc_ids         = [module.vpc.vpc_id]
  eni_ids         = ["eni-1234567890abcdef0", "eni-abcdef1234567890"]
  log_destination = var.log_destination
  iam_role_arn    = aws_iam_role.flow_logs.arn
  traffic_type    = "ALL"
  enabled         = true
  tags            = var.common_tags
}

