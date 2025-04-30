#!/bin/bash

# Install Node.js and PM2
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get update -y
apt-get install -y nodejs
npm install -g pm2

# Set correct ownership
chown -R ubuntu:ubuntu /home/ubuntu/capstone-1

# Navigate to the backend app
cd /home/ubuntu/capstone-1/backend

# Install dependencies and start app as ubuntu
sudo -u ubuntu npm install
sudo -u ubuntu pm2 delete all || true
sudo -u ubuntu pm2 start app.js --name "capstone-backend"
