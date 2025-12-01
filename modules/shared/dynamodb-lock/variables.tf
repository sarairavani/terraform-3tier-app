variable "lock_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the DynamoDB table"
  type        = map(string)
  default     = {}
}

