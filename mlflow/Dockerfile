FROM python:3.10.6-slim-bullseye

RUN pip install --no-cache mlflow==1.29.0 psycopg2-binary==2.9.3 boto3==1.24.66

CMD mlflow server \
      --host 0.0.0.0 \
      --port 5000 \
      --backend-store-uri postgresql://${PG_USER}:${PG_PASSWORD}@${PG_HOST}:5432/mlflow \
      --default-artifact-root ${DEFAULT_ARTIFACT_ROOT}