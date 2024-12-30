# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/12/30 07:28:24 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

check_env:
	@if [ ! -f srcs/.env ]; then \
		echo "Error : .env file not found, aborting Docker Build"; \
		exit 1; \
	fi

all: check_env create_volume
		
	@sudo apt-get -y install hostsed > /dev/null
	@sudo hostsed add 127.0.0.1 flverge.42.fr > /dev/null
	@echo "\n\033[1;32m***| ADD flverge.42.fr to /etc/hosts |***\033[0m\n"
	@echo "\n\033[1;33m***| BUILDING AND UP-ING CONTAINERS |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml up --build -d
	@echo "\n\033[1;32m***| CONTAINERS BUILT AND RUNNING |***\033[0m\n"

up: create_volume
	@echo "\n\033[1;33m***| UP-ING CONTAINERS |***\033[0m\n"
	@sudo hostsed add 127.0.0.1 flverge.42.fr > /dev/null
	@echo "\n\033[1;32m***| ADD flverge.42.fr to /etc/hosts |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml up --detach
	@echo "\n\033[1;32m***| CONTAINERS UP |***\033[0m\n"

down:
	@echo "\n\033[1;33m***| DOWNING CONTAINERS |***\033[0m\n"
	@sudo hostsed rm 127.0.0.1 flverge.42.fr > /dev/null
	@echo "\n\033[1;31m***| DELETE flverge.42.fr from /etc/hosts |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml down
	@echo "\n\033[1;32m***| CONTAINERS DOWN |***\033[0m\n"

du: check_env down up

stop:
	@echo "\n\033[1;33m***| STOPPING CONTAINERS |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml stop
	@echo "\n\033[1;32m***| CONTAINERS STOPPED |***\033[0m\n"

start:
	@echo "\n\033[1;33m***| STARTING CONTAINERS |***\033[0m\n"
	@docker compose -f srcs/docker-compose.yml start
	@echo "\n\033[1;32m***| CONTAINERS STARTED |***\033[0m\n"

restart: check_env stop start

re: check_env clean all

prod: check_env down delete_volume up

# TOUT FAIRE PETER
clean: down delete_volume
	@echo "\n\033[1;33m***| CLEANNING CONTAINERS |***\033[0m\n"
	@docker system prune --all --force
	@echo "\n\033[1;32m***| FULL DOCKER CLEANED |***\033[0m\n"

create_volume:
	@echo "\n\033[1;33m***| Creating Volumes |***\033[0m\n"
	@mkdir -p /home/${USER}/data/mariadb
	@mkdir -p /home/${USER}/data/wordpress
	@mkdir -p /home/${USER}/data/static_website_volume
	@echo "\n\033[1;32m***| Volumes Created |***\033[0m\n"

delete_volume:
	@echo "\n\033[1;33m***| Deleting volumes |***\033[0m\n"
	@sudo rm -rf /home/${USER}/data/mariadb
	@sudo rm -rf /home/${USER}/data/wordpress
	@sudo rm -rf /home/${USER}/data/static_website_volume
	@echo "\n\033[1;32m***| Volumes Deteted |***\033[0m\n"

.PHONY : all up down du re prod clean stop start restart create_volume delete_volume check_env