--- READ COMMITED PARA MOSTRAR LECTURA NO REPETIBLE Y LECTURA FANTASMA

SHOW default_transaction_isolation;

DROP TABLE IF EXISTS cuentas;
CREATE TABLE cuentas (
    id SERIAL PRIMARY KEY,
    saldo INT
);
INSERT INTO cuentas (saldo) VALUES (100), (200);


------------------  LECTURA NO REPETIBLE  ----------------
S1:
BEGIN;
-- Saldo es 100.
SELECT saldo FROM cuentas WHERE id = 1;

S2: -- Aumento saldo en 50. Ahora es 150.
UPDATE cuentas SET saldo = saldo + 50 WHERE id = 1;

S1: -- Yaveo los cambios de S2, saldo es 150.
SELECT saldo FROM cuentas WHERE id = 1;
----- y despues hago
COMMIT;

/*
Una lectura no repetible pasa cuando:

Leés la misma fila dos veces dentro de la misma transacción 
y obtenés resultados distintos porque otra transacción ya 
hizo COMMIT.

Problema clave: la fila existe, pero su contenido cambió.
*/


--------------------- LECTURA FANTASMA ------------------
S1:
BEGIN;
-- Muestra 2.
SELECT COUNT(*) FROM cuentas;

S2: -- Agrego un registro. Ahora son 3.
INSERT INTO cuentas (saldo) VALUES (300);

S1: --Muestra 3.
SELECT COUNT(*) FROM cuentas;
------- y despues
COMMIT;

/*
Una lectura fantasma pasa cuando:

Hacés una consulta (ej: COUNT, SELECT con condiciones) 
y luego aparecen o desaparecen filas nuevas por otra 
transacción.

Problema clave: no cambió una fila, apareció una fila nueva.
*/

---------------------------------------------------------

/* No hay aislamiento entre lecturas dentro de la misma 
transacción.*/

