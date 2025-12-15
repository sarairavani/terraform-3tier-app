---

# 🚀 EC2 Module – 3-Tier Architecture

This **Terraform module** provisions **EC2 instances** for **Web, App, DB, and Bastion tiers**.  
While production deployments typically use **Auto Scaling Groups (ASG)** and **Launch Templates**, this module provides **direct EC2 control** for single instances or specialized workloads.

---

## ✨ Features Implemented

### ✅ 1. Tier-Based EC2 Instances
- Deploys instances for all tiers: Web, App, DB, and Bastion  
- Useful for:
  - Single DB nodes  
  - Bastion hosts  
  - Any non-scaled workloads

---

### ✅ 2. Flexible Configuration
- Fully parameterized instance attributes:
  - AMI (`ami_id`)  
  - Instance type (`instance_type`)  
  - Subnet (`subnet_id`)  
  - Security groups (`vpc_security_group_ids`)  
  - IAM instance profile (`iam_instance_profile`)  
  - Public IP assignment (`associate_public_ip`)

---

### ✅ 3. User Data
- Supports EC2 bootstrap using `user_data`  
- Base64 encoded for Terraform compliance  
- Enables automated instance setup

---

### ✅ 4. Root Volume Configuration
- Encrypted GP3 root volume  
- Configurable size per instance

---

### ✅ 5. Tagging
- Merges `common_tags` with instance-specific tags:
  - Name  
  - Environment  
  - Tier  
- Facilitates **identification, monitoring, and cost allocation**

---

## 🧩 Production Enhancements (Planned)

### 🔐 1. Security
- Avoid public IPs for App/DB tiers by default  
- Pull secrets dynamically from **SSM Parameter Store** or **Secrets Manager**  
- Enforce **least-privilege IAM roles**

### 🛠️ 2. Scaling & High Availability
- Replace direct EC2 with **ASGs + Launch Templates** for production  
- Multi-AZ deployment for fault tolerance

### 📊 3. Observability & Monitoring
- Enable **CloudWatch detailed metrics and logs**  
- Integrate with monitoring pipelines (Grafana, Prometheus, ELK)

### ⚙️ 4. Lifecycle & Protection
- Optionally add `prevent_destroy` for critical instances  
- Versioned AMIs and **immutable infrastructure patterns**

---

## 📘 Notes
- Intended for **manual or specialized EC2 deployments**  
- Fully modular and parameterized, supporting dev, staging, and prod environments  
- Works in tandem with **Launch Templates** and **ASGs** if future scaling is needed  
- Provides **fine-grained control** over instances when ASG is not required

---

