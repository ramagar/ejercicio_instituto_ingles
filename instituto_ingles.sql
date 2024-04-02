### Parte 1 ###

### Creacion de Tablas ###
CREATE TABLE IF NOT EXISTS nivel(
nivel_id int AUTO_INCREMENT PRIMARY KEY,
nivel VARCHAR (3)
);

CREATE TABLE IF NOT EXISTS genero(
genero_id int AUTO_INCREMENT PRIMARY KEY,
genero varchar (20)
);

CREATE TABLE IF NOT EXISTS instructores(
instructor_id int AUTO_INCREMENT PRIMARY KEY,
apellido varchar (20),
nombre varchar (20),
email varchar (45)
);

CREATE TABLE IF NOT EXISTS alumnos(
legajo int AUTO_INCREMENT PRIMARY KEY,
apellido varchar (50),
nombre varchar (50),
email varchar (50),
genero_id int,
nota_1p decimal (4, 2),
nota_2p decimal (4, 2),
nota_final decimal (4, 2),
nivel_id int,
instructor_id int,
FOREIGN KEY (genero_id) REFERENCES genero (genero_id),
FOREIGN KEY (nivel_id) REFERENCES nivel (nivel_id),
FOREIGN KEY (instructor_id) REFERENCES instructores (instructor_id)
);

### Insercion de Datos ###
INSERT INTO nivel (nivel)
VALUES ('1A'), ('1B'), ('2'), ('3'), ('4');

INSERT INTO genero (genero)
VALUES ('Female'), ('Male'), ('Polygender'), ('Genderqueer'), ('Genderfluid'),
	('Agender'), ('Non-binary'), ('Bigender');








