#!/bin/bash
# Web tier userdata script
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello from Web Tier</h1>" > /var/www/html/index.html
