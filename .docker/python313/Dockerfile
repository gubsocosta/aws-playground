FROM python:3.13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r appuser && useradd -r -g appuser appuser

RUN pip install --no-cache-dir --upgrade \
    pip \
    setuptools \
    wheel

RUN pip install --no-cache-dir \
    chalice==1.32.0 \
    boto3==1.42.25 \
    python-dotenv==1.2.1

RUN mkdir -p /app && chown -R appuser:appuser /app

USER appuser

EXPOSE 8000

CMD ["tail", "-f", "/dev/null"]