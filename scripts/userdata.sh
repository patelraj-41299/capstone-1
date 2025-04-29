#!/bin/bash
yum update -y
yum install -y git

# Install Node.js 18
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Install PM2 globally
npm install -g pm2

# Switch to ec2-user home directory
cd /home/ec2-user

# Clone your GitHub repo
git clone https://github.com/patelraj-41299/capstone-1.git
cd capstone-1/backend

# Install backend dependencies
npm install

# Start the app using PM2
pm2 start app.js
