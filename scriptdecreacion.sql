#CREATE DATABASE Universidad;
USE Universidad;

CREATE TABLE Estudiantes(
codStud	INT auto_increment primary key,
nombre	VARCHAR(50), 
carrera	VARCHAR(20),
promedio	DECIMAL(4,2),
genero	VARCHAR(10), 
nacimiento	DATE
);  

create table docentes(
codProf

)

create table departamentos(
idDep
    
)

create table administrativos(
idAdm
    
)


create table servicios_gen(


)

create table finanzas(

    
)

create table control_esc(

    
)



INSERT	INTO Estudiantes(nombre,carrera,promedio,genero,nacimiento)
VALUES
("PIPOPE","IA",60.00,"INDEFINIDO",12-10-2000);
SELECT * FROM Estudiantes;
#DROP TABLE Estudiantes;
