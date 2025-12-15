---

# 🚀 Auto Scaling Group (ASG) Module – 3-Tier Architecture

This **Terraform module** provisions **Auto Scaling Groups (ASGs)** for the **Web** and **App** tiers in a 3-tier architecture.  
The ASGs automatically manage **EC2 instance scaling, health, and replacement**, ensuring high availability and resilience.

---

## ✨ Features Implemented

### ✅ 1. Tier-Based Auto Scaling
- **Web Tier ASG:** Public-facing, scalable according to traffic demand  
- **App Tier ASG:** Private, runs in private subnets using NAT  
- **DB Tier:** No ASG; use managed **RDS instances** instead

---

### ✅ 2. Launch Template Integration
- Each ASG is linked to a **Launch Template**, ensuring:
  - Consistent EC2 configuration  
  - IAM roles  
  - Security groups  
  - User-data bootstrap

---

### ✅ 3. Health Checks
- EC2-based health checks (`health_check_type = EC2`)  
- Configurable grace period (`health_check_grace_period`)  
- Automatically replaces unhealthy instances

---

### ✅ 4. Rolling Updates & Lifecycle
- `create_before_destroy = true` ensures **minimal downtime** during updates  
- `termination_policies = ["OldestInstance"]` ensures safe replacement

---

### ✅ 5. Tagging
- ASGs and instances are tagged for:
  - Environment  
  - Tier  
  - Project/Cost allocation  
- Tags **propagated automatically** to launched instances

---

### ✅ 6. Optional ALB Integration
- Supports **Target Group attachments** if an ALB exists  
- Automatically forwards traffic to Web or App tiers

---

## 🧩 Production Enhancements (Planned)

### 🔐 1. Advanced Scaling Policies
- Dynamic scaling policies:
  - CPU / Memory / Custom metrics  
  - Step or target tracking policies

### 🛠️ 2. Multi-AZ High Availability
- Deploy ASGs across multiple **Availability Zones** for resilience  
- Ensure automatic failover in case of instance or AZ failure

### 📊 3. Observability
- Integration with **CloudWatch alarms and metrics**  
- Metrics for scaling decisions and SLA monitoring

### ⚙️ 4. Spot & Reserved Instances
- Spot instances for cost optimization in non-critical tiers  
- Reserved or On-Demand instances for production-critical tiers

### 🧱 5. Lifecycle Hooks
- Pre-terminate or post-launch hooks for custom automation  
- Notify monitoring/logging systems on instance lifecycle events

---

## 📘 Notes
- Depends on **Launch Templates, Security Groups, and Subnets** modules  
- Designed for **Web and App tiers only**; DB tier uses managed services (RDS)  
- Fully modular and **environment-aware**, supporting dev, staging, and prod  
- Ensures **high availability, automated replacement**, and consistent EC2 configuration

---

