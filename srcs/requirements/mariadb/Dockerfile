# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 05:58:37 by flverge           #+#    #+#              #
#    Updated: 2024/09/19 08:31:12 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye}

# Basics container packages
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        zsh \
        mariadb-server
        

# CMD ["rc-service", "mariadb", "start"]

# Forbidden command
CMD ["tail", "-f", "/dev/null"]

