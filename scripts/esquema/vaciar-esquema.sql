-- Desactivar la verificación de claves foráneas
EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

-- Eliminar las claves foráneas
DECLARE @sql NVARCHAR(MAX)

-- Inicializar la variable SQL
SET @sql = ''

-- Construir la lista de sentencias DROP CONSTRAINT para cada FK
SELECT @sql = @sql + 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(fk.parent_object_id)) + '.' + QUOTENAME(OBJECT_NAME(fk.parent_object_id)) + ' DROP CONSTRAINT ' + QUOTENAME(fk.name) + '' + CHAR(13) + CHAR(10)
FROM sys.foreign_keys AS fk

-- Ejecutar las sentencias
EXEC sp_executesql @sql

-- Eliminar las tablas
DROP TABLE IF EXISTS bajo_contrato_en, acepta, es_accedida, cumple, franja_horaria, nivel_seguridad, area, evento, personal, personal_jerarquico, especialidad, personal_profesional, personal_no_profesional, personal_profesional_permanente, personal_profesional_contratado, contrato_de_trabajo, auditoria

-- Activar la verificación de claves foráneas
EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'
