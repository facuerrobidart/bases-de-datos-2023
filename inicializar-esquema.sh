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

echo "Vaciando esquema..."
cat ./scripts/esquema/vaciar-esquema.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING

echo "Creando tablas..."
cat ./scripts/esquema/crear-esquema.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING

# echo "Aplicando cambios al esquema..."
cat ./scripts/data/nivel_seguridad.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/area.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/evento.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/personal.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/personal_jerarquico.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/especialidad.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/personal_profesional.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/personal_no_profesional.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/personal_profesional_permanente.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/personal_profesional_contratado.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/contrato_de_trabajo.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/auditoria.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
# cat ./scripts/data/bajo_contrato_en.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING              -->   falta desarrollar todavia
cat ./scripts/data/franja_horaria.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/cumple.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/data/es_accedida.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING

cat ./scripts/queries/empleados_5_fallas_o_area__no_permitida.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/queries/empleados-no-prof-seguridad.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/queries/vista_entradas_fallidas.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING
cat ./scripts/queries/restriccion-empleados-area.sql | docker exec -i $SQL_SERVER_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd $CONNECTION_STRING

echo "Exito"
