-- pretifly.categories definition

drop database Pretifly;

Create database Pretifly;

use Pretifly;

show tables;

CREATE TABLE `categories` (
  `idCategories` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCategories`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- pretifly.clients definition

CREATE TABLE `clients` (
  `idClients` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idClients`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- pretifly.contents_types definition

CREATE TABLE `contents_types` (
  `idContents_Types` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idContents_Types`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- pretifly.contents definition

CREATE TABLE `contents` (
  `idContents` int NOT NULL AUTO_INCREMENT,
  `idContents_Types` int NOT NULL,
  `idCategories` int NOT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `Release_Year` int DEFAULT NULL,
  PRIMARY KEY (`idContents`),
  KEY `idContents_Types` (`idContents_Types`),
  KEY `idx_contents_release_year` (`Release_Year`),
  CONSTRAINT `contents_ibfk_2` FOREIGN KEY (`idContents_Types`) REFERENCES `contents_types` (`idContents_Types`),
  CONSTRAINT `contents_check` CHECK ((`Release_Year` > 1900))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- pretifly.views definition

CREATE TABLE `views` (
  `idViews` int NOT NULL AUTO_INCREMENT,
  `idClients` int DEFAULT NULL,
  `idContents` int DEFAULT NULL,
  `View_Date` datetime DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  PRIMARY KEY (`idViews`),
  KEY `idClients` (`idClients`),
  KEY `idContents` (`idContents`),
  CONSTRAINT `views_clients_FK` FOREIGN KEY (`idClients`) REFERENCES `clients` (`idClients`),
  CONSTRAINT `views_contents_FK` FOREIGN KEY (`idContents`) REFERENCES `contents` (`idContents`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;