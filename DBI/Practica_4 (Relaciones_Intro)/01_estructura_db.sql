-- =====================================
-- CREACIÓN DE TABLAS
-- =====================================

-- Limpieza previa (opcional)
DROP TABLE IF EXISTS sucursales;
DROP TABLE IF EXISTS versiones;
DROP TABLE IF EXISTS modelos;

-- =====================
-- TABLA MODELOS
-- =====================
CREATE TABLE modelos(
	id_modelo INT PRIMARY KEY,
	nombre VARCHAR(50),
	tipo VARCHAR(30)
);

-- =====================
-- TABLA VERSIONES
-- =====================
CREATE TABLE versiones (
	id_version INT PRIMARY KEY,
	id_modelo INT,
	nombre VARCHAR(50),
	motor VARCHAR(30),
	precio DECIMAL(12,2),
	FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo)
);

-- =====================
-- TABLA SUCURSALES
-- =====================
CREATE TABLE sucursales (
	id_sucursal INT PRIMARY KEY,
	nombre VARCHAR(50),
	ciudad VARCHAR(50),
	id_version INT,
	stock INT,
	FOREIGN KEY (id_version) REFERENCES versiones(id_version)
);
