all: cvat mongodb mlflow

cvat:
	@echo "Starting up CVAT"
	docker compose -f cvat/docker-compose.yml up -d

mongodb:
	@echo "Starting up MongoDB"
	docker compose -f docker-compose.mongodb.yml up -d

mlflow:
	@echo "Starting up MLflow"
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker compose -f mlflow/docker-compose.yml --env-file mlflow/.env up -d

include .env

sync:
	@echo "Syncing files to the cloud"
	rsync -avP cvat mlflow docker-compose.mongodb.yml Makefile .env $(CLOUD):~/

run:
	@echo "Logging in and starting up services"
	ssh -t $(CLOUD) 'make'