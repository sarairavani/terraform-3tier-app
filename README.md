# 🚀 Terraform 3-Tier AWS Architecture

**Production-grade (Design) | Modular | Secure | Cost-Aware | Performance-Driven**

⭐ *If you like well-designed infrastructure projects, give this repo a star!*

---

## 👋 Overview

This project is a **fully modular Terraform implementation** of a classic **AWS 3-Tier architecture**, designed with a **real production mindset**.

This is **not** just about creating AWS resources.  
It’s about **understanding why each service exists**, **when to use it**, and **how it behaves in real-world systems**.

Before writing a single line of Terraform, the focus was on:

- ✅ *Why* each AWS service exists  
- ✅ *When* to use it (and when **not** to)  
- ✅ Impact on **cost**, **performance**, and **security**

This repository reflects that understanding.

---

## 🧠 Required AWS Concepts (Before Starting)

To fully understand this project, you should be familiar with:

### ☁️ Core AWS Services
- VPC & Subnets (Public / Private)
- Internet Gateway & NAT Gateway
- Route Tables
- EC2, Launch Templates, Auto Scaling Groups
- Application Load Balancer (ALB)
- RDS
- IAM Roles & Policies
- Security Groups
- KMS & Secrets Manager
- CloudWatch, SNS, Flow Logs, CloudTrail

### 📦 Infrastructure as Code
- Terraform modules
- Remote backend (S3 + DynamoDB)
- Environment separation (dev / staging / prod)
- Variables, locals, outputs

---

## 🎯 Project Goals

This project is built around **three core principles**:

### 💰 Cost Optimization
- Tier-based scaling (ASG only where needed)
- NAT Gateway per AZ (balanced vs cost-aware)
- No unnecessary public IPs
- Reusable modules to avoid duplication

### ⚡ Performance
- Auto Scaling Groups for Web & App tiers
- Application Load Balancer with path-based routing
- Health checks, stickiness, rolling updates
- CloudWatch detailed monitoring enabled

### 🔐 Security (By Design)
- Private subnets for App & DB tiers
- Bastion access via **SSM only** (no SSH)
- IAM least-privilege roles per tier
- Secrets stored in AWS Secrets Manager
- Encryption everywhere (EBS, RDS, Secrets, Logs)
- Clear separation of security responsibilities

---

## 🏗️ Architecture Overview

Internet
   |
 [ ALB ]
   |
 [ Web ASG ]  (Public Subnets)
   |
 [ App ASG ]  (Private Subnets via NAT)
   |
 [ RDS ]      (Private Subnets)

- 🔐 Bastion access via **AWS SSM Session Manager**
- 📊 Logs & monitoring via **CloudWatch, Flow Logs, CloudTrail**
- 🔑 Secrets via **Secrets Manager + KMS**

---

## 📂 Repository Structure

```text
terraform-3tier-app/
├── environments        # dev / staging / prod
├── modules
│   ├── networking      # VPC, Subnets, IGW, NAT, Routes
│   ├── compute         # ALB, ASG, EC2, Bastion, Launch Templates
│   ├── database        # RDS & subnet groups
│   ├── security        # IAM, SGs, KMS, Secrets
│   ├── monitoring      # CloudWatch, Alarms, SNS
│   ├── logging         # CloudTrail, Flow Logs, S3 logs
│   └── shared          # S3 backend & DynamoDB lock
├── ci-cd               # CI/CD configurations
├── docs                # Architecture diagrams & notes
└── README.md
```
---

## 🚀 Quick Start

### Prerequisites
- Terraform >= 1.6.0
- AWS CLI configured with appropriate credentials
- (Optional) pre-commit, tflint, terraform-docs for development

### Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/SaraIravani/terraform-3tier-app.git
   cd terraform-3tier-app
   ```

2. **Copy example configuration:**
   ```bash
   cd environments/dev
   cp ../../examples/terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your values
   ```

3. **Initialize Terraform:**
   ```bash
   make init ENV=dev
   # Or: cd environments/dev && terraform init
   ```

4. **Validate and plan:**
   ```bash
   make validate ENV=dev
   make plan ENV=dev
   ```

5. **Apply (when ready):**
   ```bash
   make apply ENV=dev
   ```

### Useful Commands

```bash
make fmt              # Format Terraform files
make validate ENV=dev # Validate configuration
make lint             # Run tflint
make security-check   # Run security scan
make all-checks       # Run all checks
```

For more details, see [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 🌍 Multi-Environment Ready

This project supports:

- 🧪 **dev**
- 🚦 **staging**
- 🏭 **production**

Each environment:
- Uses its own `tfvars`
- Shares the same modules
- Applies different constraints via **inputs**, not code duplication

---

## 🔐 Security Highlights

- ❌ No SSH access
- ❌ No hardcoded secrets
- ✅ SSM-only bastion
- ✅ IAM roles per tier
- ✅ SG-to-SG communication
- ✅ Encrypted storage everywhere
- ✅ Environment-aware tagging

---

## 🚧 Production Notes

This repository is **production-ready in structure**.

Some advanced production hardening steps are **intentionally documented but not enforced by default**, such as:

- Tighter outbound (egress) rules
- Advanced IAM permission boundaries
- Additional Network ACL layers
- Multi-region disaster recovery strategies

👉 These are **design decisions**, not missing features.

---

## 🎯 Best Practices Implemented

This project follows industry-standard Terraform and AWS best practices:

### 📋 Code Quality & Standards
- ✅ Consistent file naming (`main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`)
- ✅ Terraform version constraints and provider version pinning
- ✅ Pre-commit hooks for automated code quality checks
- ✅ TFLint configuration for best practice enforcement
- ✅ Automated CI/CD with GitHub Actions
- ✅ Comprehensive documentation with terraform-docs

### 🔐 Security Best Practices
- ✅ No hardcoded secrets (sensitive variables marked appropriately)
- ✅ Least-privilege IAM policies (custom policies vs overly permissive managed policies)
- ✅ KMS encryption with automatic key rotation enabled
- ✅ RDS with encryption at rest, deletion protection, and automated backups
- ✅ VPC Flow Logs for network monitoring
- ✅ CloudTrail for audit logging
- ✅ Security scanning with Checkov

### 🏗️ Infrastructure Best Practices
- ✅ Modular architecture with reusable components
- ✅ Environment separation (dev/staging/prod)
- ✅ Remote state management (S3 + DynamoDB locking ready)
- ✅ Variable validation for input safety
- ✅ Consistent tagging strategy
- ✅ Multi-AZ deployment for high availability

### 🛠️ Developer Experience
- ✅ Makefile for common operations
- ✅ Example configuration files
- ✅ Comprehensive CONTRIBUTING.md
- ✅ Best practices documentation
- ✅ .editorconfig for consistent formatting

For detailed best practices, see [docs/BEST_PRACTICES.md](docs/BEST_PRACTICES.md)

---
⚠️ Current Status
-----------------

This project has been designed and verified with a **production mindset**.  
All modules pass `terraform validate` and `terraform plan`.

Actual deployment (`terraform apply`) to AWS is intentionally deferred and planned as a next step.

* * *

## 💼 Why This Project Matters

This is **not a tutorial project**.  
This is a **portfolio-grade infrastructure design** that demonstrates:

- Real AWS understanding
- Terraform best practices
- Clean module boundaries
- Security & cost awareness
- A true production mindset

**Perfect for:**
- DevOps Engineers
- Cloud Engineers
- Platform Engineers
- Infrastructure-focused roles

---

## ⭐ Final Words

### Why this project?

Through this project, I focused on:

- Infrastructure design with scalability in mind
- Security-first cloud architecture
- Cost-aware decisions without sacrificing performance

If you're an engineer:
⭐ Feel free to explore, fork, or learn from it.

---

🔥 **Designed with a Production Mindset**  
👩‍💻 **By Sara**

