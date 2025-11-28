############################################################
# DB Subnet Group Variables
############################################################

variable "subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "subnet_group_description" {
  description = "Description for the DB subnet group"
  type        = string
  default     = "Private subnets for RDS"
}

variable "subnet_ids" {
  description = "List of private subnet IDs to include in the DB subnet group"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the DB subnet group"
  type        = map(string)
  default     = {}
}

