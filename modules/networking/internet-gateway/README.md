---

# 🌐 Internet Gateway (IGW) Module – 3-Tier Architecture

This **Terraform module** provisions an **Internet Gateway (IGW)** and attaches it to a **VPC**, enabling **internet access for public subnets**.

---

## ✨ Features Implemented

### ✅ 1. Internet Gateway Creation
- Creates **one IGW per VPC**  
- Essential for providing **outbound and inbound internet access** to public subnets

---

### ✅ 2. Tagging
- Merges **common tags** with **environment-specific tags**  
- Includes `Name = <environment>-igw` for **identification, monitoring, and cost allocation**

---

## 🧩 Production Plan (Optional Enhancements)
- **Multi-AZ support:** IGW is inherently global within a VPC, but ensure route tables are configured per AZ for proper traffic routing  
- **Monitoring:** Enable CloudWatch metrics for IGW traffic  
- **Security:** Integrate with **Network ACLs** or firewall rules for public subnet protection

---

## 📘 Notes
- Required to allow **public subnets and associated resources** (e.g., NAT Gateways, Web servers, ALBs) to communicate with the internet  
- Fully **modular and reusable**, supporting dev, staging, and production environments  
- Integrates seamlessly with **VPC, Subnets, NAT Gateway, and Route Tables**  
- Designed for **secure, reliable, and well-tagged internet connectivity**

---

