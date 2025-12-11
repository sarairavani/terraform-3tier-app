############################################################
# Route Tables Module
# Purpose:
#   - Create public and private route tables
#   - Attach public subnets to Internet Gateway
#   - Attach private subnets to NAT Gateway
############################################################

# ----------------------------------------------
# PUBLIC ROUTE TABLES
# ----------------------------------------------
resource "aws_route_table" "public" {
  for_each = var.public_subnet_map

  vpc_id = each.value.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name    = "${each.value.environment_name}-public-rt-${each.value.az}"
      Tier    = "web"
      Network = "public"
    }
  )
}

# Attach route to Internet Gateway
resource "aws_route" "public_internet_route" {
  for_each = aws_route_table.public

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_ids[each.key]
# gateway_id             = lookup(var.internet_gateway_ids, each.key)
# gateway_id             = module.internet_gateway.internet_gateway_ids[each.key]

}

# Associate public subnets to public route tables
resource "aws_route_table_association" "public_assoc" {
  for_each = var.public_subnet_map

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.public[each.key].id
}

# ----------------------------------------------
# PRIVATE ROUTE TABLES
# ----------------------------------------------
resource "aws_route_table" "private" {
  for_each = var.private_subnet_map

  vpc_id = each.value.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name    = "${each.value.environment_name}-private-rt-${each.value.az}"
      Tier    = "app"
      Network = "private"
    }
  )
}

# Route private subnets via NAT Gateway
resource "aws_route" "private_nat_route" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_ids[each.key]
}

# Associate private subnets to private route tables
resource "aws_route_table_association" "private_assoc" {
  for_each = var.private_subnet_map

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.private[each.key].id
}

