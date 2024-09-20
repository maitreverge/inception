# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/20 11:29:23 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Arguments used in an image reference should be valid when no build arguments are used.
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN apt-get -y update && \
    apt-get -y install \
        nginx \
        openssl

# FOR NGINX MANAGING ENV VARIABLES IN NGINX CONF FILE

# !! The gettext-base package provides basic internationalization and localization functions,
# like envsubst, which substitutes environment variables in strings.
# This package is less directly related to starting services but
# is often used in Docker images or scripts to help localize output or manage environment variables.

# Copy the conf file
COPY conf/nginx/nginx.conf /etc/nginx/

# Base Script
COPY conf/nginx/config_nginx.sh /etc/nginx

# Give permissions to the script
RUN chmod +x etc/nginx/config_nginx.sh

# Create a base html file
# RUN echo "<h1>Hello, NGINX on Alpine!</h1>" > /var/www/html/index.html
COPY conf/nginx/index.html /var

# !!!!!!!!!!!!!!!!!!!!!!!!!! A REGARDER
EXPOSE 443

ENTRYPOINT ["etc/nginx/config_nginx.sh"]