#!/bin/sh

# As long as the MySQL command to connect to the MariaDB server returns an error (i.e., the server is not ready or the connection fails), keep executing the loop.
# until mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -h mariadb -P 3306 --silent; do
#     echo "Wordpress container waiting for MariaDB connection$..."
# done
# No need to disconnect from mysql afterwards, commands  within a `until` stays within this scope.

echo "MariaDB is up and running."

# Allows the script to exit if any of the commands fails
set -e
# In this script, set -e needs to be placed after the until top loop, otherwise the `until` block will trigger set -e if the sql command fails

# Creating base wordpress directories
mkdir -p /var/www/
mkdir -p /var/www/html

cd /var/www/html

#Cleaning old stuff
rm -rf /var/www/html/*

# Check if WP-CLI already has been installed
if [ ! -f "/usr/local/bin/wp" ]; then
	# Install Wordpress CLI
	echo "Installing Wordpress CLI .........."
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	# Typing wp instead of php wp-cli.phar
	chmod +x wp-cli.phar
	sudo mv wp-cli.phar /usr/local/bin/wp
    
	echo -e "\033[0;32m***** WordPress CLI SUCCESSFULLY installed *****\033[0m"
else
    echo -e "\033[0;33m***** WordPress CLI is already installed *****\033[0m"
fi

# Checks if WP has already been configured
if [ ! -f "/var/www/html/wp-config.php" ]; then
	
	# Download Main Wordpress
	echo "Downloading Wordpress ..............."
	wp core download --allow-root

	# Change the config sample into the real config
	mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

	##################### CHANGE CONFIG IN WORDPRESS CONFIG ########################

	echo "Changing the config file ..............."
	# /** The name of the database for WordPress */
	# define( 'DB_NAME', 'database_name_here' );
	sed -i -r "s|database_name_here|$MARIADB_DATABASE_NAME|1"   /var/www/html/wp-config.php

	cat /var/www/html/wp-config.php | grep $MARIADB_DATABASE_NAME

	# /** Database username */
	# define( 'DB_USER', 'username_here' );
	sed -i -r "s|username_here|$MARIADB_USER_LOGIN|1"  /var/www/html/wp-config.php

	cat /var/www/html/wp-config.php | grep $MARIADB_USER_LOGIN

	# /** Database password */
	# define( 'DB_PASSWORD', 'password_here' );
	sed -i -r "s|password_here|$MARIADB_USER_PASSWORD|1"    /var/www/html/wp-config.php
	
	cat /var/www/html/wp-config.php | grep $MARIADB_USER_PASSWORD

	# /** Database hostname */
	# define( 'DB_HOST', 'localhost' );
	sed -i -r "s|localhost|mariadb:3306|1"    /var/www/html/wp-config.php  #(to connect with mariadb database)
	
	cat /var/www/html/wp-config.php | grep mariadb

	echo "Config file done "

	sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf


	wp core install --url=$DOMAIN_NAME/ --title=$WEBSITE_TITLE --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

	wp user create $WP_USER_LOGIN $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

	wp theme install codeify --activate --allow-root

	# REDIS BONUS
	# wp plugin install redis-cache --activate --allow-root

	# Change the line `listen = /run/php/php7.4-fpm.sock`` into `listen = 9000`
    
	echo -e "\033[0;32m***** WordPress has been SUCCESSFULLY configured *****\033[0m"
else
    echo -e "\033[0;33m***** WordPress has ALREADY been configured *****\033[0m"
fi


if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
    echo -e "\033[0;32mCreated /run/php directory.\033[0m"
else
    echo -e "\033[0;33m***** /run/php directory already exists *****\033[0m"
fi

# REDIS BONUS
# wp redis enable --allow-root

# ./php-fpm7.4 -F

exec /usr/sbin/php-fpm7.4 -F


