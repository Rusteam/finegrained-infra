all: cvat mongodb

cvat:
	@echo "Starting up CVAT"
	docker compose -f cvat/docker-compose.yml up -d

mongodb:
	@echo "Starting up MongoDB"
	docker compose -f docker-compose.mongodb.yml up -d

include .env

sync:
	@echo "Syncing files to the cloud"
	rsync -avP cvat docker-compose.mongodb.yml Makefile .env $(CLOUD):~/

run:
	@echo "Logging in and starting up services"
	ssh -t $(CLOUD) 'make'