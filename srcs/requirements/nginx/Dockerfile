# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/12 18:36:06 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG LOGIN
ARG URL

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
RUN openssl req -x509 -nodes -out \
	${PATH_NGINX_CERTIFICATE}/inception.crt \
	-keyout ${PATH_NGINX_TSL_KEY}/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${URL}/UID=${LOGIN}"

# Building nginx configuration path
RUN mkdir -p /var/run/nginx



RUN apk cache clean

# commande magique qui tiens le container UP, mais commande interdite
CMD ["tail", "-f", "/dev/null"]
