############################################################
# Launch Template Module Variables
############################################################

variable "launch_templates" {
  description = "Map of launch templates to create for each tier"
  type = map(object({
    ami_id                 = string
    instance_type          = string
    key_name               = string
    iam_instance_profile   = string
    associate_public_ip    = bool
    security_groups        = list(string)
    user_data              = string
    tier                   = string
  }))
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

