#!/bin/bash
set -e  # Exit immediately if any command fails

# Update system packages
yum update -y

# Install Git
yum install -y git

# Install Node.js 18
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Install PM2 globally
npm install -g pm2

# Move to ec2-user's home directory
cd /home/ec2-user

# Clone GitHub repo (remove if it already exists)
if [ -d "capstone-1" ]; then
  rm -rf capstone-1
fi

git clone https://github.com/patelraj-41299/capstone-1.git
cd capstone-1/backend

# Set ec2-user as the owner (ensures PM2 can access all files)
chown -R ec2-user:ec2-user /home/ec2-user/capstone-1

# Install dependencies
npm install

# Start backend app using PM2
pm2 start app.js --name "capstone-backend"

# Enable PM2 on startup
pm2 startup systemd -u ec2-user --hp /home/ec2-user
pm2 save
