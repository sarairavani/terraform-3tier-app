############################################################
# Auto Scaling Module Variables
############################################################

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "asg_definitions" {
  description = "Auto scaling configuration for each tier"
  type = map(object({
    max_size            = number
    min_size            = number
    desired_capacity    = number
    launch_template_id  = string
    subnet_ids          = list(string)
    target_group_arn    = optional(string)
  }))
}

variable "common_tags" {
  description = "Common tags applied to all ASGs"
  type        = map(string)
}

