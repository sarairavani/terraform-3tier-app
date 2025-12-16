---

# 🏘️ Subnets Module – 3-Tier Architecture

This **Terraform module** provisions **public and private subnets** for a **3-tier architecture**, separating **Web, App, and Database tiers** to ensure proper **isolation, security, and routing**.

---

## ✨ Features Implemented

### ✅ 1. Public Subnets (Web Tier)
- Hosts **web servers** accessible from the internet  
- `map_public_ip_on_launch = true` for **direct internet access**  
- Tagged with **environment, tier (web), and network type (public)**

---

### ✅ 2. Private Subnets (App Tier)
- Hosts **application servers** that do **not** require direct internet access  
- Internet-bound traffic routed via **NAT Gateway**  
- Tagged with **environment, tier (app), and network type (private)**

---

### ✅ 3. Private Subnets (Database Tier)
- Hosts **database instances** (e.g., RDS)  
- No direct internet access; fully private  
- Tagged with **environment, tier (database), and network type (private)**

---

### ✅ 4. Tagging
- Merges **common tags** with **subnet-specific tags**  
- Includes **Name, Tier, and Network type** for clarity  
- Supports **organization, monitoring, and cost allocation**

---

## 📘 Notes
- Ensures proper **isolation of each tier** in a 3-tier architecture  
- Fully **modular and reusable**, supporting **dev, staging, and production environments**  
- Integrates seamlessly with **VPC, Route Tables, NAT Gateway, and Internet Gateway**  
- Designed for **secure, reliable, and well-tagged subnet architecture**

---

