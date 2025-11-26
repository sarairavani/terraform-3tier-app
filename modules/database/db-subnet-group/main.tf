############################################################
# DB Subnet Group
############################################################

resource "aws_db_subnet_group" "this" {
  name        = var.name
  subnet_ids  = var.subnet_ids
  description = var.description

  tags = merge(
    var.tags,
    { Name = var.name }
  )
}

