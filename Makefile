
RM_ORPHANS = --remove-orphans
BASH = /bin/bash
FILE = -f ./srcs/docker-compose.yml

.PHONY: up
up:
	docker compose $(FILE) up

.PHONY: down
down:
	docker compose $(FILE) down
	
.PHONY: run
run: up $(RM_ORPHANS)

.PHONY: delete_all
delete_all:
	down --rmi all --volumes $(RM_ORPHANS)

.PHONY restart
restart:
	down 
	up --build
