############################################################
# Variables for NAT Gateway Module
############################################################

variable "public_subnet_map" {
  description = <<EOT
Map of public subnets for NAT Gateway creation.
Each item represents an AZ with a public subnet.

Example:
{
  "az1" = {
    public_subnet_id  = "subnet-0abcd123"
    az                = "ca-central-1a"
    environment_name  = "dev"
  }
  "az2" = {
    public_subnet_id  = "subnet-0efgh456"
    az                = "ca-central-1b"
    environment_name  = "dev"
  }
}
EOT
  type = map(object({
    public_subnet_id  = string
    az                = string
    environment_name  = string
  }))
}

variable "common_tags" {
  description = "Common tags applied to all NAT resources"
  type        = map(string)
  default     = {}
}

