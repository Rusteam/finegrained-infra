all: cvat mongodb mlflow

cvat:
	@echo "Starting up CVAT"
	docker compose -f docker-compose.cvat.yml up -d

mongodb:
	@echo "Starting up MongoDB"
	docker compose -f docker-compose.mongodb.yml up -d

mlflow:
	@echo "Starting up MLflow"
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker compose -f mlflow/docker-compose.yml --env-file mlflow/.env up -d

mlflow_build:
	@echo "Starting up MLflow"
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker compose -f mlflow/docker-compose.yml --env-file mlflow/.env up -d --build

include .env

sync:
	@echo "Syncing files to the cloud"
	rsync -avP mlflow docker-compose.mongodb.yml docker-compose.cvat.yml Makefile .env $(CLOUD):~/

run:
	@echo "Logging in and starting up services"
	ssh -t $(CLOUD) 'make'