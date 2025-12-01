############################################################
# Security Groups Module
# Purpose:
#   - Create security groups for Web, App, DB, and Bastion tiers
#   - Apply proper ingress/egress rules per tier
#   - Designed for 3-tier web application architecture
############################################################

resource "aws_security_group" "this" {
  for_each = var.sg_map

  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = each.value.name
      Environment = var.environment
      Tier        = each.value.tier
    }
  )
}

############################################################
# Ingress Rules
# - Supports multiple sources: CIDR blocks or other SGs
############################################################

resource "aws_security_group_rule" "ingress" {
  for_each = {
    for sg_key, sg_value in var.sg_map :
    sg_key => sg_value
  }

  type              = "ingress"
  security_group_id = aws_security_group.this[each.key].id
  from_port         = each.value.ingress.from_port
  to_port           = each.value.ingress.to_port
  protocol          = each.value.ingress.protocol

  # Support source as CIDR - security_groups reference not supported in this simple model
  cidr_blocks = length(each.value.ingress.cidr_blocks) > 0 ? each.value.ingress.cidr_blocks : null
  description = each.value.ingress.description
}

############################################################
# Egress Rules
# - Default allows all outbound
############################################################
resource "aws_security_group_rule" "egress" {
  for_each = {
    for sg_key, sg_value in var.sg_map :
    sg_key => sg_value
  }

  type              = "egress"
  security_group_id = aws_security_group.this[each.key].id
  from_port         = each.value.egress.from_port
  to_port           = each.value.egress.to_port
  protocol          = each.value.egress.protocol

  cidr_blocks = lookup(each.value.egress, "cidr_blocks", ["0.0.0.0/0"])
  description = each.value.egress.description
}

