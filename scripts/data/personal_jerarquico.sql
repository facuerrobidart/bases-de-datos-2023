-- Personal_jerarquico.numero_area tiene que estar en Area.numero_area
-- Area.numero_area puede no estar en personal_jerarquico.numero_area
-- hay 15 areas en total del 1 al 15
-- hay id_empleado va del 1 al 100 incremental

INSERT INTO personal_jerarquico (id_personal, numero_area, fecha_de_inicio)
VALUES 
(1, 3, '2023-01-01'),
(2, 8, '2023-02-15'),
(3, 5, '2023-03-10'),
(4, 12, '2023-04-20'),
(5, 10, '2023-05-05'),
(6, 2, '2023-06-15'),
(7, 14, '2023-07-01'),
(8, 6, '2023-08-10'),
(9, 1, '2023-09-20'),
(10, 9, '2023-10-05');

-- Los 10 primeros ros de personal son jerarquicos de un area