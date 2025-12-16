---

# 🔑 KMS Key Module – 3-Tier Architecture

This **Terraform module** provisions a **KMS symmetric key** for encrypting AWS resources such as **S3, RDS, and Secrets Manager**.  
It also creates an **alias** for easy reference.

---

## ✨ Features Implemented

### ✅ 1. KMS Key Creation
- Creates a **customer-managed symmetric key**  
- Supports **automatic key rotation** to enhance security  
- Customizable **deletion window** for safe key removal  
- Key policy can be provided via `var.key_policy` or a local policy override

---

### ✅ 2. KMS Alias
- Creates an **alias** for the key (`alias/<key_alias>`)  
- Enables **easy reference** in other AWS resources without using the key ID

---

### ✅ 3. Tagging
- Merges **common tags** with **key-specific tags**  
- Includes **Name** and **Environment** for **organization, auditing, and cost tracking**

---

## 📘 Notes
- Ensures **secure encryption** for sensitive resources across **dev, staging, and production**  
- Fully **modular and reusable**, with consistent tagging and naming conventions  
- Production-ready: key and alias can be used in all environments **without extra changes**  
- Integrates with other **security modules** like IAM Roles and Secrets Manager

---

