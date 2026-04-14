-- =====================================
-- CREACIÓN DE TABLAS
-- =====================================

-- Borrar las tablas
DROP TABLE IF EXISTS modelos;
DROP TABLE IF EXISTS versiones;
DROP TABLE IF EXISTS sucursales;

-- Crear las tablas
CREATE TABLE modelos (
    id_modelo INT,
    nombre VARCHAR(50),
    tipo VARCHAR(30)   -- sedan, pickup, suv
);

CREATE TABLE versiones (
    id_version INT,
    id_modelo INT,
    nombre VARCHAR(50),
    motor VARCHAR(30),
    precio DECIMAL(12,2)
);

CREATE TABLE sucursales (
    id_sucursal INT,
    nombre VARCHAR(50),
    ciudad VARCHAR(50),
    id_version INT,
    stock INT
);
