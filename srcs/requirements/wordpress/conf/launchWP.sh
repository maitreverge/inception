#!/bin/sh

#Creating base wordpress directories
mkdir /var/www/
mkdir /var/www/html

cd /var/www/html

#Cleaning old stuff
rm -rf *

# Install Wordpress CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Typing wp instead of php wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp



