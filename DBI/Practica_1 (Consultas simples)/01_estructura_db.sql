-- Borrar las tablas
    --DROP TABLE clientes;
    --DROP TABLE departamentos;
    --DROP TABLE empleados;


-- Tabla Clientes
CREATE TABLE clientes (
    id_cliente INT,
    nombre VARCHAR(50),
    email VARCHAR(100)
);

-- Tabla Departamentos
CREATE TABLE departamentos (
    id_departamento INT,
    nombre_departamento VARCHAR(50)
);

-- Tabla Empleados
CREATE TABLE empleados (
    id_empleado INT,
    nombre VARCHAR(50),
    salario DECIMAL(10,2),
    id_departamento INT
);