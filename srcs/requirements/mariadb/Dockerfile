# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 05:58:37 by flverge           #+#    #+#              #
#    Updated: 2024/09/30 12:19:15 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN apt-get -y update && \
    apt-get -y install \
        zsh \
        mariadb-server
        
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

COPY conf/mariadb_init_script.sh /etc

RUN chmod +x etc/mariadb_init_script.sh

# This expose command only serves as documentation
# as the real exposing process happens to be in the docker-compose
EXPOSE 3306
        
ENTRYPOINT [ "etc/mariadb_init_script.sh" ]