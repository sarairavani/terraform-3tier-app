---

# 🛡️ AWS Secrets Manager Module – 3-Tier Architecture

This **Terraform module** provisions **encrypted secrets** in **AWS Secrets Manager**, using a **KMS key** for encryption.  
Designed to securely store **database credentials, API keys**, or other **sensitive information**.

---

## ✨ Features Implemented

### ✅ 1. Secret Creation
- Creates a **Secrets Manager secret**  
- Assigns a **custom name** and **description**  
- Uses a **KMS key** (`var.kms_key_id`) for encryption, ensuring **data security**

---

### ✅ 2. Secret Versioning
- Creates a **secret version** with the value provided in `var.secret_value`  
- Supports **dynamic secret strings**, useful for DB credentials, API keys, or other sensitive data

---

### ✅ 3. Tagging
- Merges **common tags** with **environment-specific tags**  
- Includes **Environment** for **organization, auditing, and cost tracking**

---

## 📘 Notes
- Ensures **secure and auditable storage** of sensitive data across **dev, staging, and production**  
- Fully **modular and reusable**, supporting **consistent tagging** and **KMS encryption**  
- Production-ready: can be used **directly in production**  
- Integrates with other **Security modules** like IAM Roles and KMS Keys for **fine-grained access control**

---

