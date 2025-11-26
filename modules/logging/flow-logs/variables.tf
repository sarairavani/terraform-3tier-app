variable "vpc_ids" {
  description = "List of VPC IDs to create flow logs for"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "List of Subnet IDs to create flow logs for"
  type        = list(string)
  default     = []
}

variable "eni_ids" {
  description = "List of ENI IDs to create flow logs for"
  type        = list(string)
  default     = []
}

variable "log_destination" {
  description = "Destination for flow logs. Can be S3 bucket ARN, CloudWatch log group ARN, or Kinesis Firehose ARN."
  type        = string
}

variable "iam_role_arn" {
  description = "IAM role ARN with permission to write VPC flow logs to the destination"
  type        = string
}

variable "traffic_type" {
  description = "Traffic type to log: ALL, ACCEPT, or REJECT"
  type        = string
  default     = "ALL"
}

variable "enabled" {
  description = "Enable or disable flow logs"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to each flow log"
  type        = map(string)
  default     = {}
}

