# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/21 11:41:14 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Arguments used in an image reference should be valid when no build arguments are used.
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN apt-get -y update && \
    apt-get install -y \
        zsh \
        wget \
        php7.4 \
        php-fpm \
        php-mysql \
        php-intl \
        mariadb-client

# Create main scripts folder
ARG SCRIPTS_FOLDER
RUN mkdir -p ${SCRIPTS_FOLDER}
        
# Target folder creation for Wordpress
RUN mkdir -p /var/www

# Get Wordpress
RUN wget https://fr.wordpress.org/wordpress-6.6.2-fr_FR.tar.gz -P /var/www

# Unzip the archive and delete it
RUN cd /var/www && \
    tar -xzf wordpress-6.6.2-fr_FR.tar.gz && \
    rm wordpress-6.6.2-fr_FR.tar.gz && \
    cd ../../

# Give to root WRITE rights to the wordpress folder
RUN		chown -R root:root /var/www/wordpress

# !         SECURITY COMMANDS :
# Saving the current PHP and Wordpress config files
# before copying my config files
RUN cp /etc/php/7.4/fpm/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf.bak && \
    cp /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.bak


# Copy PHP config file
COPY conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

# Copy Wordpress config file # ? REALLY USEFULL ?????
# COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install Wordpress CLI for automatic config
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Give authorization to the binari WP-CLI, and move it to binary folder (eases the call of the binary with )
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

ARG SCRIPTS_FOLDER
COPY scripts/wp-config.sh ${SCRIPTS_FOLDER}

RUN chmod +x ${SCRIPTS_FOLDER}/wp-config.sh


ENTRYPOINT ["sh", "-c", "tail -f /dev/null"]