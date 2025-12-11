############################################################
# EC2 Module
# Purpose:
#   Create EC2 instances for each tier (web, app, db, bastion)
#
# Notes:
#   - Production architectures usually use ASG + LT (which you already have),
#     but this module gives you direct EC2 control when needed
#     (e.g., Bastion host or single DB node).
#
############################################################

resource "aws_instance" "this" {
  for_each = var.instances

  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  key_name               = each.value.key_name
  vpc_security_group_ids = each.value.security_groups

  iam_instance_profile = each.value.iam_instance_profile

  user_data_base64 = base64encode(each.value.user_data)


  associate_public_ip_address = each.value.associate_public_ip

  tags = merge(
    var.common_tags,
    {
      Name        = "${each.key}-${var.environment}"
      Environment = var.environment
      Tier        = each.value.tier
    }
  )

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = "gp3"
    encrypted   = true
  }
}

