# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/23 16:58:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/29 11:52:50 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get -y update && \
		apt-get -y install unzip curl apache2 && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

COPY conf/webserv_website.zip /

COPY conf/run.sh /

RUN chmod +x run.sh
		
RUN mkdir -p /var/www/static_website

# Unzip the archive in a different directory
RUN unzip webserv_website.zip -d /var/www/static_website

CMD ["apache2ctl", "-D", "FOREGROUND"]

