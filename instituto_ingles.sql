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
nombre varchar (50),
apellido varchar (50),
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

### Instructores y Alumnos se importaron por .csv ###

### Parte 2 ###

### A ###
SELECT a.nombre, a.apellido , a.email
FROM alumnos a 
INNER JOIN nivel n 
	ON a.nivel_id = n.nivel_id 
WHERE n.nivel = '1A'
	AND a.nota_final IS NULL;

### B ###
SELECT a.nombre , a.apellido , a.nota_final 
FROM alumnos a 
INNER JOIN nivel n 
	ON a.nivel_id = n.nivel_id 
WHERE n.nivel_id = (SELECT max(n.nivel_id) FROM nivel n)
	AND a.nota_final >= 6; 

### C ###
SELECT count(a.nota_final)
FROM alumnos a
WHERE a.nota_final >= 6;

### D ###
SELECT n.nivel, count(a.legajo) AS Inscriptos
FROM alumnos a 
INNER JOIN nivel n 
	ON a.nivel_id = n.nivel_id
GROUP BY n.nivel;

SELECT n.nivel, count(a.nota_final) AS Aprobados
FROM alumnos a 
INNER JOIN nivel n 
	ON a.nivel_id = n.nivel_id
WHERE a.nota_final >= 6
GROUP BY n.nivel;

SELECT n.nivel, count(a.nota_final) AS Desaprobados
FROM alumnos a 
INNER JOIN nivel n 
	ON a.nivel_id = n.nivel_id
WHERE a.nota_final < 6
GROUP BY n.nivel;

SELECT n.nivel, count(isnull(a.nota_final)) AS Ausentes
FROM alumnos a 
INNER JOIN nivel n 
	ON a.nivel_id = n.nivel_id
WHERE a.nota_final IS NULL 
GROUP BY n.nivel;

### E ###
SELECT i.nombre , i.apellido , i.email , a.nota_final 
FROM alumnos a 
INNER JOIN instructores i 
	ON a.instructor_id =i.instructor_id 
WHERE a.nombre = 'Valeria'
	AND a.apellido = 'McPartlin';

### F ###
SELECT a.*
FROM alumnos a 
INNER JOIN nivel n 
	ON a.nivel_id = n.nivel_id 
WHERE n.nivel_id = (SELECT max(n.nivel_id) FROM nivel n)
	AND a.apellido REGEXP '^[MNOP]' 
ORDER BY a.apellido;

### G ###
SELECT i.nombre , i.apellido , count(a.nota_final) AS alumnos_distinguidos
FROM instructores i 
INNER JOIN alumnos a 
	ON i.instructor_id = a.instructor_id 
WHERE a.nota_final > 9
GROUP BY i.instructor_id
HAVING COUNT(a.nota_final) = (
    SELECT MAX(alumnos_distinguidos)
    FROM (
        SELECT COUNT(nota_final) AS alumnos_distinguidos
        FROM instructores i
        INNER JOIN alumnos a ON i.instructor_id = a.instructor_id
        WHERE a.nota_final > 9
        GROUP BY i.instructor_id
    ) AS max_alumnos
);
