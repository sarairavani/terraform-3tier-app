---

# 🚀 Launch Template Module – 3-Tier Architecture

This **Terraform module** defines reusable **EC2 Launch Templates** for Web, App, and Bastion tiers within a **3-tier architecture**.  
Launch Templates standardize EC2 configurations, enabling **autoscaling, consistency, and easy versioning** across environments.

---

## ✨ Features Implemented

### ✅ 1. Reusable EC2 Configurations
- Launch templates for **Web, App, and Bastion tiers** (DB tier excluded; usually RDS is used)  
- Configurable parameters:
  - AMI (`image_id`)  
  - Instance type  
  - Key pair (`key_name`)  
  - IAM instance profile (from IAM module)

---

### ✅ 2. Network Configuration
- Network interfaces configured per instance  
- Optional public IP (`associate_public_ip_address`)  
- Security groups attached  
- Ensures correct **network isolation** and flexibility

---

### ✅ 3. User Data
- Encoded `user_data` automatically applied for instance bootstrap  
- Enables automated setup on instance launch (e.g., installing agents, configuration)

---

### ✅ 4. Tagging
- Tags merged from `common_tags` and instance-specific tags  
- Supports **identification, monitoring, cost allocation, and resource management**

---

### ✅ 5. Monitoring
- Detailed **CloudWatch monitoring** enabled for each instance  
- Collects 1-minute metrics for **autoscaling and alerting**

---

### ✅ 6. Lifecycle Management
- `create_before_destroy = true` ensures new template version is applied before old version is replaced  
- Reduces downtime and maintains service availability during updates

---

## 🧩 Production Enhancements (Planned)

### 🔐 1. Enhanced Security
- Stricter security groups per tier  
- Integration with **AWS Systems Manager** for patching and remote management  
- Hardened EC2 access using instance metadata options

### 🛠️ 2. Advanced Launch Template Options
- Block device mapping for additional volumes  
- Spot instance support for cost optimization in non-prod tiers  
- Capacity reservations for critical production instances

### 📊 3. Observability
- **CloudWatch Agent** and custom metrics  
- Integration with logs and monitoring pipelines (e.g., ELK, Prometheus, Grafana)

### ⚙️ 4. Versioning & Deployment Automation
- Automated creation of new template versions during CI/CD pipelines  
- Supports **immutable infrastructure** practices

---

## 📘 Notes

- This module **excludes the DB tier**; RDS or other managed database services are recommended for production.  
- Designed to work seamlessly with **Auto Scaling Groups** for Web and App tiers.  
- Flexible and modular: variables allow **environment-specific customization**.  
- Ensures **consistency, auditability, and reduced human errors** when deploying EC2 instances.

---

