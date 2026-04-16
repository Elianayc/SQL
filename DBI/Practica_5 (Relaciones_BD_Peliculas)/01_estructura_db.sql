CREATE TABLE pais(
	id INT PRIMARY KEY,
	nombre VARCHAR(30)
);

CREATE TABLE director(
	id INT PRIMARY KEY,
	pais_nacimiento INT,
	anio_nacimiento INT,
	nombre VARCHAR(50),
	apellido VARCHAR(50),
	FOREIGN KEY (pais_nacimiento) REFERENCES pais(id)
);

CREATE TABLE categoria(
	id INT PRIMARY KEY,
	nombre VARCHAR(30)
);

CREATE TABLE actor(
	id INT PRIMARY KEY,
	pais_nacimiento INT,
	anio_nacimiento INT,
	nombre VARCHAR(50),
	apellido VARCHAR(50),
	FOREIGN KEY (pais_nacimiento) REFERENCES pais(id)
);

CREATE TABLE pelicula(
	id INT PRIMARY KEY,
	sinopsis VARCHAR(50),
	categoria INT,
	director INT,
	anio_estreno INT,
	recaudacion DECIMAL(10,2),
	titulo VARCHAR(50),
	FOREIGN KEY (categoria) REFERENCES categoria(id),
	FOREIGN KEY (director) REFERENCES director(id)
);

CREATE TABLE actores_x_pelicula(
	id_actor INT,
	id_pelicula INT,
	PRIMARY KEY (id_actor, id_pelicula),
	FOREIGN KEY (id_actor) REFERENCES actor(id),
	FOREIGN KEY (id_pelicula) REFERENCES pelicula(id)
);