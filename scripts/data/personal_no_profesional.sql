
INSERT INTO personal_no_profesional (id_personal, id_nivel_seguridad)
SELECT
    id_personal,
    ABS(CHECKSUM(NEWID())) % 3 + 1 AS id_nivel_seguridad
FROM
    personal
WHERE
    id_personal BETWEEN 101 AND 150;

-- Los id_personal van del 101 al 150
-- El numero de seguridad va del 1 al 3