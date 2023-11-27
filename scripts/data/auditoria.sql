-- Declaración de variables
DECLARE @ContadorAuditoria INT = 1;

-- Bucle WHILE para generar datos de auditoría
WHILE @ContadorAuditoria <= 100
BEGIN
    -- Generar datos aleatorios
    DECLARE @FechaHoraAuditoria DATETIME = GETDATE();
    DECLARE @ResultadoAuditoria VARCHAR(100);
    DECLARE @IdContratoAuditoria INT;
    DECLARE @IdPersonalAuditoria INT;

    -- Asignar un resultado aleatorio
    SET @ResultadoAuditoria = CASE WHEN RAND() > 0.5 THEN 'Aprobado' ELSE 'Rechazado' END;

    -- Asignar un id_contrato y id_personal aleatorios
    SET @IdContratoAuditoria = CAST(RAND() * 40 + 1 AS INT);
    SET @IdPersonalAuditoria = CAST(RAND() * 40 + 51 AS INT);

    -- Insertar datos en la tabla auditoria
    INSERT INTO auditoria (id_auditoria, fecha_hora, resultado, id_contrato, id_personal)
    VALUES (@ContadorAuditoria, @FechaHoraAuditoria, @ResultadoAuditoria, @IdContratoAuditoria, @IdPersonalAuditoria);

    -- Incrementar el contador
    SET @ContadorAuditoria = @ContadorAuditoria + 1;
END;


-- los id_personal van del 51 al 90
-- los id_contrato van del 1 al 40
-- se pueden hacer varias auditorias sobre un mismo id de contrato