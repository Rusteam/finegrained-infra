all: cvat mongodb mlflow

cvat: ./cvat docker-compose.cvat.yml
	@echo "Starting up CVAT"
	docker compose -f docker-compose.cvat.yml up -d

cvat_logs:
	@echo "CVAT logs"
	docker compose -f docker-compose.cvat.yml logs -f --tail=20

mongodb:
	@echo "Starting up MongoDB"
	docker compose -f docker-compose.mongodb.yml up -d

mlflow: ./mlflow docker-compose.mlflow.yml
	@echo "Starting up MLflow"
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker compose -f docker-compose.mlflow.yml up -d

mlflow_logs:
	@echo "MLflow logs"
	docker compose -f docker-compose.mlflow.yml logs -f --tail=20 mlflow

https:
	@echo "Starting a https reverse proxy"
	docker compose -f docker-compose.https.yml \
				   -f docker-compose.mlflow.yml \
				   -f docker-compose.cvat.yml up -d https

https_logs:
	@echo "Starting a https reverse proxy"
	docker compose -f docker-compose.https.yml \
				   -f docker-compose.mlflow.yml \
				   -f docker-compose.cvat.yml logs -f --tail=20 https

mlflow_build:
	@echo "Starting up MLflow"
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker compose -f docker-compose.mlflow.yml build

mlflow_upload:
	@echo "Uploading MLflow docker image"
	docker save -o fg-mlflow.tar finegrained/mlflow:0.1
	bzip2 -f fg-mlflow.tar
	rsync -avP fg-mlflow.tar.bz2 $(CLOUD):~/

down:
	@echo "Stopping all services"
	docker compose -f docker-compose.https.yml \
				   -f docker-compose.mlflow.yml \
				   -f docker-compose.cvat.yml \
				   -f docker-compose.mongodb.yml \
					down

include .env

sync:
	@echo "Syncing files to the cloud"
	rsync -avP --delete \
 				docker-compose.mongodb.yml \
				docker-compose.cvat.yml cvat \
				docker-compose.mlflow.yml \
				docker-compose.https.yml \
				Makefile $(CLOUD):~/

launch:
	@echo "Logging in and starting up services"
	ssh -t $(CLOUD) 'make'