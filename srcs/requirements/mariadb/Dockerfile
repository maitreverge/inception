# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 05:58:37 by flverge           #+#    #+#              #
#    Updated: 2024/09/20 13:49:37 by flverge          ###   ########.fr        #
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
        procps \
        gettext-base \
        mariadb-server
        

# The service command indirectly relies on procps to check and manage processes
# (e.g., determining if mysqld is running or stopping).
# Without procps, your environment may lack the necessary
# system utilities to correctly manage services like MySQL/MariaDB.

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

COPY conf/mariadb_init_script.sh /etc

RUN chmod +x etc/mariadb_init_script.sh

EXPOSE 3306
        
ENTRYPOINT [ "etc/mariadb_init_script.sh" ]  