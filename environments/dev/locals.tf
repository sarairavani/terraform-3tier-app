locals {
  tags = var.common_tags
  sg_map = {
    web_sg = {
      name        = "web-sg-${var.environment}"
      tier        = "web"
      vpc_id      = var.vpc_id
      description = "Security group for Web Tier"

      ingress = {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
        description     = "Allow HTTP from anywhere"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }

    app_sg = {
      name        = "app-sg-${var.environment}"
      tier        = "app"
      vpc_id      = var.vpc_id
      description = "Security group for App Tier"

      ingress = {
        from_port       = 8080
        to_port         = 8080
        protocol        = "tcp"
        cidr_blocks     = []
        security_groups = ["web_sg"]
        description     = "Allow traffic from Web Tier"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }

    db_sg = {
      name        = "db-sg-${var.environment}"
      tier        = "db"
      vpc_id      = var.vpc_id
      description = "Security group for DB Tier"

      ingress = {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = []
        security_groups = ["app_sg"]
        description     = "Allow MySQL from App only"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }

    bastion_sg = {
      name        = "bastion-sg-${var.environment}"
      tier        = "bastion"
      vpc_id      = var.vpc_id
      description = "Security group for Bastion"

      ingress = {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = [var.admin_ip]
        security_groups = []
        description     = "Allow SSH from admin IP"
      }

      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound"
      }
    }
  }
}

