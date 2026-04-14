/* Generar las sentencias SQL para generar las siguientes consultas:*/

-- 1. Listar los identificadores de categoría que aparecen en la tabla de productos, sin repetir valores.
SELECT DISTINCT id_categoria FROM productos;

-- 2. Obtener la cantidad total de categorías distintas presentes en los productos.
SELECT COUNT(DISTINCT id_categoria) AS "total_categorias" FROM productos;

-- 3. Mostrar cuántos productos hay en cada categoría.
SELECT id_categoria, COUNT(*) AS "cantidad"
FROM productos 
GROUP BY id_categoria;

-- 4. Calcular el precio promedio de los productos por categoría.
SELECT id_categoria, AVG(precio) AS "precio_promedio"
FROM productos
GROUP BY id_categoria;

-- 5. Obtener la suma total de los precios de los productos por cada categoría.
SELECT id_categoria, SUM(precio) AS "suma_precios"
FROM productos
GROUP BY id_categoria;

-- 6. Mostrar el precio mínimo y el precio máximo de los productos por categoría.
SELECT id_categoria, 
MIN(precio) AS "min_precio", 
MAX(precio) AS "max_precio"
FROM productos
GROUP BY id_categoria;

-- 7. Listar las categorías cuyo precio promedio de productos sea mayor a 1500.
SELECT id_categoria, AVG(precio) AS "precio_promedio"
FROM productos
GROUP BY id_categoria
HAVING AVG(precio) > 1500;

-- 8. Mostrar las categorías que tienen 3 o más productos.
SELECT id_categoria
FROM productos
GROUP BY id_categoria
HAVING COUNT(*) >= 3;

-- 9. Indicar, para cada categoría, cuántos productos tienen precio cargado (es decir, distinto de NULL).

--WHERE → filtra filas antes del GROUP BY
--HAVING → filtra grupos después del GROUP BY
SELECT id_categoria,
COUNT(*) AS "cantidad_con_precio"
FROM productos 
WHERE precio IS NOT NULL
GROUP BY id_categoria;
--FROM → WHERE → GROUP BY → HAVING → SELECT

-- 10. Listar el nombre de cada producto junto con el nombre de su categoría, considerando solo aquellos productos 
-- que tienen categoría asociada.
SELECT p.nombre, c.nombre_categoria
FROM productos p, categorias c
WHERE p.id_categoria = c.id_categoria;

-- MEJOR:
SELECT p.nombre, c.nombre_categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria;
-- FROM/JOIN → cómo se conectan las tablas
-- WHERE → qué filas querés filtrar

-- 11. Listar el nombre de cada producto, su categoría y la sucursal a la que pertenece dicha categoría.
SELECT p.nombre, c.nombre_categoria, s.nombre
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
JOIN sucursales s ON c.id_sucursal = s.id_sucursal;

-- 12. Listar todos los productos junto con su categoría, incluyendo aquellos productos que no tienen categoría 
-- asignada. 
SELECT p.nombre, c.nombre_categoria, s.nombre 
  FROM productos p 
  LEFT JOIN categorias c ON p.id_categoria = c.id_categoria 
  LEFT JOIN sucursales s ON c.id_sucursal = s.id_sucursal; 
--Se usa LEFT para indicar que quiero TODAS las filas de la tabla izquierda, tengan o no coincidencia en la derecha.

-- 13. Listar todas las categorías junto con los productos asociados, incluyendo aquellas categorías que no tienen 
-- productos.
SELECT c.nombre_categoria, p.nombre AS producto
FROM categorias c
LEFT JOIN productos p ON c.id_categoria = p.id_categoria;

-- 14. Listar todos los productos y todas las categorías, incluyendo tanto productos sin categoría como categorías
-- sin productos.
SELECT p.nombre AS producto, c.nombre_categoria
FROM productos p
FULL JOIN categorias c 
ON p.id_categoria = c.id_categoria;

-- LEFT JOIN → conservo izquierda
-- RIGHT JOIN → conservo derecha
-- FULL JOIN → conservo TODO

-- 15. Mostrar todos los productos que no tienen precio cargado.
SELECT * FROM productos WHERE precio IS NULL;

-- 16. Listar los productos cuyo precio sea mayor a 1500.
SELECT * FROM productos WHERE precio > 1500;

-- 17. Mostrar los productos que no tienen categoría asignada.
SELECT * FROM productos WHERE id_categoria IS NULL;

-- 18. Obtener la cantidad total de productos.
SELECT COUNT (*) FROM productos;

-- 19. Obtener la cantidad de productos que tienen precio cargado.
SELECT * FROM productos WHERE id_categoria IS NOT NULL;

-- 20. Mostrar el nombre del producto, su precio, el precio con IVA (21%) y la ciudad de la sucursal a la que 
-- pertenece (si tiene).
SELECT 
  p.nombre, 
  p.precio, 
  p.precio*1.21 AS IVA, 
  s.ciudad 
FROM productos p
LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
LEFT JOIN sucursales s ON c.id_sucursal = s.id_sucursal;
