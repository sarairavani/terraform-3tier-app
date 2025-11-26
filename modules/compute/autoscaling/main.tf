############################################################
# Auto Scaling Groups for 3-Tier Architecture
# - Web Tier ASG (public)
# - App Tier ASG (private, uses NAT)
# - DB Tier has NO ASG (DB uses RDS, not EC2)
#
# This module depends on:
# - Launch Templates Module
# - Security Groups Module
# - Subnets Module
############################################################

resource "aws_autoscaling_group" "asg" {
  for_each = var.asg_definitions

  name             = "${each.key}-${var.environment}-asg"
  max_size         = each.value.max_size
  min_size         = each.value.min_size
  desired_capacity = each.value.desired_capacity

  vpc_zone_identifier = each.value.subnet_ids
  launch_template {
    id      = each.value.launch_template_id
    version = "$Latest"
  }

  # Ensure rolling replacement happens safely
  health_check_type         = lookup(each.value, "health_check_type", "EC2")
  health_check_grace_period = lookup(each.value, "health_check_grace_period", 300)

  # Ensure ASG replaces unhealthy instances
  termination_policies = ["OldestInstance"]

  tag {
    key                 = "Name"
    value               = "${each.key}-${var.environment}"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

############################################################
# Target Group Attachments (Optional, depends if ALB exists)
############################################################

resource "aws_autoscaling_attachment" "asg_alb" {
  for_each = {
    for k, v in var.asg_definitions :
    k => v if v.target_group_arn != null && v.target_group_arn != ""
  }

  autoscaling_group_name = aws_autoscaling_group.asg[each.key].name
  lb_target_group_arn    = each.value.target_group_arn
}

