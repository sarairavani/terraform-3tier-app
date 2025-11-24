############################################################
# DB Subnet Group Variables
############################################################

variable "name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "description" {
  description = "Description for the DB subnet group"
  type        = string
  default     = "Private subnets for RDS"
}

variable "subnet_ids" {
  description = "List of private subnet IDs for the DB"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to DB subnet group"
  type        = map(string)
  default     = {}
}

