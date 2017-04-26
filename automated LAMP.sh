#!/bin/bash

if cat /etc/issue | grep Amazon > /dev/null
then 
echo updating
  sudo yum update
echo "installing httpd"
  sudo yum install httpd -y > /dev/null
echo "starting httpd"
  sudo service httpd start
echo "installing mysql"
  sudo yum install mysql mysql-server -y > /dev/null
echo "starting mysqld"
  sudo service mysqld start
echo "secure installation"
  if mysql -u root 2>/dev/null <<EOF
exit
EOF
  then
    mysql -u root <<EOF
UPDATE mysql.user SET Password=PASSWORD('$1') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF
  fi
echo "installing php"
  sudo yum install php php-mysql -y > /dev/null
  sudo chkconfig httpd on
  sudo chkconfig mysqld on
  sudo service httpd restart

elif cat /etc/issue | grep Ubuntu > /dev/null
  then
echo updating
  sudo apt-get update
echo "installing apache2"
  sudo apt-get install apache2 -y > /dev/null
  sudo systemctl restart apache2
  sudo ufw app list
  sudo ufw app info "Apache Full"
  sudo ufw allow in "Apache Full"
echo "installing mysq"
  sudo apt-get install mysql-server -y > /dev/null
echo "secure installation"
  if mysql -u root 2>/dev/null <<EOF
exit
EOF
  then
    mysql -u root <<EOF
UPDATE mysql.user SET Password=PASSWORD('$1') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF
  fi
echo "installing php"
  sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql
fi