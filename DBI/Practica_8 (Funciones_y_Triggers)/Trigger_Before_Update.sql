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

-- Función que chequea que no quede saldo negativo.
CREATE OR REPLACE FUNCTION check_account_update()
RETURNS trigger AS $$
BEGIN
    RAISE INFO 'Ejecuta trigger';

    IF NEW.balance < 0 THEN
        RAISE EXCEPTION 'No se permite saldo negativo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------

-- Trigger que ejecuta antes de updatear.
CREATE OR REPLACE TRIGGER check_update
BEFORE UPDATE ON accounts
FOR EACH ROW
WHEN (OLD.balance IS DISTINCT FROM NEW.balance)
EXECUTE PROCEDURE check_account_update();

-----------------------------PRUEBAS-------------------------------

-- Cambiar solo el nombre (el trigger NO se ejecuta)
UPDATE accounts 
SET name = 'Carlos Pérez' 
WHERE id = 1;

-- Cambiar el saldo a un valor negativo (el trigger SÍ se ejecuta)
UPDATE accounts 
SET balance = -100 
WHERE id = 1;

-- Cambiar el saldo a un valor positivo (el trigger SÍ se ejecuta, pero permite la operación)
UPDATE accounts 
SET balance = 300 
WHERE id = 1;

--------------------------------------------------------------------

