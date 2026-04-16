--   ===========================================
--   PRACTICA 1 � CONSULTAS SQL SIMPLES
--   Base de datos: Empleados
--   Tablas: clientes, departamentos, empleados
--   =========================================== 

-- Ejercicio 1: Mostrar todos los datos de todos los empleados.
SELECT * FROM empleados;
SELECT * FROM departamentos;
SELECT * FROM clientes;

-- Ejercicio 2: Listar el nombre y el email de todos los clientes.
SELECT nombre, email FROM clientes;

-- Ejercicio 3: Obtener todos los datos del cliente cuyo ID es 1.
SELECT * FROM clientes WHERE id_cliente=1;

-- Ejercicio 4: Mostrar los nombres de los empleados que tienen un salario entre 50.000 y 60.000.
SELECT nombre FROM empleados WHERE salario BETWEEN 50000 AND 60000;

-- Ejercicio 5: Listar los empleados cuyo nombre comienza con la letra "M".
SELECT * FROM empleados WHERE nombre LIKE 'M%';

-- Ejercicio 6: Mostrar los nombres de los empleados que pertenecen a los departamentos 2 o 3.
SELECT nombre FROM empleados WHERE id_departamento = 2 OR id_departamento = 3;

-- Ejercicio 7: Listar el nombre y salario de los empleados ordenados por salario de menor a mayor.
SELECT nombre, salario FROM empleados ORDER BY salario ASC;

-- Ejercicio 8: Listar el nombre y salario de los empleados ordenados por salario de mayor a menor.
SELECT nombre, salario FROM empleados ORDER BY salario DESC;

-- Ejercicio 9: Mostrar el nombre y salario de los empleados ordenados primero por salario de mayor a menor y, en caso de empate, por nombre en orden alfab�tico.
SELECT nombre, salario FROM empleados ORDER BY salario DESC, nombre ASC;

-- Ejercicio 10: Mostrar el nombre de los empleados y su salario anual (salario mensual * 12), ordenados de mayor a menor.
SELECT nombre, salario*12 AS "Salario Anual" FROM empleados ORDER BY "Salario Anual" DESC;

-- Ejercicio 11: Listar los nombres de los empleados ordenados por la longitud del nombre, del más largo al más corto.
SELECT nombre FROM empleados ORDER BY LENGTH(nombre) DESC;

-- Ejercicio 12: Mostrar el nombre y salario de los empleados ordenando primero los que tienen salario informado (no nulo) de mayor a menor, y dejando al final los que no tienen salario.
SELECT nombre, salario FROM empleados ORDER BY salario IS NOT NULL DESC, salario;

-- Ejercicio 13: Listar los empleados mostrando su nombre y departamento, colocando primero a los que pertenecen al departamento 3 y luego al resto, ordenados alfabaticamente por nombre.
SELECT nombre, id_departamento FROM empleados ORDER BY id_departamento = 3 DESC, nombre ASC;

-- Ejercicio 14: Mostrar los 3 empleados con mayor salario, excluyendo aquellos que no tienen salario informado.
SELECT * FROM empleados WHERE salario IS NOT NULL ORDER BY salario DESC LIMIT 3; 
   
-- Ejercicio 15: Listar los nombres de los empleados ordenados de mayor a menor según su salario.
SELECT nombre FROM empleados ORDER BY salario DESC;

-- Ejercicio 16: Mostrar los nombres de los empleados en un orden aleatorio.
SELECT nombre FROM empleados ORDER BY RANDOM();

-- Ejercicio 17: Mostrar el ID, nombre y salario de los empleados ordenados por salario de mayor a menor, omitiendo los primeros 5 registros y mostrando los siguientes 10.
SELECT id_empleado, nombre, salario FROM empleados ORDER BY salario DESC OFFSET 5 LIMIT 10;

-- Ejercicio 18: Calcular el salario promedio de los empleados del departamento 2 (mostrar como promedio_salario).
SELECT AVG(salario) AS "promedio_salario" FROM empleados WHERE id_departamento = 2;

-- Ejercicio 19: Obtener el salario máximo de los empleados con salario mayor a 50.000 (mostrar como salario_maximo).
SELECT MAX(salario) AS "salario_maximo" FROM empleados WHERE salario>50000;

-- Ejercicio 20: Obtener el salario mínimo de los empleados del departamento 3 (mostrar como salario_minimo).
SELECT MIN(salario) AS "salario_minimo" FROM empleados WHERE id_departamento = 3;

-- Ejercicio 21: Contar la cantidad de empleados del departamento 1 (mostrar como cantidad_empleados).
SELECT COUNT(*) AS cantidad_empleados FROM empleados WHERE id_departamento = 1;

-- Ejercicio 22: Contar cuántos empleados tienen salario mayor a 55.000 (mostrar como empleados_con_salario_alto).
SELECT COUNT(*) AS "empleados_con_salario_alto" FROM empleados WHERE salario > 55000;