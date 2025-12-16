---

# 🌐 VPC Module – 3-Tier Architecture

This **Terraform module** provisions a **Virtual Private Cloud (VPC)** for a **3-tier architecture**, serving as the **foundational networking layer** for all other resources (subnets, gateways, EC2 instances, ALB, etc.).

---

## ✨ Features Implemented

### ✅ 1. Custom CIDR Block
- VPC created with a **user-defined CIDR** (`vpc_cidr_block`)  
- Flexible IP addressing suitable for **Web, App, DB, and Bastion tiers**

---

### ✅ 2. DNS Configuration
- `enable_dns_support = true` → Enables DNS resolution within the VPC  
- `enable_dns_hostnames = true` → EC2 instances get **private DNS hostnames**  
- Supports **internal service discovery and routing**

---

### ✅ 3. Tagging
- Merges **global tags** with VPC-specific tags  
- Includes `Name = var.vpc_name` for easy identification and cost allocation

---

## 📘 Notes
- This module is the **foundation for all networking** in the 3-tier architecture  
- Fully **modular and reusable**, supporting **dev, staging, and production environments**  
- Integrates seamlessly with **subnets, Internet Gateway, NAT Gateway, and route tables**  
- Ensures a **secure, well-tagged, and production-ready VPC**
