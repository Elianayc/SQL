-- =========================================================
-- LIMPIEZA INICIAL
-- =========================================================

-- Elimina índices si ya existían para evitar errores.
DROP INDEX IF EXISTS i_sample;
DROP INDEX IF EXISTS i_sample1;
DROP INDEX IF EXISTS i_sample2;



-- =========================================================
-- OBTENER DATOS DEL CATÁLOGO DEL SISTEMA
-- =========================================================

SELECT relname
FROM pg_class
ORDER BY 1
LIMIT 8;

-- pg_class es una tabla interna de PostgreSQL.
-- Guarda información sobre tablas, índices, secuencias, etc.
--
-- relname = nombre del objeto.
--
-- Esto muestra algunos nombres de objetos del sistema.
--
-- Ejemplo:
-- pg_class
-- pg_index
-- pg_proc
-- etc.



SELECT substring(relname, 1, 1)
FROM pg_class
ORDER BY 1
LIMIT 8;

-- substring(relname, 1, 1)
-- toma SOLO la primera letra del nombre.
--
-- Ejemplo:
-- pg_class -> p
-- pg_index -> p
--
-- Esto se usa luego para generar datos simples
-- y repetidos dentro de la tabla sample.



-- =========================================================
-- CREACIÓN DE TABLA TEMPORAL
-- =========================================================

DROP TABLE IF EXISTS sample;

CREATE TEMPORARY TABLE sample (letter, junk) AS
    SELECT substring(relname, 1, 1), repeat('x', 250)
    FROM pg_class
    ORDER BY random();

-- CREATE TEMPORARY TABLE
-- crea una tabla temporal.
--
-- Las tablas temporales:
-- - solo existen durante la sesión actual
-- - desaparecen al cerrar la conexión
--
-- letter:
-- guarda la primera letra del nombre.
--
-- junk:
-- genera texto largo con repeat('x',250)
-- solo para hacer filas más "pesadas".
--
-- ORDER BY random()
-- mezcla aleatoriamente las filas.



-- =========================================================
-- INSPECCIONAR DATOS
-- =========================================================

SELECT * FROM sample LIMIT 10;

-- Muestra algunas filas de la tabla temporal.



SELECT COUNT(*) FROM sample;

-- Cuenta cuántas filas tiene la tabla.



SELECT letter, COUNT(*) 
FROM sample
GROUP BY letter
ORDER BY letter;

-- Cuenta cuántas veces aparece cada letra.
--
-- Esto es importante porque:
-- PostgreSQL decidirá si usar índice
-- dependiendo de cuántas filas coincidan.



-- =========================================================
-- CONSULTA SIN ÍNDICE
-- =========================================================

EXPLAIN SELECT * FROM sample WHERE letter = 'p';

-- EXPLAIN muestra el plan de ejecución.
--
-- Resultado esperado:
--
-- Seq Scan on sample
--
-- PostgreSQL recorre TODA la tabla
-- buscando filas con letter='p'.
--
-- Esto ocurre porque NO existe índice.



-- =========================================================
-- CREAR ÍNDICE
-- =========================================================

DROP INDEX IF EXISTS i_sample;

CREATE INDEX i_sample ON sample(letter);

-- Crea un índice B-tree sobre la columna letter.
--
-- Un índice funciona como un mapa rápido
-- para encontrar registros sin recorrer toda la tabla.



SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE tablename = 'sample';

-- Muestra los índices asociados a la tabla sample.



-- =========================================================
-- CONSULTA CON ÍNDICE
-- =========================================================

EXPLAIN SELECT * FROM sample WHERE letter = 'p';

-- Ahora PostgreSQL detecta el índice.
--
-- Resultado esperado:
--
-- Bitmap Index Scan
--
-- PostgreSQL:
-- 1) usa el índice para localizar coincidencias
-- 2) luego accede a las filas reales
--
-- Esto es más eficiente cuando pocas filas coinciden.



-- =========================================================
-- ANALYZE
-- =========================================================

ANALYZE sample;

-- ANALYZE actualiza estadísticas internas.
--
-- PostgreSQL aprende:
-- - cantidad de filas
-- - distribución de valores
-- - frecuencia de datos
--
-- Estas estadísticas ayudan al planner
-- a decidir el mejor plan.



EXPLAIN SELECT * FROM sample WHERE letter = 'p';

-- Luego de ANALYZE puede volver a usar Seq Scan.
--
-- ¿Por qué?
--
-- Porque PostgreSQL descubre que:
-- hay MUCHAS filas con letter='p'.
--
-- Entonces usar índice deja de ser eficiente.
--
-- Si hay demasiadas coincidencias,
-- suele ser más rápido leer toda la tabla.



EXPLAIN SELECT * FROM sample WHERE letter = 'f';

-- Para otra letra menos frecuente,
-- PostgreSQL sí usa el índice.
--
-- Porque pocas filas coinciden.



-- =========================================================
-- FORZAR PLANES
-- =========================================================

SET enable_seqscan = false;

-- Deshabilita temporalmente Sequential Scan.
--
-- PostgreSQL se ve obligado
-- a usar otros métodos.



EXPLAIN SELECT * FROM sample WHERE letter = 'p';

-- Ahora usa índice aunque no sea eficiente.
--
-- Esto sirve para pruebas y análisis.



SET enable_seqscan = true;

-- Vuelve a habilitar Sequential Scan.



-- =========================================================
-- CLUSTER
-- =========================================================

CLUSTER sample USING i_sample;

-- Reordena físicamente la tabla
-- siguiendo el orden del índice.
--
-- Filas con valores similares
-- quedan almacenadas juntas.
--
-- Esto puede mejorar acceso secuencial
-- y locality de lectura.



EXPLAIN SELECT * FROM sample WHERE letter = 'p';

-- PostgreSQL sigue pudiendo elegir Seq Scan.
--
-- CLUSTER no obliga a usar índices.



ANALYZE sample;

-- Actualiza nuevamente estadísticas.



EXPLAIN SELECT * FROM sample WHERE letter = 'p';

-- El planner vuelve a decidir el plan
-- según costos estimados.



VACUUM sample;

-- VACUUM limpia espacio interno
-- y mantiene la tabla saludable.
--
-- Elimina espacio muerto generado
-- por updates/deletes.



EXPLAIN SELECT * FROM sample WHERE letter = 'p';

-- Permite observar si cambió el plan.



-- =========================================================
-- SEGUNDA PARTE: JOINS
-- =========================================================

DROP TABLE IF EXISTS sample1;

CREATE TEMPORARY TABLE sample1 (id, junk) AS
    SELECT oid, repeat('x', 250)
    FROM pg_proc
    ORDER BY random();

-- sample1 contiene:
-- - oid
-- - texto basura
--
-- oid = identificador interno.



DROP TABLE IF EXISTS sample2;

CREATE TEMPORARY TABLE sample2 (id, junk) AS
    SELECT oid, repeat('x', 250)
    FROM pg_class
    ORDER BY random();

-- sample2 similar a sample1.



-- =========================================================
-- JOIN SIN ÍNDICES
-- =========================================================

EXPLAIN SELECT s1.id, s1.junk, s2.junk
FROM sample1 s1
JOIN sample2 s2 ON s1.id = s2.id
WHERE s1.id = 33;

-- Resultado esperado:
--
-- Nested Loop
-- Seq Scan
--
-- PostgreSQL:
-- 1) recorre sample1
-- 2) recorre sample2
-- 3) compara filas
--
-- Esto es costoso sin índices.



-- =========================================================
-- CREAR ÍNDICES
-- =========================================================

CREATE INDEX i_sample1 ON sample1(id);
CREATE INDEX i_sample2 ON sample2(id);

-- Índices sobre columnas id.



EXPLAIN SELECT s1.id, s1.junk, s2.junk
FROM sample1 s1
JOIN sample2 s2 ON s1.id = s2.id
WHERE s1.id = 33;

-- Ahora PostgreSQL puede usar:
--
-- Bitmap Index Scan
--
-- porque puede localizar rápidamente
-- las filas con id=33.



-- =========================================================
-- ANALYZE EN JOINS
-- =========================================================

ANALYZE sample1;
ANALYZE sample2;

-- Actualiza estadísticas reales
-- de ambas tablas.



EXPLAIN SELECT s1.id, s1.junk, s2.junk
FROM sample1 s1
JOIN sample2 s2 ON s1.id = s2.id
WHERE s1.id = 33;

-- Ahora aparece:
--
-- Index Scan
--
-- PostgreSQL entiende que:
-- id=33 devuelve muy pocas filas.
--
-- Entonces el índice es ideal.



-- =========================================================
-- CLUSTER EN JOINS
-- =========================================================

CLUSTER sample1 USING i_sample1;
CLUSTER sample2 USING i_sample2;

-- Reordena físicamente ambas tablas
-- siguiendo los índices.



ANALYZE sample1;
ANALYZE sample2;

-- Actualiza estadísticas nuevamente.



EXPLAIN SELECT s1.id, s1.junk, s2.junk
FROM sample1 s1
JOIN sample2 s2 ON s1.id = s2.id
WHERE s1.id = 33;

-- PostgreSQL vuelve a evaluar costos
-- y elige el mejor plan disponible.



VACUUM sample1, sample2;

-- Limpieza y mantenimiento interno.



EXPLAIN SELECT s1.id, s1.junk, s2.junk
FROM sample1 s1
JOIN sample2 s2 ON s1.id = s2.id
WHERE s1.id = 33;

-- Verificación final del plan de ejecución.

