############################################################
# Web Tier Module
# - Wraps the generic autoscaling module to create web ASG
# - Uses provided launch template and attaches to web TG
############################################################

locals {
  asg_key = "${var.name}-${var.environment}"
}

# Build ASG definition map expected by modules/compute/autoscaling
module "asg_wrapper" {
  source      = "../../compute/autoscaling"
  environment = var.environment
  common_tags = var.common_tags

  asg_definitions = {
    # key = web (you can change the key but keep it unique)
    web = {
      max_size           = var.max_size
      min_size           = var.min_size
      desired_capacity   = var.desired_capacity
      launch_template_id = var.launch_template_id
      subnet_ids         = var.subnet_ids
      target_group_arn   = var.target_group_arn
    }
  }
}

