############################################################
# DB Subnet Group
############################################################

resource "aws_db_subnet_group" "this" {
  name        = var.subnet_group_name
  subnet_ids  = var.subnet_ids
  description = var.subnet_group_description

  tags = merge(
    var.tags,
    { Name = var.subnet_group_name }
  )
}

