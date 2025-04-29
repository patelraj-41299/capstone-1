#!/bin/bash
cd /home/ubuntu/capstone-1/backend
npm install
pm2 delete all || true
pm2 start app.js
