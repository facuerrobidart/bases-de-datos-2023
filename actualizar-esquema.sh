#!/bin/bash

# Defino una variables con el nombre del contenedor
SQL_SERVER_CONTAINER_NAME="sql_server_container"

# Levanto la direccion ip del contenedor
SQL_SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $SQL_SERVER_CONTAINER_NAME)

# Credenciales de la base
SQL_SERVER_USERNAME="sa"
SQL_SERVER_PASSWORD="Password123"
SQL_SERVER_DATABASE="master"

# Armo los parametros de conexion
CONNECTION_STRING="-S $SQL_SERVER_IP -U $SQL_SERVER_USERNAME -P $SQL_SERVER_PASSWORD -d $SQL_SERVER_DATABASE"

# Mando el script al contenerdor y lo ejecuto
cat ./scripts/esquema/crear-esquema.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
