variable "aws_region" {
  description = "AWS region for this environment"
  default     = "ca-central-1"
}

variable "environment" {
  description = "Deployment environment name"
  default     = "dev"
}
variable "cidr_block" {
  description = "CIDR block for the VPC in this environment"
  default     = "10.0.0.0/16"
}
variable "log_destination" {
  description = "ARN of the destination for VPC Flow Logs (S3, CloudWatch, or Kinesis)"
  default     = "arn:aws:s3:::my-vpc-flow-logs"
}

