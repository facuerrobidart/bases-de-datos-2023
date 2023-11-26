-- los empleados van del 11 al 100 inclusive
-- id_especialidad va del 1 al 10
-- Especialidad.id_especialidad debe estar en Personal_profesional.id_especialidad
-- Personal_profesional.id_especialidad debe estar en Especialidad.id_especialidad

DECLARE @Contador INT = 11;  -- Comenzamos desde el empleado número 11

WHILE @Contador <= 100
BEGIN
    -- Generar un ID de especialidad aleatorio entre 1 y 10
    DECLARE @IdEspecialidad INT;
    SET @IdEspecialidad = CAST(RAND() * 10 + 1 AS INT);

    -- Insertar la fila en la tabla personal_profesional
    INSERT INTO personal_profesional (id_personal, id_especialidad)
    VALUES (@Contador, @IdEspecialidad);

    -- Incrementar el contador
    SET @Contador = @Contador + 1;
END;