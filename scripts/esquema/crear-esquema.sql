-- SI SE VAN A AGREGAR MÁS TABLAS ACÁ, POR FAVOR HACERLO EN EL ORDEN DEL ARCHIVO DEL MLR

CREATE TABLE IF NOT EXISTS nivel_seguridad(
    nivel SERIAL PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS area(
    numero_area SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel INT NOT NULL,
    FOREIGN KEY (nivel) REFERENCES nivel_seguridad(nivel)
);

CREATE TABLE IF NOT EXISTS evento(
    id_evento SERIAL PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    id_area INT NOT NULL,
    FOREIGN KEY (id_area) REFERENCES area(id_area)
);

CREATE TABLE IF NOT EXISTS personal(
    id_personal SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(10) NOT NULL,
    genero VARCHAR(1) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    huella TEXT NOT NULL,    
);

CREATE TABLE IF NOT EXISTS personal_jerarquico(
    id_personal INT PRIMARY KEY,
    numero_area INT PRIMARY KEY,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
);

CREATE TABLE IF NOT EXISTS especialidad(
    id_especialidad SERIAL PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS personal_profesional(
    id_personal INT PRIMARY KEY,
    id_especialidad INT PRIMARY KEY,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE IF NOT EXISTS personal_no_profesional(
    id_personal INT PRIMARY KEY,
    id_nivel_seguridad INT PRIMARY KEY,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    FOREIGN KEY (id_nivel_seguridad) REFERENCES nivel_seguridad(nivel)
);

CREATE TABLE IF NOT EXISTS personal_profesional_permanente(
    id_personal INT PRIMARY KEY,
    numero_area INT PRIMARY KEY,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    FOREIGN KEY (numero_area) REFERENCES area(numero_area)
);

CREATE TABLE IF NOT EXISTS personal_profesional_contratado(
    id_personal INT PRIMARY KEY,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
)

CREATE TABLE IF NOT EXISTS contrato_de_trabajo(
    id_contrato INT PRIMARY KEY,
    tarea TEXT NOT NULL,
    periodo_inicio DATE NOT NULL,
    periodo_fin DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS auditoria(
    id_auditoria SERIAL PRIMARY KEY,
    fecha_hora TIMESTAMP NOT NULL,
    resultado VARCHAR(100) NOT NULL,
    id_contrato INT PRIMARY KEY,
    id_personal INT PRIMARY KEY,
    FOREIGN KEY (id_contrato) REFERENCES contrato_de_trabajo(id_contrato),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);

