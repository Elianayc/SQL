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

----------------------------------------------------------------------

/*FUNCION QUE ESCRIBE EN TEXTO UN NÚMERO*/

DROP FUNCTION IF EXISTS dup;
/*
Recibe un número y devuelve una “mini tabla” con:
el número
ese número convertido a texto con una frase.
*/

CREATE FUNCTION dup(int) 
RETURNS TABLE(f1 int, f2 text) AS $$ -- Retorna una tabla con dos campos.
SELECT $1, CAST($1 AS text) || ' is text' --$1 = primer parámetro.
$$ LANGUAGE SQL;


SELECT * FROM dup(42);
/*
| f1 | f2         |
| -- | ---------- |
| 42 | 42 is text |
*/


