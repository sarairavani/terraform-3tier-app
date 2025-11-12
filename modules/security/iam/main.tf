############################################################
# IAM Role Module
# Purpose:
#   - Create IAM roles with fine-grained trust and permissions
#   - Designed for multi-tier AWS environments (Web, App, DB)
# Design:
#   - Uses for_each to dynamically create multiple roles
#   - Each role supports custom assume role policies and managed policies
# Note:
#   - For operations like backup, snapshot, or cross-account access,
#     a direct Role assignment (not just assume_role) may be required.
#   - EC2s / Lambda in App Tier assume dedicated Roles for accessing
#     DynamoDB, RDS, SQS, etc. Roles are temporary and follow least privilege.
#   - EC2s in Web Tier assume dedicated Roles for accessing
#     S3, CloudWatch, etc.
#   - DB Tier resources (RDS, EC2 for DB management, or Automation scripts)
#     may assume dedicated Roles for database access and maintenance.
#   - Each Role is tied to its Tier and Environment (dev, staging, prod)
#     to enforce separation of concerns and security boundaries.
############################################################

resource "aws_iam_role" "this" {
  for_each = var.iam_roles

  name               = each.value.name
  assume_role_policy = each.value.assume_role_policy

  tags = merge(
    var.common_tags,
    {
      Name        = each.value.name
      Environment = var.environment
    }
  )
}

############################################################
# IAM Role Policy Attachments
# - Attach one or more AWS Managed Policies per role
############################################################

resource "aws_iam_role_policy_attachment" "attachments" {
  for_each = {
    for role_key, role_value in var.iam_roles :
    role_key => {
      role_name        = aws_iam_role.this[role_key].name
      managed_policies = role_value.managed_policies
    }
  }

  # Iterate through managed policy ARNs for each role
  dynamic "policy_arn" {
    for_each = each.value.managed_policies
    content {
      policy_arn = policy_arn.value
    }
  }

  role       = each.value.role_name
  policy_arn = element(each.value.managed_policies, 0)
}

