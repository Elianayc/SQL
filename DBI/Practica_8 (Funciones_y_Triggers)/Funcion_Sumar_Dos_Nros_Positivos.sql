/*FUNCION QUE SUMA DOS NÚMEROS POSITIVOS*/

DROP FUNCTION IF EXISTS sum_positive;

CREATE FUNCTION sum_positive(n1 integer, n2 integer)
RETURNS integer AS
$$
BEGIN
    IF (n1 > 0 AND n2 > 0) THEN
        RETURN n1 + n2;
    ELSE
        RETURN NULL;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT sum_positive(3, 5);   -- Devuelve 8
SELECT sum_positive(10, -2); -- Muestra "NOTICE: Error!!" y no devuelve nada
