#!/bin/bash
# App tier userdata script
yum update -y
# Install application dependencies
yum install -y java-17-amazon-corretto
