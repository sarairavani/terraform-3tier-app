############################################################
# SNS Variables
############################################################

variable "name" {
  description = "SNS topic name"
  type        = string
}

variable "email_subscription" {
  description = "Email addresses to subscribe for notifications"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for SNS topic"
  type        = map(string)
  default     = {}
}

