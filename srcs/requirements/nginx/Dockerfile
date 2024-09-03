# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42perpignan.fr    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/02 16:14:45 by flverge           #+#    #+#              #
#    Updated: 2024/09/03 08:30:20 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19.3

# Basics container packages
RUN apk update && \
    apk add --no-cache \
        zsh \
        vim \
        curl \
        nginx \
        openssl

# OH-MY-ZSH REQUIREMENTS
COPY conf/zsh/basic_zsh.sh /basic_zsh.sh

RUN apk add git && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    find ~/.oh-my-zsh/themes -type f ! -name 'robbyrussell.zsh-theme' -exec rm -rf {} + && \
    rm -rf ~/.oh-my-zsh/plugins/* && \
    chmod +x /basic_zsh.sh && \
    /basic_zsh.sh && \
    rm /basic_zsh.sh

RUN apk cache clean

CMD ["zsh"]