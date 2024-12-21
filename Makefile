# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/12/21 14:46:34 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: up down re clean

all : up

# -f : Specify the target when docker-compose is in another location
# -d : Run in detached mode.
up: create_volume
	@sudo apt-get -y install hostsed
	@sudo hostsed add 127.0.0.1 flverge.42.fr && echo "\033[1;32m~|ADD flverge.42.fr to /etc/hosts|~\033[0m"
	@docker compose -f srcs/docker-compose.yml up --build -d

down:
	@sudo hostsed rm 127.0.0.1 flverge.42.fr && echo "\033[1;31m~|DELETE flverge.42.fr from /etc/hosts|~\033[0m"
	@docker compose -f srcs/docker-compose.yml down

re: clean up

# faire peter les networks
clean: down delete_volume
	@docker system prune --all --force

prod: down delete_volume create_volume up

create_volume:
	@echo "Creating MariaDB volume"
	@mkdir -p /home/${USER}/data/mariadb
	@echo "Creating wordpress volume"
	@mkdir -p /home/${USER}/data/wordpress

delete_volume:
	@echo "Deleting volumes"
	@sudo rm -rf /home/${USER}/data/mariadb
	@sudo rm -rf /home/${USER}/data/wordpress
	@echo "Volumes deteted"

.PHONY : all up down re cle prod create_volume delete_volume