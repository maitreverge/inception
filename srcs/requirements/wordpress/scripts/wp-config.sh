#! /bin/sh

# Make sure MariaDB has correctly started
sleep 10

# If the wp-config.php file does not exists, configure Wordpress
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    # Download the core `wp` component, responsible for processing core WP files.
    wp core download --allow-root

    # Allows the above package to install proprely
    sleep 5

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
                        --title=${WEBSITE_TITLE}
                        --admin_user=${WP_ADMIN_LOGIN}
                        --admin_password=${WP_ADMIN_PASSWORD}
                        --admin_email=
                        --skip-email=
                        --path='/var/www/html'

    # Create another user which is not root for Wordpress
else
    echo "Wordpress config file does already exists, skipping configuration..."
fi