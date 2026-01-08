# Contributing to Terraform 3-Tier Application

Thank you for your interest in contributing to this project! This document provides guidelines and best practices for contributing.

## Table of Contents
- [Development Setup](#development-setup)
- [Code Standards](#code-standards)
- [Commit Guidelines](#commit-guidelines)
- [Testing](#testing)
- [Security](#security)

## Development Setup

### Prerequisites
- Terraform >= 1.6.0
- AWS CLI configured with appropriate credentials
- Pre-commit hooks (optional but recommended)
- tflint (optional but recommended)
- terraform-docs (optional but recommended)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/SaraIravani/terraform-3tier-app.git
cd terraform-3tier-app
```

2. Install pre-commit hooks (optional):
```bash
pip install pre-commit
make install-hooks
```

3. Initialize Terraform:
```bash
make init ENV=dev
```

## Code Standards

### Terraform Formatting
- Always run `terraform fmt -recursive` before committing
- Use 2 spaces for indentation
- Follow HashiCorp's Terraform style guide
- Use the provided `.editorconfig` for consistent formatting

Quick format:
```bash
make fmt
```

### Naming Conventions
- **Resources**: Use lowercase with hyphens (e.g., `aws_vpc.main`)
- **Variables**: Use lowercase with underscores (e.g., `vpc_cidr_block`)
- **Modules**: Use lowercase with hyphens (e.g., `web-tier`)
- **Files**: Standard names: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`

### Module Structure
Each module should follow this structure:
```
module-name/
├── main.tf          # Main resource definitions
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── versions.tf      # Provider and Terraform version constraints
└── README.md        # Module documentation
```

### Documentation
- Document all variables with descriptions
- Document all outputs with descriptions
- Include examples in module README files
- Use inline comments for complex logic only
- Keep comments up-to-date with code changes

### Variables Best Practices
- Always define `type` for variables
- Provide meaningful `description` for all variables
- Use `validation` blocks where appropriate
- Mark sensitive variables with `sensitive = true`
- Avoid default values for secrets/passwords
- Use `locals` for computed values

Example:
```hcl
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "Must be a valid IPv4 CIDR block."
  }
}
```

## Commit Guidelines

### Commit Message Format
Follow conventional commits:
```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Example:
```
feat(networking): add VPC flow logs module

- Implements VPC flow logs with CloudWatch integration
- Adds support for S3 destination
- Includes IAM role for flow logs

Closes #123
```

## Testing

### Validation
Before submitting changes, run:
```bash
# Format check
make fmt

# Validate syntax
make validate ENV=dev

# Lint with tflint
make lint

# Security scan
make security-check

# Run all checks
make all-checks
```

### Plan Review
Always review the plan output:
```bash
make plan ENV=dev
```

Ensure:
- No unexpected resource deletions
- Proper resource dependencies
- Correct naming and tagging
- Security best practices followed

## Security

### Secrets Management
- **NEVER** commit secrets, passwords, or API keys
- Use AWS Secrets Manager or Parameter Store
- Set `sensitive = true` for sensitive variables
- Use `.gitignore` to exclude `.tfvars` files
- Use environment variables or encrypted storage for credentials

### Security Best Practices
- Follow least privilege principle for IAM roles
- Enable encryption at rest and in transit
- Use security groups with minimal required access
- Enable logging and monitoring
- Regular security scans with checkov/tfsec

### Running Security Checks
```bash
make security-check
```

## Pull Request Process

1. Create a feature branch from `main`
2. Make your changes following the guidelines above
3. Run all validation checks: `make all-checks`
4. Update documentation if needed
5. Commit with clear, descriptive messages
6. Push to your fork and submit a Pull Request
7. Address review comments promptly

### PR Checklist
- [ ] Code follows style guidelines
- [ ] All checks pass (`make all-checks`)
- [ ] Documentation updated
- [ ] No secrets committed
- [ ] Variables properly documented
- [ ] Outputs properly documented
- [ ] Changes tested with `terraform plan`

## Questions?

If you have questions or need help:
- Open an issue for bugs or feature requests
- Check existing issues and discussions
- Review the main README.md for architecture details

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on constructive feedback
- Maintain professional communication

Thank you for contributing! 🚀
