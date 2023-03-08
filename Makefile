
RM_ORPHANS = --remove-orphans
BASH = /bin/bash
FILE = -f ./srcs/docker-compose.yml

.PHONY: up
up:
	docker compose $(FILE) up

.PHONY: down
down:
	docker compose $(FILE) down
	
.PHONY: build
build:
	docker compose $(FILE) build
	
.PHONY: run
run: 
	docker compose $(FILE) up --build $(RM_ORPHANS)

.PHONY: clean
clean:
	docker compose $(FILE) down --rmi all --volumes $(RM_ORPHANS)

.PHONY: restart
restart: down build up
