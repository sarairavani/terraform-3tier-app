variable "name" {
  description = "Logical name prefix for app-tier"
  type        = string
  default     = "app"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID to use for app-tier"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for app-tier"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ALB target group ARN for app tier (app TG)"
  type        = string
}

variable "min_size" {
  type    = number
  default = 2
}
variable "max_size" {
  type    = number
  default = 4
}
variable "desired_capacity" {
  type    = number
  default = 2
}
variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

