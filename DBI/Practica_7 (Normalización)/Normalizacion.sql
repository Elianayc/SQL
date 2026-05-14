/* 

Normalización paso a paso — Base de datos de películas

Objetivo
Partiendo de una base completamente desnormalizada, se irá aplicando el proceso de normalización:

* 0FN / UNF
* 1FN
* 2FN
* 3FN
* 4FN
* 5FN

En cada etapa se muestran:
* estructura,
* carga de datos,
* ejemplos de consultas,
* y el problema que resuelve.
*/





/*
-- ETAPA 0 — UNF / 0FN
Problemas
* Grupos repetidos
* Columnas duplicadas
* Cantidad fija de actores
* Redundancia extrema
* Anomalías de inserción, borrado y modificación
*/

DROP TABLE IF EXISTS peliculas_0FN CASCADE;
CREATE TABLE peliculas_0FN (
    id_pelicula INT,
    titulo VARCHAR(50),
    sinopsis VARCHAR(200),
    anio_estreno INT,
    recaudacion FLOAT,

    categoria VARCHAR(30),

    director_nombre VARCHAR(50),
    director_apellido VARCHAR(50),
    director_pais VARCHAR(30),
    director_anio_nacimiento INT,

    actor1_nombre VARCHAR(50),
    actor1_apellido VARCHAR(50),
    actor1_pais VARCHAR(30),
    actor1_anio_nacimiento INT,

    actor2_nombre VARCHAR(50),
    actor2_apellido VARCHAR(50),
    actor2_pais VARCHAR(30),
    actor2_anio_nacimiento INT
);

INSERT INTO peliculas_0FN VALUES
(1,'Inception','Ladrón roba secretos a través de sueños',2010,829.89,
'Ciencia Ficción',
'Christopher','Nolan','Reino Unido',1970,
'Leonardo','DiCaprio','Estados Unidos',1974,
'Emma','Watson','Reino Unido',1990),

(2,'Jurasic Park','Parque temático con dinosaurios clonados',1993,1029.15,
'Acción',
'Steven','Spielberg','Estados Unidos',1946,
'Brad','Pitt','Estados Unidos',1963,
'Tom','Hanks','Estados Unidos',1956),

(3,'Volver','Historia de mujeres en La Mancha',2006,124.5,
'Drama',
'Pedro','Almodóvar','España',1949,
'Penélope','Cruz','España',1974,
NULL,NULL,NULL,NULL),

(4,'El secreto de sus ojos','Exempleado judicial investiga un caso sin resolver',2009,34.9,
'Drama',
'Juan','José Campanella','Argentina',1959,
'Ricardo','Darín','Argentina',1957,
NULL,NULL,NULL,NULL),

(5,'Titanic','Romance en el barco hundido',1997,2187.5,
'Romance',
'James','Cameron','Estados Unidos',1954,
'Leonardo','DiCaprio','Estados Unidos',1974,
'Brad','Pitt','Estados Unidos',1963);

SELECT * FROM peliculas_0FN;






/* 
ETAPA 1 — 1FN

Objetivo
Eliminar grupos repetidos.

Ahora:
* cada fila representa una película + un actor
* todos los atributos son atómicos


Problema restante
Aún existe redundancia:
* los datos de película se repiten por cada actor
* los datos del director también
*/

DROP TABLE IF EXISTS peliculas_1FN CASCADE;
CREATE TABLE peliculas_1FN (
    id_pelicula INT,
    titulo VARCHAR(50),
    sinopsis VARCHAR(200),
    anio_estreno INT,
    recaudacion FLOAT,

    categoria VARCHAR(30),

    director_nombre VARCHAR(50),
    director_apellido VARCHAR(50),
    director_pais VARCHAR(30),
    director_anio_nacimiento INT,

    actor_nombre VARCHAR(50),
    actor_apellido VARCHAR(50),
    actor_pais VARCHAR(30),
    actor_anio_nacimiento INT,

    PRIMARY KEY (
        id_pelicula,
        actor_nombre,
        actor_apellido
    )
);

INSERT INTO peliculas_1FN VALUES
(1,'Inception','Ladrón roba secretos a través de sueños',2010,829.89,
'Ciencia Ficción',
'Christopher','Nolan','Reino Unido',1970,
'Leonardo','DiCaprio','Estados Unidos',1974),

(1,'Inception','Ladrón roba secretos a través de sueños',2010,829.89,
'Ciencia Ficción',
'Christopher','Nolan','Reino Unido',1970,
'Emma','Watson','Reino Unido',1990),

(2,'Jurasic Park','Parque temático con dinosaurios clonados',1993,1029.15,
'Acción',
'Steven','Spielberg','Estados Unidos',1946,
'Brad','Pitt','Estados Unidos',1963),

(2,'Jurasic Park','Parque temático con dinosaurios clonados',1993,1029.15,
'Acción',
'Steven','Spielberg','Estados Unidos',1946,
'Tom','Hanks','Estados Unidos',1956),

(3,'Volver','Historia de mujeres en La Mancha',2006,124.5,
'Drama',
'Pedro','Almodóvar','España',1949,
'Penélope','Cruz','España',1974),

(4,'El secreto de sus ojos','Exempleado judicial investiga un caso sin resolver',2009,34.9,
'Drama',
'Juan','José Campanella','Argentina',1959,
'Ricardo','Darín','Argentina',1957),

(5,'Titanic','Romance en el barco hundido',1997,2187.5,
'Romance',
'James','Cameron','Estados Unidos',1954,
'Leonardo','DiCaprio','Estados Unidos',1974),

(5,'Titanic','Romance en el barco hundido',1997,2187.5,
'Romance',
'James','Cameron','Estados Unidos',1954,
'Brad','Pitt','Estados Unidos',1963);

SELECT *
FROM peliculas_1FN
ORDER BY id_pelicula;





/* 
ETAPA 2 — 2FN
Objetivo: eliminar dependencias parciales 
*/

DROP TABLE IF EXISTS pelicula_2FN CASCADE;
CREATE TABLE pelicula_2FN (
    id_pelicula INT PRIMARY KEY,
    titulo VARCHAR(50),
    sinopsis VARCHAR(200),
    anio_estreno INT,
    recaudacion FLOAT,
    categoria VARCHAR(30),
    director_nombre VARCHAR(50),
    director_apellido VARCHAR(50),
    director_pais VARCHAR(30),
    director_anio_nacimiento INT
);

DROP TABLE IF EXISTS actor_2FN CASCADE;
CREATE TABLE actor_2FN (
    id_actor INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    pais VARCHAR(30),
    anio_nacimiento INT
);

DROP TABLE IF EXISTS actores_x_pelicula_2FN CASCADE;
CREATE TABLE actores_x_pelicula_2FN (
    id_pelicula INT,
    id_actor INT,
    PRIMARY KEY (id_pelicula, id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula_2FN(id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor_2FN(id_actor)
);

INSERT INTO pelicula_2FN VALUES
(1,'Inception','Ladrón roba secretos a través de sueños',2010,829.89,'Ciencia Ficción','Christopher','Nolan','Reino Unido',1970),
(2,'Jurasic Park','Parque temático con dinosaurios clonados',1993,1029.15,'Acción','Steven','Spielberg','Estados Unidos',1946),
(3,'Volver','Historia de mujeres en La Mancha',2006,124.5,'Drama','Pedro','Almodóvar','España',1949),
(4,'El secreto de sus ojos','Exempleado judicial investiga un caso sin resolver',2009,34.9,'Drama','Juan','José Campanella','Argentina',1959),
(5,'Titanic','Romance en el barco hundido',1997,2187.5,'Romance','James','Cameron','Estados Unidos',1954);

INSERT INTO actor_2FN VALUES
(1,'Leonardo','DiCaprio','Estados Unidos',1974),
(2,'Emma','Watson','Reino Unido',1990),
(3,'Brad','Pitt','Estados Unidos',1963),
(4,'Tom','Hanks','Estados Unidos',1956),
(5,'Penélope','Cruz','España',1974),
(6,'Ricardo','Darín','Argentina',1957);

INSERT INTO actores_x_pelicula_2FN VALUES
(1,1),(1,2),(2,3),(2,4),(3,5),(4,6),(5,1),(5,3);






/* ETAPA 3 — 3FN
 Eliminación de dependencias transitivas */

DROP TABLE IF EXISTS pais_3FN CASCADE;
CREATE TABLE pais_3FN (
    id INT PRIMARY KEY,
    nombre VARCHAR(30)
);

DROP TABLE IF EXISTS director_3FN CASCADE;
CREATE TABLE director_3FN (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    pais_nacimiento INT,
    anio_nacimiento INT,
    FOREIGN KEY (pais_nacimiento) REFERENCES pais_3FN(id)
);

DROP TABLE IF EXISTS actor_3FN CASCADE;
CREATE TABLE actor_3FN (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    pais_nacimiento INT,
    anio_nacimiento INT,
    FOREIGN KEY (pais_nacimiento) REFERENCES pais_3FN(id)
);

DROP TABLE IF EXISTS categoria_3FN CASCADE;
CREATE TABLE categoria_3FN (
    id INT PRIMARY KEY,
    nombre VARCHAR(30)
);

DROP TABLE IF EXISTS pelicula_3FN CASCADE;
CREATE TABLE pelicula_3FN (
    id INT PRIMARY KEY,
    titulo VARCHAR(50),
    sinopsis VARCHAR(200),
    categoria INT,
    director INT,
    anio_estreno INT,
    recaudacion FLOAT,
    FOREIGN KEY (categoria) REFERENCES categoria_3FN(id),
    FOREIGN KEY (director) REFERENCES director_3FN(id)
);

DROP TABLE IF EXISTS actores_x_pelicula_3FN CASCADE;
CREATE TABLE actores_x_pelicula_3FN (
    id_actor INT,
    id_pelicula INT,
    PRIMARY KEY (id_actor, id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor_3FN(id),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula_3FN(id)
);

INSERT INTO pais_3FN VALUES
(1,'Estados Unidos'),
(2,'Reino Unido'),
(3,'Francia'),
(4,'Argentina'),
(5,'España'),
(6,'Canadá'),
(7,'Italia'),
(8,'Australia');

INSERT INTO categoria_3FN VALUES
(1,'Acción'),
(2,'Drama'),
(3,'Comedia'),
(4,'Ciencia Ficción'),
(5,'Terror'),
(6,'Romance'),
(7,'Aventura'),
(8,'Animación');

INSERT INTO director_3FN VALUES
(1,'Steven','Spielberg',1,1946),
(2,'Christopher','Nolan',2,1970),
(3,'Quentin','Tarantino',1,1963),
(4,'Pedro','Almodóvar',5,1949),
(5,'James','Cameron',1,1954);

INSERT INTO actor_3FN VALUES
(1,'Leonardo','DiCaprio',1,1974),
(2,'Emma','Watson',2,1990),
(3,'Penélope','Cruz',5,1974),
(4,'Ricardo','Darín',4,1957),
(5,'Brad','Pitt',1,1963),
(6,'Tom','Hanks',1,1956);

INSERT INTO pelicula_3FN VALUES
(1,'Inception','Ladrón roba secretos a través de sueños',4,2,2010,829.89),
(2,'Jurasic Park','Parque temático con dinosaurios clonados',1,1,1993,1029.15),
(3,'Volver','Historia de mujeres en La Mancha',2,4,2006,124.5),
(4,'El secreto de sus ojos','Exempleado judicial investiga un caso sin resolver',2,5,2009,34.9),
(5,'Titanic','Romance en el barco hundido',6,5,1997,2187.5);

INSERT INTO actores_x_pelicula_3FN VALUES
(1,1),(2,1),(5,2),(6,2),(3,3),(4,4),(1,5),(5,5);









/*
ETAPA 4 — 4FN
Eliminación de dependencias multivaluadas 
*/

DROP TABLE IF EXISTS idioma_4FN CASCADE;
CREATE TABLE idioma_4FN (
    id INT PRIMARY KEY,
    nombre VARCHAR(30)
);

DROP TABLE IF EXISTS pelicula_idioma_4FN CASCADE;
CREATE TABLE pelicula_idioma_4FN (
    id_pelicula INT,
    id_idioma INT,
    PRIMARY KEY (id_pelicula, id_idioma),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula_3FN(id),
    FOREIGN KEY (id_idioma) REFERENCES idioma_4FN(id)
);

INSERT INTO idioma_4FN VALUES
(1,'Inglés'),
(2,'Español'),
(3,'Francés');

INSERT INTO pelicula_idioma_4FN VALUES
(1,1),(1,2),(2,1),(3,2),(4,2),(5,1),(5,2);

SELECT 
    p.titulo,
    i.nombre AS idioma
FROM pelicula_3FN p
JOIN pelicula_idioma_4FN pi ON p.id = pi.id_pelicula
JOIN idioma_4FN i ON pi.id_idioma = i.id
ORDER BY p.titulo, i.nombre;

CREATE TABLE pelicula_actor_idioma_INCORRECTA (
    id_pelicula INT,
    id_actor INT,
    id_idioma INT
);









/* 
ETAPA 5 — 5FN
Eliminación de dependencias de JOIN 
*/

DROP TABLE IF EXISTS plataforma_5FN CASCADE;
CREATE TABLE plataforma_5FN (
    id INT PRIMARY KEY,
    nombre VARCHAR(50)
);

DROP TABLE IF EXISTS pelicula_plataforma_5FN CASCADE;
CREATE TABLE pelicula_plataforma_5FN (
    id_pelicula INT,
    id_plataforma INT,
    PRIMARY KEY (id_pelicula, id_plataforma)
);

DROP TABLE IF EXISTS actor_plataforma_5FN CASCADE;
CREATE TABLE actor_plataforma_5FN (
    id_actor INT,
    id_plataforma INT,
    PRIMARY KEY (id_actor, id_plataforma)
);

INSERT INTO plataforma_5FN VALUES
(1,'Netflix'),
(2,'Disney+'),
(3,'HBO Max');

INSERT INTO pelicula_plataforma_5FN VALUES
(1,1),(2,2),(5,1),(5,3);

INSERT INTO actor_plataforma_5FN VALUES
(1,1),(1,3),(5,1),(2,2);

SELECT
    pl.nombre AS plataforma,
    p.titulo
FROM pelicula_plataforma_5FN pp
JOIN plataforma_5FN pl ON pp.id_plataforma = pl.id
JOIN pelicula_3FN p ON pp.id_pelicula = p.id
ORDER BY pl.nombre, p.titulo;

SELECT
    pl.nombre AS plataforma,
    a.nombre || ' ' || a.apellido AS actor
FROM actor_plataforma_5FN ap
JOIN plataforma_5FN pl ON ap.id_plataforma = pl.id
JOIN actor_3FN a ON ap.id_actor = a.id
ORDER BY pl.nombre, actor;

DROP TABLE IF EXISTS pelicula_actor_plataforma CASCADE;
CREATE TABLE pelicula_actor_plataforma (
    id_pelicula INT,
    id_actor INT,
    id_plataforma INT,
    PRIMARY KEY (id_pelicula, id_actor, id_plataforma)
);





/* 
Resumen conceptual
| Forma Normal | Problema resuelto          |
| ------------ | -------------------------- |
| 1FN          | Grupos repetidos           |
| 2FN          | Dependencias parciales     |
| 3FN          | Dependencias transitivas   |
| 4FN          | Dependencias multivaluadas |
| 5FN          | Dependencias de JOIN       |
*/