############################################################
# Launch Template Module - Main Configuration
# Purpose: Define reusable EC2 launch templates for app, web, basation tiers.
# Notes:
# 1. iam_instance_profile:
#    - Specifies the IAM role that EC2 instances launched from this template will assume.
#    - The role is defined in the IAM module and linked here for proper permissions.
#
# 2. network_interfaces:
#    - associate_public_ip_address: Determines if the EC2 instance gets a public IP.
#    - security_groups: Assigns network security groups to the instance.
#
# 3. tag_specifications:
#    - Tags are used for identification, monitoring, and resource management.
#    - Merging common_tags with instance-specific tags ensures flexibility and consistency.
#
# 4. monitoring { enabled = true }:
#    - Enables detailed monitoring for CloudWatch.
#    - Collects metrics every 1 minute, useful for alerts and autoscaling.
#
# 5. lifecycle { create_before_destroy = true }:
#    - Ensures a new template version is created before the old one is destroyed.
#    - Reduces downtime and improves service stability.
############################################################

resource "aws_launch_template" "this" {
  for_each = var.launch_templates{
    for k, v in var.launch_templates : k => v if v.tier != "db"
  }

  name_prefix   = each.key
  image_id      = each.value.ami_id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  iam_instance_profile { name = each.value.iam_instance_profile }

  network_interfaces {
    associate_public_ip_address = each.value.associate_public_ip
    security_groups             = each.value.security_groups
  }

  user_data = base64encode(each.value.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.common_tags,
      {
        "Name"       = "${each.key}-${var.environment}"
        "Environment" = var.environment
        "Tier"        = each.value.tier
      }
    )
  }

  monitoring {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

