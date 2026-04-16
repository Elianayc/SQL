SELECT * FROM director;
SELECT * FROM actor;
SELECT * FROM pais;
SELECT * FROM categoria;
SELECT * FROM pelicula;
SELECT * FROM actores_x_pelicula;


-- 1. Corregir el nombre de la película cuyo id es 2
UPDATE pelicula SET titulo = 'Parque Jurásico' WHERE id = 2;
SELECT * FROM pelicula;

-- 2. Dejar vacío (NULL) el campo director de las películas cuyo año de estreno sea menor a 1995
UPDATE pelicula SET director = NULL WHERE anio_estreno < 1995;
SELECT * FROM pelicula;

-- 1. Listar todos los datos de todos los directores
SELECT * FROM director;

-- 2. Listar el nombre de todos los directores
SELECT nombre FROM director;

-- 3. Listar el nombre y el año de estreno de todas las películas
SELECT titulo, anio_estreno FROM pelicula;

-- 4. Listar el nombre y la recaudación de cada película en pesos y dólares (2 decimales)
SELECT titulo, 
recaudacion AS recaudacion_usd, 
ROUND(recaudacion*1400,2) AS recaudacion_ars 
FROM pelicula;

-- 5. Listar el nombre de todo el elenco con columna nombre_completo
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM actor;

-- 6. Listar el código de los directores que dirigieron películas entre 2005 y 2015, sin duplicados
SELECT DISTINCT director
FROM pelicula
WHERE anio_estreno BETWEEN 2005 AND 2015;

-- 7. Listar las películas estrenadas entre 2015 y 2021 ordenadas por año descendente y nombre ascendente


-- 8. Listar las películas que no se estrenaron en 2016


-- 9. Listar el nombre y apellido del director más joven


-- 10. Listar todas las películas cuya categoría sea Acción, Drama, Animación usando los códigos de categorías según nuestro ejemplo: Acción=1, Drama=2, Animación=8


-- 11. Listar todas las películas cuyo año de estreno no sea 2006, 2010, 2015


-- 12. Listar las películas cuyo nombre contenga la palabra "Max"


-- 13. Listar las películas cuyo año de estreno > 2010 y < 2016 o recaudación < 100 recaudación en millones USD


-- 14. Listar actores nacidos en 1974 y de nacionalidad española España = id 5


-- 15. Listar nombre, apellido y año de nacimiento de actores y directores nacidos en 1970, indicando tipo

------------------------------------------------------------------------

-- 1. Listar nombre completo del elenco y nombre de películas. Orden por película y actor


-- 2. Nombre completo, nacionalidad de todo el elenco, y nombre de películas del director con código 1


-- 3. Nombre de todos los directores que no estrenaron película en 2015 o 2020


-- 4. Nombre de directores junto con sus películas


-- 5. Igual que anterior, incluyendo directores sin películas


-- 6. Actores nacidos entre 1970 y 1990, con o sin película estrenada en 2020

-----------------------------------------------------------------------

-- 1. Total de películas


-- 2. Número de directores (distintos) a partir de datos en películas


-- 3. Mínimo y máximo valor de recaudación


-- 4. Código de la categoría cuya película tuvo menor recaudación


-- 5. Número de películas estrenadas en 2018


-- 6. Número de películas por director


-- 7. Categorías con promedio de recaudación superior a AR$ 500000


-- 8. Directores que estrenaron menos de 5 películas

----------------------------------------------------------------------

-- 1. Películas cuya recaudación > promedio de recaudación de 2018

-- 2. Directores que no hayan estrenado películas

-- 3. Nombre del director junto con el nombre y recaudación de su película más taquillera

----------------------------------------------------------------------