############################################################
# IAM Role Module
# Purpose:
#   - Create IAM roles with fine-grained trust and permissions
#   - Designed for multi-tier AWS environments (Web, App, DB)
# Design:
#   - Uses for_each to dynamically create multiple roles
#   - Each role supports custom assume role policies and managed policies
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

locals {
  # Flatten the role-policy combinations for for_each
  role_policy_attachments = flatten([
    for role_key, role_value in var.iam_roles : [
      for policy_arn in role_value.managed_policies : {
        role_key   = role_key
        policy_arn = policy_arn
      }
    ]
  ])
}

resource "aws_iam_role_policy_attachment" "attachments" {
  for_each = {
    for attachment in local.role_policy_attachments :
    "${attachment.role_key}-${basename(attachment.policy_arn)}" => attachment
  }

  role       = aws_iam_role.this[each.value.role_key].name
  policy_arn = each.value.policy_arn
}

