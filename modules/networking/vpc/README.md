# VPC Module

This module creates an AWS VPC with DNS support and hostnames enabled.

## Features

- Creates a VPC with custom CIDR block
- Enables DNS hostnames for instances
- Enables DNS resolution within the VPC
- Supports custom tagging

## Usage

```hcl
module "vpc" {
  source = "../../modules/networking/vpc"

  vpc_name       = "dev-vpc"
  vpc_cidr_block = "10.0.0.0/16"

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
