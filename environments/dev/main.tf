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
# ------------------------------------------------------
# VPC Module
# ------------------------------------------------------
module "vpc" {
  source         = "../../modules/networking/vpc"
  vpc_name       = "dev-vpc"
  vpc_cidr_block = var.vpc_cidr_block
# common_tags    = var.common_tags

}
# -----------------------------------------------------
# Subnets Module
# -----------------------------------------------------
module "subnets" {
  source                   = "../../modules/networking/subnets"
  vpc_id                   = module.vpc.vpc_id
  environment_name         = var.environment
  availability_zones       = var.availability_zones
  web_public_subnet_cidrs  = var.web_public_subnet_cidrs
  app_private_subnet_cidrs = var.app_private_subnet_cidrs
  db_private_subnet_cidrs  = var.db_private_subnet_cidrs
  common_tags              = var.common_tags
}
# --------------------------------------------
# Internet Gateway
# ---------------------------------------------
module "internet_gateway" {
  source = "../../modules/networking/internet-gateway"

  vpc_map = {
    "dev" = {
      vpc_id           = module.vpc.vpc_id
      environment_name = var.environment
    }
  }
  common_tags = var.common_tags
}
# ----------------------------------------------
# Nat Gateway
# ----------------------------------------------
module "nat_gateway" {
  source = "../../modules/networking/nat-gateway"

  public_subnet_map = {
    "az1" = {
      public_subnet_id = module.subnets.web_public_subnet_ids[0]
      az               = var.availability_zones[0]
      environment_name = var.environment
    }
    "az2" = {
      public_subnet_id = module.subnets.web_public_subnet_ids[1]
      az               = var.availability_zones[1]
      environment_name = var.environment
    }
  }
  common_tags = var.common_tags
}
# -------------------------------------------------
# Route Tables
# ------------------------------------------------
module "route_tables" {
  source = "../../modules/networking/route-tables"

  # Maps
  public_subnet_map = {
    "az1" = {
      subnet_id        = module.subnets.web_public_subnet_ids[0]
      vpc_id           = module.vpc.vpc_id
      az               = var.availability_zones[0]
      environment_name = var.environment
    }
    "az2" = {
      subnet_id        = module.subnets.web_public_subnet_ids[1]
      vpc_id           = module.vpc.vpc_id
      az               = var.availability_zones[1]
      environment_name = var.environment
    }
  }

  private_subnet_map = {
    "az1" = {
      subnet_id        = module.subnets.app_private_subnet_ids[0]
      vpc_id           = module.vpc.vpc_id
      az               = var.availability_zones[0]
      environment_name = var.environment
    }
    "az2" = {
      subnet_id        = module.subnets.app_private_subnet_ids[1]
      vpc_id           = module.vpc.vpc_id
      az               = var.availability_zones[1]
      environment_name = var.environment
    }
  }

  # Gateways
  internet_gateway_ids = module.internet_gateway.internet_gateway_ids
  nat_gateway_ids      = module.nat_gateway.nat_gateway_ids

  # Tags
  common_tags = var.common_tags
}

################################################################
# ********************* Security Modules **********************
#
#
#
#################################################################

# --------------------------------------------------
# IAM Roles
# Context:
#   - IAM roles for each tier (Web, App, DB, Bastion)
#   - Follows least privilege principle
# --------------------------------------------------

# IAM Assume Role Policy for EC2 instances
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

module "iam_roles" {
  source      = "../../modules/security/iam"
  environment = var.environment

  iam_roles = {
    app_role = {
      name               = "app-tier-role-${var.environment}"
      assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }

    web_role = {
      name               = "web-tier-role-${var.environment}"
      assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }

    db_role = {
      name               = "db-tier-role-${var.environment}"
      assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
        "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }

    bastion_role = {
      name               = "bastion-access-role-${var.environment}"
      assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
      managed_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]
    }
  }

  common_tags = var.common_tags

}
# ----------------------------------------------------------
#  Security Groups Module
#   - Uses sg_map from variables.tf for clean and dynamic configuration
# -----------------------------------------------------------

module "security_groups" {
  source      = "../../modules/security/security-groups"
  environment = var.environment
  common_tags = var.common_tags

  sg_map = var.sg_map
}

# ----------------------------------------------------------
# KMS Module
# ----------------------------------------------------------
module "kms" {
  source      = "../../modules/security/kms"
  key_name    = var.kms_key_name
  key_alias   = var.kms_key_alias
  environment = var.environment

  common_tags = var.common_tags
}

# ----------------------------------------------------------
#  Secrets Manager 
# ---------------------------------------------------------

module "secrets_manager" {
  source             = "../../modules/security/secrets-manager"
  secret_name        = var.secret_name
  secret_description = "DB credentials for dev environment"
  environment        = var.environment
  kms_key_id         = var.kms_key_id

  secret_value = jsonencode({
    username = var.db_username
    password = var.db_password
  })

  common_tags = var.common_tags
}
############################################################
#****************** Compute Module*************************
# Purpose: Create launch templates for Web, App, and DB tiers
############################################################
#
# ----------------------------------------------------
#  Launch Template 
# ----------------------------------------------------
module "launch_templates" {
  source = "../../modules/compute/launch-templates"

  environment = var.environment
  common_tags = var.common_tags

  launch_templates = {
    web = {
      ami_id               = var.web_ami
      instance_type        = var.web_instance_type
      key_name             = var.key_name
      iam_instance_profile = var.iam_instance_profile
      associate_public_ip  = true
      security_groups      = [var.web_sg_id]
      user_data            = filebase64("${path.module}/scripts/web-userdata.sh")
      tier                 = "web"
    }

    app = {
      ami_id               = var.app_ami
      instance_type        = var.app_instance_type
      key_name             = var.key_name
      iam_instance_profile = var.iam_instance_profile
      associate_public_ip  = false
      security_groups      = [var.app_sg_id]
      user_data            = filebase64("${path.module}/scripts/app-userdata.sh")
      tier                 = "app"
    }

  }
}

# ---------------------------------------------------------
# EC2 Instances 
# ---------------------------------------------------------

module "ec2_instances" {
  source = "../../modules/compute/ec2"

  environment = var.environment
  common_tags = var.common_tags

  instances = {
    bastion = {
      ami_id               = var.bastion_ami
      instance_type        = var.bastion_type
      subnet_id            = module.subnets.web_public_subnet_ids[0]
      key_name             = var.key_name
      security_groups      = [var.bastion_sg_id]
      iam_instance_profile = var.iam_instance_profile
      associate_public_ip  = true
      user_data            = file("${path.module}/scripts/bastion-userdata.sh")
      tier                 = "bastion"
      volume_size          = 20
    }

    web = {
      ami_id               = var.web_ami
      instance_type        = var.web_instance_type
      subnet_id            = module.subnets.web_public_subnet_ids[0]
      key_name             = var.key_name
      security_groups      = [var.web_sg_id]
      iam_instance_profile = var.iam_instance_profile
      associate_public_ip  = false
      user_data            = file("${path.module}/scripts/web-userdata.sh")
      tier                 = "web"
      volume_size          = 16
    }

    app = {
      ami_id               = var.app_ami
      instance_type        = var.app_instance_type
      subnet_id            = module.subnets.app_private_subnet_ids[0]
      key_name             = var.key_name
      security_groups      = [var.app_sg_id]
      iam_instance_profile = var.iam_instance_profile
      associate_public_ip  = false
      user_data            = file("${path.module}/scripts/app-userdata.sh")
      tier                 = "app"
      volume_size          = 20
    }

    db = {
      ami_id               = var.db_ami
      instance_type        = var.db_instance_type
      subnet_id            = module.subnets.db_private_subnet_ids[0]
      key_name             = var.key_name
      security_groups      = [var.db_sg_id]
      iam_instance_profile = var.iam_instance_profile
      associate_public_ip  = false
      user_data            = file("${path.module}/scripts/db-userdata.sh")
      tier                 = "db"
      volume_size          = 50
    }
  }
}

# ----------------------------------------------------------
# Auto Scaling 
# ----------------------------------------------------------

module "autoscaling" {
  source      = "../../modules/compute/autoscaling"
  environment = "dev"

  asg_definitions = {
    web = {
      max_size           = 3
      min_size           = 1
      desired_capacity   = 1
      launch_template_id = var.launch_template_ids["web"]
      subnet_ids         = var.web_subnet_ids
      target_group_arn   = null # attach to ALB later
    }

    app = {
      max_size           = 4
      min_size           = 2
      desired_capacity   = 2
      launch_template_id = var.launch_template_ids["app"]
      subnet_ids         = var.app_subnet_ids
      target_group_arn   = var.app_target_group_arn
    }
  }

  common_tags = var.common_tags
}

# ----------------------------------------------------------
# ALB Module
# ----------------------------------------------------------
module "alb" {
  source = "../../modules/compute/alb"

  environment_name       = var.environment
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = var.public_subnet_ids
  alb_security_group_ids = var.alb_sg_ids

  internal = false

  listener_http_port  = 80
  listener_https_port = 443
  enable_https        = true
  ssl_certificate_arn = var.ssl_certificate_arn

  redirect_http_to_https = true
  ssl_policy             = "ELBSecurityPolicy-2016-08"

  enable_access_logs = true
  alb_logs_bucket    = var.alb_logs_bucket

  enable_maintenance = false

  web_tg = var.web_tg
  app_tg = var.app_tg

  common_tags = var.common_tags
}

# ----------------------------------------------------------
# Bastion Host
# ----------------------------------------------------------
module "bastion" {
  source              = "../../modules/compute/bastion-host"
  bastion_name_prefix = "myapp"
  environment         = var.environment

  vpc_id     = module.vpc.vpc_id
  subnet_id  = var.private_subnet_ids[0]
  subnet_ids = var.private_subnet_ids

  bastion_ami_id        = var.bastion_ami
  bastion_instance_type = var.instance_type
  associate_public_ip   = var.associate_public_ip
  allocate_eip          = var.allocate_eip

  aws_region  = var.aws_region
  common_tags = var.common_tags

  enable_route53 = var.enable_route53
}
############################################################
# Wire Web-Tier AND  App-Tier Modules
############################################################

module "web_tier" {
  source             = "../../modules/app/web-tier"
  name               = "web"
  environment        = var.environment
  launch_template_id = var.launch_template_ids["web"]
  subnet_ids         = var.web_subnet_ids
  target_group_arn   = var.web_target_group_arn[0]
  min_size           = 1
  max_size           = 3
  desired_capacity   = 1
  common_tags        = var.common_tags
}

module "app_tier" {
  source             = "../../modules/app/app-tier"
  name               = "app"
  environment        = var.environment
  launch_template_id = var.launch_template_ids["app"]
  subnet_ids         = var.app_subnet_ids
  target_group_arn   = var.app_target_group_arn[0]
  min_size           = 2
  max_size           = 4
  desired_capacity   = 2
  common_tags        = var.common_tags
}

############################################################
# DB-Subnet-Group  AND RDS
############################################################

# ---------------------------------------------------------
# RDS Subnet Group Module
# ---------------------------------------------------------
module "db_subnet_group" {
  source            = "../../modules/database/db-subnet-group"
  subnet_group_name = "dev-db-subnet-group"
  subnet_ids        = var.db_subnet_ids
  tags              = local.tags
}
# --------------------------------------------------------
# RDS Database Module
# --------------------------------------------------------
module "rds" {
  source                  = "../../modules/database/rds"
  instance_identifier     = "dev-rds"
  engine                  = "postgres"
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  multi_az                = var.db_multi_az
  allocated_storage       = var.db_allocated_storage
  storage_type            = var.db_storage_type
  db_subnet_group_name    = module.db_subnet_group.db_subnet_group_name
  vpc_security_group_ids  = var.db_security_group_ids
  master_username         = var.db_username
  master_password         = var.db_password
  db_name                 = var.db_name
  backup_retention_period = var.db_backup_retention_period
  kms_key_id              = var.db_kms_key_id
  tags                    = var.common_tags
}
##################################################################
# ********************* Logging Modules **************************
# - IAM Role for Flow Logs
# - VPC Flow Logs
# - Subnet Flow Logs
# - ENI Flow Logs
# - S3 Logs
# - CloudTrail
##################################################################

# -----------------------------------------------------------------
# IAM ROLE FOR FLOW LOGS
# Required for sending VPC/Subnet/ENI logs to CloudWatch or S3
# -----------------------------------------------------------------
resource "aws_iam_role" "flow_logs" {
  name = "${var.environment}-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy" "flow_logs" {
  name = "${var.environment}-flow-logs-policy"
  role = aws_iam_role.flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

# -----------------------------------------------------------------
# FLOW LOGS MODULES
# Context:
#   - Capture network traffic at VPC and Subnet levels and ENI
#   - Send logs to centralized destination (S3, CW Logs, or Firehose)
#   - Useful for security monitoring and auditing network activity
# ------------------------------------------------------------------

# VPC Flow Logs Module
# Captures traffic logs for all VPC-level network activity.
module "flow_logs_vpc" {
  source          = "../../modules/logging/flow-logs"
  vpc_ids         = module.vpc.vpc_id
  log_destination = var.log_destination
  iam_role_arn    = aws_iam_role.flow_logs.arn
  traffic_type    = "ALL"
  enabled         = true
  tags            = var.common_tags
}

# Subnet Flow Logs Module
module "flow_logs_subnets" {
  source     = "../../modules/logging/flow-logs"
  vpc_ids    = module.vpc.vpc_id
  subnet_ids = concat(module.subnets.public_subnet_ids,
    module.subnets.private_app_subnet_ids,
  module.subnets.private_db_subnet_ids)
  log_destination = var.log_destination
  iam_role_arn    = aws_iam_role.flow_logs.arn
  traffic_type    = "ALL"
  enabled         = true
  tags            = var.common_tags
}

# ENI Flow Logs Module
module "flow_logs_eni" {
  source          = "../../modules/logging/flow-logs"
  vpc_ids         = module.vpc.vpc_id
  eni_ids         = ["eni-1234567890abcdef0", "eni-abcdef1234567890"]
  log_destination = var.log_destination
  iam_role_arn    = aws_iam_role.flow_logs.arn
  traffic_type    = "ALL"
  enabled         = true
  tags            = var.common_tags
}
# -----------------------------------------------------------------
# S3 Logging Module
# -----------------------------------------------------------------
module "s3_logs" {
  source        = "../../modules/logging/s3-logs"
  bucket_name   = var.bucket_name
  force_destroy = var.force_destroy
  common_tags   = var.common_tags
}
# -----------------------------------------------------------------
# CloudTrial Module
# ----------------------------------------------------------------
module "cloudtrail" {
  source         = "../../modules/logging/cloudtrail"
  trail_name     = var.trail_name
  enable_logging = true
  # enable_logging             = var.enable_log_file_validation
  is_multi_region_trail = var.is_multi_region_trail
  # enable_insight_selector    = var.enable_insight_selector
  s3_bucket_name = module.s3_logs.bucket_name
  # sns_topic_arn              = var.sns_topic_arn
  common_tags = var.common_tags
}
#################################################################
# ********************* Monitoring Modules **********************
# Context:
#   - CloudWatch → creates alarms for EC2, RDS, or any AWS metric
#   - SNS → sends notifications to email (or Slack, Lambda, webhook)
#   - Alarms → attaches SNS actions to CloudWatch alarms
##################################################################

# -------------------------------------------------------------
# SNS
# -------------------------------------------------------------
module "sns" {
  source              = "../../modules/monitoring/sns"
  topic_name          = "dev-alerts"
  email_subscriptions = var.sns_emails
  tags                = var.common_tags
}
# ------------------------------------------------------------
# CloudWatch
# ------------------------------------------------------------
module "cloudwatch" {
  source      = "../../modules/monitoring/cloudwatch"
  environment = var.environment
  metrics     = var.cloudwatch_metrics
  tags        = var.common_tags
}
# -----------------------------------------------------------
# Alarms
# Alarms can reference the SNS topic
# -----------------------------------------------------------
module "alarms" {
  source        = "../../modules/monitoring/alarms"
  sns_topic_arn = module.sns.sns_topic_arn
  alarm_actions = module.cloudwatch.alarms
}
