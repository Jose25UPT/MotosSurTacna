# Dockerfile para base de datos MySQL
FROM mysql:8.0

ENV MYSQL_DATABASE=tienda_motos
ENV MYSQL_ROOT_PASSWORD=root

COPY tienda_motos.sql /docker-entrypoint-initdb.d/
