#!/bin/bash

# Define variables
dockerContainerName="sql_server_container"
dockerImage="mcr.microsoft.com/mssql/server"
dockerImageTag="2019-latest"
# El usuario por defecto es "sa"
saPassword="Password123"  # Contraseña
sqlServerPort="1433"

# Si el contenedor ya existe, lo arrancamos
if docker ps -a --format '{{.Names}}' | grep -Eq "^${dockerContainerName}$"; then
    echo "Arrancando contenedor existente..."
    docker start $dockerContainerName
else
    # Si no existe, lo creamos y arrancamos
    echo "Creando y corriendo el nuevo contenedor..."
    docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$saPassword" \
        --name $dockerContainerName -p $sqlServerPort:1433 \
        -d $dockerImage:$dockerImageTag
fi

# Espero un segundo para que se inicie el contenedor
echo "Esperando que arranque SQL server..."
sleep 1

# Chequeo si está corriendo
if docker ps --format '{{.Names}}' | grep -Eq "^${dockerContainerName}$"; then
    echo "SQL Server is running on port $sqlServerPort."
else
    echo "Failed to start SQL Server container."
fi
