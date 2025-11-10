############################################################
# Internet Gateway Module
# Creates an Internet Gateway (IGW) and attaches it to the VPC
# Usage: Use this module to enable Internet access for public subnets
############################################################

resource "aws_internet_gateway" "this" {
  for_each = var.vpc_map

  vpc_id = each.value.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${each.value.environment_name}-igw"
    }
  )
}

