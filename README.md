# Fine-grained infrastructure 

Tools and services to help with data prep and model training.

Current deployment includes:
- [CVAT](https://github.com/opencv/cvat) for data annotation.
- [MongoDB](https://www.mongodb.com/compatibility/docker) for storing data related to [FiftyOne](https://voxel51.com/docs/).
- [MLflow](https://mlflow.org/) to keep track of experiments and model registry. 

## Usage

### Setup

**Pre-reqs:**
- docker and docker-compose

**Change environment variables:**
1. Update mongodb and ssh connection (if deployed to an ssh server) inside `.env.example`. Rename it to `.env`.
2. Update MLflow S3 connection and postgres details inside `mlflow/.env.example`. Rename it to `mlflow/.env`.

### Run

**all services:** `make`

**single service:** `make -B <service>`

services: cvat, mongodb, mlflow.

#### MLflow postgres setup

To create a database for mlflow service in postgres run the following commands:
1. Log in to postgres docker: `docker exec -it fg-mlflow-db bash`
2. Log in to postgres db: `psql -U postgres -d postgres`
3. Run SQL commands to create a db and a user:
```sql
create role <user> with password '<password>';
create database <database>;
grant all priviliges on database <database> to <user>;
alter role <user> with login;
```
