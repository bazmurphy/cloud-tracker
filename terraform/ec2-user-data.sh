#!/bin/bash -xe
# this command makes a log of the ec2 user data and stores it at /var/log/user-data.log for debugging
# exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "EC2 User Data Script Started"
# update packages
sudo yum update -y
# install docker
sudo yum install -y docker
# start the docker service
sudo systemctl start docker.service
# autostart the docker service on reboot
sudo systemctl enable docker
# check docker is running
# sudo systemctl status docker # how to exit from this elegantly?
# Add ec2-user to the docker group
sudo usermod -a -G docker ec2-user
# Make changes to the group take affect immediately
newgrp docker
# download docker compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# fix permissions after download
sudo chmod +x /usr/local/bin/docker-compose
# check docker compose installed correctly
docker-compose version
# pull the images
docker pull bazmurphy/cloud-tracker-database:latest
docker pull bazmurphy/cloud-tracker-backend:latest
docker pull bazmurphy/cloud-tracker-frontend:latest
# get the docker-compose file from github repo
sudo wget -O /home/ec2-user/docker-compose.yml https://raw.githubusercontent.com/bazmurphy/cloud-tracker/main/docker-compose.yml
# get the .env file from github repo (this is totally unsafe...)
# sudo wget -O /home/ec2-user/.env https://raw.githubusercontent.com/bazmurphy/cloud-tracker/main/.env
# change directory
cd /home/ec2-user/
# make an .env file and add the variables to it
# echo "POSTGRES_USER=${POSTGRES_USER}\nPOSTGRES_PASSWORD=${POSTGRES_PASSWORD}\nDB_CONNECTION_STRING=${DB_CONNECTION_STRING}\nDB_SSL=${DB_SSL}" >> .env
cat << EOF >.env
POSTGRES_USER=${POSTGRES_USER}  
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
DB_CONNECTION_STRING=${DB_CONNECTION_STRING}  
DB_SSL=${DB_SSL}
AWS_CLOUDWATCH_REGION=${AWS_CLOUDWATCH_REGION}
AWS_CLOUDWATCH_ACCESS_KEY_ID=${AWS_CLOUDWATCH_ACCESS_KEY_ID}
AWS_CLOUDWATCH_SECRET_ACCESS_KEY=${AWS_CLOUDWATCH_SECRET_ACCESS_KEY}
VITE_EC2_INTERNAL_IP=${ifconfig enX0 | awk '/inet / {print $2}' | cut -d: -f2}
EOF
# run docker compose
docker-compose up -d
echo "EC2 User Data Script Finished"