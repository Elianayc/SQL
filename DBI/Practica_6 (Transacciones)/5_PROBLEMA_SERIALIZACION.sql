----PROBLEMA DE SERIALIZACION CON REPEATABLE READ
DROP TABLE IF EXISTS doctores;
CREATE TABLE doctores (
    id SERIAL PRIMARY KEY,
    nombre TEXT,
    de_guardia BOOLEAN
);
INSERT INTO doctores (nombre, de_guardia) VALUES
('Ana', TRUE),
('Bruno', TRUE);

--------------------------------------------------------------

S1:
-- Establezco isolation lvl en REPETEABLE READ.
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Devuelve 2.
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;  

-- Si ya hay 2 doctores, Ana se puede ir.
-- Ahora Ana pasó a FALSE.
UPDATE doctores SET de_guardia = FALSE WHERE nombre = 'Ana';

--------------------------------------------------------------

S2:
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Devuelve 2. Está con su snapshot propio.
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;  

-- Como hay 2 doctores, Bruno se puede ir.
-- Ahora Bruno también pasó a FALSE.
UPDATE doctores SET de_guardia = FALSE WHERE nombre = 'Bruno';

--------------------------------------------------------------

S1:
COMMIT;
-- Muestra 1. Queda un doctor.
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;

S2:
COMMIT;
-- Muestra 0. Se fueron los dos doctores.
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;


