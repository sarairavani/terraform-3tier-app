admin_ip                 = "0.0.0.0/0"
alb_logs_bucket          = "my-alb-logs-bucket"
alb_sg_ids               = []
bucket_name              = "dummy-bucket"
kms_key_id               = "dummy-kms-key"
public_subnet_ids        = ["subnet-00000000000000000"]
ssl_certificate_arn      = "arn:aws:acm:ca-central-1:000000000000:certificate/dummy-cert"
vpc_cidr_block           = "10.0.0.0/16"
trail_name               = "dummy-cloudtrail"
s3_bucket_name           = "dummy-s3-bucket"
common_tags              = {
  Project = "terraform-3tier-app"
  Env     = "dev"
}
bastion_ami_id           = "ami-00000000000000000"
bastion_instance_type    = "t2.micro"
key_name                 = "dummy-key"
#subnet_id                = "subnet-00000000000000000"
associate_public_ip      = false
bastion_name_prefix      = "dev"
root_volume_size_gb      = 8
additional_security_group_ids = []
traffic_type             = "ALL"
enabled                  = false
log_destination          = "arn:aws:s3:::dummy-log-bucket"
app_target_group_arn     = ["arn:aws:elasticloadbalancing:ca-central-1:123456789012:targetgroup/app-tg/abcd1234efgh5678"]

vpc_ids                  = ["vpc-00000000000000000"]
#public_subnet_map = {
#  az1 = {
#    subnet_id        = "subnet-111111"
#    vpc_id           = "vpc-aaaaaa"
#    az               = "ca-central-1a"
#    environment_name = "dev"
#  }
#  az2 = {
#    subnet_id        = "subnet-222222"
#    vpc_id           = "vpc-aaaaaa"
#    az               = "ca-central-1b"
#    environment_name = "dev"
#  }
#}

internet_gateway_ids = {
  az1 = "igw-abc123"
  az2 = "igw-def456"
}

sg_map = {
  bastion_sg = {
    name        = "bastion-sg"
    tier        = "bastion"
    vpc_id      = "vpc-abc123"
    description = "Bastion SG"
    ingress = {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      description     = "SSH access"
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

#private_subnet_map = {
#  az1 = {
#    subnet_id        = "subnet-333333"
#    vpc_id           = "vpc-aaaaaa"
#    az               = "ca-central-1a"
#    environment_name = "dev"
#  }
#  az2 = {
#    subnet_id        = "subnet-444444"
#    vpc_id           = "vpc-aaaaaa"
#    az               = "ca-central-1b"
#    environment_name = "dev"
#  }
#}
