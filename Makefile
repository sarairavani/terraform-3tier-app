.PHONY: help init validate fmt format plan apply destroy clean lint security-check docs install-hooks

# Default target
help:
	@echo "Available targets:"
	@echo "  init            - Initialize Terraform working directory"
	@echo "  validate        - Validate Terraform configuration"
	@echo "  fmt             - Format Terraform files"
	@echo "  format          - Alias for fmt"
	@echo "  plan            - Generate and show Terraform execution plan"
	@echo "  apply           - Apply Terraform changes"
	@echo "  destroy         - Destroy Terraform-managed infrastructure"
	@echo "  clean           - Clean Terraform artifacts"
	@echo "  lint            - Run tflint on all modules"
	@echo "  security-check  - Run security checks with checkov"
	@echo "  docs            - Generate documentation with terraform-docs"
	@echo "  install-hooks   - Install pre-commit hooks"
	@echo "  all-checks      - Run all checks (fmt, validate, lint, security)"

# Environment variable for selecting environment (default: dev)
ENV ?= dev
ENV_DIR = environments/$(ENV)

init:
	@echo "Initializing Terraform for $(ENV) environment..."
	cd $(ENV_DIR) && terraform init

validate: init
	@echo "Validating Terraform configuration for $(ENV) environment..."
	cd $(ENV_DIR) && terraform validate

fmt:
	@echo "Formatting Terraform files..."
	terraform fmt -recursive

format: fmt

plan: validate
	@echo "Planning Terraform changes for $(ENV) environment..."
	cd $(ENV_DIR) && terraform plan

apply: validate
	@echo "Applying Terraform changes for $(ENV) environment..."
	cd $(ENV_DIR) && terraform apply

destroy:
	@echo "Destroying Terraform infrastructure for $(ENV) environment..."
	cd $(ENV_DIR) && terraform destroy

clean:
	@echo "Cleaning Terraform artifacts..."
	find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.tfstate" -delete
	find . -type f -name "*.tfstate.backup" -delete
	find . -type f -name ".terraform.lock.hcl" -delete

lint:
	@echo "Running tflint..."
	@command -v tflint >/dev/null 2>&1 || { echo "tflint not installed. Install from https://github.com/terraform-linters/tflint"; exit 1; }
	tflint --init
	tflint --recursive

security-check:
	@echo "Running security checks with checkov..."
	@command -v checkov >/dev/null 2>&1 || { echo "checkov not installed. Install with: pip install checkov"; exit 1; }
	checkov --directory . --framework terraform --quiet

docs:
	@echo "Generating documentation with terraform-docs..."
	@command -v terraform-docs >/dev/null 2>&1 || { echo "terraform-docs not installed. Install from https://terraform-docs.io/"; exit 1; }
	@for dir in modules/*/* modules/*/*/* environments/*; do \
		if [ -d "$$dir" ] && [ -f "$$dir/main.tf" ]; then \
			echo "Generating docs for $$dir..."; \
			terraform-docs markdown table --output-file README.md --output-mode inject "$$dir"; \
		fi \
	done

install-hooks:
	@echo "Installing pre-commit hooks..."
	@command -v pre-commit >/dev/null 2>&1 || { echo "pre-commit not installed. Install with: pip install pre-commit"; exit 1; }
	pre-commit install
	pre-commit install --hook-type commit-msg

all-checks: fmt validate lint security-check
	@echo "All checks completed successfully!"
