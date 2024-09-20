# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/09/20 17:27:55 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: up down re clean

all : up

# -f : Specify the target when docker-compose is in another location
# -d : Run in detached mode.
up: create_volume
	@docker compose -f srcs/docker-compose.yml up --build -d

down:
	@docker compose -f srcs/docker-compose.yml down

re: clean up

clean: down delete_volume
	@docker system prune --all --force

create_volume:
	@echo "Creating MariaDB volume"
	@mkdir -p /home/flverge/data/mysql
	@echo "Creating wordpress volume"
	@mkdir -p /home/flverge/data/wordpress

delete_volume:
	@echo "Deleting volumes"
	@sudo rm -rf /home/flverge/data/mysql
	@sudo rm -rf /home/flverge/data/wordpress
	@echo "Volumes deteted"
	