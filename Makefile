# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/09/23 09:47:18 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: up down re clean

all : up

# -f : Specify the target when docker-compose is in another location
# -d : Run in detached mode.
up: create_volume
	@docker compose -f srcs/docker-compose.yml up --build

down:
	@docker compose -f srcs/docker-compose.yml down

re: clean up

# faire peter les networks
clean: down delete_volume
	@docker system prune --all --force

prod: down up
	

create_volume:
	@echo "Creating MariaDB volume"
	@mkdir -p /home/${USER}/data/mysql
	@echo "Creating wordpress volume"
	@mkdir -p /home/${USER}/data/wordpress

delete_volume:
	@echo "Deleting volumes"
	@sudo rm -rf /home/${USER}/data/mysql
	@sudo rm -rf /home/${USER}/data/wordpress
	@echo "Volumes deteted"
	