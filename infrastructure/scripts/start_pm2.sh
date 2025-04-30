#!/bin/bash
cd /home/ubuntu/capstone-1/backend

# Install dependencies
npm install

# Stop any running PM2 apps (ignore errors if none exist)
pm2 delete all || true

# Start your app
pm2 start app.js --name "capstone-backend"
