############################################################
# RDS Module Variables
############################################################

variable "instance_identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine type (e.g., postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Version of the database engine"
  type        = string
  default     = "15.3"
}

variable "instance_class" {
  description = "RDS instance type (e.g., db.t3.medium, db.r5.large)"
  type        = string
  default     = "db.t3.medium"
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = true
}

variable "allocated_storage" {
  description = "Initial storage allocation in GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Storage type (gp2, gp3, io1, io2)"
  type        = string
  default     = "gp3"
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the RDS instance"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "master_username" {
  description = "Master username for the RDS database"
  type        = string
  default     = "admin"
}

variable "master_password" {
  description = "Master password for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
  default     = ""
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "kms_key_id" {
  description = "KMS key ARN for storage encryption (leave empty for default encryption)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the RDS instance"
  type        = map(string)
  default     = {}
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying the RDS instance (not recommended for production)"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection for the RDS instance"
  type        = bool
  default     = true
}

variable "backup_window" {
  description = "Preferred backup window in UTC (format: hh24:mi-hh24:mi)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred maintenance window in UTC (format: ddd:hh24:mi-ddd:hh24:mi)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch Logs"
  type        = list(string)
  default     = ["postgresql"]
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds (0, 1, 5, 10, 15, 30, 60)"
  type        = number
  default     = 60
}

variable "monitoring_role_arn" {
  description = "ARN of the IAM role for enhanced monitoring (required if monitoring_interval > 0)"
  type        = string
  default     = ""
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades during maintenance window"
  type        = bool
  default     = true
}

