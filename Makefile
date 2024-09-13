# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/09/13 18:31:36 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : up

# -f : Specify the target when docker-compose is in another location
# -d : Run in detached mode.
up:
	@docker compose -f srcs/docker-compose.yml up --build -d

down:
	@docker compose -f srcs/docker-compose.yml down

re: clean up

clean:
    @containers=$$(docker ps -qa); \ # Checks if there is something to stop
    if [ -n "$$containers" ]; then \
        docker stop $$containers; \
        docker rm $$containers; \
    fi
    @images=$$(docker images -qa); \
    if [ -n "$$images" ]; then \
        docker rmi -f $$images; \
    fi
    @volumes=$$(docker volume ls -q); \
    if [ -n "$$volumes" ]; then \
        docker volume rm $$volumes; \
    fi
    @networks=$$(docker network ls -q); \
    if [ -n "$$networks" ]; then \
        docker network rm $$networks; \
    fi
	@docker system prune --force;

.PHONY: up down re clean