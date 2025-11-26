############################################################
# Environment Settings
############################################################
variable "aws_region" {
  description = "AWS region for this environment"
  type        = string
  default     = "ca-central-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-3tier-app"
}

variable "cidr_block" {
  description = "CIDR block for the VPC in this environment"
  type        = string
  default     = "10.0.0.0/16"
}

variable "log_destination" {
  description = "ARN of the destination for VPC Flow Logs (S3, CloudWatch, or Kinesis)"
  type        = string
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
    ManagedBy   = "Terraform"
    Owner       = "Sara"
  }
}

##############################################################
# Security Groups
##############################################################

variable "admin_ip" {
  description = "Admin IP address for SSH access to bastion host"
  type        = string
  default     = "0.0.0.0/0"
}

########################################################
# KMS
########################################################

variable "kms_name" {
  description = "KMS key name"
  type        = string
  default     = "dev-3tier-kms"
}

variable "alias_name" {
  description = "KMS key alias name"
  type        = string
  default     = "dev-3tier-kms"
}

########################################################
# Secrets Manager
########################################################

variable "kms_key_id" {
  description = "KMS key ARN or ID for encrypting secrets"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Database username for RDS"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Database password for RDS"
  type        = string
  sensitive   = true
  default     = "ChangeMe123!"
}

variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
  default     = "dev-db-credentials"
}

############################################################
# EC2 / Launch Templates / Compute
############################################################

variable "key_name" {
  description = "EC2 key pair for SSH access"
  type        = string
  default     = "my-dev-key"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2 instances"
  type        = string
  default     = "ec2-instance-profile-dev"
}

# AMIs
variable "bastion_ami" {
  description = "AMI ID for bastion host"
  type        = string
  default     = "ami-0aaa000bbb111ccc1"
}

variable "web_ami" {
  description = "AMI ID for web tier"
  type        = string
  default     = "ami-0aaa000bbb111ccc2"
}

variable "app_ami" {
  description = "AMI ID for app tier"
  type        = string
  default     = "ami-0aaa000bbb111ccc3"
}

variable "db_ami" {
  description = "AMI ID for database tier"
  type        = string
  default     = "ami-0aaa000bbb111ccc4"
}

# Instance types
variable "bastion_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "web_instance_type" {
  description = "Instance type for web tier"
  type        = string
  default     = "t3.micro"
}

variable "app_instance_type" {
  description = "Instance type for app tier"
  type        = string
  default     = "t3.small"
}

variable "db_instance_type" {
  description = "Instance type for database tier"
  type        = string
  default     = "t3.medium"
}

# Security group IDs
variable "bastion_sg_id" {
  description = "Security group ID for bastion"
  type        = string
  default     = "sg-bastion"
}

variable "web_sg_id" {
  description = "Security group ID for web tier"
  type        = string
  default     = "sg-web"
}

variable "app_sg_id" {
  description = "Security group ID for app tier"
  type        = string
  default     = "sg-app"
}

variable "db_sg_id" {
  description = "Security group ID for database tier"
  type        = string
  default     = "sg-db"
}

# Subnets for EC2
variable "public_subnet_1" {
  description = "Public subnet ID for web tier"
  type        = string
  default     = "subnet-public-1"
}

variable "private_app_subnet_1" {
  description = "Private subnet ID for app tier"
  type        = string
  default     = "subnet-app-1"
}

variable "private_db_subnet_1" {
  description = "Private subnet ID for database tier"
  type        = string
  default     = "subnet-db-1"
}

############################################################
# Autoscaling
############################################################

variable "launch_template_ids" {
  description = "Launch template IDs from launch-template module"
  type        = map(string)
  default = {
    web = "lt-0abc123def4567890"
    app = "lt-0abc123def4567891"
  }
}

variable "web_subnet_ids" {
  description = "Public subnets for Web tier"
  type        = list(string)
  default     = ["subnet-0aaa111bbb222ccc0", "subnet-0aaa111bbb222ccc1"]
}

variable "app_subnet_ids" {
  description = "Private subnets for App tier"
  type        = list(string)
  default     = ["subnet-0aaa111bbb222ccc2", "subnet-0aaa111bbb222ccc3"]
}

variable "web_target_group_arn" {
  description = "ARN of Web Tier Target Group for ALB"
  type        = string
  default     = "arn:aws:elasticloadbalancing:ca-central-1:123456789012:targetgroup/web-tg/abcd1234efgh5678"
}

variable "app_target_group_arn" {
  description = "ARN of App Tier Target Group for ALB"
  type        = string
  default     = "arn:aws:elasticloadbalancing:ca-central-1:123456789012:targetgroup/app-tg/abcd1234efgh5678"
}

############################################################
# ALB module
############################################################

variable "vpc_id" {
  description = "VPC ID for resources"
  type        = string
  default     = "vpc-1234567890abcdef"
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
  default     = ["subnet-public-1", "subnet-public-2"]
}

variable "alb_sg_ids" {
  description = "Security group IDs for ALB"
  type        = list(string)
  default     = ["sg-alb"]
}

variable "ssl_certificate_arn" {
  description = "SSL certificate ARN for HTTPS"
  type        = string
  default     = ""
}

variable "alb_logs_bucket" {
  description = "S3 bucket for ALB access logs"
  type        = string
  default     = "alb-logs-bucket"
}

variable "env_name" {
  description = "Environment name for ALB naming"
  type        = string
  default     = "dev"
}

variable "web_tg" {
  description = "Web tier target group configuration"
  type = object({
    port                = number
    protocol            = string
    target_type         = string
    stickiness_enabled  = bool
    stickiness_duration = number
    health = object({
      path                = string
      matcher             = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
    })
  })
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
  description = "App tier target group configuration"
  type = object({
    port                = number
    protocol            = string
    target_type         = string
    stickiness_enabled  = bool
    stickiness_duration = number
    health = object({
      path                = string
      matcher             = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
    })
  })
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

variable "name" {
  description = "Base name for resources"
  type        = string
  default     = "myapp"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for bastion VPC endpoints"
  type        = list(string)
  default     = ["subnet-11111111", "subnet-22222222"]
}

variable "instance_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP to the bastion"
  type        = bool
  default     = false
}

variable "allocate_eip" {
  description = "Allocate Elastic IP for bastion host"
  type        = bool
  default     = false
}

variable "enable_route53" {
  description = "Enable Route53 record for bastion"
  type        = bool
  default     = false
}

variable "region" {
  description = "AWS region for bastion host VPC endpoints"
  type        = string
  default     = "ca-central-1"
}

############################################################
# RDS / Database
############################################################

variable "db_subnet_ids" {
  description = "List of private subnet IDs where RDS instances will be deployed."
  type        = list(string)
  default     = ["subnet-private-1", "subnet-private-2"]
}

variable "db_security_group_ids" {
  description = "List of security group IDs to attach to RDS instances."
  type        = list(string)
  default     = ["sg-db-private"]
}

variable "db_kms_key_id" {
  description = "KMS Key ARN used to encrypt RDS database storage."
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Name of the initial database to create in RDS."
  type        = string
  default     = "mydb"
}

variable "db_backup_retention_period" {
  description = "Number of days to retain RDS backups."
  type        = number
  default     = 7
}

variable "db_instance_class" {
  description = "EC2 instance class for the RDS instance."
  type        = string
  default     = "db.t3.medium"
}

variable "db_engine_version" {
  description = "Database engine version for RDS."
  type        = string
  default     = "15.3"
}

variable "db_multi_az" {
  description = "Whether to deploy RDS in Multi-AZ for high availability."
  type        = bool
  default     = true
}

variable "db_allocated_storage" {
  description = "The allocated storage for RDS in GB."
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "The storage type for RDS (gp2, gp3, io1)."
  type        = string
  default     = "gp3"
}

############################################################
# Monitoring
############################################################

variable "sns_emails" {
  description = "Email addresses for SNS notifications"
  type        = list(string)
  default     = ["devops-team@example.com"]
}

variable "cloudwatch_metrics" {
  description = "CloudWatch metrics configuration"
  type = list(object({
    namespace           = string
    metric_name         = string
    statistic           = string
    threshold           = number
    period              = number
    evaluation_periods  = number
    comparison_operator = string
  }))
  default = [
    {
      namespace           = "AWS/EC2"
      metric_name         = "CPUUtilization"
      statistic           = "Average"
      threshold           = 70
      period              = 300
      evaluation_periods  = 2
      comparison_operator = "GreaterThanThreshold"
    },
    {
      namespace           = "AWS/RDS"
      metric_name         = "CPUUtilization"
      statistic           = "Average"
      threshold           = 70
      period              = 300
      evaluation_periods  = 2
      comparison_operator = "GreaterThanThreshold"
    }
  ]
}

############################################################
# Logging
############################################################

variable "bucket_name" {
  description = "Name of the S3 bucket for CloudTrail logs"
  type        = string
  default     = "cloudtrail-logs-dev"
}

variable "force_destroy" {
  description = "Force destroy S3 bucket"
  type        = bool
  default     = false
}

variable "trail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
  default     = "dev-cloudtrail"
}

variable "enable_log_file_validation" {
  description = "Enable file integrity validation"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Whether CloudTrail is multi-region"
  type        = bool
  default     = true
}

variable "enable_insight_selector" {
  description = "Enable CloudTrail Insights"
  type        = bool
  default     = true
}

variable "sns_topic_arn" {
  description = "SNS topic for CloudTrail notifications"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}

##############################################################
# Security Groups Map
##############################################################
variable "sg_map" {
  description = "Map of security groups for 3-tier architecture"
  type = map(object({
    name        = string
    tier        = string
    vpc_id      = string
    description = string
    ingress = object({
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
  default = {}
}
