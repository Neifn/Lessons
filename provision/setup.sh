#!/bin/bash

echo "Provisioning virtual machine..."

echo "updating repositories"
export DEBIAN_FRONTEND=noninteractive
add-apt-repository ppa:ondrej/php5 -y > /dev/null
apt-get update > /dev/null
echo "Installing Git"
apt-get install git -y > /dev/null
    
echo "Installing Nginx"
apt-get install nginx -y > /dev/null

apt-get install python-software-properties build-essential -y > /dev/null

echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null
    
echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null

apt-get install debconf-utils -y > /dev/null

debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
    
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"

apt-get install mysql-server -y > /dev/null

echo "Configuring Nginx"
cp /var/www/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null
    
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/
    
rm -rf /etc/nginx/sites-available/default
    
service nginx restart > /dev/null

