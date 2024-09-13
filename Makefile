# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/09/13 18:19:13 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : up

up:
	docker compose -f srcs/requirements

down:
	docker compose down

re: clean up

clean: down
	docker compose down;
	docker stop $(docker ps -qa);
	docker rm $(docker ps -qa);
	docker rmi -f $(docker images -qa);
	docker volume rm $(docker volume ls -q);
	docker system prune --force;
	docker network rm $(docker network ls -q)

.PHONY: up down re clean