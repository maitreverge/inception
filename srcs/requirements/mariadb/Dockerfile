# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 05:58:37 by flverge           #+#    #+#              #
#    Updated: 2024/09/15 10:47:37 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION:-3.19.3}

# Basics container packages
RUN apk update && \
    apk add --no-cache \
        zsh \
        vim \
        curl \
        mariadb
        

# CMD ["rc-service", "mariadb", "start"]

# Forbidden command
CMD ["tail" "-f" "/dev/null"]

