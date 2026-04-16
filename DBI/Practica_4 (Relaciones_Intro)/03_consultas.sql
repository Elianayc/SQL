/* Generar las sentencias SQL para generar las siguientes consultas:*/
SELECT * FROM modelos;
SELECT * FROM versiones;
SELECT * FROM sucursales;

/* Del 1 al 22 están hechos en el ejercicio anterior. */

-- 23. Insertar un nuevo registro en la tabla modelos con los siguientes valores:
-- id_modelo: NULL
-- nombre: 'Modelo X'
-- tipo: 'sedan'

INSERT INTO modelos (id_modelo, nombre, tipo) 
VALUES(NULL, 'Sedan', 'Modelo X'); 
SELECT * FROM modelos;
--Da error porque id_modelo es NOT NULL ya que es PRIMARY KEY.

-- 24. Insertar un nuevo registro en la tabla modelos con los siguientes valores:
-- id_modelo: 1
-- nombre: 'Modelo duplicado'
-- tipo: 'suv'

INSERT INTO modelos (id_modelo, nombre, tipo)
VALUES(1, 'Modelo duplicado', 'suv');
SELECT * FROM modelos;
--Da error porque la PRIMARY KEY debe ser única.

-- 25. Insertar un nuevo registro en la tabla versiones con los siguientes valores:
-- id_version: 99
-- id_modelo: 999
-- nombre: 'Versión inválida'
-- motor: 'nafta'
-- precio: 1000000

INSERT INTO versiones (id_version, id_modelo, nombre, motor, precio)
VALUES(99, 999, 'Versión inválida', 'nafta', 1000000);
SELECT * FROM versiones;
--Da error porque no existe el id_modelo 999 en la tabla modelos. 

-- 26. Insertar un nuevo registro en la tabla sucursales con los siguientes valores:
-- id_sucursal: 99
-- nombre: 'Sucursal Fantasma'
-- ciudad: 'Buenos Aires'
-- id_version: 999
-- stock: 10
INSERT INTO sucursales (id_sucursal, nombre, ciudad, id_version, stock)
VALUES(99, 'Sucursal Fantasma', 'Buenos Aires', 999, 10);
SELECT * FROM sucursales;
--Da error porque no existe el id_sucursal 99 en la tabla versiones. 


-- 27. Eliminar el registro de la tabla modelos cuyo id_modelo sea 1.
DELETE FROM modelos WHERE id_modelo = 1;
SELECT * FROM modelos;
--Da error porque no se puede borrar un registro que es referido por otra tabla.

-- 28. Eliminar el registro de la tabla versiones cuyo id_version sea 1.
DELETE FROM versiones WHERE id_modelo = 1;
SELECT * FROM versiones;
--Da error porque no se puede borrar un registro que es referido por otra tabla.

-- 29. Insertar un nuevo registro en la tabla versiones con los siguientes valores:
-- id_version: 1
-- id_modelo: 1
-- nombre: 'Duplicado'
-- motor: 'nafta'
-- precio: 100
INSERT INTO versiones (id_version, id_modelo, nombre, motor, precio)
VALUES(1, 1, 'Duplicado', 'nafta', 100);
SELECT * FROM versiones;
--Da error porque la PRIMARY KEY debe ser única.

-- 30. Actualizar el campo id_modelo de la tabla versiones a 999 para el registro cuyo id_version sea 1.
UPDATE versiones
SET id_modelo = 999
WHERE id_version = 1;
SELECT * FROM versiones;
--Da error porque no existe id_modelo 999 en la tabla modelos.

-- 31. Intentar eliminar completamente la tabla modelos.
DROP TABLE modelos;
--Da error porque no se puede eliminar una tabla si otra depende de ella.

-- 32. Eliminar completamente la tabla modelos utilizando la opción CASCADE.
DROP TABLE modelos CASCADE;
SELECT * FROM versiones;
--Borra la tabla y todos las relaciones con ella. 

