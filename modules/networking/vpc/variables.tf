variable "vpc_name" {
  description = "Name of the VPC for identification and tagging"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC (e.g., 10.0.0.0/16)"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to the VPC"
  type        = map(string)
  default     = {}
}

