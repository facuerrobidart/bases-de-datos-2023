CREATE TRIGGER trigger_validar_es_accedida
ON es_accedida
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.metodo_de_acceso not in (
            "Huella",
            "Contraseña"
        )
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, 'El metodo de acceso debe ser Huella o Contraseña.', 1;
    END;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.ingreso_o_egreso not in (
            "Ingreso",
            "Egreso"
        )
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, 'El tipo de acceso debe ser Entrada o Salida.', 1;
    END;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.estado_lector_huellas = "Activo"
            AND i.metodo_de_acceso = "Contraseña"
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, 'El acceso por contraseña solo está disponible si el lector de huellas esta Inactivo', 1;
    END;
END;