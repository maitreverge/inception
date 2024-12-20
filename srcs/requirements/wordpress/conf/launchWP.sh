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

# Change the config sample into the real config
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

##################### CHANGE CONFIG IN WORDPRESS CONFIG ########################

# /** The name of the database for WordPress */
# define( 'DB_NAME', 'database_name_here' );
sed -i -r "s/database_name_here/$MARIADB_DATABASE_NAME/1"   wp-config.php

# /** Database username */
# define( 'DB_USER', 'username_here' );
sed -i -r "s/username_here/$MARIADB_USER_LOGIN/1"  wp-config.php


# /** Database password */
# define( 'DB_PASSWORD', 'password_here' );
sed -i -r "s/password_here/$MARIADB_USER_PASSWORD/1"    wp-config.php

# /** Database hostname */
# define( 'DB_HOST', 'localhost' );
sed -i -r "s/localhost/mariadb/1"    wp-config.php  #(to connect with mariadb database)