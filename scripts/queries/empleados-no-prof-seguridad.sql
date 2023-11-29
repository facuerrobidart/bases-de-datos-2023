-- Esta es una version alternativa que usa un join en lugar de subqueries, es mas eficiente

CREATE PROCEDURE empleados_no_profesionales_seguridad_join
AS
    SELECT DISTINCT  p.nombre, p.apellido, p.id_personal
    FROM personal p
    --Filtra solo personal no profesional
    INNER JOIN personal_no_profesional pnp ON p.id_personal = pnp.id_personal
    INNER JOIN nivel_seguridad ns ON pnp.id_nivel_seguridad = ns.nivel
    INNER JOIN cumple c ON p.id_personal = c.id_personal
    --Hago join con las areas que tienen el mismo nivel
    INNER JOIN area a1 ON a1.nivel = ns.nivel
    --Y de nuevo para validar que sean las miasmas que en el cumple
    INNER JOIN area a2 ON a2.numero_area = c.numero_area AND a2.nivel = ns.nivel
    WHERE c.numero_area = a1.numero_area
GO;