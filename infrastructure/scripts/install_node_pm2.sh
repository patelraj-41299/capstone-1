#!/bin/bash

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get update -y
sudo apt-get install -y nodejs

# Install PM2 globally
sudo npm install -g pm2
