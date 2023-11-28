SELECT
  p.id_personal,
  p.dni,
  p.nombre,
  p.apellido,
  p.genero,
  p.fecha_nacimiento ,
  p.contraseña,
  p.huella
FROM
  Personal p
INNER JOIN
  Es_accedida e
ON
  p.id_personal = e.id_personal
INNER JOIN 
  personal_no_profesional pnp 
ON 
  p.id_personal = pnp.id_personal 
WHERE
  (
    (
      SELECT
        COUNT(*)
      FROM
        Es_accedida
      WHERE
        DATEDIFF(day, GETDATE() , e.[timestamp]) < 30
        AND e.id_personal = p.id_personal
        AND e.es_autorizado = 0
    ) > 5
  )
OR
  (
    SELECT
      COUNT(*)
    FROM
      Es_accedida
    WHERE
      DATEDIFF(day, GETDATE() , e.[timestamp]) < 30
      AND e.id_personal = p.id_personal
      AND e.numero_area IN
      (
        SELECT
          a.numero_area
        FROM
          Area a
        WHERE
          a.nivel > (
            SELECT
              pnp.id_nivel_seguridad
            FROM
              Personal p
            WHERE
              p.id_personal = e.id_personal
          )
      )
  ) > 0
