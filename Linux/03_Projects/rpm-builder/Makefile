# Makefile
.PHONY: build run exec

# Name of the Docker image
IMAGE_NAME = rpm-builder

# Docker container name
CONTAINER_NAME = rpm-builder

build: clean
	docker build -t $(IMAGE_NAME) .

start:
	docker run -d --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	@if [ -n "`docker ps -q -f name=$(CONTAINER_NAME)`" ]; then \
		docker stop $(CONTAINER_NAME); \
	fi

exec:
	docker exec -it $(CONTAINER_NAME) /bin/bash

clean: stop
	@if [ -n "`docker ps -a -q -f name=$(CONTAINER_NAME)`" ]; then \
		docker rm $(CONTAINER_NAME); \
	fi;
	@if [ -n "`docker images -q $(IMAGE_NAME)`" ]; then \
		docker rmi $(IMAGE_NAME); \
	fi;
