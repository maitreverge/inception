# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 05:58:37 by flverge           #+#    #+#              #
#    Updated: 2024/09/18 10:09:12 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION:-3.19.3}

# Basics container packages
RUN apk update && \
    apk add --no-cache \
        zsh \
        mariadb
        

# CMD ["rc-service", "mariadb", "start"]

# Forbidden command
CMD ["tail", "-f", "/dev/null"]

