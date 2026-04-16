-- =========================
-- Insertar países
-- =========================
INSERT INTO pais (id, nombre) VALUES
(1, 'Estados Unidos'),
(2, 'Reino Unido'),
(3, 'Francia'),
(4, 'Argentina'),
(5, 'España'),
(6, 'Canada'),
(7, 'Italia'),
(8, 'Australia');

-- =========================
-- Insertar directores
-- =========================
INSERT INTO director (id, pais_nacimiento, anio_nacimiento, nombre, apellido) VALUES
(1, 1, 1946, 'Steven', 'Spielberg'),
(2, 2, 1970, 'Christopher', 'Nolan'),
(3, 1, 1963, 'Quentin', 'Tarantino'),
(4, 5, 1949, 'Pedro', 'Almodovar'),
(5, 1, 1954, 'James', 'Cameron'),
(6, 1, 1964, 'Guillermo', 'del Toro'),
(7, 4, 1959, 'Juan Jose', 'Campanella'),
(8, 6, 1967, 'Denis', 'Villeneuve'),
(9, 1, 1942, 'Martin', 'Scorsese'),
(10, 8, 1962, 'Baz', 'Luhrmann');

-- =========================
-- Insertar actores
-- =========================
INSERT INTO actor (id, pais_nacimiento, anio_nacimiento, nombre, apellido) VALUES
(1, 1, 1974, 'Leonardo', 'DiCaprio'),
(2, 2, 1990, 'Emma', 'Watson'),
(3, 5, 1974, 'Penelope', 'Cruz'),
(4, 4, 1957, 'Ricardo', 'Darin'),
(5, 1, 1963, 'Brad', 'Pitt'),
(6, 6, 1981, 'Natalie', 'Portman'),
(7, 1, 1956, 'Tom', 'Hanks'),
(8, 2, 1974, 'Christian', 'Bale'),
(9, 1, 1937, 'Morgan', 'Freeman'),
(10, 6, 1994, 'Saoirse', 'Ronan'),
(11, 1, 1943, 'Robert', 'De Niro'),
(12, 1, 1970, 'Matt', 'Damon'),
(13, 5, 1985, 'Gal', 'Gadot'),
(14, 8, 1968, 'Hugh', 'Jackman'),
(15, 3, 1975, 'Marion', 'Cotillard'),
(16, 5, 1960, 'Antonio', 'Banderas'),
(17, 8, 1969, 'Cate', 'Blanchett'),
(18, 5, 1969, 'Javier', 'Bardem'),
(19, 1, 1988, 'Emma', 'Stone'),
(20, 3, 1977, 'Michael', 'Fassbender');

-- =========================
-- Insertar categorías
-- =========================
INSERT INTO categoria (id, nombre) VALUES
(1, 'Accion'),
(2, 'Drama'),
(3, 'Comedia'),
(4, 'Ciencia Ficcion'),
(5, 'Terror'),
(6, 'Romance'),
(7, 'Aventura'),
(8, 'Animacion');

-- =========================
-- Insertar películas
-- =========================
INSERT INTO pelicula (id, sinopsis, categoria, director, anio_estreno, recaudacion, titulo) VALUES
(1, 'Ladron roba secretos mediante suenos', 4, 2, 2010, 829.89, 'Inception'),
(2, 'Parque con dinosaurios clonados', 1, 1, 1993, 1029.15, 'Jurassic Park'),
(3, 'Historia de mujeres en La Mancha', 2, 4, 2006, 124.50, 'Volver'),
(4, 'Investigacion de caso sin resolver', 2, 7, 2009, 34.90, 'El secreto de sus ojos'),
(5, 'Romance en el Titanic', 6, 5, 1997, 2187.50, 'Titanic'),
(6, 'Historias cruzadas de crimen', 2, 3, 1994, 213.90, 'Pulp Fiction'),
(7, 'Persecuciones en mundo postapocaliptico', 7, 10, 2015, 378.90, 'Mad Max Fury Road'),
(8, 'Conflictos en planeta desertico', 4, 8, 2021, 400.00, 'Dune'),
(9, 'Busqueda de paciente desaparecida', 2, 2, 2010, 294.80, 'Shutter Island'),
(10, 'Venganza tras ataque de oso', 2, 9, 2015, 533.00, 'The Revenant'),
(11, 'Origenes de Batman', 1, 2, 2005, 374.20, 'Batman Begins'),
(12, 'Romance entre musico y actriz', 6, 10, 2016, 446.10, 'La La Land'),
(13, 'Historia del crimen organizado', 2, 9, 2019, 8.00, 'The Irishman'),
(14, 'Animales viven en sociedad moderna', 8, 1, 2016, 1023.00, 'Zootopia'),
(15, 'Fantasia en posguerra espanola', 5, 6, 2006, 83.00, 'El laberinto del fauno');

-- =========================
-- Relación actores_x_película
-- =========================
INSERT INTO actores_x_pelicula (id_actor, id_pelicula) VALUES
(1,1),
(2,1),
(5,2),
(7,2),
(3,3),
(4,4),
(1,5),
(5,5),
(11,6),
(12,6),
(8,7),
(14,7),
(6,8),
(10,8),
(1,9),
(12,9),
(1,10),
(11,10),
(8,11),
(2,11),
(2,12),
(19,12),
(4,13),
(11,13),
(15,14),
(17,14),
(16,15),
(18,15);
