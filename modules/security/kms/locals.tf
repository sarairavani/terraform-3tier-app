locals {
  kms_policy = var.key_policy != null ? var.key_policy : jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowUseOfKey"
        Effect    = "Allow"
        Principal = { AWS = "*" }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:GenerateDataKey",
          "kms:ReEncrypt*"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/Project" = "terraform-3tier-app"
          }
        }
      },
      {
        Sid       = "EnableIAMUserPermissions"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::<YOUR_ACCOUNT_ID>:root" }
        Action    = "kms:*"
        Resource  = "*"
      }
    ]
  })
}

