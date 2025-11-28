############################################################
# SNS Variables
############################################################

variable "topic_name" {
  description = "Name of the SNS topic for alert notifications"
  type        = string
}

variable "email_subscriptions" {
  description = "List of email addresses to subscribe for notifications"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the SNS topic"
  type        = map(string)
  default     = {}
}

