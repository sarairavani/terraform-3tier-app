---

# 🔐 Security Groups Module – 3-Tier Architecture

This **Terraform module** defines **tier-based security groups and rules** for a classic **3-tier application architecture**  
(**Web, App, Database, Bastion**).

It enforces **network-level isolation**, **least-privilege access**, and **environment-aware configuration**.

---

## 🎯 Purpose
- Create **separate security groups per tier**
- Apply **explicit ingress and egress rules**
- Support **CIDR-based** and **Security Group–based** traffic
- Work consistently across **dev / staging / production**

---

## ✨ Features Implemented

### ✅ 1. Dynamic Security Group Creation
- Uses `for_each` to create multiple security groups from `sg_map`
- Each security group is tagged with:
  - `Name`
  - `Environment`
  - `Tier`
- Fully **reusable**, **scalable**, and **environment-agnostic**

---

### ✅ 2. Ingress Rules (Inbound Traffic)
- One ingress rule per security group
- Supports:
  - **CIDR blocks** (Internet or trusted IP ranges)
  - **Security Group references** (tier-to-tier communication)
- Each rule defines:
  - Port range
  - Protocol
  - Source
  - Description

**Typical traffic flow:**
- Web → open to Internet (HTTP/HTTPS)
- App → allowed only from Web Security Group
- DB → allowed only from App Security Group
- Bastion → restricted access or SSM-only

---

### ✅ 3. Egress Rules (Outbound Traffic)
- Explicit egress rules per tier
- Outbound behavior fully controlled via inputs
- Designed to support **stricter egress policies** in production

---

### ✅ 4. Environment-Aware Design
- Same module works for **all environments**
- No hardcoded values
- All behavior controlled through **input variables**

---

## 🔐 Security Design Principles
- **Least-privilege networking** per tier
- Clear **separation of concerns** (Web / App / DB / Bastion)
- **Auditable and readable** rules with descriptions
- Ready for integration with:
  - ALB
  - Auto Scaling Groups
  - Bastion (SSM)
  - RDS

---

## 🚧 Production Hardening Plan
This module is **structurally production-ready**, with the following planned improvements applied via stricter inputs:

- 🔒 Replace broad CIDR rules with **Security Group references**
- 🔒 Restrict **egress rules** per tier (no wide outbound access)
- 🔒 Limit public exposure strictly to **ALB / Web tier**
- 🔒 Optional integration with **Network ACLs** for DB tier
- 🔒 Enforce documentation on every ingress/egress rule

> No separate production module is required — production behavior is achieved through configuration.

---

## 📌 Notes
- This module focuses **only on network-level security**
- **IAM and KMS** are handled in separate Security modules
- Designed to **evolve without breaking** existing environments

---

## 🧠 Summary
- ✅ Modular and reusable  
- ✅ Clear tier isolation  
- ✅ Production-ready structure  

🚀 Designed for **gradual hardening**, not rewrites

---

