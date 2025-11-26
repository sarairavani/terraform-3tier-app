#!/bin/bash
# Ensure SSM agent is installed and running

# Check if SSM agent is installed
if ! command -v amazon-ssm-agent &> /dev/null; then
    # Install SSM agent based on OS
    if [ -f /etc/debian_version ]; then
        # Debian/Ubuntu
        snap install amazon-ssm-agent --classic || true
        systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
        systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
    elif [ -f /etc/redhat-release ]; then
        # RHEL/CentOS/Amazon Linux
        yum install -y amazon-ssm-agent
        systemctl enable amazon-ssm-agent
        systemctl start amazon-ssm-agent
    fi
else
    # SSM agent already installed, ensure it's running
    systemctl enable amazon-ssm-agent || systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
    systemctl start amazon-ssm-agent || systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
fi
