#!/bin/bash
yum update -y
yum install -y git
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs
npm install pm2 -g

cd /home/ec2-user
git clone https://github.com/your-github-username/your-repo-name.git
cd your-repo-name/backend
npm install

pm2 start app.js
