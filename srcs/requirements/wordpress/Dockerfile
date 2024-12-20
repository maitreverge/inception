# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/23 18:37:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/20 11:57:20 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get update -y && \
		apt-get install -y \
		sudo \
		curl \
        php-fpm \
		php-mysql

# # Create the directory for making the container up.
# RUN mkdir -p /run/php

# Copy config file for php
# COPY conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

COPY conf/launchWP.sh /

RUN chmod +x launchWP.sh

ENTRYPOINT ["/usr/sbin/php-fpm7.4", "-F"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]