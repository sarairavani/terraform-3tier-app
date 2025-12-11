# Terraform 3-Tier AWS Application

**A fully modular Terraform project to deploy a scalable, secure, and maintainable 3-tier application on AWS.**  
Designed for multi-environment deployments, reusable modules, automated networking, and integrated monitoring & security.

---

## Project Overview

This project provisions a complete AWS infrastructure for a 3-tier application including:

- **Networking**: VPC, public & private subnets, Internet/NAT Gateways, Route Tables  
- **Compute**: EC2 instances, ALB, Autoscaling Groups, Bastion hosts  
- **Database**: RDS instances, DB subnet groups  
- **Logging & Monitoring**: CloudTrail, VPC Flow Logs, S3 logging, CloudWatch, SNS, Alarms  
- **Security**: IAM roles & policies, KMS, Secrets Manager, Security Groups  
- **Shared Services**: S3 backend, DynamoDB lock for Terraform state  
- **Bootstrap Scripts**: Pre-configured userdata scripts for EC2 instances
---

## Key Features

- **Multi-Environment Support**: Separate configs for dev, staging, and prod  
- **Modular Architecture**: Reusable modules for networking, compute, database, security, logging, and monitoring  
- **Automated Networking**: VPC, subnets, route tables, and gateways fully automated  
- **Secure Infrastructure**: IAM roles, Security Groups, KMS, and Secrets Manager integration  
- **Monitoring & Logging**: CloudWatch alarms, SNS notifications, CloudTrail, and VPC Flow Logs  
- **Infrastructure as Code**: Complete Terraform codebase, easy to maintain and extend  

---

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/your-username/terraform-3tier-app.git
cd terraform-3tier-app
```
2. Select environment and apply
```bash
cd environments/dev
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

