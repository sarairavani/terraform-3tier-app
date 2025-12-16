---

# 🔐 IAM Role Module – 3-Tier Architecture

This **Terraform module** provisions **IAM roles** for a **multi-tier AWS environment**, including **Web, App, and DB tiers**.  
Designed for **fine-grained access control** and **dynamic role creation**.

---

## ✨ Features Implemented

### ✅ 1. Dynamic Role Creation
- Uses `for_each` to create **multiple IAM roles dynamically**  
- Supports **custom assume role policies** per role  
- Fully parameterized for **environment-specific naming** and tags

---

### ✅ 2. Managed Policy Attachments
- Attaches **one or more AWS Managed Policies** per role  
- Uses a **flattened map** to manage role-policy combinations efficiently  
- Ensures **least privilege principle** by attaching only necessary policies

---

### ✅ 3. Tagging
- Merges **common tags** with **role-specific tags**  
- Includes **Name** and **Environment** for organization, auditing, and cost tracking

---

## 📘 Notes
- Ensures **secure, reusable IAM roles** for multi-tier environments  
- Integrates seamlessly with **EC2, Lambda, and other AWS services** requiring IAM roles  
- Supports **dev, staging, and production environments** with consistent tagging and naming  
- Enables **modular security management** across multiple AWS accounts or environments

---

