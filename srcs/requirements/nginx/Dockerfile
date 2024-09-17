# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/17 17:26:31 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Arguments used in an image reference should be valid when no build arguments are used.
ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION:-3.19.3}

# Basics container packages
RUN apk update && \
    apk add --no-cache \
        zsh \
        vim \
        curl \
        nginx \
        openssl

# OH-MY-ZSH REQUIREMENTS
COPY conf/zsh/basic_zsh.sh /basic_zsh.sh

# Installing oh-my-zsh + init .zshrc file.
RUN apk add git && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    find ~/.oh-my-zsh/themes -type f ! -name 'robbyrussell.zsh-theme' -exec rm -rf {} + && \
    rm -rf ~/.oh-my-zsh/plugins/* && \
    chmod +x /basic_zsh.sh && \
    /basic_zsh.sh && \
    rm /basic_zsh.sh

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

# Copy custom nginx config file
COPY conf/nginx/pre_nginx.conf /etc/nginx/

COPY conf/nginx/swap_env_nginx.sh /etc/nginx/

RUN chmod +x /etc/nginx/swap_env_nginx.sh
RUN /bin/sh /etc/nginx/swap_env_nginx.sh

# Create the html directory for stocking the base html file
RUN mkdir -p /var/www/html

# Create a base html file
# RUN echo "<h1>Hello, NGINX on Alpine!</h1>" > /var/www/html/index.html
COPY conf/nginx/index.html /var/www/html/

# ? IS USELESS
# Building nginx configuration path
RUN mkdir -p /var/run/nginx

# Give authorization on the root
RUN chmod 755 /var/www/html

# Create the data user and adds it to the www-data group
RUN adduser -S -G www-data www-data

# Give authorization on the main user
RUN chown -R www-data:www-data /var/www/html

# Clean useless packages for optimizing container size
RUN apk cache clean

# Runs the nginx process as a non daemon process,
# to avoid PID 1 to rip it off, become a zombie process and then shut-down the container.
CMD ["nginx", "-g", "daemon off;"]
# CMD ["tail", "-f", ">dev/null;"] Forbidden command
