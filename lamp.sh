#!/bin/bash

 #root password for MySQL
 read -p 'db_root_password [secretpasswd]: ' db_root_password
 echo

 #update system
 sudo apt-get update -y

 #install APache, PHP and MySQL
 sudo apt-get install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y

 apt-get install php libapache2-mod-php php-mysql -y

 export DEBIAN_FRONTEND="noninteractive"
 debconf-set-selections <<< "mysql-server mysql-server/root_password password $db_root_password"
 debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $db_root_password"
 apt-get install mysql-server -y

 sudo a2enmod rewrite
 sudo php5enmod mcrypt

 #install and configure PhpMyAdmin 
 sudo apt-get install phpmyadmin -y

 echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf

 sudo chown -R www-data:www-data /var/www

 #restart Apache
 sudo service apache2 restart
