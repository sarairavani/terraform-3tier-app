# IAM Policies Module

This module provides custom, scoped IAM policies following the principle of least privilege.

## Purpose

Replace overly permissive AWS managed policies (like `AmazonS3FullAccess`, `AmazonRDSFullAccess`) with custom policies that grant only the necessary permissions.

## Security Best Practices

1. **Least Privilege**: Policies grant only the minimum permissions required
2. **Resource Scoping**: Policies are scoped to specific resources (buckets, secrets, etc.)
3. **Action Restrictions**: Only necessary actions are allowed
4. **KMS Integration**: Includes KMS decrypt permissions for Secrets Manager

## Provided Policies

- **Web Tier S3 Policy**: Scoped S3 access for web assets bucket
- **App Tier S3 Policy**: Read-only S3 access for app data bucket
- **App Tier Secrets Policy**: Access to specific secrets in Secrets Manager with KMS decrypt
- **DB Tier Logs Policy**: CloudWatch Logs access scoped to RDS logs

## Usage

```hcl
module "iam_policies" {
  source = "../../modules/security/iam-policies"

  environment       = "dev"
  aws_region        = "us-east-1"
  web_assets_bucket = "my-web-assets-bucket"
  app_data_bucket   = "my-app-data-bucket"
  db_secret_arn     = module.secrets_manager.secret_arn
  kms_key_arn       = module.kms.key_arn

  common_tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

## Notes

- These policies should be attached to IAM roles instead of AWS managed policies
- Always review and adjust resource ARNs to match your actual resources
- Consider adding condition blocks for additional security (e.g., IP restrictions, MFA)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
