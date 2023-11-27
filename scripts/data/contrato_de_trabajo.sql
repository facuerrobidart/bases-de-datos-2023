-- Es necesario llevar registro del área para la cual fue contratado el profesional, la tarea
-- a realizar y el período de contrato. Ocasionalmente, sobre algunos de estos trabajos se realizan
-- auditorías, siendo necesario registrar fecha y hora de la misma y su resultado

-- auditoria.id_contrato tiene que estar en Contrato_de_trabajo.id_contrato
-- Contrato_de_trabajo.id_contrato tiene que estar auditoria.id_contrato


DECLARE @FechaInicio DATETIME = '2023-01-01';
DECLARE @FechaFin DATETIME = '2023-11-25';
DECLARE @DiasDiferencia INT = DATEDIFF(DAY, @FechaInicio, @FechaFin);
DECLARE @Contador INT = 1;

WHILE @Contador <= 40
BEGIN
    DECLARE @FechaHoraEvento DATETIME = DATEADD(SECOND, RAND() * @DiasDiferencia * 24 * 60 * 60, @FechaInicio);
    DECLARE @IdArea INT = CAST(RAND() * 15 + 1 AS INT);
    DECLARE @DescripcionEvento VARCHAR(100) = 'Descripción del evento #' + CAST(@Contador AS VARCHAR) + ' en el área ' + CAST(@IdArea AS VARCHAR);

    INSERT INTO contrato_de_trabajo (id_contrato, tarea, periodo_inicio, periodo_fin) 
    VALUES (@Contador, @DescripcionEvento, @FechaHoraEvento, DATEADD(MONTH, 3, @FechaHoraEvento));

    SET @Contador = @Contador + 1;
END;

-- Hay 40 contratos
