#!/bin/bash -xe
# this command makes a log of the ec2 user data and stores it at /var/log/user-data.log for debugging
# exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
  echo "EC2 User Data Script Started"
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  sudo sh -c 'echo "<div style=\"font-family: sans-serif; display: grid; place-items: center\"><h1>Cloud Tracker</h1><h2>Load Balancer Test</h2><h3>Instance Public IP: $(curl -s http://ifconfig.me/ip)</h3><h3>Instance Private IP: $(hostname -f)</h3></div>" > /var/www/html/index.html'
  echo "EC2 User Data Script Finished"