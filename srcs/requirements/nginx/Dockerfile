# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/23 20:55:03 by flverge          ###   ########.fr        #
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
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Give authorization on the root
RUN chmod 755 /var/www/html

# Give authorization on the main user
RUN chown -R www-data:www-data /var/www/html
        
# Build Path for certificate
ARG PATH_NGINX_CERTIFICATE
RUN mkdir -p ${PATH_NGINX_CERTIFICATE}

# Build Path for TSL key
ARG PATH_NGINX_TSL_KEY
RUN mkdir -p ${PATH_NGINX_TSL_KEY}

# Creating the self-signed certificate
RUN openssl req -x509 \
                -nodes \
                -out ${PATH_NGINX_CERTIFICATE}/inception.crt \
                -keyout ${PATH_NGINX_TSL_KEY}/inception.key \
                -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=flverge.42.fr/UID=flverge"

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]