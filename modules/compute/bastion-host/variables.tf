############################################################
# Bastion Host (SSM) Module Variables
############################################################

variable "bastion_name_prefix" {
  description = "Name prefix for the bastion host resources"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the bastion host will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the bastion instance"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnets for optional Route53 records"
  type        = list(string)
  default     = []
}

variable "bastion_ami_id" {
  description = "AMI ID for the bastion host instance"
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name for SSH access (optional when using SSM)"
  type        = string
  default     = ""
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP to the bastion"
  type        = bool
  default     = false
}

variable "allocate_eip" {
  description = "Allocate an Elastic IP for the bastion host (only if public IP is assigned)"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "Custom user data for bastion instance (base64 encoded or empty to use default)"
  type        = string
  default     = ""
}

variable "root_volume_size_gb" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}

variable "additional_security_group_ids" {
  description = "Additional security group IDs to attach to the bastion host"
  type        = list(string)
  default     = []
}

variable "aws_region" {
  description = "AWS region where the VPC and bastion reside"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all bastion resources"
  type        = map(string)
  default     = {}
}

variable "enable_route53" {
  description = "Enable creating private Route53 record for the bastion host"
  type        = bool
  default     = false
}

variable "private_zone_id" {
  description = "Route53 private hosted zone ID"
  type        = string
  default     = ""
}

variable "private_zone_name" {
  description = "Private hosted zone domain name"
  type        = string
  default     = ""
}

