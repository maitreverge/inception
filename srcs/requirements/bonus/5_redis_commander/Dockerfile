# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/23 16:58:21 by flverge           #+#    #+#              #
#    Updated: 2024/12/28 19:33:01 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

RUN		apt-get -y update && \
    	apt-get -y install npm && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

# COPY conf/.redis-commander /root/

RUN npm install -g redis-commander

ENTRYPOINT ["redis-commander"]
# ENTRYPOINT ["redis-commander", "--config", "/root/.redis-commander"]

# ENTRYPOINT ["redis-commander", "--nl", "--redis-hosts", "redis_wp:redis:6379:0"]

		# ENTRYPOINT ["tail", "-f", "/dev/null"]
# ENTRYPOINT ["redis-commander", "-1-host", "redis", "--port", "6579", "--is-cluster"]
