-- Tabla Clientes
INSERT INTO clientes (id_cliente, nombre, email) VALUES
(1, 'Juan Pérez', 'juan.perez@email.com'),
(2, 'María López', 'maria.lopez@email.com'),
(3, 'Carlos Gómez', 'carlos.gomez@email.com');

-- Tabla Departamentos
INSERT INTO departamentos (id_departamento, nombre_departamento) VALUES
(1, 'Recursos Humanos'),
(2, 'Ventas'),
(3, 'TI'),
(4, 'Marketing');

-- Tabla Empleados
INSERT INTO empleados (id_empleado, nombre, salario, id_departamento) VALUES
(1, 'Miguel Torres', 55000, 2),
(2, 'Mariana Díaz', 60000, 2),
(3, 'Mario Fernández', 48000, 3),
(4, 'Lucía Martínez', 75000, 1),
(5, 'Ana Morales', 52000, 3),
(6, 'Matías Suárez', NULL, 4),
(7, 'Mónica Castro', 52000, 3),
(8, 'Paula Ríos', 58000, 2),
(9, 'Marcos León', 61000, 1),
(10, 'Mariela Vega', 49000, 4);