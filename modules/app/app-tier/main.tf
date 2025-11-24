############################################################
# App Tier Module
# - Wraps autoscaling module to create app ASG
# - App tier is internal only; it's attached to the app TG
############################################################

module "asg_wrapper" {
  source      = "../../compute/autoscaling"
  environment = var.environment
  common_tags = var.common_tags

  asg_definitions = {
    app = {
      max_size           = var.max_size
      min_size           = var.min_size
      desired_capacity   = var.desired_capacity
      launch_template_id = var.launch_template_id
      subnet_ids         = var.subnet_ids
      target_group_arn   = var.target_group_arn
    }
  }
}

