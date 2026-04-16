/* Generar las sentencias SQL para generar las siguientes consultas:*/
SELECT * FROM modelos;
SELECT * FROM versiones;
SELECT * FROM sucursales;


--DDL - DEFINICIÓN DE DATOS

--1. Generar las tablas modelos, versiones, sucursales.
--Hecho

--2. Cargar las tablas con los registros suministrados.
--Hecho

--3. Verificar la correcta carga de los datos.
--Hecho

--4. Agregar una columna año (INT) a la tabla versiones.
ALTER TABLE versiones 
ADD COLUMN año INT;
SELECT * FROM versiones;

--5. Agregar una columna origen (VARCHAR(30)) a la tabla versiones.
ALTER TABLE versiones 
ADD COLUMN origen VARCHAR(30);
SELECT * FROM versiones;

--6. Agregar una columna teléfono (VARCHAR(20)) a la tabla sucursales.
ALTER TABLE sucursales 
ADD COLUMN telefono VARCHAR(20);
SELECT * FROM sucursales;

--7. Modificar la columna nombre de la tabla modelos para que permita hasta 100 caracteres.
ALTER TABLE modelos
ALTER COLUMN nombre TYPE VARCHAR(100) ;
SELECT * FROM modelos;

--8. Eliminar la columna origen de la tabla versiones.
ALTER TABLE versiones
DROP COLUMN origen;
SELECT * FROM versiones;


--DML - MANIPULACIÓN DE DATOS

--9. Completar la columna año en versiones con el valor 2025 para todos los registros.
UPDATE versiones
SET año = 2025;
SELECT * FROM versiones;

--10. Aumentar el precio de todas las versiones en un 10%.
UPDATE versiones
SET precio = precio*1.1;
SELECT * FROM versiones;

--11. Cambiar el motor a 'hibrido' para la versión 'XEI 2.0 CVT'.
UPDATE versiones
SET motor = 'hibrido'
WHERE nombre = 'XEI 2.0 CVT';
SELECT * FROM versiones;

--12. Actualizar el stock a 0 en todas las sucursales de la ciudad 'Salta'.
UPDATE sucursales
SET stock = 0
WHERE ciudad = 'Salta';
SELECT * FROM sucursales;

--13. Cambiar el nombre de la sucursal 'Toyota Caballito' a 'Toyota Centro'
UPDATE sucursales
SET nombre = 'Toyota Centro'
WHERE nombre = 'Toyota Caballito';
SELECT * FROM sucursales;

--14. Eliminar todas las versiones cuyo precio sea menor a 35.000.000.
DELETE FROM versiones
WHERE precio < 35000000;
SELECT * FROM versiones;

--15. Eliminar todas las sucursales que tengan stock igual a 0.
DELETE FROM sucursales
WHERE stock = 0;
SELECT * FROM sucursales;

--16. Eliminar los modelos de tipo 'hatchback'.
DELETE FROM modelos
WHERE tipo = 'hatchback';
SELECT * FROM modelos;

--17. Mostrar todos los registros de la tabla modelos.
SELECT * FROM modelos;

--18. Mostrar nombre y precio de todas las versiones.
SELECT nombre, precio FROM versiones;

--19. Mostrar todas las sucursales de la ciudad 'Buenos Aires'.
SELECT * FROM sucursales
WHERE ciudad = 'Buenos Aires';

--20. Mostrar las versiones cuyo precio sea mayor a 50.000.000.
SELECT * FROM versiones
WHERE precio > 50000000;

-- 21.	Mostrar el nombre del modelo y el nombre de la versión.
SELECT m.nombre AS modelo, v.nombre AS version
FROM modelos m
JOIN versiones v ON m.id_modelo = v.id_modelo;

-- 22.	Mostrar ciudad, nombre del modelo, nombre de la versión y stock.
SELECT s.ciudad, m.nombre AS modelo, v.nombre AS version, s.stock
FROM sucursales s
JOIN versiones v ON s.id_version = v.id_version
JOIN modelos m ON v.id_modelo = m.id_modelo;

-- 23.	Mostrar todas las versiones junto con su modelo, ordenadas por precio de mayor a menor.
SELECT m.nombre AS modelo, v.nombre AS version, v.precio
FROM modelos m
JOIN versiones v ON m.id_modelo = v.id_modelo
ORDER BY v.precio DESC;