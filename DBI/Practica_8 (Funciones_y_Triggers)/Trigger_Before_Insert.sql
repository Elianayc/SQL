-----------------------------TRIGGERS-------------------------------

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    balance NUMERIC(10,2) NOT NULL
);

INSERT INTO accounts (name, balance) VALUES
('Ana Pérez', 500.00),
('Juan López', 1000.00),
('Lucía Torres', 200.00);

--------------------------------------------------------------------

--Función que chequea que la provincia no tenga menos de 3 caracteres.
CREATE OR REPLACE FUNCTION before_insert_provincias()
RETURNS trigger AS $$
BEGIN
    RAISE INFO 'Ejecuta trigger';
    
    IF length(NEW.prv_nombre) < 3 THEN
        RETURN NULL;  -- anula la inserción
    END IF;
    
    RETURN NEW;  -- permite el insert
END;
$$ LANGUAGE plpgsql;

--Trigger que ejecuta antes de insertar.
CREATE TRIGGER before_insert_provincias
BEFORE INSERT ON provincias
FOR EACH ROW
EXECUTE PROCEDURE before_insert_provincias();

-----------------------------PRUEBAS-------------------------------

INSERT INTO provincias (prv_nombre) VALUES ('BA');
-- No se inserta nada, porque 'BA' tiene solo 2 caracteres.

INSERT INTO provincias (prv_nombre) VALUES ('Buenos Aires');
-- Inserción exitosa.

--------------------------------------------------------------------