----------------------------------------------------------------------------------
/* CONSULTAS SOBRE UNA TABLA */
SELECT * FROM director;
SELECT * FROM actor;
SELECT * FROM pais;
SELECT * FROM categoria;
SELECT * FROM pelicula;
SELECT * FROM actores_x_pelicula;

-- a. Corregir el nombre de la película cuyo id es 2.
UPDATE pelicula SET titulo = 'Parque Jurásico' WHERE id = 2;
SELECT * FROM pelicula;

-- b. Dejar vacío (NULL) el campo director de las películas cuyo año de estreno 
-- sea menor a 1995.
UPDATE pelicula SET director = NULL WHERE anio_estreno < 1995;
SELECT * FROM pelicula;

-- 1. Listar todos los datos de todos los directores.
SELECT * FROM director;

-- 2. Listar el nombre de todos los directores.
SELECT nombre FROM director;

-- 3. Listar el nombre y el año de estreno de todas las películas.
SELECT titulo, anio_estreno FROM pelicula;

-- 4. Listar el nombre y la recaudación de cada película en pesos y dólares (2 decimales).
SELECT titulo, 
recaudacion AS recaudacion_usd, 
ROUND(recaudacion*1400,2) AS recaudacion_ars 
FROM pelicula;

-- 5. Listar el nombre de todo el elenco con columna nombre_completo.
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM actor;

-- 6. Listar el código de los directores que dirigieron películas entre 2005 y 2015, 
-- sin duplicados.
SELECT DISTINCT director
FROM pelicula
WHERE anio_estreno BETWEEN 2005 AND 2015;

-- 7. Listar las películas estrenadas entre 2015 y 2021 ordenadas por año descendente 
-- y nombre ascendente.
SELECT *
FROM pelicula
WHERE anio_estreno BETWEEN 2015 AND 2021
ORDER BY anio_estreno DESC, titulo ASC;

-- 8. Listar las películas que no se estrenaron en 2016.
SELECT * FROM pelicula
WHERE anio_estreno <> 2016;

-- 9. Listar el nombre y apellido del director más joven.
SELECT nombre, apellido
FROM director
ORDER BY anio_nacimiento DESC
LIMIT 1;

-- 10. Listar todas las películas cuya categoría sea Acción, Drama, Animación 
-- usando los códigos de categorías según nuestro ejemplo: Acción=1, Drama=2, Animación=8.
SELECT *
FROM pelicula
WHERE categoria IN (1, 2, 8);

-- 11. Listar todas las películas cuyo año de estreno no sea 2006, 2010, 2015.
SELECT *
FROM pelicula
WHERE anio_estreno NOT IN (2006, 2010, 2015);

-- 12. Listar las películas cuyo nombre contenga la palabra "Max".
SELECT * FROM pelicula 
WHERE titulo LIKE '%Max%';

-- 13. Listar las películas cuyo año de estreno > 2010 y < 2016 o recaudación < 100 
-- recaudación en millones USD.
SELECT * FROM pelicula
WHERE (anio_estreno > 2010 AND anio_estreno < 2016)
OR recaudacion < 100;

-- 14. Listar actores nacidos en 1974 y de nacionalidad española España = id 5.
SELECT * FROM actor
WHERE anio_nacimiento = 1974 
AND pais_nacimiento = 5;

-- 15. Listar nombre, apellido y año de nacimiento de actores y directores nacidos 
-- en 1970, indicando tipo.
SELECT nombre, apellido, anio_nacimiento, 'Actor' AS tipo 
FROM actor 
WHERE anio_nacimiento = 1970 

UNION 

SELECT nombre, apellido, anio_nacimiento, 'Director' AS tipo 
FROM director 
WHERE anio_nacimiento = 1970; 
/*
JOIN 👉 une datos relacionados 
(clientes ↔ pedidos) 

UNION 👉 apila resultados que solo coinciden en estructura 
(clientes + sucursales, por ejemplo) 
*/

----------------------------------------------------------------------------------
/* CONSULTAS MULTITABLA */

-- 1. Listar nombre completo del elenco y nombre de películas. Orden por película 
-- y actor.
SELECT CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
	   p.titulo AS pelicula
FROM actores_x_pelicula axp

-- Join con tabla actor por FK
JOIN actor a ON axp.id_actor = a.id

-- Join con tabla pelicula por FK
JOIN pelicula p ON axp.id_pelicula = p.id

-- Ordenamiento
ORDER BY p.titulo ASC, a.nombre ASC;


-- 2. Nombre completo, nacionalidad de todo el elenco y nombre de películas del director 
-- con código 1.
SELECT CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
       pa.nombre AS pais,
       p.titulo AS pelicula
       
FROM actores_x_pelicula AS axp

-- Join con tabla actor por FK
JOIN actor AS a ON axp.id_actor = a.id

-- Join con tabla pelicula por FK
JOIN pelicula AS p ON axp.id_pelicula = p.id

-- Join con tabla director por FK
JOIN director AS d ON p.director = d.id

-- Join con tabla pais por FK
JOIN pais AS pa ON a.pais_nacimiento = pa.id

-- Filtro
WHERE d.id = 1

-- Ordenamiento
ORDER BY p.titulo ASC, a.nombre ASC;


-- 3. Nombre de todos los directores que no estrenaron película en 2015 o 2020.



-- 4. Nombre de directores junto con sus películas.



-- 5. Igual que anterior, incluyendo directores sin películas.



-- 6. Actores nacidos entre 1970 y 1990, con o sin película estrenada en 2020.


-----------------------------------------------------------------------
/* CONSULTAS ESTADÍSTICAS */

-- 1. Total de películas.
SELECT COUNT(*) AS total_peliculas
FROM pelicula;

-- 2. Número de directores (distintos) a partir de datos en películas.
SELECT COUNT(DISTINCT director) AS total_directores
FROM pelicula;

-- 3. Mínimo y máximo valor de recaudación.
SELECT MIN(recaudacion) AS minimo, 
	   MAX(recaudacion) AS maximo
FROM pelicula;

-- 4. Código de la categoría cuya película tuvo menor recaudación.


-- 5. Número de películas estrenadas en 2018.


-- 6. Número de películas por director.


-- 7. Categorías con promedio de recaudación superior a AR$ 500000.
/*
ORDEN CORRECTO DE EJECUCIÓN EN SQL
1. FROM (armar el conjunto base de datos)
2. JOIN (relacionar tablas)
3. WHERE (filtrar filas crudas)
4. GROUP BY (formar grupos)
5. AGREGACIONES (AVG, SUM, MIN, MAX, COUNT, etc.)
6. HAVING (filtrar grupos ya agregados)
7. SELECT (elegir qué mostrar y calcular expresiones finales)
8. DISTINCT (eliminar duplicados del resultado final)
9. ORDER BY (ordenar el resultado final)
10. LIMIT / OFFSET (recortar filas finales)
*/

--Tomo los nombres de las categorías
SELECT c.nombre AS categoria,
--Calculo y muestro los promedios de las recaudaciones de cada categoria
-- uso ::numeric para asegurar precisión decimal en el cálculo
-- especialmente cuando intervienen valores enteros.
-- uso ROUND(x, 2) para mostrar el resultado con 2 decimales.
	ROUND(AVG(p.recaudacion*1400)::numeric,2) AS promedio_ars
FROM pelicula AS p

--Join con la tabla categorias para reemplazar id_categoria por sus nombres.
JOIN categoria AS c ON p.categoria = c.id

-- Agrupo por categoría, uno todos los que son de la misma.
GROUP BY c.id, c.nombre

-- Filtro las categorías ya agrupadas, para quedarme las que necesito.
HAVING AVG(p.recaudacion*1400)>500000;



-- 8. Directores que estrenaron menos de 5 películas.

----------------------------------------------------------------------
/* SUBCONSULTAS */

-- 1. Películas cuya recaudación > promedio de recaudación de 2018.
SELECT * FROM pelicula
WHERE recaudacion > (
	SELECT AVG(recaudacion) 
	FROM pelicula 
	WHERE anio_estreno = 2018
);
	
-- 2. Directores que no hayan estrenado películas.

-- 3. Nombre del director junto con el nombre y recaudación de su película más taquillera.

----------------------------------------------------------------------
