############################################################
# NAT Gateway Module
# Purpose:
#   - Provides outbound internet access for private subnets
#   - Typically used by the Application Tier
# Design:
#   - Creates one Elastic IP and one NAT Gateway per public subnet
#   - Each NAT Gateway is associated with the public subnet in the same AZ
############################################################

# Allocate Elastic IP for each NAT Gateway
resource "aws_eip" "nat_eip" {
  for_each = var.public_subnet_map

  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${each.value.environment_name}-eip-${each.value.az}"
    }
  )
}

# Create NAT Gateway per public subnet (per AZ)
resource "aws_nat_gateway" "this" {
  for_each = var.public_subnet_map

  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = each.value.public_subnet_id

  tags = merge(
    var.common_tags,
    {
      Name = "${each.value.environment_name}-nat-${each.value.az}"
    }
  )

  depends_on = [aws_eip.nat_eip]
}

