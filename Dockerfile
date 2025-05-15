# Usa la imagen oficial de PostgreSQL
FROM postgres:17.4

# Copia tu archivo de backup.sql al contenedor
COPY backup.sql /docker-entrypoint-initdb.d/

# Variables de entorno
ENV POSTGRES_DB=oftalcrm
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=admin123
