############################################################
# EC2 Module Variables
############################################################

variable "instances" {
  description = "Map of EC2 instances to deploy per tier"
  type = map(object({
    ami_id               = string
    instance_type        = string
    subnet_id            = string
    key_name             = string
    security_groups      = list(string)
    iam_instance_profile = string
    associate_public_ip  = bool
    user_data            = string
    tier                 = string
    volume_size          = number
  }))
}

variable "environment" {
  description = "Environment name (dev/staging/prod)"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

