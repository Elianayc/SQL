-- =====================================
-- INSERTS
-- =====================================

INSERT INTO sucursales (id_sucursal, nombre, ciudad) VALUES
(1, 'Sucursal Centro', 'Buenos Aires'),
(2, 'Sucursal Norte', 'Córdoba'),
(3, 'Sucursal Sur', 'Mar del Plata');

INSERT INTO categorias (id_categoria, nombre_categoria, id_sucursal) VALUES
(1, 'Lácteos', 1),
(2, 'Bebidas', 1),
(3, 'Limpieza', 2),
(4, 'Almacén', 2),
(5, 'Congelados', 3); -- sin productos

INSERT INTO productos (id_producto, nombre, precio, id_categoria) VALUES
(1, 'Leche', 1200, 1),
(2, 'Queso', 2500, 1),
(3, 'Gaseosa', 1500, 2),
(4, 'Detergente', 1800, 3),
(5, 'Pan', 900, 4),
(6, 'Yogur', NULL, 1),
(7, 'Cerveza', 2000, 2),
(8, 'Fideos', 1100, 4),
(9, 'Lavandina', 1300, 3),
(10, 'Arroz', 1400, 4),
(11, 'Helado', 999, NULL); -- producto sin categoria (congelado)

