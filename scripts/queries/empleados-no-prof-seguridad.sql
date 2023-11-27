CREATE PROCEDURE empleados_no_profesionales_seguridad_subqueries
AS
    SELECT p.nombre, p.apellido, p.id_personal
    FROM personal p
    -- Este join hace que solo se muestre personal no profesional
    INNER JOIN personal_no_profesional pnp ON p.id_personal = pnp.id_personal
    INNER JOIN nivel_seguridad ns ON pnp.id_nivel_seguridad = ns.nivel
    INNER JOIN cumple c ON p.id_personal = c.id_personal
    -- Este join hace que ambas listas sean iguales
    -- Entonces, solo se muestra el personal que trabaja en TODAS las areas de su nivel de seguridad
    WHERE (SELECT c.numero_area FROM cumple c WHERE c.id_personal = p.id_personal) IN 
        (SELECT numero_area FROM area a WHERE a.nivel_seguridad = ns.nivel)
    AND (SELECT numero_area FROM area a WHERE a.nivel_seguridad = ns.nivel) IN
        (SELECT c.numero_area FROM cumple c WHERE c.id_personal = p.id_personal)
GO;

-- Esta es una version alternativa que usa un join en lugar de subqueries, es mas eficiente

CREATE PROCEDURE empleados_no_profesionales_seguridad_join
AS
    SELECT p.nombre, p.apellido, p.id_personal
    FROM personal p
    INNER JOIN personal_no_profesional pnp ON p.id_personal = pnp.id_personal
    INNER JOIN nivel_seguridad ns ON pnp.id_nivel_seguridad = ns.nivel
    INNER JOIN cumple c ON p.id_personal = c.id_personal
    INNER JOIN area a1 ON a1.nivel = ns.nivel
    INNER JOIN area a2 ON a2.numero_area = c.numero_area AND a2.nivel = ns.nivel
    WHERE c.numero_area = a1.numero_area
GO;