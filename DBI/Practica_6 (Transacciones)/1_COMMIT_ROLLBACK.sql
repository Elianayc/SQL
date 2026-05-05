DROP TABLE IF EXISTS cuentas;

CREATE TABLE cuentas (
    id SERIAL PRIMARY KEY, --serializable: autoincrementable
    saldo INT
);

-- INSERTO VALORES
INSERT INTO cuentas (saldo) VALUES (100), (200);

-----------------------------------------------------------

-- TRANSACCIÓN CON COMMIT
BEGIN;

-- Mostrar total inicial 300
SELECT SUM(saldo) AS total_inicial FROM cuentas; 

-- Resto 50 al saldo de id=1
UPDATE cuentas SET saldo = saldo - 50 WHERE id = 1; 
COMMIT; -- Aplico

-- Mostrar total, ahora 250
SELECT SUM(saldo) AS total_inicial FROM cuentas;

-----------------------------------------------------------

-- TRANSACCIÓN CON ROLLBACK
BEGIN;

-- Mostrar total inicial 300
SELECT SUM(saldo) AS total_inicial FROM cuentas;

-- Resto 50 al saldo de id=1
UPDATE cuentas SET saldo = saldo - 50 WHERE id = 1;
ROLLBACK; -- Vuelvo hacia atrás

-- Mostrar total, sigue en 300
SELECT SUM(saldo) AS total_inicial FROM cuentas;