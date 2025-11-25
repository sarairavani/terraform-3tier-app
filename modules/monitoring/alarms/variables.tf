############################################################
# Alarms Variables
############################################################

variable "sns_topic_arn" {
  description = "SNS Topic ARN for alarm notifications"
  type        = string
}

variable "alarm_actions" {
  description = "List of alarm actions (usually SNS)"
  type        = list(string)
  default     = []
}

