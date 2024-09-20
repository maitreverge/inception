# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 05:58:37 by flverge           #+#    #+#              #
#    Updated: 2024/09/20 10:17:32 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
# !! DELETE VIM AND ZSH
RUN apt-get -y update && \
    apt-get -y install \
        vim \
        zsh \
        mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

COPY conf/mariadb_init_script.sh /etc

RUN chmod +x etc/mariadb_init_script.sh
        
ENTRYPOINT [ "etc/mariadb_init_script.sh", "mysqld_safe" ]