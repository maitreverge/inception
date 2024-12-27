# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/23 16:58:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/27 21:42:22 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get -y update && \
    	apt-get -y install npm && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

		# $ npm install -g redis-commander
        #   $ redis-commander

ENTRYPOINT ["tail", "-f", "/dev/null"]
