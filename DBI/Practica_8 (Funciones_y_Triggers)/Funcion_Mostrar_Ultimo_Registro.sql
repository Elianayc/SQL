DROP TABLE IF EXISTS provincias;

CREATE TABLE provincias (
    prv_id SERIAL PRIMARY KEY,
    prv_nombre TEXT NOT NULL,
    poblacion INTEGER
);
INSERT INTO provincias (prv_nombre, poblacion) VALUES
('Buenos Aires', 15500000),
('Córdoba', 3800000),
('Santa Fe', 3400000),
('Mendoza', 2000000);

------------------------------------------------------------------------

/*FUNCION QUE MUESTRA EL ÚLTIMO REGISTRO*/

CREATE OR REPLACE FUNCTION last_record() RETURNS provincias AS $$
DECLARE t2_row provincias%ROWTYPE;
BEGIN
    SELECT * INTO t2_row
    FROM provincias
    ORDER BY prv_id DESC
    LIMIT 1;
    
    RETURN t2_row;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------

/*PRUEBAS*/

SELECT * FROM last_record();

/*
La función last_record() hace exactamente eso: selecciona la fila con el 
ID más alto y la devuelve completa. 
Así evitamos escribir ORDER BY ... LIMIT 1 cada vez que necesitamos 
el último registro.
*/

INSERT INTO provincias (prv_nombre, poblacion) VALUES
('Salta', 1440000);

SELECT * FROM last_record();
