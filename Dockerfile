FROM bitnami/jasperreports:latest

WORKDIR /app

RUN docker run \ -e ALLOW_EMPTY_PASSWORD=yes \ -v /path/to/mysql-persistence:/bitnami/mysql/data \ bitnami/mysql:latest