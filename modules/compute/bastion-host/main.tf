############################################################
# Bastion Host (SSM) Module
# Purpose:
#   - Create a minimal bastion EC2 that is accessible via AWS SSM Session Manager.
#   - No inbound SSH required. No public IP by default.
# Design notes:
#   - Instance runs in given subnet (private or public). If in private, ensure NAT for outbound access.
#   - Attaches an IAM instance profile with AmazonSSMManagedInstanceCore.
#   - Security group allows no inbound by default (SSM works over HTTPS outbound).
############################################################

# IAM role for SSM
resource "aws_iam_role" "ssm_role" {
  name = "${var.name}-ssm-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, { Name = "${var.name}-ssm-role" })
}

# Attach managed policy for SSM
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance profile
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.name}-ssm-profile-${var.environment}"
  role = aws_iam_role.ssm_role.name
}

# Security group for bastion (no inbound by default; allow outbound)
resource "aws_security_group" "bastion_sg" {
  name        = "${var.name}-bastion-sg-${var.environment}"
  description = "Bastion SG (SSM) - no inbound required. Outbound for SSM/NAT."
  vpc_id      = var.vpc_id

  # No inbound rules by default (SSM uses outbound HTTPS)
  ingress = []

  # Allow all outbound so SSM agent can reach AWS endpoints (or use narrow rules if desired)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.name}-bastion-sg" })
}

# EC2 instance (bastion)
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = var.associate_public_ip
  vpc_security_group_ids      = concat([aws_security_group.bastion_sg.id], var.additional_security_group_ids)

  # Ensure SSM agent is present; most official AMIs include it. Provide fallback install script.
  user_data = var.user_data != "" ? var.user_data : file("${path.module}/scripts/ensure-ssm.sh")

  tags = merge(var.common_tags, {
    Name        = "${var.name}-bastion-${var.environment}"
    Environment = var.environment
    Role        = "bastion"
  })

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Optional Elastic IP (only used if associate_public_ip = true and user wants stable public IP)
resource "aws_eip" "bastion_eip" {
  count    = var.allocate_eip && var.associate_public_ip ? 1 : 0
  instance = aws_instance.bastion.id
  domain   = "vpc"

  tags = merge(var.common_tags, { Name = "${var.name}-bastion-eip" })
}
############################################################
# VPC Endpoints for SSM (Private-Only Bastion Best Practice)
############################################################

resource "aws_vpc_endpoint" "ssm" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_id != null ? [var.subnet_id] : []
  security_group_ids = [aws_security_group.bastion_sg.id]

  private_dns_enabled = true
  tags                = merge(var.common_tags, { Name = "${var.name}-ssm-endpoint" })
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_id != null ? [var.subnet_id] : []
  security_group_ids = [aws_security_group.bastion_sg.id]

  private_dns_enabled = true
  tags                = merge(var.common_tags, { Name = "${var.name}-ssmmessages-endpoint" })
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_id != null ? [var.subnet_id] : []
  security_group_ids = [aws_security_group.bastion_sg.id]

  private_dns_enabled = true
  tags                = merge(var.common_tags, { Name = "${var.name}-ec2messages-endpoint" })
}
############################################################
# Optional: Route53 Private Record
############################################################
resource "aws_route53_record" "bastion" {
  count   = var.enable_route53 ? length(var.subnet_ids) : 0
  zone_id = var.private_zone_id
  name    = "bastion-${count.index}.${var.private_zone_name}"
  type    = "A"
  ttl     = 60
  records = [aws_instance.bastion[count.index].private_ip]
}
