DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);
INSERT INTO cliente (name, password) VALUES
('juan', 'clave_1234'),
('ana', 'secreto'),
('carlos', '12345');

----------------------------------------------------------------------------

/*FUNCION QUE CHEQUEA UN PASSWORD*/

CREATE OR REPLACE FUNCTION check_password(uname TEXT, pass TEXT) RETURNS BOOLEAN 
AS $$

DECLARE passed BOOLEAN;
BEGIN
    passed := false; -- Inicializamos el boleano como falso.
	
	/* Compara la contraseña almacenada con la recibida y 
	guarda el resultado (TRUE/FALSE) en la variable passed.*/
    SELECT (password = $2) INTO passed 
    FROM cliente
    WHERE name = $1;
	
    -- En caso de que el query no retorne filas, la variable passed contiene NULL
    IF passed IS NULL THEN
        RAISE LOG 'El usuario % no existe', uname; -- Excepción.
        passed := false;
    END IF;
    
    RETURN passed;
END;

$$ LANGUAGE plpgsql;

----------------------------------------------------------------------------

/* PRUEBAS */

-- Usuario y contraseña correctos
SELECT check_password('ana', 'secreto');   -- Resultado: t

-- Contraseña incorrecta
SELECT check_password('carlos', 'clave_1234');   -- Resultado: f

-- Usuario inexistente
SELECT check_password('marcos', 'abc');   -- Resultado: f
