----NIVEL DE AISLAMIENTO SERIALIZABLE PARA RESOLVER SERIALIZATION
DROP TABLE IF EXISTS doctores;
CREATE TABLE doctores (
    id SERIAL PRIMARY KEY,
    nombre TEXT,
    de_guardia BOOLEAN
);
INSERT INTO doctores (nombre, de_guardia) VALUES
('Ana', TRUE),
('Bruno', TRUE);

-----------------------------------------------------------------
S1:
-- Establezco isolation lvl en SERIALILZABLE.
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Devuelve 2.
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;  

-- Si ya hay 2 doctores, Ana se puede ir.
-- Ahora Ana pasó a FALSE.
UPDATE doctores SET de_guardia = FALSE WHERE nombre = 'Ana';

-----------------------------------------------------------------

S2:
-- Establezco isolation lvl en SERIALILZABLE.
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Devuelve 2. Está con su snapshot propio.
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;  

-- Como hay 2 doctores, Bruno se puede ir.
-- Ahora Bruno también pasó a FALSE.
UPDATE doctores SET de_guardia = FALSE WHERE nombre = 'Bruno';

-----------------------------------------------------------------

S1:
COMMIT;
-- Muestra 1. Se fue un doctor.
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;

S2:
COMMIT;
-- Da eERROR:  no se pudo serializar el acceso debido a dependencias 
-- read/write entre transacciones.
-- Reason code: Canceled on identification as a pivot, during commit 
-- attempt. 
SELECT COUNT(*) FROM doctores WHERE de_guardia = TRUE;



