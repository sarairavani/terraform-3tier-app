variable "name" {
  description = "Logical name prefix for web-tier"
  type        = string
  default     = "web"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID to use for web-tier (from launch-templates module)"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs (AZs) where web-tier instances will run"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ALB target group ARN for the web tier (web TG)"
  type        = string
}

variable "min_size" { type = number; default = 1 }
variable "max_size" { type = number; default = 3 }
variable "desired_capacity" { type = number; default = 1 }

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

