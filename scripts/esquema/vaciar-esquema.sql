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


-- Eliminar todos los stored procedures
DECLARE @procedureName NVARCHAR(MAX)
DECLARE curProcedure CURSOR FOR
SELECT [name] FROM sys.procedures

OPEN curProcedure
FETCH NEXT FROM curProcedure INTO @procedureName

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP PROCEDURE ' + @procedureName)
    FETCH NEXT FROM curProcedure INTO @procedureName
END

CLOSE curProcedure
DEALLOCATE curProcedure

-- Eliminar todas las vistas (views)
DECLARE @viewName NVARCHAR(MAX)
DECLARE curView CURSOR FOR
SELECT [name] FROM sys.views

OPEN curView
FETCH NEXT FROM curView INTO @viewName

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP VIEW ' + @viewName)
    FETCH NEXT FROM curView INTO @viewName
END

CLOSE curView
DEALLOCATE curView

-- Eliminar todos los triggers
DECLARE @triggerName NVARCHAR(MAX)
DECLARE curTrigger CURSOR FOR
SELECT [name] FROM sys.triggers

OPEN curTrigger
FETCH NEXT FROM curTrigger INTO @triggerName

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP TRIGGER ' + @triggerName)
    FETCH NEXT FROM curTrigger INTO @triggerName
END

CLOSE curTrigger
DEALLOCATE curTrigger