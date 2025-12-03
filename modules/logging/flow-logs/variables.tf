variable "vpc_ids" {
  description = "List of VPC IDs to create flow logs for"
  type        = list(string)
}

variable "log_destination_type" {
  description = "Destination for flow logs. Can be S3 bucket ARN, CloudWatch log group ARN, or Kinesis Firehose ARN."
  type        = string
}

variable "log_destination" {
  type        = string
  description = "ARN for Flow Logs destination (CloudWatch Log Group ARN)"
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


variable "subnet_ids" {
  description = "Optional list of subnet IDs to create flow logs for"
  type        = list(string)
  default     = []
}

variable "eni_ids" {
  description = "Optional list of ENI IDs to create flow logs for"
  type        = list(string)
  default     = []

}
variable "enabled" {
  description = "Enable or disable flow logs"
  type        = bool
  default     = true
}


variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}


variable "common_tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
  default     = {}
}

