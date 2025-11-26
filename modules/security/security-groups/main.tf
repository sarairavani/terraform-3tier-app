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
# Ingress Rules - CIDR based
# - For rules that use CIDR blocks as source
############################################################

resource "aws_security_group_rule" "ingress_cidr" {
  for_each = {
    for sg_key, sg_value in var.sg_map :
    sg_key => sg_value if length(sg_value.ingress.cidr_blocks) > 0
  }

  type              = "ingress"
  security_group_id = aws_security_group.this[each.key].id
  from_port         = each.value.ingress.from_port
  to_port           = each.value.ingress.to_port
  protocol          = each.value.ingress.protocol
  cidr_blocks       = each.value.ingress.cidr_blocks
  description       = each.value.ingress.description
}

############################################################
# Ingress Rules - Security Group based
# - For rules that use other security groups as source
############################################################

resource "aws_security_group_rule" "ingress_sg" {
  for_each = {
    for sg_key, sg_value in var.sg_map :
    sg_key => sg_value if length(coalesce(sg_value.ingress.security_groups, [])) > 0
  }

  type                     = "ingress"
  security_group_id        = aws_security_group.this[each.key].id
  from_port                = each.value.ingress.from_port
  to_port                  = each.value.ingress.to_port
  protocol                 = each.value.ingress.protocol
  source_security_group_id = aws_security_group.this[each.value.ingress.security_groups[0]].id
  description              = each.value.ingress.description
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

