BEGIN TRANSACTION;
-- SI SE VAN A AGREGAR MÁS TABLAS ACÁ, POR FAVOR HACERLO EN EL ORDEN DEL ARCHIVO DEL MLR

IF OBJECT_ID('nivel_seguridad', 'U') IS NULL
CREATE TABLE nivel_seguridad(
    nivel INT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);
GO

IF OBJECT_ID('area', 'U') IS NULL
CREATE TABLE area(
    numero_area INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel INT NOT NULL,
    FOREIGN KEY (nivel) REFERENCES nivel_seguridad(nivel)
);
GO

IF OBJECT_ID('evento', 'U') IS NULL
CREATE TABLE evento(
    id_evento INT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    numero_area INT NOT NULL,
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
);
GO

IF OBJECT_ID('personal', 'U') IS NULL
CREATE TABLE personal(
    id_personal INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(10) NOT NULL,
    genero VARCHAR(1) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    huella TEXT NOT NULL,    
);
GO

IF OBJECT_ID('personal_jerarquico', 'U') IS NULL
CREATE TABLE personal_jerarquico(
    id_personal INT,
    numero_area INT,
    PRIMARY KEY (id_personal, numero_area),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
);
GO

IF OBJECT_ID('especialidad', 'U') IS NULL
CREATE TABLE especialidad(
    id_especialidad INT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);
GO

IF OBJECT_ID('personal_profesional', 'U') IS NULL
CREATE TABLE personal_profesional(
    id_personal INT PRIMARY KEY,
    id_especialidad INT,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);
GO

IF OBJECT_ID('personal_no_profesional', 'U') IS NULL
CREATE TABLE personal_no_profesional(
    id_personal INT,
    id_nivel_seguridad INT,
    PRIMARY KEY (id_personal, id_nivel_seguridad),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_nivel_seguridad) REFERENCES nivel_seguridad(nivel)
);
GO

IF OBJECT_ID('personal_profesional_permanente', 'U') IS NULL
CREATE TABLE personal_profesional_permanente(
    id_personal INT,
    numero_area INT,
    PRIMARY KEY (id_personal, numero_area),
    FOREIGN KEY (id_personal) REFERENCES personal_profesional(id_personal),
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
);
GO

IF OBJECT_ID('personal_profesional_contratado', 'U') IS NULL
CREATE TABLE personal_profesional_contratado(
    id_personal INT PRIMARY KEY,
    FOREIGN KEY (id_personal) REFERENCES personal_profesional(id_personal)
)
GO

IF OBJECT_ID('contrato_de_trabajo', 'U') IS NULL
CREATE TABLE contrato_de_trabajo(
    id_contrato INT PRIMARY KEY,
    tarea TEXT NOT NULL,
    periodo_inicio DATE NOT NULL,
    periodo_fin DATE NOT NULL
);
GO

IF OBJECT_ID('auditoria', 'U') IS NULL
CREATE TABLE auditoria(
    id_auditoria INT,
    fecha_hora TIMESTAMP NOT NULL,
    resultado VARCHAR(100) NOT NULL,
    id_contrato INT,
    id_personal INT,
    PRIMARY KEY (id_auditoria, id_contrato, id_personal),
    FOREIGN KEY (id_contrato) REFERENCES contrato_de_trabajo(id_contrato),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);
GO

IF OBJECT_ID('acepta', 'U') IS NULL
CREATE TABLE acepta(
    id_contrato INT,
    id_personal INT,
    numero_area INT NOT NULL,
    PRIMARY KEY (id_contrato, id_personal),
    FOREIGN KEY (id_contrato) REFERENCES contrato_de_trabajo(id_contrato),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
)
GO


IF OBJECT_ID('bajo_contrato_en', 'U') IS NULL
CREATE TABLE bajo_contrato_en(
    id_contrato INT,
    id_personal INT,
    numero_area INT,
    PRIMARY KEY (id_contrato, id_personal, numero_area),
    FOREIGN KEY (id_contrato) REFERENCES contrato_de_trabajo(id_contrato),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
)
GO

IF OBJECT_ID('franja_horaria', 'U') IS NULL
CREATE TABLE franja_horaria(
    id_franja INT PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
)
GO

IF OBJECT_ID('cumple', 'U') IS NULL
CREATE TABLE cumple(
    id_franja INT,
    id_personal INT,
    numero_area INT NOT NULL,
    PRIMARY KEY (id_franja, id_personal),
    FOREIGN KEY (id_franja) REFERENCES franja_horaria(id_franja),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
)
GO

IF OBJECT_ID('es_accedida', 'U') IS NULL
CREATE TABLE es_accedida(
    fecha_hora TIMESTAMP,
    -- true si la autenticacion es correcta, false si no
    es_autorizado BIT NOT NULL,
    -- true si es ingreso, false si es egreso
    ingreso_o_egreso BIT NOT NULL,
    estado_lector VARCHAR(100) NOT NULL,
    metodo_de_acceso VARCHAR(100) NOT NULL,
    numero_area INT,
    id_personal INT,
    PRIMARY KEY (fecha_hora, numero_area, id_personal),
    FOREIGN KEY (numero_area) REFERENCES area(numero_area),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
)
GO

COMMIT TRANSACTION;