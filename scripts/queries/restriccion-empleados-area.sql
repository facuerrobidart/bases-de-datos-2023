CREATE TRIGGER trigger_evitar_asignacion
ON cumple
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN personal_no_profesional p ON i.id_personal = p.id_personal
        JOIN area a ON i.numero_area = a.numero_area
        WHERE a.nivel > p.id_nivel_seguridad
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, 'No se puede asignar un área a un empleado si no está capacitado para el nivel de seguridad de ese área.', 1;
    END
END;