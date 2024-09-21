#! /bin/sh

# If a command fails, script will stop immediately
set -e

#Create a config directory
mkdir -p /var/run/nginx

# Give authorization on the root
chmod 755 /var/www/html

# Give authorization on the main user
chown -R www-data:www-data /var/www/html

# Build Path for certificate
mkdir -p $PATH_NGINX_CERTIFICATE

# Build Path for TSL key
mkdir -p $PATH_NGINX_TSL_KEY

# Creating the self-signed certificate
openssl req -x509 \
            -nodes \
            -out $PATH_NGINX_CERTIFICATE/inception.crt \
            -keyout $PATH_NGINX_TSL_KEY/inception.key \
            -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=flverge.42.fr/UID=flverge"

# Runs the nginx process as a non daemon process,
# to avoid PID 1 to rip it off, become a zombie process and then shut-down the container.
nginx -g 'daemon off;'