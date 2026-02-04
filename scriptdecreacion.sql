# Eliminar base de datos en caso de existir
DROP DATABASE IF EXISTS Universidad;

# Creacion de la base de datos
CREATE DATABASE Universidad;

# Seleccionamos la base de datos
USE Universidad;

CREATE TABLE Estudiantes(
codStud	INT auto_increment primary key not NULL,
nombre	VARCHAR(50), 
carrera	VARCHAR(20),
promedio	DECIMAL(4,2),
genero	VARCHAR(10), 
nacimiento	DATE
);  

create table docentes(
codProf INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50),
genero VARCHAR(15),
fecha_nac DATE,
nivel_acad VARCHAR(50),
rfc VARCHAR(13),
curp VARCHAR(18),
correo(60)
);

create table departamentos(
idDep INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
depa VARCHAR(50),
correo VARCHAR(60),
tel INT(10),
Coordi_id int,
CONSTRAINT fk_docente_coordi
FOREIGN KEY (Coordi_id)
REFERENCES docentes(codProf)
);

create table administrativos(
idAdm INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre VARCHAR(50)
);
