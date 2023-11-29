-- Declaración de variables
DECLARE @ContadorAcceso INT = 1;

-- Bucle WHILE para generar datos de acceso
WHILE @ContadorAcceso <= 500
BEGIN
    -- Generar datos aleatorios
    DECLARE @FechaHoraAcceso DATETIME = DATEADD(SECOND, -RAND() * 86400, GETDATE()); -- Entre hoy y el pasado
    DECLARE @IdPersonalAcceso INT = CAST(RAND() * 150 + 1 AS INT);
    DECLARE @NumeroAreaAcceso INT = CAST(RAND() * 15 + 1 AS INT);
    DECLARE @MetodoDeAcceso VARCHAR(100) = CASE WHEN RAND() > 0.5 THEN 'Contraseña' ELSE 'Huella' END;
    DECLARE @EstadoLectorHuellas VARCHAR(20) = CASE WHEN @MetodoDeAcceso = 'Huella' THEN 'Activo' ELSE 'Inactivo' END;
    DECLARE @IngresoOEgreso VARCHAR(20) = CASE WHEN RAND() > 0.5 THEN 'Ingreso' ELSE 'Egreso' END;
    DECLARE @EsAutorizado BIT = CAST(CASE WHEN RAND() > 0.2 THEN 1 ELSE 0 END AS BIT); -- 80% de probabilidad de ser autorizado

    -- Verificar que id_personal no esté en el rango del 91 al 100
    WHILE @IdPersonalAcceso BETWEEN 91 AND 100
    BEGIN
        SET @IdPersonalAcceso = CAST(RAND() * 150 + 1 AS INT);
    END;

    -- Insertar datos en la tabla es_accedida
    INSERT INTO es_accedida (timestamp, id_personal, numero_area, metodo_de_acceso, estado_lector_huellas, ingreso_o_egreso, es_autorizado)
    VALUES (@FechaHoraAcceso, @IdPersonalAcceso, @NumeroAreaAcceso, @MetodoDeAcceso, @EstadoLectorHuellas, @IngresoOEgreso, @EsAutorizado);

    -- Incrementar el contador
    SET @ContadorAcceso = @ContadorAcceso + 1;
END;


-- id_personal puede ser un valor entre 1 al 150, menos los numeros del 91 al 100
-- el numero de area va del 1 al  15 
-- el timestamp no puede ser en un futuro, siempre de hoy para atras