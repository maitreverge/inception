#! /bin/sh

# Make sure MariaDB has correctly started
# sleep 10

# Download the core `wp` component, responsible for processing core WP files.
wp core download --allow-root
# wp core download

# Allows the above package to install proprely
sleep 10

# If the wp-config.php file does not exists, configure Wordpress
if [ ! -f /var/www/wordpress/wp-config.php ]; then

    cd /war/www/wordpress

    echo "==================================================="
    echo "              Configuring the database"
    echo "==================================================="
    # Create the database for wordpress
    wp config create    --allow-root \
                        --dbname=${MARIADB_DATABASE_NAME} \
                        --dbuser=${MARIADB_USER_LOGIN} \
                        --dbpass=${MARIADB_USER_PASSWORD} \
                        --dbhost=mariadb:3306 \
                        --path='/var/www/wordpress'
    
    # Create the admin login details
    wp core install     --allow-root \
                        --url=${URL} \
                        --title=${WEBSITE_TITLE} \
                        --admin_user=${WP_ADMIN_LOGIN} \
                        --admin_password=${WP_ADMIN_PASSWORD} \
                        --admin_email${WP_ADMIN_EMAIL} \
                        --skip-email \
                        --path='/var/www/wordpress'

    # Create another user which is not root for Wordpress
    wp user create      --allow-root \
                        --${WP_USER_LOGIN} \
                        --${WP_USER_EMAIL} \
                        --user_pass=${WP_USER_PASSWORD} \
                        --role='editor' \
                        --display_name=${WP_USER_LOGIN} \
                        --porcelain \
                        --path='/var/www/wordpress'
else
    echo "Wordpress config file does already exists, skipping configuration..."
fi

# Exec CDM Docker file as an argumentm if not, skip the CMD
exec "$@"

# exec "/usr/sbin/php-fmp7.4 -F"