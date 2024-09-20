# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/20 18:09:03 by flverge          ###   ########.fr        #
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

# creation de dosser
RUN mkdir -p /var/www

# Installation de wordpress
RUN wget https://fr.wordpress.org/wordpress-6.6.2-fr_FR.tar.gz -P /var/www

# Unzip 
RUN cd /var/www && tar -xzf wordpress-6.6.2-fr_FR.tar.gz && rm wordpress-6.6.2-fr_FR.tar.gz

# Give rightsd access
RUN		chown -R root:root /var/www/wordpress



ENTRYPOINT ["sh", "-c", "tail -f /dev/null"]