############################################################
# CloudWatch Variables
############################################################

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "metrics" {
  description = "List of AWS services/metrics to monitor"
  type        = list(object({
    namespace  = string
    metric_name = string
    statistic  = string
    threshold  = number
    period     = number
    evaluation_periods = number
    comparison_operator = string
  }))
}

variable "tags" {
  description = "Tags for CloudWatch resources"
  type        = map(string)
  default     = {}
}

