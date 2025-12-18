# 🚀 Terraform 3-Tier AWS Architecture

**Production-grade | Modular | Secure | Cost-Aware | Performance-Driven**

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

terraform-3tier-app/
├── environments        # dev / staging / prod
├── modules
│   ├── networking      # VPC, Subnets, IGW, NAT, Routes
│   ├── compute         # ALB, ASG, EC2, Bastion, LT
│   ├── database        # RDS & subnet groups
│   ├── security        # IAM, SGs, KMS, Secrets
│   ├── monitoring      # CloudWatch, Alarms, SNS
│   ├── logging         # CloudTrail, Flow Logs, S3 logs
│   └── shared          # S3 backend & DynamoDB lock
├── ci-cd               # CI/CD related configs
├── docs                # Architecture & notes
└── README.md

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

**If you are a recruiter or hiring manager:**  
This project shows how I:
- Think about infrastructure
- Design for scale
- Secure cloud systems
- Balance cost and performance

**If you are an engineer:**  
⭐ Feel free to **star**, **fork**, or **learn** from it.

---

🔥 **Designed with a Production Mindset**  
👩‍💻 **By Sara**

