#!/bin/bash
# Ensure SSM Agent is installed and running
if ! systemctl status amazon-ssm-agent >/dev/null 2>&1; then
    if command -v yum >/dev/null 2>&1; then
        yum install -y amazon-ssm-agent
    elif command -v apt-get >/dev/null 2>&1; then
        apt-get update
        apt-get install -y amazon-ssm-agent
    fi
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
fi

