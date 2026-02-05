# Eliminar base de datos en caso de existir
DROP DATABASE IF EXISTS Universidad;

# Creacion de la base de datos
CREATE DATABASE Universidad;

# Seleccionamos la base de datos
USE Universidad;

-- Creamos tabla de estudiantes
CREATE TABLE Estudiantes(
    codStud	INT auto_increment primary key not NULL,
    nombre	VARCHAR(50), 
    carrera	VARCHAR(20),
    promedio	DECIMAL(4,2),
    genero	VARCHAR(10), 
    nacimiento	DATE
);

-- Creamos tabla de docentes
create table Docentes(
    codProf INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (50),
    genero VARCHAR(15),
    fecha_nac DATE,
    nivel_acad VARCHAR(50),
    rfc VARCHAR(13),
    curp VARCHAR(18),
    correo VARCHAR(60)
);

-- Creamos tabla de departamentos
create table Departamentos(
    idDep INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    depa VARCHAR(50),
    correo VARCHAR(60),
    tel INT(10),
    Coordi_id int,

    -- Llave foranea de la tabla docentes
    CONSTRAINT fk_docente_coordi
    FOREIGN KEY (Coordi_id)
    REFERENCES Docentes(codProf)
);

-- Creamos tablas de admnistrativos
create table Administrativos(
    idAdm INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50)
);


-- Creamos la tabla de finanzas 
CREATE TABLE Finanzas (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,     
    Rubro VARCHAR(100) NOT NULL,    
    Egreso DECIMAL(10, 2),     
    Ingreso DECIMAL(10, 2),     
    cuenta_origen INT(20) NOT NULL,     
    cuenta_destino INT(20) NOT NULL,     
    Administrador INT NOT NULL,  
        
    -- Asignamos la llave foranea de la tabla administrativos
    CONSTRAINT AdminForaneo     
    FOREIGN KEY (Administrador)     
    REFERENCES Administrativos(idAdm)     
);  
        
-- Creamos la tabla de control escolar 
CREATE TABLE Control_escolar(     
    idTramite INT AUTO_INCREMENT PRIMARY KEY,     
    Tramites VARCHAR(100),     
    Cod_Estudiantes INT,      
    Id_finanza INT, 
    Id_Admin INT,

    -- Usamos llaves foranea de las tablas;
    -- estudiantes, finanzas y administrativos
    
    -- Llave codStud de Estudiantes
    CONSTRAINT EstudianteKey
    FOREIGN KEY (Cod_Estudiantes)
    REFERENCES Estudiantes(codStud),
    -- Llave rubro finanzas
    CONSTRAINT idKey
    FOREIGN KEY (Id_finanza)
    REFERENCES Finanzas(id),
    -- Llave idAdm de Administrativos
    CONSTRAINT idAmdKey
    FOREIGN KEY (Id_Admin)
    REFERENCES Administrativos(idAdm)
);

-- Creamos la tabla de servicios generales

CREATE TABLE Servicios_Generales(
    idServ INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Servicio VARCHAR(100),
    Administrador INT,


    -- Usamos la llave foranea de administradores
    CONSTRAINT AdministradorKey
    FOREIGN KEY (Administrador) 
    REFERENCES Administrativos(idAdm)
);

-- Agregamos datos (5 por área)
INSERT INTO Estudiantes(nombre, carrera, promedio, genero, nacimiento)
VALUES 
('Ana Lucía Torres', 'Ciberseguridad', 8.7, 'Femenino', 14/08/2003),
('Diego Manuel Rivas', 'Ciberseguridad', 9.2, 'Masculino', 27/11/2004),
('Sofía Valentina Cruz', 'Creatividad Digital', 'Femenino', 8.9, 08/12/2002),
('Carlos Andrés Méndez', 'Inteligencia Artificial y Ciencia de Datos', 'Masculino', 8.0, 22/09/2004),
('Mariana Isabel López', 'Ciberseguridad', 'Femenino', 8.5, 12/01/2000);

INSERT INTO Docentes(nombre, genero, fecha_nac, nivel_acad, rfc, curp, correo)
VALUES 
('Laura Patricia Ramírez', 'Femenino', 12/05/84, 'Maestría', 'RAPL840512MX1', 'RAPL840512MDFMRS07', 'l.ramirez.docente@escuela.mx'),
('José Antonio Delgado', 'Masculino', 03/12/90, 'Doctorado', 'DEAJ780923HT2', 'DEAJ780923HGRLNS05', 'jose.delgado@instituto.edu'),
('Mariana Solís Vega', 'Femenino', 10/02/91, 'Doctorado', 'SOVM900204AB3', 'SOVM900204MPLSGR08', 'm.solis.vega@colegio.mx'),
('Ricardo Alberto Núñez', 'Masculino', 22/07/87, 'Maestría', 'NUAR821117ZX4', 'NUAR821117HCMNRC06', 'r.nunez@universidad.edu'),
('Karla Daniela Méndez', 'Femenino', 09/12/80, 'Licenciatura', 'MEDK870730QP5', 'MEDK870730MMNDLR09', 'karla.mendez@prepa.mx');

INSERT INTO Departamentos(depa, correo, tel, Coordi_id)
VALUES
('Ciberseguridad', 'ciberseguridad@institucion.mx', '5512345678', 1),
('Inteligencia Artificial y Ciencia de Datos', 'ia.datos@institucion.mx', '5556789123', 2),
('Tecnologías Biomédicas', 'biomedicas@institucion.mx', '5523456789', 3),
('Inteligencia Financiera y de Negocios', 'finanzas.inteligentes@institucion.mx', '5567890123', 4),
('Innovación Digital y Analítica', 'innovacion.digital@institucion.mx', '5534567890', 5);

INSERT INTO Administrativos(nombre)
VALUES
('Ana Paula Herrera'),
('Miguel Ángel Salazar'),
('Fernanda Isabel Torres'),
('Roberto Carlos Medina'),
('Paola Adriana Jiménez');

INSERT INTO Finanzas(Rubro, Ingreso, Egreso, cuenta_origen, cuenta_destino, Administrador)
VALUES
('Pago de nómina', 0.00, 125000.00, 'BANCO_OPERATIVO', 'NOMINA_EMPLEADOS', 1),
('Inscripción estudiantes', 98000.00, 0.00, 'CAJA_ESCOLAR', 'BANCO_OPERATIVO', 2),
('Compra de equipo', 0.00, 45000.00, 'BANCO_OPERATIVO', 'PROVEEDORES_TI', 3),
('Becas académicas', 0.00, 32000.00, 'FONDO_BECAS', 'CUENTA_ESTUDIANTES', 4),
('Servicios básicos', 0.00, 18500.00, 'BANCO_OPERATIVO', 'CFE_AGUA_INTERNET', 5);

INSERT INTO Control_Escolar(Tramites, Cod_Estudiante, Id_finanzas, Id_Admin)
('Constancia de estudios', 1, 1, 3),
('Reposición de credencial', 3, 5, 1),
('Certificado parcial de estudios', 5, 4, 5),
('Duplicado de boleta', 2, 2, 4),
('Trámite de baja temporal', 4, 3, 2);

INSERT INTO Servicios_Generales(Servicio, Administrador)
VALUES
('Biblioteca universitaria', 4),
('Centro de cómputo', 3),
('Orientación psicopedagógica', 1),
('Servicio médico escolar', 2),
('Transporte universitario', 5);











