#!/bin/bash -xe
# this command makes a log of the ec2 user data and stores it at /var/log/user-data.log for debugging
# exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
  echo "EC2 User Data Script Start..."
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  sudo sh -c 'echo "<h1>Cloud Tracker - Load Balancer Test - Instance $(hostname -f)</h1>" > /var/www/html/index.html'
  echo "EC2 User Data Script Finished..."