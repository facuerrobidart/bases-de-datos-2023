-- Insertar 200 filas de datos de ejemplo en la tabla personal
DECLARE @ContadorPersonal INT = 1

WHILE @ContadorPersonal <= 200
BEGIN
    -- Generar nombres y apellidos aleatorios
    DECLARE @Nombre VARCHAR(100)
    SET @Nombre = 'Nombre' + CAST(@ContadorPersonal AS VARCHAR)

    DECLARE @Apellido VARCHAR(100)
    SET @Apellido = 'Apellido' + CAST(@ContadorPersonal AS VARCHAR)

    DECLARE @DNI VARCHAR(10)
    SET @DNI = CAST(10000000 + CAST(RAND() * (40000000 - 10000000) AS INT) AS VARCHAR(10)) -- Hasta 40 millones

    -- Generar un género aleatorio ('M' o 'F')
    DECLARE @Genero CHAR(1)
    SET @Genero = CASE WHEN RAND() > 0.5 THEN 'M' ELSE 'F' END

    -- Generar una fecha de nacimiento aleatoria en un rango específico
    DECLARE @FechaNacimiento DATE
    SET @FechaNacimiento = DATEADD(DAY, -CAST(RAND() * 365 * 50 AS INT), GETDATE())

    -- Generar una contraseña aleatoria (simplemente para ejemplo, en una aplicación real, debería ser manejada de manera segura)
    DECLARE @Contrasena VARCHAR(100)
    SET @Contrasena = 'Password' + CAST(@ContadorPersonal AS VARCHAR)

    -- Generar una huella (texto aleatorio)
    DECLARE @Huella VARCHAR(MAX)
    SET @Huella = 'Huella' + CAST(@ContadorPersonal AS VARCHAR)

    -- Insertar la fila en la tabla personal
    INSERT INTO personal (id_personal, nombre, apellido, dni, genero, fecha_nacimiento, contraseña, huella)
    VALUES (@ContadorPersonal, @Nombre, @Apellido, @DNI, @Genero, @FechaNacimiento, @Contrasena, @Huella)

    -- Incrementar el contador
    SET @ContadorPersonal = @ContadorPersonal + 1
END;
