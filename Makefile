# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/12/22 14:55:27 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: create_volume
	@sudo apt-get -y install hostsed > /dev/null
	@sudo hostsed add 127.0.0.1 flverge.42.fr > /dev/null
	@echo "\033[1;32m***| ADD flverge.42.fr to /etc/hosts |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml up --build -d

up: create_volume
	@sudo hostsed add 127.0.0.1 flverge.42.fr > /dev/null
	@echo "\033[1;32m***| ADD flverge.42.fr to /etc/hosts |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml up --detach

down:
	@sudo hostsed rm 127.0.0.1 flverge.42.fr > /dev/null
	@echo "\033[1;31m***| DELETE flverge.42.fr from /etc/hosts |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml down

du: down up

re: clean all

prod: down delete_volume up

# TOUT FAIRE PETER
clean: down delete_volume
	@docker system prune --all --force
	@echo "\033[1;32m***| FULL DOCKER CLEANED |***\033[0m\n"

create_volume:
	@echo "\033[1;33m***| Creating Volumes |***\033[0m\n"
	@mkdir -p /home/${USER}/data/mariadb
	@mkdir -p /home/${USER}/data/wordpress
	@echo "\033[1;32m***| Volumes Created |***\033[0m\n"

delete_volume:
	@echo "\033[1;33m***| Deleting volumes |***\033[0m\n"
	@sudo rm -rf /home/${USER}/data/mariadb
	@sudo rm -rf /home/${USER}/data/wordpress
	@echo "\033[1;31m***| Volumes Deteted |***\033[0m\n"

.PHONY : all up down du re prod clean create_volume delete_volume