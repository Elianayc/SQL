----READ COMMIT PARA MOSTRAR AISLAMIENTO EN CONSULTAS

--Muestro aislamiento actual (read commited)
SHOW transaction_isolation;

------------------------------------------------------------

--Creo tabla e ingreso datos
DROP TABLE IF EXISTS cuentas;

CREATE TABLE cuentas (
    id SERIAL PRIMARY KEY,
    saldo INT
);

INSERT INTO cuentas (saldo) VALUES (100), (200);

------------------------------------------------------------

S1: --Sesión 1
BEGIN;
SELECT SUM(saldo) FROM cuentas;

S2: --Sesión 2
SELECT * FROM cuentas;

------------------------------------------------------------

S1: --Sesión 1 
-- resto a saldo 50 al saldo de id 2, queda 150.
UPDATE cuentas SET saldo = saldo - 50 WHERE id = 2;
SELECT SUM(saldo) FROM cuentas;

S2: --Sesión 2
-- No se ve ningún cambio hecho en la sesión 1.
SELECT * FROM cuentas;

------------------------------------------------------------

S1: --Sesión 1
COMMIT;

S2: --Sesión 2
-- Ahora sí se ven los cambios y saldo de id=2 es 150.
SELECT * FROM cuentas;

------------------------------------------------------------