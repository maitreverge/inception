# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 05:58:37 by flverge           #+#    #+#              #
#    Updated: 2024/12/30 08:45:11 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN		apt-get -y update && \
    	apt-get -y install mariadb-server && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*
        
COPY conf/50-server.cnf /etc/mysql/my.cnf

COPY conf/mariadb_init_script.sh /

RUN chmod +x mariadb_init_script.sh

# # This expose command only serves as documentation
# # as the real exposing process happens to be in the docker-compose
EXPOSE 3306
        
ENTRYPOINT [ "bash", "mariadb_init_script.sh" ]