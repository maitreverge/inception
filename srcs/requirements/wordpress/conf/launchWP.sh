#!/bin/sh

# As long as the MySQL command to connect to the MariaDB server returns an error (i.e., the server is not ready or the connection fails), keep executing the loop.
counter=3
until mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -h "mariadb" --silent; do
    dots=$(printf "%${counter}s" | tr ' ' '.') # trailing dots that nobody will pay attention to, because Inception isn't complicated enough
    echo "Wordpress container waiting for MariaDB connection${dots}"
    sleep 1
    counter=$((counter + 1))
done
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

# Install Wordpress CLI
echo "Installing Wordpress CLI .........."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Typing wp instead of php wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

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

# /** Database username */
# define( 'DB_USER', 'username_here' );
sed -i -r "s|username_here|$MARIADB_USER_LOGIN|1"  /var/www/html/wp-config.php

# /** Database password */
# define( 'DB_PASSWORD', 'password_here' );
sed -i -r "s|password_here|$MARIADB_USER_PASSWORD|1"    /var/www/html/wp-config.php

# /** Database hostname */
# define( 'DB_HOST', 'localhost' );
sed -i -r "s|localhost|mariadb|1"    /var/www/html/wp-config.php  #(to connect with mariadb database)

echo "Config file done "

wp core install --url=$DOMAIN_NAME/ --title=$WEBSITE_TITLE --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USER_LOGIN $WP_USER_EMAIL --role=author --user_pass=$WP_PWD --allow-root

wp theme install codeify --activate --allow-root

# REDIS BONUS
# wp plugin install redis-cache --activate --allow-root

# Change the line `listen = /run/php/php7.4-fpm.sock`` into `listen = 9000`
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
    echo "Created /run/php directory."
fi

# REDIS BONUS
# wp redis enable --allow-root

bash /usr/sbin/php-fpm7.4 -F

