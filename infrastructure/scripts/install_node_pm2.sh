#!/bin/bash

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get update -y
apt-get install -y nodejs

# Install PM2 globally
npm install -g pm2
