output "web_tier_s3_policy_arn" {
  description = "ARN of the web tier S3 policy"
  value       = aws_iam_policy.web_tier_s3.arn
}

output "app_tier_s3_policy_arn" {
  description = "ARN of the app tier S3 policy"
  value       = aws_iam_policy.app_tier_s3.arn
}

output "app_tier_secrets_policy_arn" {
  description = "ARN of the app tier secrets policy"
  value       = aws_iam_policy.app_tier_secrets.arn
}

output "db_tier_logs_policy_arn" {
  description = "ARN of the DB tier logs policy"
  value       = aws_iam_policy.db_tier_logs.arn
}
