# ==========================================
# PUBLIC SUBNETS (Web Tier)
# These subnets host web servers accessible from the internet.
# ==========================================
resource "aws_subnet" "web_public_subnet" {
  for_each = {
    for idx, az in var.availability_zones :
    az => {
      cidr = var.web_public_subnet_cidrs[idx]
    }
  }

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name    = "${var.environment_name}-web-public-${each.key}"
      Tier    = "web"
      Network = "public"
    }
  )
}

# =========================================
# PRIVATE SUBNETS (App Tier)
# =========================================
resource "aws_subnet" "app_private_subnet" {
  for_each = {
    for idx, az in var.availability_zones :
    az => {
      cidr = var.app_private_subnet_cidrs[idx]
    }
  }

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.key

  tags = merge(
    var.common_tags,
    {
      Name    = "${var.environment_name}-app-private-${each.key}"
      Tier    = "app"
      Network = "private"
    }
  )
}

# =============================================
# PRIVATE SUBNETS (Database Tier)
# =============================================
resource "aws_subnet" "db_private_subnet" {
  for_each = {
    for idx, az in var.availability_zones :
    az => {
      cidr = var.db_private_subnet_cidrs[idx]
    }
  }

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.key

  tags = merge(
    var.common_tags,
    {
      Name    = "${var.environment_name}-db-private-${each.key}"
      Tier    = "database"
      Network = "private"
    }
  )
}

