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
