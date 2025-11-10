variable "environment_name" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where subnets will be created"
  type        = string
}

variable "availability_zones" {
  description = "List of Availability Zones (e.g., [\"ca-central-1a\", \"ca-central-1b\"])"
  type        = list(string)
}

variable "web_public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (Web Tier)"
  type        = list(string)
}

variable "app_private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (App Tier)"
  type        = list(string)
}

variable "db_private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (DB Tier)"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags applied to all subnet resources"
  type        = map(string)
  default     = {}
}

