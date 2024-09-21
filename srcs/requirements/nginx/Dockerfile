# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/21 14:23:43 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Arguments used in an image reference should be valid when no build arguments are used.
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN apt-get update -y && \
    apt-get install -y \
        nginx \
        openssl

# Copy the conf file
COPY conf/nginx/nginx.conf /etc/nginx/nginx.conf

# Base Script
COPY conf/nginx/config_nginx.sh /etc/nginx

# Give permissions to the script
RUN chmod +x etc/nginx/config_nginx.sh

# Create a base html file
# RUN echo "<h1>Hello, NGINX on Alpine!</h1>" > /var/www/html/index.html
# COPY conf/nginx/index.html /var

# !!!!!!!!!!!!!!!!!!!!!!!!!! A REGARDER
EXPOSE 443

ENTRYPOINT ["etc/nginx/config_nginx.sh"]