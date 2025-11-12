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
#-------------------------
# Security Groups Map
#-------------------------
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
#-------------------------
# KMS
#-------------------------

variable "kms_name" {
  description = "KMS name"
  default     = "dev-3tier-kms"
}
variale "alias_name"{
  description = "alias name"
  default     = "dev-3tier-kms"
}
