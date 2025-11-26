############################################################
# Variables for Internet Gateway Module
############################################################

variable "vpc_map" {
  description = <<-EOT
    Map of VPCs to create IGWs for.
    Example:
    {
      "dev" = {
        vpc_id           = "vpc-123456"
        environment_name = "dev"
      }
    }
  EOT
  type = map(object({
    vpc_id           = string
    environment_name = string
  }))
  default = {}
}

variable "common_tags" {
  description = "Common tags applied to all IGWs"
  type        = map(string)
  default     = {}
}

