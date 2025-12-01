#!/bin/bash
# Ensure SSM Agent is installed and running
yum install -y amazon-ssm-agent || dnf install -y amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
