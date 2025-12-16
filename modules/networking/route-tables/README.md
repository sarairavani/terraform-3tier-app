---

# 🛣️ Route Tables Module – 3-Tier Architecture

This **Terraform module** provisions **route tables** for both **public** and **private subnets** in a 3-tier architecture.  
It ensures proper **routing for internet-bound traffic** and **subnet connectivity**.

---

## ✨ Features Implemented

### ✅ 1. Public Route Tables
- Creates **one route table per public subnet / AZ**  
- Routes **internet-bound traffic (0.0.0.0/0)** via the **Internet Gateway (IGW)**  
- Associates each **public subnet** with its corresponding route table  
- Tags include **environment, tier (web), and network type (public)**

---

### ✅ 2. Private Route Tables
- Creates **one route table per private subnet / AZ**  
- Routes **internet-bound traffic** via the **NAT Gateway**  
- Associates each **private subnet** with its corresponding route table  
- Tags include **environment, tier (app), and network type (private)**

---

### ✅ 3. Tagging
- Merges **common tags** with **route-table-specific tags**  
- Supports **organization, monitoring, and cost allocation**

---

## 📘 Notes
- Ensures **proper routing** for **public and private subnets**  
- Fully **modular and reusable**, supporting **dev, staging, and production environments**  
- Integrates seamlessly with **VPC, Subnets, IGW, NAT Gateway, and other network resources**  
- Designed for **secure, reliable, and well-tagged networking**

---

