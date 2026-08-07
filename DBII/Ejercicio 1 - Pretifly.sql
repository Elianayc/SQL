-- ============================================================
-- BASE DE DATOS: PRETIFLY
-- ============================================================

DROP DATABASE IF EXISTS Pretifly;
CREATE DATABASE Pretifly;
USE Pretifly;


-- ============================================================
-- TABLA: categories
-- ============================================================

CREATE TABLE categories (
    idCategories INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (idCategories)
) ENGINE=InnoDB
  AUTO_INCREMENT=9
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO categories (idCategories, Name) VALUES
(1, 'Action'),
(2, 'Drama'),
(3, 'Comedy'),
(4, 'Sci-Fi'),
(5, 'Documentary'),
(6, 'Horror'),
(7, 'Romance'),
(8, 'Thriller');


-- ============================================================
-- TABLA: clients
-- ============================================================

CREATE TABLE clients (
    idClients INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100) DEFAULT NULL,
    Email VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (idClients)
) ENGINE=InnoDB
  AUTO_INCREMENT=19
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO clients (idClients, Name, Email) VALUES
(1, 'Juan Perez', 'juan@test.com'),
(2, 'Anna Smith', 'anna@test.com'),
(3, 'Carlos Lopez', 'carlos@test.com'),
(4, 'Maria Gomez', 'maria@test.com'),
(5, 'Pedro Silva', 'a@mail.com'),
(6, 'Hans Muller', 'hans@test.com'),
(7, 'Emily Johnson', 'emily@test.com'),
(8, 'Lucia Fernandez', 'lucia@test.com'),
(9, 'Bruno Costa', 'bruno@test.com'),
(10, 'Sofia Martinez', 'sofia@test.com'),
(11, 'Michael Brown', 'michael@test.com'),
(12, 'Raul Torres', 'raul@test.com'),
(13, 'Greta Klein', 'greta@test.com'),
(14, 'Amanda Souza', 'amanda@test.com'),
(15, 'Diego Ruiz', 'diego@test.com'),
(16, 'Claudio Rodriguez', 'crodriguez@test.com'),
(18, 'Pablo Perez', 'pperez@mail.com');


-- ============================================================
-- TABLA: contents_types
-- ============================================================

CREATE TABLE contents_types (
    idContents_Types INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (idContents_Types)
) ENGINE=InnoDB
  AUTO_INCREMENT=6
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO contents_types (idContents_Types, Name) VALUES
(1, 'Movie'),
(2, 'Series'),
(3, 'Documentary'),
(4, 'Short Film'),
(5, 'Anime');


-- ============================================================
-- TABLA: contents
-- ============================================================

CREATE TABLE contents (
    idContents INT NOT NULL AUTO_INCREMENT,
    idContents_Types INT NOT NULL,
    idCategories INT NOT NULL,
    Title VARCHAR(100) DEFAULT NULL,
    Release_Year INT DEFAULT NULL,
    PRIMARY KEY (idContents),
    KEY idContents_Types (idContents_Types),
    KEY idx_contents_release_year (Release_Year),
    CONSTRAINT contents_ibfk_2
        FOREIGN KEY (idContents_Types)
        REFERENCES contents_types (idContents_Types),
    CONSTRAINT contents_check
        CHECK (Release_Year > 1900)
) ENGINE=InnoDB
  AUTO_INCREMENT=31
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO contents
(idContents, idContents_Types, idCategories, Title, Release_Year)
VALUES
(1, 1, 1, 'Galaxy War', 2022),
(2, 2, 2, 'The Detective Mind', 2021),
(3, 1, 3, 'Love in Paris', 2020),
(4, 3, 4, 'Deep Ocean', 2019),
(5, 2, 4, 'Haunted Nights', 2023),
(6, 1, 1, 'Last Stand', 2022),
(7, 4, 4, 'The Last Message', 2018),
(8, 1, 6, 'Cyber Future', 2024),
(9, 2, 5, 'Hospital Shift', 2020),
(10, 1, 7, 'Jungle Mission', 2021),
(11, 3, 8, 'World War II Files', 2017),
(12, 1, 7, 'Speed Racers', 2023),
(13, 2, 7, 'Cooking Master', 2019),
(14, 1, 1, 'Silent Hill Road', 2022),
(15, 1, 7, 'Parallel Worlds', 2024),
(16, 5, 5, 'Shadow Mecha X', 2023),
(17, 5, 2, 'Crimson Ninja Saga', 2022),
(18, 5, 1, 'Neon Spirits', 2024),
(19, 5, 3, 'Tokyo Bytecode', 2021),
(20, 5, 4, 'Dragon Pulse Reborn', 2020),
(21, 5, 7, 'Skyblade Chronicles', 2023),
(22, 5, 8, 'Ghosts of Sakura', 2019),
(23, 5, 8, 'Quantum Samurai', 2024),
(24, 5, 1, 'Mythic Academy', 2022),
(25, 5, 1, 'Cyber Ronin', 2023),
(27, 1, 2, 'Galaxy 0', 1901),
(28, 1, 3, 'Galaxy 1', 2020);


-- ============================================================
-- TABLA: views
-- ============================================================

CREATE TABLE views (
    idViews INT NOT NULL AUTO_INCREMENT,
    idClients INT DEFAULT NULL,
    idContents INT DEFAULT NULL,
    View_Date DATETIME DEFAULT NULL,
    Rating INT DEFAULT NULL,
    PRIMARY KEY (idViews),
    KEY idClients (idClients),
    KEY idContents (idContents),
    CONSTRAINT views_clients_FK
        FOREIGN KEY (idClients)
        REFERENCES clients (idClients),
    CONSTRAINT views_contents_FK
        FOREIGN KEY (idContents)
        REFERENCES contents (idContents)
) ENGINE=InnoDB
  AUTO_INCREMENT=39
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO views
(idViews, idClients, idContents, View_Date, Rating)
VALUES
(1, 1, 1, '2025-03-01 20:00:00', 5),
(2, 1, 2, '2025-03-02 21:00:00', 4),
(3, 2, 1, '2025-03-03 22:00:00', 5),
(4, 3, 3, '2025-03-03 19:00:00', 3),
(5, 4, 5, '2025-03-04 23:00:00', 4),
(6, 5, 6, '2025-03-05 18:00:00', 4),
(7, 6, 8, '2025-03-05 20:00:00', 5),
(8, 7, 2, '2025-03-06 21:30:00', 2),
(9, 8, 9, '2025-03-06 22:30:00', 4),
(10, 9, 10, '2025-03-07 20:15:00', 5),
(11, 10, 11, '2025-03-07 19:10:00', 3),
(12, 11, 12, '2025-03-08 20:40:00', 4),
(13, 12, 13, '2025-03-08 21:00:00', 2),
(14, 13, 14, '2025-03-09 22:00:00', 5),
(15, 14, 15, '2025-03-09 23:00:00', 4),
(16, 15, 1, '2025-03-10 20:00:00', 5),
(17, 3, 8, '2025-03-10 21:00:00', 4),
(18, 4, 2, '2025-03-10 22:00:00', 3),
(19, 6, 4, '2025-03-11 18:00:00', 5),
(20, 8, 5, '2025-03-11 19:00:00', 4),
(21, 9, 6, '2025-03-12 20:00:00', 3),
(22, 10, 7, '2025-03-12 21:00:00', 4),
(23, 11, 8, '2025-03-13 20:00:00', 5),
(24, 12, 9, '2025-03-13 21:00:00', 3),
(25, 13, 10, '2025-03-14 22:00:00', 4),
(26, 14, 3, '2025-03-14 23:00:00', 5),
(27, 15, 4, '2025-03-15 20:00:00', 4),
(28, 2, 5, '2025-03-15 21:00:00', 5),
(29, 5, 8, '2025-03-16 20:00:00', 5),
(30, 7, 1, '2025-03-16 22:00:00', 3),
(31, 3, 16, '2025-03-20 21:00:00', 5),
(34, 1, 2, '2026-04-01 19:57:33', 5),
(38, 7, 2, '2026-04-15 18:48:06', 4);


-- ============================================================
-- CONSULTAS
-- ============================================================


-- 1. Consulta simple
SELECT *
FROM contents c;


-- 2. Consulta con columnas específicas
SELECT
    Title,
    Release_Year
FROM contents;


-- 3. Filtrado avanzado
SELECT
    Title,
    Release_Year
FROM contents
WHERE Release_Year > 2000;


-- 4. JOIN utilizando WHERE
SELECT
    ct.Name AS Content_Type,
    c.Title,
    c.Release_Year
FROM contents c, contents_types ct
WHERE c.Release_Year > 2000
  AND ct.idContents_Types = c.idContents_Types;


-- 5. INNER JOIN
SELECT
    ct.Name AS Content_Type,
    ca.Name AS Category,
    c.Title,
    c.Release_Year
FROM contents c
INNER JOIN contents_types ct
    ON ct.idContents_Types = c.idContents_Types
INNER JOIN categories ca
    ON ca.idCategories = c.idCategories
WHERE c.Release_Year > 2000
ORDER BY c.Release_Year DESC;


-- 6. Cantidad de contenidos por año
--    filtrado por agrupamiento
SELECT
    COUNT(c.idContents) AS Cantidad,
    c.Release_Year
FROM contents c
INNER JOIN contents_types ct
    ON ct.idContents_Types = c.idContents_Types
INNER JOIN categories ca
    ON ca.idCategories = c.idCategories
WHERE c.Release_Year > 2000
GROUP BY c.Release_Year
HAVING COUNT(c.idContents) > 1
ORDER BY c.Release_Year DESC;

