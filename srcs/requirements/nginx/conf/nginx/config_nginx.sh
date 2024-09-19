#! /bin/sh

# Create the html directory for stocking the base html file
mkdir -p /var/www/html

# ? IS USELESS
# Building nginx configuration path
mkdir -p /var/run/nginx

# Give authorization on the root
chmod 755 /var/www/html

# # Create the data user and adds it to the www-data group
# adduser -S -G www-data www-data

# Give authorization on the main user
chown -R www-data:www-data /var/www/html

# Clean useless packages for optimizing container size
apt clean