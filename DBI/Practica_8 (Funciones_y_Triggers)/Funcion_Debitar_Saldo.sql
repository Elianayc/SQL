DROP TABLE IF EXISTS bank;

CREATE TABLE bank (
    accountno INTEGER PRIMARY KEY,
    holder_name TEXT,
    balance NUMERIC(10,2)
);

INSERT INTO bank (accountno, holder_name, balance) VALUES
(101, 'Ana Pérez', 1500.00),
(102, 'Carlos Gómez', 2300.00),
(103, 'Lucía Torres', 500.00);

------------------------------------------------------------------

/*FUNCION QUE DEBITA DINERO DE CUENTA*/

DROP FUNCTION IF EXISTS tf1; -- Elimino la fx si existe.

--Fx que recibe un entero nro de cuenta y un numerico a debitar.
CREATE FUNCTION tf1(accountno integer, debit numeric) 
RETURNS integer AS $$ -- AS $$ indica el cuerpo de la fx. Devuelve un entero.

-- Acciones de consulta
UPDATE bank
SET balance = balance - debit
WHERE accountno = tf1.accountno;
SELECT 1; -- Devuelve "1", pudo finalizar.


$$ LANGUAGE SQL; -- Terminba el cuerpo de la fx. Definición del lenguaje.


SELECT * FROM bank;

-- Invoco la fx.
SELECT tf1(102, 200);
