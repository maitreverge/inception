# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flverge <flverge@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/13 18:18:52 by flverge           #+#    #+#              #
#    Updated: 2024/09/17 09:30:04 by flverge          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: up down re clean

all : up

# -f : Specify the target when docker-compose is in another location
# -d : Run in detached mode.
up:
	@docker compose -f srcs/docker-compose.yml up --build -d

down:
	@docker compose -f srcs/docker-compose.yml down

re: clean up

clean: down
	@docker system prune --all --force --volumes
	@echo "kill_inception.sh OVER"