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