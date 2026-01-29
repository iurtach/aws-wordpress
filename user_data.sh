#!/bin/bash


dnf update -y
dnf install -y httpd php php-mysqlnd amazon-efs-utils

#Run WEB server
systemctl start httpd
systemctl enable httpd

#Mount EFS
mkdir -p /var/www/html
mount -t efs -o tls ${efs_id}:/ /var/www/html

#Prevent from removing 
echo "${efs_id}:/ /var/www/html efs _netdev,tls 0 0" >> /etc/fstab

#Install WordPress
cd /var/www/html
if [ ! -f index.php ]; then
    echo "Installing WordPress..."
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mv wordpress/* .
    rm -rf wordpress latest.tar.gz
    
    #Assign rights
    chown -R apache:apache /var/www/html
    chmod -R 755 /var/www/html
    
    #Create wp-config.php
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/${db_name}/" wp-config.php
    sed -i "s/username_here/${db_username}/" wp-config.php
    sed -i "s/password_here/${db_password}/" wp-config.php
    sed -i "s/localhost/${db_endpoint}/" wp-config.php
fi
