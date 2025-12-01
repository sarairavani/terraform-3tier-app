#!/bin/bash
# Web tier user data script
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Web Tier" > /var/www/html/index.html
