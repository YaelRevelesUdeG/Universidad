USE Universidad;

-- Convertimos lo valores de las tablas en vacios para evitar errores
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Docentes;
TRUNCATE TABLE Departamentos;
TRUNCATE TABLE Administrativos;
TRUNCATE TABLE Control_escolar;
TRUNCATE TABLE Finanzas;
TRUNCATE TABLE Servicios_Generales;
SET FOREIGN_KEY_CHECKS = 1;

--------------------
--    DOCENTES    --
--------------------

-- Se agregaron los campos necesarios para complementar la tabla.
ALTER TABLE Docentes
ADD COLUMN numero varchar (10),
ADD COLUMN idiomas varchar (50),
ADD id_depa int NOT NULL,
DROP column fecha_nac;

-- En este punto se agrego la relacion de la tabla docentes con la tabla de departamentos.
ALTER TABLE Docentes
ADD CONSTRAINT fk_docentes_depa
FOREIGN key (id_depa)
REFERENCES Departamentos(idDep)
ON DELETE CASCADE;

---------------------
--  DEPARTAMENTOS  --
---------------------

-- Se modifica la tabla departamentos para agregar los campos necesarios para la limpieza.
-- Se hace cambio de nombre de una columna y se elimina una FK
ALTER TABLE Departamentos
ADD COLUMN coordinador varchar (30) NOT NULL,
ADD COLUMN ubicacion varchar (50) NOT NULL,
ADD COLUMN no_empleados int,
RENAME COLUMN tel TO extension,
DROP CONSTRAINT fk_docente_coordi;

ALTER TABLE Departamentos
DROP COLUMN Coordi_id;

ALTER TABLE Administrativos
ADD COLUMN area varchar (30) NOT NULL,
ADD COLUMN puesto varchar(50) NOT NULL,
ADD COLUMN rfc varchar (14) NOT NULL,
ADD COLUMN telefono varchar (10) NOT NULL,
ADD COLUMN correo VARCHAR (50) NOT NULL,
ADD COLUMN nivel_acad VARCHAR (50) NOT NULL;

---------------------
-- CONTROL ESCOLAR --
---------------------

-- Modificamos la tabla control escolar
ALTER TABLE Control_escolar
ADD COLUMN Requisitos VARCHAR(100),
ADD COLUMN Nombre_Tramite VARCHAR(100) NOT NULL,
ADD COLUMN Costo DECIMAL(10, 2) NOT NULL,
ADD COLUMN Tiempo_Resolucion TIMESTAMP NOT NULL,
RENAME COLUMN Id_Admin TO Responsable,
DROP CONSTRAINT idAmdkey,
DROP CONSTRAINT idkey,
DROP CONSTRAINT Estudiantekey,
DROP COLUMN Cod_Estudiante;

-- Añadimos la llave foranea de administrativos a
-- la tabla de control escolar para el responsable
-- El join debe ser al nombre del administrativo
ALTER TABLE Control_escolar
ADD CONSTRAINT fk_administrativos_nombre
FOREIGN KEY (Responsable)
REFERENCES Administrativos(idAdm)
ON DELETE CASCADE;

----------------------
--     FINANZAS     --
----------------------

-- Añadimos las columnas faltantes y las existentes las
-- renombramos
ALTER TABLE Finanzas
RENAME COLUMN id TO Id_Tramite,
RENAME COLUMN Egreso TO Ingreso_Egreso,
ADD COLUMN Concepto VARCHAR(100) NOT NULL,
ADD COLUMN Fecha TIMESTAMP NOT NULL,
ADD COLUMN Monto DECIMAL(10, 2) NOT NULL,
DROP COLUMN Ingreso;

-- Nos deshacemos de la constraint dedicada a dar la llave
-- de amdmin y de paso borramos la columna

ALTER TABLE Finanzas
DROP CONSTRAINT AdminForaneo,
DROP COLUMN Administrador;

-------------------------
-- SERVICIOS GENERALES --
-------------------------

-- Añandimos las columnas restantes de la tabla
-- y renombramos un par existente
ALTER TABLE Servicios_Generales
RENAME COLUMN idServ TO id,
RENAME COLUMN Servicio TO Nombre_Actividad,
ADD COLUMN Area VARCHAR (50) NOT NULL,
ADD COLUMN Turno_Encargado VARCHAR (15) NOT NULL;

-- Eliminamos la llave foranea y renombramos la columna

ALTER TABLE Servicios_Generales
DROP CONSTRAINT AdministradorKey,
RENAME COLUMN Administrador TO Encargado;

-- Volver a conectar Encargado con Administrativos
ALTER TABLE Servicios_Generales
ADD CONSTRAINT fk_servicios_encargado
FOREIGN KEY (Encargado)
REFERENCES Administrativos(idAdm);





-- Comenzamos a insertar datos
-- =============================================
-- 1. INSERTAR ADMINISTRATIVOS (Tabla Padre)
-- =============================================
INSERT INTO Administrativos (nombre, area, puesto, rfc, telefono, correo, nivel_acad) VALUES
('Ana Paula Herrera', 'Recursos Humanos', 'Directora', 'HEPA800101H23', '5512345678', 'ana.herrera@uni.edu', 'Maestría'),
('Miguel Ángel Salazar', 'Finanzas', 'Contador General', 'SAMM750505M12', '5587654321', 'miguel.salazar@uni.edu', 'Licenciatura'),
('Fernanda Isabel Torres', 'Servicios Escolares', 'Coordinadora', 'TOIF900202F45', '5511223344', 'fernanda.torres@uni.edu', 'Licenciatura'),
('Roberto Carlos Medina', 'Mantenimiento', 'Jefe de Servicios', 'MERJ850808R67', '5599887766', 'roberto.medina@uni.edu', 'Bachillerato'),
('Paola Adriana Jiménez', 'Jurídico', 'Abogada General', 'JIPA881111P89', '5544556677', 'paola.jimenez@uni.edu', 'Doctorado');

-- =============================================
-- 2. INSERTAR DEPARTAMENTOS (Tabla Padre)
-- =============================================
INSERT INTO Departamentos (depa, correo, extension, coordinador, ubicacion, no_empleados) VALUES
('Ingeniería', 'ing@uni.edu', '1001', 'Ing. Luis García', 'Edificio A, Piso 1', 25),
('Ciencias de la Salud', 'salud@uni.edu', '1002', 'Dra. Elena Ramos', 'Edificio B, PB', 30),
('Humanidades', 'humanidades@uni.edu', '1003', 'Lic. Marco Polo', 'Edificio C, Piso 2', 15),
('Negocios', 'negocios@uni.edu', '1004', 'Mtra. Sofía Castro', 'Edificio A, Piso 2', 20),
('Artes', 'artes@uni.edu', '1005', 'Lic. Frida Kahlo', 'Edificio D, Taller 1', 10);

-- =============================================
-- 3. INSERTAR DOCENTES (Hijo de Departamentos)
-- =============================================
INSERT INTO Docentes (nombre, genero, nivel_acad, rfc, curp, correo, numero, idiomas, id_depa) VALUES
('Laura Patricia Ramírez', 'Femenino', 'Maestría', 'RAPL840512MX1', 'RAPL840512MDFMRS07', 'l.ramirez@uni.edu', '5510101010', 'Inglés, Francés', 1),
('José Antonio Delgado', 'Masculino', 'Doctorado', 'DEAJ780923HT2', 'DEAJ780923HGRLNS05', 'j.delgado@uni.edu', '5520202020', 'Inglés', 1),
('Mariana Solís Vega', 'Femenino', 'Doctorado', 'SOVM900204AB3', 'SOVM900204MPLSGR08', 'm.solis@uni.edu', '5530303030', 'Alemán', 2),
('Ricardo Alberto Núñez', 'Masculino', 'Maestría', 'NUAR821117ZX4', 'NUAR821117HCMNRC06', 'r.nunez@uni.edu', '5540404040', 'Inglés', 4),
('Karla Daniela Méndez', 'Femenino', 'Licenciatura', 'MEDK870730QP5', 'MEDK870730MMNDLR09', 'k.mendez@uni.edu', '5550505050', 'Español', 3);

-- =============================================
-- 4. INSERTAR ESTUDIANTES (Independiente)
-- =============================================
INSERT INTO Estudiantes (nombre, carrera, promedio, genero, nacimiento) VALUES 
('Ana Lucía Torres', 'Ciberseguridad', 8.7, 'Femenino', '2003-08-14'),
('Diego Manuel Rivas', 'Ingeniería Civil', 9.2, 'Masculino', '2004-11-27'),
('Sofía Valentina Cruz', 'Medicina', 8.9, 'Femenino', '2002-12-08'),
('Carlos Andrés Méndez', 'Derecho', 8.0, 'Masculino', '2004-09-22'),
('Mariana Isabel López', 'Diseño Gráfico', 8.5, 'Femenino', '2000-01-12');

-- =============================================
-- 5. INSERTAR FINANZAS (Independiente tras los cambios)
-- =============================================
INSERT INTO Finanzas (Rubro, Ingreso_Egreso, Concepto, Fecha, Monto, cuenta_origen, cuenta_destino) VALUES
('Nómina', 0.00, 'Pago Quincena 1', '2023-10-15 12:00:00', 500000.00, 'Santander-Principal', 'Bancomer-Nomina'),
('Colegiaturas', 0.00, 'Inscripción Semestral', '2023-10-16 09:00:00', 1500.00, 'Caja-Ventanilla', 'Santander-Ingresos'),
('Proveedores', 0.00, 'Compra Pizarrones', '2023-10-17 14:30:00', 12500.50, 'Santander-Principal', 'OfficeDepot-Cuenta'),
('Mantenimiento', 0.00, 'Reparación Aire Acond.', '2023-10-18 10:00:00', 3400.00, 'Caja-Chica', 'Técnicos-SA'),
('Donaciones', 0.00, 'Donativo Ex-Alumnos', '2023-10-19 11:00:00', 50000.00, 'Fundación-BBVA', 'Santander-Becas');

-- =============================================
-- 6. INSERTAR SERVICIOS GENERALES (Hijo de Administrativos)
-- =============================================
-- Nota: Encargado apunta al ID de Administrativos (1 al 5)
INSERT INTO Servicios_Generales (Nombre_Actividad, Area, Turno_Encargado, Encargado) VALUES
('Limpieza General', 'Edificio A', 'Matutino', 4),
('Seguridad Puerta 1', 'Entrada Principal', 'Nocturno', 4),
('Jardinería', 'Áreas Verdes', 'Matutino', 4),
('Cafetería', 'Comedor Central', 'Mixto', 2),
('Transporte Escolar', 'Estacionamiento', 'Vespertino', 4);

-- =============================================
-- 7. INSERTAR CONTROL ESCOLAR (Hijo de Administrativos y Finanzas)
-- =============================================
-- Nota: Responsable apunta a Administrativos
-- Id_finanza apunta lógicamente a Finanzas (aunque borraste la constraint, mantenemos la lógica)
INSERT INTO Control_escolar (Tramites, Nombre_Tramite, Requisitos, Costo, Tiempo_Resolucion, Responsable, Id_finanza) VALUES
('Certificación', 'Certificado Parcial', 'Boleta, Fotos, Pago', 500.00, '2023-10-20 12:00:00', 3, 2),
('Titulación', 'Examen Profesional', 'Tesis, Votos, Pago', 3500.00, '2023-11-01 09:00:00', 3, 2),
('Baja', 'Baja Temporal', 'Carta Motivos', 0.00, '2023-10-21 10:00:00', 3, NULL),
('Credencial', 'Reposición Credencial', 'Reporte Robo, Pago', 150.00, '2023-10-22 11:00:00', 3, 2),
('Becas', 'Solicitud Beca', 'Promedio 9.0, Estudio', 0.00, '2023-10-25 14:00:00', 1, 5);

-- Verificamos todo
SELECT * FROM Control_escolar;