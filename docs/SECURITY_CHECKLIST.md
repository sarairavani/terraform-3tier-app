# Security Checklist

This checklist helps ensure that your Terraform infrastructure follows security best practices.

## Pre-Deployment Security Checks

### Authentication & Authorization

- [ ] IAM roles follow least-privilege principle
- [ ] No use of root AWS account credentials
- [ ] IAM policies are resource-scoped (not using `*`)
- [ ] AWS managed policies reviewed and minimized
- [ ] Custom IAM policies created where needed
- [ ] MFA enabled for console access (if applicable)

### Secrets Management

- [ ] No hardcoded secrets in `.tf` files
- [ ] No secrets in version control
- [ ] Sensitive variables marked with `sensitive = true`
- [ ] `.tfvars` files containing secrets are gitignored
- [ ] Secrets stored in AWS Secrets Manager or Parameter Store
- [ ] Database passwords retrieved from Secrets Manager
- [ ] KMS keys used for secret encryption

### Encryption

- [ ] Encryption at rest enabled for all data stores
  - [ ] RDS storage encrypted
  - [ ] EBS volumes encrypted
  - [ ] S3 buckets encrypted
  - [ ] Secrets Manager uses KMS encryption
- [ ] Encryption in transit configured
  - [ ] HTTPS/SSL for ALB
  - [ ] SSL/TLS for RDS connections
- [ ] KMS key rotation enabled
- [ ] Appropriate KMS key policies configured

### Network Security

- [ ] VPC Flow Logs enabled
- [ ] Database in private subnets only
- [ ] Application tier in private subnets
- [ ] Security groups follow least-privilege
- [ ] No security group rules with `0.0.0.0/0` for ingress (except ALB)
- [ ] Network ACLs configured (if needed)
- [ ] NAT Gateway for private subnet internet access
- [ ] No direct internet access for databases

### Access Control

- [ ] Bastion host uses SSM Session Manager (no SSH keys)
- [ ] No public access to RDS instances
- [ ] No unnecessary public IPs
- [ ] S3 buckets not publicly accessible
- [ ] CloudTrail enabled for audit logging

### Monitoring & Logging

- [ ] CloudWatch Logs enabled for critical resources
- [ ] CloudTrail logging enabled
- [ ] VPC Flow Logs configured
- [ ] RDS CloudWatch logs exported
- [ ] SNS alerts configured for critical events
- [ ] Log retention periods configured

### Backup & Recovery

- [ ] RDS automated backups enabled
- [ ] Appropriate backup retention period (7-35 days)
- [ ] RDS Multi-AZ enabled for production
- [ ] Deletion protection enabled for critical resources
- [ ] Final snapshots configured for RDS

### Infrastructure Security

- [ ] Terraform state stored remotely (S3)
- [ ] State file encryption enabled
- [ ] State locking configured (DynamoDB)
- [ ] State file versioning enabled
- [ ] No sensitive data in Terraform outputs (or marked sensitive)

## Post-Deployment Security Checks

### Validation

- [ ] Security scanning completed (Checkov/tfsec)
- [ ] No critical security findings
- [ ] Medium/high findings addressed or documented
- [ ] AWS Config rules evaluated (if applicable)
- [ ] AWS Security Hub findings reviewed (if applicable)

### Documentation

- [ ] Security architecture documented
- [ ] Incident response plan in place
- [ ] Access control documented
- [ ] Change management process defined

## Ongoing Security Maintenance

### Regular Tasks

- [ ] Review IAM permissions quarterly
- [ ] Rotate secrets/passwords regularly
- [ ] Update security patches
- [ ] Review CloudTrail logs for anomalies
- [ ] Review security group rules
- [ ] Update Terraform and provider versions
- [ ] Re-run security scans after changes

### Compliance

- [ ] Tag all resources appropriately
- [ ] Cost allocation tags applied
- [ ] Compliance requirements met (PCI, HIPAA, etc.)
- [ ] Data retention policies followed

## Security Tools

### Recommended Tools

- **Checkov**: Infrastructure security scanning
- **tfsec**: Terraform security scanner
- **TFLint**: Terraform linting
- **AWS Config**: AWS resource compliance
- **AWS Security Hub**: Centralized security findings
- **GuardDuty**: Threat detection (if enabled)

### Running Security Scans

```bash
# Run Checkov
make security-check

# Or manually
checkov --directory . --framework terraform

# Run tfsec
tfsec .

# Run TFLint
make lint
```

## Incident Response

### In Case of Security Incident

1. **Immediate Actions**
   - Isolate affected resources
   - Review CloudTrail logs
   - Revoke compromised credentials
   - Rotate secrets

2. **Investigation**
   - Identify scope of breach
   - Review access logs
   - Document findings

3. **Remediation**
   - Apply security patches
   - Update IAM policies
   - Strengthen security controls
   - Re-scan infrastructure

4. **Post-Incident**
   - Update incident response plan
   - Conduct lessons learned
   - Update documentation
   - Implement preventive measures

## References

- [AWS Security Best Practices](https://aws.amazon.com/architecture/security-identity-compliance/)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)
- [OWASP Cloud Security](https://owasp.org/www-project-cloud-security/)
- [Terraform Security Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

---

**Last Updated:** 2025-01-08

Review this checklist before each deployment and regularly for ongoing security maintenance.
