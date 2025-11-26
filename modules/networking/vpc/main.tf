
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  # Enables private DNS hostnames for instances within the VPC
  enable_dns_hostnames = true

  # Enables DNS resolution within the VPC
  enable_dns_support = true

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

