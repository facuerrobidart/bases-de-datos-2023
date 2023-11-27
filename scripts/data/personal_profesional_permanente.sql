-- Personal_profesional_permanente.numero_area tiene que estar en Area.numero_area
-- Area.numero_area debe estar en Personal_profesional_permanente.numero_area

INSERT INTO personal_profesional_permanente (id_personal, numero_area)
SELECT
    id_personal,
    ABS(CHECKSUM(NEWID())) % 15 + 1 AS numero_area
FROM
    personal
WHERE
    id_personal BETWEEN 11 AND 50;

-- Los Personal_profesional_permanente van del 11 al 50
