# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/23 18:37:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/22 11:17:23 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get update -y && \
		apt-get install -y \
		sudo \
		curl \
        php-fpm \
		php-mysql \

COPY conf/launchWP.sh /

RUN chmod +x launchWP.sh

# RUN bash launchWP.sh

ENTRYPOINT ["bash", "launchWP.sh"]
# ENTRYPOINT ["bash", "/usr/sbin/php-fpm7.4", "-F"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]