# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/23 16:58:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/27 21:35:23 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get -y update && \
    	apt-get -y install wget php php-mysql && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

# Bind 
RUN mkdir -p /var/www/html

RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php

EXPOSE 8080

# ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
