---REPEATABLE READ PARA MOSTRAR COMO SE EVITA LECTURA NO REPETIBLE Y LECTURA FANTASMA

SHOW transaction_isolation;
--- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

DROP TABLE IF EXISTS cuentas;

CREATE TABLE cuentas (
    id SERIAL PRIMARY KEY,
    saldo INT
);

INSERT INTO cuentas (saldo) VALUES (100), (200);


--------------  LECTURA NO REPETIBLE  -----------------
S1:
BEGIN;
-- Fuerzo el isolation lvl a REPETEABLE READ.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
--Muestra 100.
SELECT saldo FROM cuentas WHERE id = 1;

S2: -- Update a 150.
UPDATE cuentas SET saldo = saldo + 50 WHERE id = 1;

S1: -- No muestra cambios de S2. Muestra 100.
SELECT saldo FROM cuentas WHERE id = 1;
----- y despues
COMMIT;

S2: -- Después del COMMIT ahora sí muestra 150.
SELECT saldo FROM cuentas WHERE id = 1;


----------------- LECTURA FANTASMA ---------------
S1:
BEGIN;
-- Fuerzo el isolation lvl a REPETEABLE READ.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Muestra 2.
SELECT COUNT(*) FROM cuentas;

S2:
INSERT INTO cuentas (saldo) VALUES (300);
-- Muestra 3.
SELECT COUNT(*) FROM cuentas;

S1: -- Continúa mostrando 2. Ignora lo que agregué en S2.
SELECT COUNT(*) FROM cuentas;
------- y despues
COMMIT; 
-- Después del COMMIT ahora sí muestra 3.
SELECT COUNT(*) FROM cuentas;
