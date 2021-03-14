DOCKER_BRIDGE_HOST_IP := $(shell docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}')
DOCKER_COMPOSE_VARS   := DOCKER_BRIDGE_HOST_IP=$(DOCKER_BRIDGE_HOST_IP)

.SILENT: hello
hello:
	echo Welcome to Weather Backend make system!

# Start the container, keep stdout attached
start:
	$(DOCKER_COMPOSE_VARS) docker-compose up --abort-on-container-exit

# Rebuild containers without cache
cc:
	$(DOCKER_COMPOSE_VARS) docker-compose build --no-cache

# Rebuild and run the container, keep stdout attached
restart:
	$(DOCKER_COMPOSE_VARS) docker-compose up --force-recreate --build --abort-on-container-exit

# Start the container, detach stdout
up:
	$(DOCKER_COMPOSE_VARS) docker-compose up -d

# Rebuild and run the container, detach stdout
rebuild:
	$(DOCKER_COMPOSE_VARS) docker-compose up -d --force-recreate --build

# Stop and remove containers
down:
	$(DOCKER_COMPOSE_VARS) docker-compose down

reset: down rebuild

bash-root:
	$(DOCKER_COMPOSE_VARS) docker-compose exec web /bin/bash

bash-root-run:
	$(DOCKER_COMPOSE_VARS) docker-compose run web /bin/bash

bash-python:
	$(DOCKER_COMPOSE_VARS) docker-compose exec --user=python web /bin/bash

bash-python-run:
	$(DOCKER_COMPOSE_VARS) docker-compose run --user=python web /bin/bash
