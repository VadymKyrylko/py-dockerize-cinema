FROM python:3.13-slim
LABEL maintainer="kirilkovadim193@gmail.com"

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /cinema

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    libjpeg62-turbo \
    zlib1g \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt psycopg2-binary

COPY . .


RUN mkdir -p /vol/web/static /vol/web/media \
    && adduser --disabled-password --no-create-home my_user \
    && chown -R my_user /vol \
    && chmod -R 755 /vol

USER my_user

EXPOSE 8000