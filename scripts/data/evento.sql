-- Insertar 100 filas de datos de ejemplo en la tabla evento
DECLARE @FechaInicio DATETIME = '2023-01-01';
DECLARE @FechaFin DATETIME = '2023-11-25';
DECLARE @DiasDiferencia INT;

-- Calcular la diferencia en días entre las fechas de inicio y fin
SET @DiasDiferencia = DATEDIFF(day, @FechaInicio, @FechaFin);

-- Variable para contar las iteraciones
DECLARE @Contador INT = 1;

WHILE @Contador <= 100
BEGIN
    -- Generar valores aleatorios para la fecha y hora dentro del rango especificado
    DECLARE @FechaHoraEvento DATETIME;
    SET @FechaHoraEvento = DATEADD(SECOND, RAND() * @DiasDiferencia * 24 * 60 * 60, @FechaInicio);

    -- Generar un ID de área aleatorio entre 1 y 15
    DECLARE @IdArea INT;
    SET @IdArea = CAST(RAND() * 15 + 1 AS INT);

    -- Generar una descripción aleatoria para el evento
    DECLARE @DescripcionEvento VARCHAR(100);
    SET @DescripcionEvento = 'Descripción del evento #' + CAST(@Contador AS VARCHAR) + ' en el área ' + CAST(@IdArea AS VARCHAR);

    -- Insertar la fila en la tabla evento
    INSERT INTO evento (id_evento, descripcion, fecha_hora, id_area) 
    VALUES (@Contador, @DescripcionEvento, @FechaHoraEvento, @IdArea);

    -- Incrementar el contador
    SET @Contador = @Contador + 1;
END;