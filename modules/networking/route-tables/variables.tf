############################################################
# Variables for Route Tables Module
############################################################

variable "public_subnet_map" {
  description = <<EOT
Map of public subnets to create route tables for.
Example:
{
  "az1" = {
    subnet_id        = "subnet-123abc"
    vpc_id           = "vpc-0abcd123"
    az               = "ca-central-1a"
    environment_name = "dev"
  }
}
EOT
  type = map(object({
    subnet_id        = string
    vpc_id           = string
    az               = string
    environment_name = string
  }))
}

variable "private_subnet_map" {
  description = <<EOT
Map of private subnets to create route tables for.
Each should map to a NAT Gateway.
EOT
  type = map(object({
    subnet_id        = string
    vpc_id           = string
    az               = string
    environment_name = string
  }))
}

variable "internet_gateway_ids" {
  description = "Map of IGW IDs per AZ or environment"
  type        = map(string)
  default     = {} 
}

variable "nat_gateway_ids" {
  description = "Map of NAT Gateway IDs per AZ or environment"
  type        = map(string)
}

variable "common_tags" {
  description = "Common tags applied to all route tables"
  type        = map(string)
  default     = {}
}

