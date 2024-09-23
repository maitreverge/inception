# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #d
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/23 14:35:09 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Arguments used in an image reference should be valid when no build arguments are used.
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN apt-get -y update && \
    apt-get install -y \
        zsh \
        curl \
        wget \
        php8.1 \
        php-fpm \
        php-mysql \
        php-intl \
        mariadb-client

# Target folder creation for Wordpress
RUN mkdir -p /var/www/html

WORKDIR /var/www

# Copy PHP config file
COPY conf/php-fpm.conf /etc/php/8.1/fpm/

# Copy Wordpress config
COPY conf/www.conf /etc/php/8.1/fpm/pool.d/

# Get Wordpress, unzip it and delete the archive
RUN curl -o latest.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    rm -rf latest.tar.gz

# Give to root WRITE rights to the wordpress folder
RUN		chown -R www-data:www-data /var/www/wordpress

# Change authorizations
RUN		chmod -R 755 /var/www/wordpress

# !         SECURITY COMMANDS :
# Saving the current PHP and Wordpress config files
# before copying my config files
# RUN cp /etc/php/8.1/fpm/php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf.bak && \
#     cp /etc/php/8.1/fpm/pool.d/www.conf /etc/php/8.1/fpm/pool.d/www.conf.bak



# Copy Wordpress config file # ? REALLY USEFULL ?????
# COPY conf/www.conf /etc/php/8.1/fpm/pool.d/www.conf

# Install Wordpress CLI for automatic config
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Give authorization to the binari WP-CLI, and move it to binary folder (eases the call of the binary with )
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY scripts/wp-config.sh /usr/local/bin/wp-config.sh

RUN chmod +x /usr/local/bin/wp-config.sh

EXPOSE 9000

# Execute script
# ARG SCRIPTS_FOLDER
# ENTRYPOINT [ "wp-config.sh" ]
# Force to stay in foreground and ignore daemonize option from configuration file.
CMD ["php-fpm7.4", "-F"] 