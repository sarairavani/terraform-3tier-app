# 🚀 Application Load Balancer (ALB) Module – 3-Tier Architecture

This **Terraform module** provisions a dynamic **Application Load Balancer (ALB)** for a **3-tier architecture**, designed to make development and staging environments flexible, reliable, and easy to manage. It connects your **Web (frontend)** and **App (backend)** tiers seamlessly.

---

## 🌟 Features Implemented

- **HTTP & HTTPS Listeners** – Serve traffic securely on ports 80 & 443.
- **Automatic HTTP→HTTPS Redirect** – Ensure all traffic is encrypted.
- **Web & App Target Groups** – Separate backend pools for frontend & backend services.
- **Health Checks** – Keep your services reliable with configurable health checks.
- **Session Stickiness** – Optionally maintain user sessions on the same instance.
- **Optional Access Logs** – Save ALB logs to S3 for auditing and monitoring.
- **Optional Maintenance Mode** – Serve custom HTTP 503 responses during maintenance.
- **Tagging** – Automatically tag all resources for easy management and tracking.

---

## 🏗 Production Enhancements (Planned)

For production-ready setups, these advanced features can be enabled:

- **WAF Integration** – Protect against Layer 7 attacks.
- **IPv4/IPv6 Support** – Dual-stack configuration.
- **Advanced Listener Rules** – Regex/host-based routing, weighted forwarding.
- **Connection Draining / Deregistration Delay** – Graceful instance removal.
- **Advanced Security Settings** – SSL policies, ciphers, and secure negotiation.
- **Enhanced Access Logs** – Custom S3 paths, prefixes, and encryption.
- **Advanced ALB Tags** – Include Cost Center, Owner, and environment metadata.

---

## ⚡ Notes

- Optimized for **development and staging** environments.
- Production capabilities can be enabled via variables and additional configuration.
- Designed to integrate seamlessly with **existing VPCs, subnets, and security groups**.

---

## 💡 Why Use This Module?

This ALB module is **ready-to-use, flexible, and production-ready**. It allows DevOps engineers to deploy **secure, scalable, and highly available applications** without reinventing the wheel.  

---


