--Mediante una vista obtener los empleados que en el día de la fecha han realizado algún 
--intento de ingreso fallido a un área sin contar con un ingreso exitoso posterior para la 
--misma. Incluir el área donde intento ingresar en las columnas que devuelve la vista. 

CREATE VIEW vista_intentos_fallidos_con_personal AS
SELECT 
    ea.timestamp,
    ea.numero_area,
    p.id_personal,
    p.nombre,
    p.apellido
FROM 
   	es_accedida ea 
INNER JOIN personal p
    ON ea.id_personal = p.id_personal
LEFT JOIN es_accedida ea_exitoso --Debo renombrar para poder comparar con si misma
    ON ea.id_personal = ea_exitoso.id_personal
    AND ea.numero_area = ea_exitoso.numero_area
    AND ea.timestamp < ea_exitoso.timestamp
WHERE 
    ea.ingreso_o_egreso = 'Ingreso' -- Aca filtro solo los intentos de ingreso
    AND ea.es_autorizado = 0 -- Aca filtro  los intentos fallidos
    AND ea_exitoso.timestamp IS NULL -- Aca saco los intentos fallidos que no tienen un ingreso exitoso posterior
    AND CAST(ea.timestamp AS DATE) = CAST(GETDATE() AS DATE); -- Aca filtro por la fecha de hoy