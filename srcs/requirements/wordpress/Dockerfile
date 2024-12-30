# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/23 18:37:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/30 08:45:38 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get update -y && \
		apt-get install -y curl sudo php7.4 php7.4-fpm php7.4-mysql php7.4-gd php7.4-xml php7.4-curl php7.4-mbstring php7.4-zip mariadb-client php-redis ftp && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

COPY conf/launchWP.sh /

RUN chmod +x launchWP.sh

ENTRYPOINT ["bash", "launchWP.sh"]