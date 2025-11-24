############################################################
# Environment Settings
############;################################################
variable "aws_region" {
  description = "AWS region for this environment"
  default     = "ca-central-1"
}

variable "environment" {
  description = "Deployment environment name"
  default     = "dev"
}
variable "project_name" {
  description = ""
  default     = "terraform-3tier-app"
}

variable "cidr_block" {
  description = "CIDR block for the VPC in this environment"
  default     = "10.0.0.0/16"
}
variable "log_destination" {
  description = "ARN of the destination for VPC Flow Logs (S3, CloudWatch, or Kinesis)"
  default     = "arn:aws:s3:::my-vpc-flow-logs"
}
variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["ca-central-1a", "ca-central-1b"]
}

############################################################
# VPC Subnets
############################################################

variable "web_public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (Web Tier)"
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "app_private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (App Tier)"
  type        = list(string)
  default     = ["10.0.128.0/20", "10.0.144.0/20"]
}

variable "db_private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (DB Tier)"
  type        = list(string)
  default     = ["10.0.160.0/20", "10.0.176.0/20"]
}
variable "common_tags" {
  description = "Common tags for all resources in this environment"
  type        = map(string)
  default = {
    Project     = "terraform-3tier-app"
    Environment = "dev"
    Region      = "ca-central-1"
  }
}
##############################################################
# Security Groups Map
##############################################################
variable "sg_map" {
  description = <<EOT
Map of security groups for 3-tier architecture in dev environment.

Tiers:
  - web_sg: Web Tier, public
  - app_sg: Application Tier, private
  - db_sg: Database Tier, private
  - bastion_sg: Bastion host for SSH access
EOT
  type = map(object({
    name        = string
    tier        = string
    vpc_id      = string
    description = string
    ingress     = object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = list(string)
      description     = string
    })
    egress = object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = string
    })
  }))

  default = {
    web_sg = {
      name        = "web-sg-dev"
      tier        = "web"
      vpc_id      = var.vpc_id
      description = "Security group for Web Tier"

      ingress = {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
        description     = "Allow HTTP from anywhere"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }

    app_sg = {
      name        = "app-sg-dev"
      tier        = "app"
      vpc_id      = var.vpc_id
      description = "Security group for App Tier"

      ingress = {
        from_port       = 8080
        to_port         = 8080
        protocol        = "tcp"
        cidr_blocks     = []
        security_groups = [ "web_sg" ]  # Reference by key, resolved in main.tf
        description     = "Allow traffic from Web Tier only"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }

    db_sg = {
      name        = "db-sg-dev"
      tier        = "db"
      vpc_id      = var.vpc_id
      description = "Security group for DB Tier"

      ingress = {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = []
        security_groups = ["app_sg"]  # Reference by key
        description     = "Allow MySQL from App Tier only"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }

    bastion_sg = {
      name        = "bastion-sg-dev"
      tier        = "bastion"
      vpc_id      = var.vpc_id
      description = "Security group for Bastion Host"

      ingress = {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = [var.admin_ip]
        security_groups = []
        description     = "Allow SSH from admin IP"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }
  }

}
########################################################
# KMS
#######################################################

variable "kms_name" {
  description = "KMS name"
  default     = "dev-3tier-kms"
}
variable "alias_name"{
  description = "alias name"
  default     = "dev-3tier-kms"
}

########################################################
# Secrets Manager
########################################################

variable "kms_key_id" {
  description = "KMS key ARN or ID for encrypting secrets"
  type        = string
}

variable "db_username" {
  description = "Database username for RDS"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Database password for RDS"
  type        = string
  default     = "ChangeMe123!" 
}

variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
  default     = "dev-db-credentials"
}

############################################################
# Launch Templates
############################################################

variable "key_name" {
  description = "EC2 key pair for SSH access"
  default     = "my-dev-key"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2 instances"
  default     = "ec2-instance-profile-dev"
}

variable "web_ami" {
  description = "AMI ID for web tier"
  default     = "ami-0123456789abcdef0"
}

variable "web_instance_type" {
  description = "Instance type for web tier"
  default     = "t3.micro"
}

variable "web_sg_id" {
  description = "Security group ID for web tier"
  default     = "sg-web-tier-id"
}

variable "app_ami" {
  description = "AMI ID for app tier"
  default     = "ami-0123456789abcdef1"
}

variable "app_instance_type" {
  description = "Instance type for app tier"
  default     = "t3.small"
}

variable "app_sg_id" {
  description = "Security group ID for app tier"
  default     = "sg-app-tier-id"
}

variable "db_ami" {
  description = "AMI ID for database tier"
  default     = "ami-0123456789abcdef2"
}

variable "db_instance_type" {
  description = "Instance type for database tier"
  default     = "t3.medium"
}

variable "db_sg_id" {
  description = "Security group ID for database tier"
  default     = "sg-db-tier-id"
}
############################################################
# EC2 Instances
############################################################

variable "key_name" {
  default = "my-dev-key"
}

variable "iam_instance_profile" {
  default = "ec2-instance-profile-dev"
}

# AMIs
variable "bastion_ami"       { default = "ami-0aaa000bbb111ccc1" }
variable "web_ami"           { default = "ami-0aaa000bbb111ccc2" }
variable "app_ami"           { default = "ami-0aaa000bbb111ccc3" }
variable "db_ami"            { default = "ami-0aaa000bbb111ccc4" }

# Instance types
variable "bastion_type"      { default = "t3.micro" }
variable "web_instance_type" { default = "t3.micro" }
variable "app_instance_type" { default = "t3.small" }
variable "db_instance_type"  { default = "t3.medium" }

# Security group IDs
variable "bastion_sg_id" { default = "sg-bastion" }
variable "web_sg_id"     { default = "sg-web" }
variable "app_sg_id"     { default = "sg-app" }
variable "db_sg_id"      { default = "sg-db" }

# Subnets
variable "public_subnet_1"        { default = "subnet-public-1" }
variable "private_app_subnet_1"   { default = "subnet-app-1" }
variable "private_db_subnet_1"    { default = "subnet-db-1" }
############################################################
# Autoscaling
############################################################

variable "launch_template_ids" {
  description = "Launch template IDs from launch-template module"
  default = {
    web = "lt-0abc123def4567890"   # replace with your web launch template ID
    app = "lt-0abc123def4567891"   # replace with your app launch template ID
  }
}

variable "web_subnet_ids" {
  description = "Public subnets for Web tier"
  default = ["subnet-0aaa111bbb222ccc0","subnet-0aaa111bbb222ccc1"]
}

variable "app_subnet_ids" {
  description = "Private subnets for App tier"
  default = ["subnet-0aaa111bbb222ccc2","subnet-0aaa111bbb222ccc3"]
}

variable "app_target_group_arn" {
  description = "ARN of App Tier Target Group for ALB"
  default     = "arn:aws:elasticloadbalancing:ca-central-1:123456789012:targetgroup/app-tg/abcd1234efgh5678"
}

variable "common_tags" {
  description = "Common tags for all ASGs"
  default = {
    Project     = "terraform-3tier-app"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

############################################################
# ALB module
############################################################

variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "alb_sg_ids" {}

variable "ssl_certificate_arn" {}
variable "alb_logs_bucket" {}


variable "web_tg" {
  default = {
    port                = 80
    protocol            = "HTTP"
    target_type         = "instance"
    stickiness_enabled  = false
    stickiness_duration = 86400
    health = {
      path                = "/"
      matcher             = "200-299"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 3
      unhealthy_threshold = 3
    }
  }
}

variable "app_tg" {
  default = {
    port                = 8080
    protocol            = "HTTP"
    target_type         = "instance"
    stickiness_enabled  = false
    stickiness_duration = 86400
    health = {
      path                = "/api/health"
      matcher             = "200-299"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 3
      unhealthy_threshold = 3
    }
  }
}

############################################################
# Bastion Host
############################################################

# Naming
# -----------------------
variable "name" {
  type        = string
  description = "Base name for resources"
  default     = "myapp"
}

# Required VPC Inputs
# ------------------------

variable "vpc_id" {
  type        = string
  default     = "vpc-1234567890abcdef"
}

variable "private_subnet_ids" {
  type        = list(string)
  default     = ["subnet-11111111", "subnet-22222222"]
}

# Bastion Host Inputs
# ------------------------

variable "bastion_ami" {
  type        = string
  default     = "ami-0abcdef1234567890"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "associate_public_ip" {
  type        = bool
  default     = false
}

variable "allocate_eip" {
  type        = bool
  default     = false
}

variable "enable_route53" {
  type        = bool
  default     = false
}

############################################################
# web-tier and app-tier modules
############################################################

# Launch template IDs come from modules/compute/launch-templates outputs
variable "launch_template_ids" {
  default = {
    web = "lt-0exampleweb"
    app = "lt-0exampleapp"
  }
}

# Subnets
variable "web_subnet_ids" {
  default = ["subnet-web-1", "subnet-web-2"]  # private subnets reachable by ALB
}

variable "app_subnet_ids" {
  default = ["subnet-app-1", "subnet-app-2"]
}

# Target groups (from ALB module outputs)
variable "web_target_group_arn" {
  default = "arn:aws:elasticloadbalancing:...:targetgroup/dev-web-tg/abcd"
}

variable "app_target_group_arn" {
  default = "arn:aws:elasticloadbalancing:...:targetgroup/dev-app-tg/efgh"
}

