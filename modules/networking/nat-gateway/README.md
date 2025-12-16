---

# 🌐 NAT Gateway Module – 3-Tier Architecture

This **Terraform module** provisions **NAT Gateways** to provide **outbound internet access** for private subnets, typically used by the **Application Tier** in a 3-tier architecture.

---

## ✨ Features Implemented

### ✅ 1. Elastic IP Allocation
- Allocates **one Elastic IP per public subnet / Availability Zone**  
- Ensures each NAT Gateway has a **stable public IP**

---

### ✅ 2. NAT Gateway Creation
- Creates a **NAT Gateway per public subnet**  
- Each NAT Gateway deployed in the **same AZ** as its associated public subnet  
- Supports **high availability** when multiple public subnets are used

---

### ✅ 3. Tagging
- Tags include **environment, AZ, and common tags**  
- Supports **organization, monitoring, and cost tracking**

---

## 🧩 Production Plan (Optional Enhancements)
- **Multi-AZ deployment:** One NAT Gateway per AZ for high availability  
- **Redundancy & failover:** Update route tables to automatically failover if one NAT fails  
- **Cost optimization:** Consider using NAT instances for low-traffic environments  
- **Monitoring:** Enable CloudWatch metrics for NAT Gateway traffic and performance

---

## 📘 Notes
- Essential for **private subnets** to reach the internet securely  
- Fully **modular and reusable**, supporting dev, staging, and production environments  
- Integrates seamlessly with **VPC, subnets, and route tables**  
- Designed for **secure, reliable, and well-tagged outbound internet connectivity**
