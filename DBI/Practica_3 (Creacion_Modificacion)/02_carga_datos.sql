-- =====================================
-- INSERTS
-- =====================================

INSERT INTO modelos VALUES
(1, 'Yaris', 'hatchback'),
(2, 'Corolla', 'sedan'),
(3, 'Corolla Cross', 'suv'),
(4, 'Hilux', 'pickup');

INSERT INTO versiones VALUES
-- YARIS
(1, 1, 'XS 1.5 CVT', 'nafta', 34000000),
(2, 1, 'XLS 1.5 CVT', 'nafta', 36000000),
(3, 1, 'S 1.5 CVT', 'nafta', 38000000),

-- COROLLA
(4, 2, 'XLI 2.0 CVT', 'nafta', 44000000),
(5, 2, 'XEI 2.0 CVT', 'nafta', 48000000),
(6, 2, 'SEG HEV 1.8', 'hibrido', 56000000),

-- COROLLA CROSS
(7, 3, 'XLI 2.0 CVT', 'nafta', 52000000),
(8, 3, 'XEI 2.0 CVT', 'nafta', 56000000),
(9, 3, 'SEG HEV 1.8', 'hibrido', 63000000),

-- HILUX
(10, 4, 'DX 4x2 MT', 'diesel', 49000000),
(11, 4, 'SR 4x4 MT', 'diesel', 65000000),
(12, 4, 'SRX 4x4 AT', 'diesel', 84000000);

INSERT INTO sucursales VALUES
(1, 'Toyota Caballito', 'Buenos Aires', 1, 5),
(2, 'Toyota Caballito', 'Buenos Aires', 4, 3),
(3, 'Toyota Caballito', 'Buenos Aires', 10, 2),

(4, 'Toyota Palermo', 'Buenos Aires', 2, 4),
(5, 'Toyota Palermo', 'Buenos Aires', 5, 2),
(6, 'Toyota Palermo', 'Buenos Aires', 11, 3),

(7, 'Toyota La Plata', 'La Plata', 3, 6),
(8, 'Toyota La Plata', 'La Plata', 6, 2),
(9, 'Toyota La Plata', 'La Plata', 12, 1),

(10, 'Toyota Córdoba', 'Córdoba', 1, 3),
(11, 'Toyota Córdoba', 'Córdoba', 7, 2),
(12, 'Toyota Córdoba', 'Córdoba', 10, 4),

(13, 'Toyota Rosario', 'Rosario', 2, 5),
(14, 'Toyota Rosario', 'Rosario', 8, 3),
(15, 'Toyota Rosario', 'Rosario', 11, 2),

(16, 'Toyota Mendoza', 'Mendoza', 3, 4),
(17, 'Toyota Mendoza', 'Mendoza', 9, 2),
(18, 'Toyota Mendoza', 'Mendoza', 12, 2),

(19, 'Toyota Salta', 'Salta', 1, 2),
(20, 'Toyota Salta', 'Salta', 4, 1),
(21, 'Toyota Salta', 'Salta', 10, 3);
