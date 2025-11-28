############################################################
# Variables for Internet Gateway Module
############################################################

variable "vpc_map" {
  description = <<EOT
Map of VPCs to create Internet Gateways for.
Each key is a VPC name, each value is an object containing:
  - vpc_id: The ID of the VPC
  - environment_name: Environment identifier (e.g., dev, prod)
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

