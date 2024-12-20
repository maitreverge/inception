#!/bin/sh

#Creating base wordpress directories
mkdir -p /var/www/
mkdir -p /var/www/html

cd /var/www/html

#Cleaning old stuff
rm -rf *

# Install Wordpress CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Typing wp instead of php wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Download Main Wordpress
wp core download --allow-root

# Change the config sample into the real config
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

##################### CHANGE CONFIG IN WORDPRESS CONFIG ########################

# /** The name of the database for WordPress */
# define( 'DB_NAME', 'database_name_here' );
sed -i -r "s/database_name_here/$MARIADB_DATABASE_NAME/1"   /var/www/html/wp-config.php

# /** Database username */
# define( 'DB_USER', 'username_here' );
sed -i -r "s/username_here/$MARIADB_USER_LOGIN/1"  /var/www/html/wp-config.php

# /** Database password */
# define( 'DB_PASSWORD', 'password_here' );
sed -i -r "s/password_here/$MARIADB_USER_PASSWORD/1"    /var/www/html/wp-config.php

# /** Database hostname */
# define( 'DB_HOST', 'localhost' );
sed -i -r "s/localhost/mariadb/1"    /var/www/html/wp-config.php  #(to connect with mariadb database)

wp core install --url=$DOMAIN_NAME/ --title=$WEBSITE_TITLE --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $WP_USER_LOGIN $WP_USER_EMAIL --role=author --user_pass=$WP_PWD --allow-root

wp theme install codeify --activate --allow-root

# REDIS BONUS
# wp plugin install redis-cache --activate --allow-root

# Change the line `listen = /run/php/php7.4-fpm.sock`` into `listen = 9000`
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php

# REDIS BONUS
# wp redis enable --allow-root

bash /usr/sbin/php-fpm7.4 -F

