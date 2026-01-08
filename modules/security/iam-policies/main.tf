############################################################
# Custom IAM Policies Module
# Purpose:
#   - Provide least-privilege IAM policies for each tier
#   - Replace overly permissive AWS managed policies
#   - Follow security best practices
############################################################

# Web Tier - S3 Access Policy (Scoped to specific buckets)
data "aws_iam_policy_document" "web_tier_s3" {
  statement {
    sid    = "S3BucketAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.web_assets_bucket}/*",
      "arn:aws:s3:::${var.web_assets_bucket}"
    ]
  }
}

resource "aws_iam_policy" "web_tier_s3" {
  name        = "${var.environment}-web-tier-s3-policy"
  description = "Scoped S3 access for web tier"
  policy      = data.aws_iam_policy_document.web_tier_s3.json

  tags = var.common_tags
}

# App Tier - S3 Access Policy (Read-only for specific buckets)
data "aws_iam_policy_document" "app_tier_s3" {
  statement {
    sid    = "S3ReadAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.app_data_bucket}/*",
      "arn:aws:s3:::${var.app_data_bucket}"
    ]
  }
}

resource "aws_iam_policy" "app_tier_s3" {
  name        = "${var.environment}-app-tier-s3-policy"
  description = "Read-only S3 access for app tier"
  policy      = data.aws_iam_policy_document.app_tier_s3.json

  tags = var.common_tags
}

# App Tier - Secrets Manager Access (Scoped to specific secrets)
data "aws_iam_policy_document" "app_tier_secrets" {
  statement {
    sid    = "SecretsManagerAccess"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      var.db_secret_arn
    ]
  }

  statement {
    sid    = "KMSDecrypt"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    resources = [
      var.kms_key_arn
    ]
  }
}

resource "aws_iam_policy" "app_tier_secrets" {
  name        = "${var.environment}-app-tier-secrets-policy"
  description = "Secrets Manager access for app tier"
  policy      = data.aws_iam_policy_document.app_tier_secrets.json

  tags = var.common_tags
}

# DB Tier - CloudWatch Logs Policy
data "aws_iam_policy_document" "db_tier_logs" {
  statement {
    sid    = "CloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:*:log-group:/aws/rds/${var.environment}*"
    ]
  }
}

resource "aws_iam_policy" "db_tier_logs" {
  name        = "${var.environment}-db-tier-logs-policy"
  description = "CloudWatch Logs access for DB tier"
  policy      = data.aws_iam_policy_document.db_tier_logs.json

  tags = var.common_tags
}
