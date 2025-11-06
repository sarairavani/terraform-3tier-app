variable "name" {
  description = "VPC name tag"
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "tags" {
  description = "Additional tags for VPC"
  type        = map(string)
  default     = {}
}

variable "enable_flow_logs" {
  description = "Enable VPC flow logs"
  type        = bool
  default     = false
}

variable "flow_log_destination" {
  description = "Flow log destination ARN (CloudWatch or S3)"
  type        = string
  default     = ""
}

variable "flow_log_iam_role_arn" {
  description = "IAM role ARN for flow logs"
  type        = string
  default     = ""
}

