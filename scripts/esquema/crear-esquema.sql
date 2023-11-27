-- SI SE VAN A AGREGAR MÁS TABLAS ACÁ, POR FAVOR HACERLO EN EL ORDEN DEL ARCHIVO DEL MLR

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'nivel_seguridad')
BEGIN
    CREATE TABLE nivel_seguridad (
        nivel INT PRIMARY KEY,
        descripcion VARCHAR(100) NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'area')
BEGIN
    CREATE TABLE area (
        numero_area INT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        nivel INT NOT NULL,
        FOREIGN KEY (nivel) REFERENCES nivel_seguridad(nivel)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'evento')
BEGIN
    CREATE TABLE evento (
        id_evento INT PRIMARY KEY,
        descripcion VARCHAR(100) NOT NULL,
        fecha_hora DATETIME NOT NULL,
        id_area INT NOT NULL,
        FOREIGN KEY (id_area) REFERENCES area(numero_area)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'personal')
BEGIN
    CREATE TABLE personal (
        id_personal INT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        apellido VARCHAR(100) NOT NULL,
        dni VARCHAR(10) NOT NULL,
        genero CHAR(1) NOT NULL,
        fecha_nacimiento DATE NOT NULL,
        contraseña VARCHAR(100) NOT NULL,
        huella TEXT NOT NULL    
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'personal_jerarquico')
BEGIN
    CREATE TABLE personal_jerarquico (
        id_personal INT PRIMARY KEY,
        numero_area INT NOT NULL,  
        fecha_de_inicio DATE NOT NULL,
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
        FOREIGN KEY (numero_area) REFERENCES area(numero_area)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'especialidad')
BEGIN
    CREATE TABLE especialidad (
        id_especialidad INT PRIMARY KEY,
        descripcion VARCHAR(100) NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'personal_profesional')
BEGIN
    CREATE TABLE personal_profesional (
        id_personal INT PRIMARY KEY,
        id_especialidad INT,
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
        FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'personal_no_profesional')
BEGIN
    CREATE TABLE personal_no_profesional (
        id_personal INT PRIMARY KEY,
        id_nivel_seguridad INT,
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
        FOREIGN KEY (id_nivel_seguridad) REFERENCES nivel_seguridad(nivel)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'personal_profesional_permanente')
BEGIN
    CREATE TABLE personal_profesional_permanente (
        id_personal INT PRIMARY KEY,
        numero_area INT,
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
        FOREIGN KEY (numero_area) REFERENCES area(numero_area)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'personal_profesional_contratado')
BEGIN
    CREATE TABLE personal_profesional_contratado (
        id_personal INT PRIMARY KEY,
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'contrato_de_trabajo')
BEGIN
    CREATE TABLE contrato_de_trabajo (
        id_contrato INT PRIMARY KEY,
        tarea TEXT NOT NULL,
        periodo_inicio DATE NOT NULL,
        periodo_fin DATE NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'auditoria')
BEGIN
    CREATE TABLE auditoria (
        id_auditoria INT PRIMARY KEY,
        fecha_hora DATETIME NOT NULL,
        resultado VARCHAR(100) NOT NULL,
        id_contrato INT NOT NULL,
        id_personal INT NOT NULL,
        FOREIGN KEY (id_contrato) REFERENCES contrato_de_trabajo(id_contrato),
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'bajo_contrato_en')
BEGIN
    CREATE TABLE bajo_contrato_en (
        id_contrato INT,
        id_personal INT,
        numero_area INT,
        PRIMARY KEY (id_contrato, id_personal, numero_area),
        FOREIGN KEY (id_contrato) REFERENCES contrato_de_trabajo(id_contrato),
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    );
END;


IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'franja_horaria')
BEGIN
    CREATE TABLE franja_horaria (
        id_franja INT PRIMARY KEY,
        hora_inicio TIME NOT NULL,
        hora_fin TIME NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'cumple')
BEGIN
    CREATE TABLE cumple (
        id_personal INT,
        id_franja INT,
        numero_area INT,
        PRIMARY KEY (id_personal, id_franja),
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
        FOREIGN KEY (id_franja) REFERENCES franja_horaria(id_franja),
        FOREIGN KEY (numero_area) REFERENCES area(numero_area)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'es_accedida')
BEGIN
    CREATE TABLE es_accedida (
        timestamp DATETIME NOT NULL,
        id_personal INT NOT NULL,
        numero_area INT NOT NULL,
        metodo_de_acceso VARCHAR(100) NOT NULL,
        estado_lector_huellas VARCHAR(20) NOT NULL,
        ingreso_o_egreso VARCHAR(20) NOT NULL,
        es_autorizado BIT NOT NULL,
        PRIMARY KEY (timestamp, id_personal, numero_area),
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
        FOREIGN KEY (numero_area) REFERENCES area(numero_area)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'acepta')
BEGIN
    CREATE TABLE acepta (
        id_personal INT NOT NULL,
        id_contrato INT NOT NULL,
        numero_area INT NOT NULL,
        PRIMARY KEY (id_personal, id_contrato),
        FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
        FOREIGN KEY (id_contrato) REFERENCES contrato_de_trabajo(id_contrato),
        FOREIGN KEY (numero_area) REFERENCES area(numero_area)
    );
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'trabajan')
BEGIN
    CREATE TABLE trabajan (
        id_personal_no_profesional INT NOT NULL,
        id_franja INT NOT NULL,
        numero_area INT NOT NULL,
        PRIMARY KEY (id_personal_no_profesional, id_franja, numero_area),
        FOREIGN KEY (id_personal_no_profesional) REFERENCES personal_no_profesional(id_personal),
        FOREIGN KEY (id_franja) REFERENCES franja_horaria(id_franja),
        FOREIGN KEY (numero_area) REFERENCES area(numero_area)
    );
END;