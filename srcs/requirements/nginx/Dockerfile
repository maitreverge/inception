# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/19 08:30:14 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Arguments used in an image reference should be valid when no build arguments are used.
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        zsh \
        nginx \
        openssl

COPY conf/nginx/nginx.conf /etc/nginx/

# Build Path for certificate
ARG PATH_NGINX_CERTIFICATE
RUN mkdir -p ${PATH_NGINX_CERTIFICATE}

# Build Path for TSL key
ARG PATH_NGINX_TSL_KEY
RUN mkdir -p ${PATH_NGINX_TSL_KEY}

# Creating the self-signed certificate
ARG PATH_NGINX_CERTIFICATE
ARG PATH_NGINX_TSL_KEY
RUN openssl req -x509 -nodes -out \
	${PATH_NGINX_CERTIFICATE}/inception.crt \
	-keyout ${PATH_NGINX_TSL_KEY}/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${URL}/UID=${LOGIN}"

    # ! need to check the above line for URL and LOGIN variables

# Refactor most RUN commands into a script
COPY conf/nginx/config_nginx.sh /etc/nginx

# Give permissions to the script, execute it, delete it
RUN chmod +x etc/nginx/config_nginx.sh && \
    /bin/sh etc/nginx/config_nginx.sh && \
    rm -rf etc/nginx/config_nginx.sh

# Create a base html file
# RUN echo "<h1>Hello, NGINX on Alpine!</h1>" > /var/www/html/index.html
COPY conf/nginx/index.html /var/www/html/

# Runs the nginx process as a non daemon process,
# to avoid PID 1 to rip it off, become a zombie process and then shut-down the container.
CMD ["nginx", "-g", "daemon off;"]
# CMD ["tail", "-f", ">dev/null;"] Forbidden command
