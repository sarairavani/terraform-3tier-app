############################################################
# Variables for Security Groups Module
############################################################

variable "sg_map" {
  description = <<EOT
Map of security groups to create for each tier.

Example:
{
  "web_sg" = {
    name        = "web-sg"
    tier        = "web"
    vpc_id      = "vpc-abc123"
    description = "Security group for web tier"
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
}
EOT
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
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all security groups"
  type        = map(string)
  default     = {}
}

