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
1. Update all env variables inside `.env.example`.
2. Rename it to `.env`.

### Run

**all services:** `make`

**single service:** `make -B <service>`

services: 
- cvat
- mongodb
- mlflow
- https-proxy - for https support and reverse proxy. 
MLflow can be accessed at `https://mlflow.<domain_name>` and CVAT at `https://cvat.<domain_name>`.
Domain name is defined in `.env` file.

**stream logs:** `make <service>_logs`

**stop all**: `make down`

### To deploy on a remote server

1. Make sure remote server connection is setup in `~/.ssh/config`.
2. Provide remote server name in `.env` file.
3. Upload built mlflow image to remote server: `make mlflow_upload`.
4. Upload files on the remote server `make sync`.
5. Either log in to the server and run `make` or run `make launch` locally.