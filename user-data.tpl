#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo yum update -y
sudo yum install -y ruby wget

wget https://aws-codedeploy-eu-west-1.s3.eu-west-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

sudo amazon-linux-extras install -y nginx1

sudo service nginx start
sudo chkconfig nginx on

sudo mkdir -p /var/www/my-angular-project

sudo sed -i 's/\/usr\/share\/nginx\/html/\/var\/www\/my-angular-project/' /etc/nginx/nginx.conf

sudo service nginx restart