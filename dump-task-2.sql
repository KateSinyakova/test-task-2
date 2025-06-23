-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: test_database
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор клуба',
  `name_ru` varchar(100) NOT NULL COMMENT 'Название клуба на русском языке',
  `name_en` varchar(100) NOT NULL COMMENT 'Название клуба на английском языке',
  `city_ru` varchar(100) NOT NULL COMMENT 'Город клуба на русском языке',
  `city_en` varchar(100) NOT NULL COMMENT 'Город клуба на английском языке',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Когда запись создана',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Когда запись обновлена',
  PRIMARY KEY (`id`),
  KEY `idx_clubs_name_ru` (`name_ru`),
  KEY `idx_clubs_name_en` (`name_en`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs`
--

LOCK TABLES `clubs` WRITE;
/*!40000 ALTER TABLE `clubs` DISABLE KEYS */;
INSERT INTO `clubs` VALUES (1,'ЦСКА','CSKA','Москва','Moscow','2025-06-22 00:40:58','2025-06-22 00:40:58'),(2,'СКА','SKA','Санкт-Петербург','Saint Petersburg','2025-06-22 00:40:58','2025-06-22 00:40:58'),(3,'Динамо','Dynamo','Москва','Moscow','2025-06-22 00:40:58','2025-06-22 00:40:58'),(4,'Ак Барс','Ak Bars','Казань','Kazan','2025-06-22 00:40:58','2025-06-22 00:40:58'),(5,'Салават Юлаев','Salavat Yulaev','Уфа','Ufa','2025-06-22 00:40:58','2025-06-22 00:40:58');
/*!40000 ALTER TABLE `clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_club_season`
--

DROP TABLE IF EXISTS `player_club_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_club_season` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор записи',
  `player_id` bigint unsigned NOT NULL COMMENT 'Ссылка на игрока',
  `club_id` bigint unsigned NOT NULL COMMENT 'Ссылка на клуб',
  `season_id` bigint unsigned NOT NULL COMMENT 'Ссылка на сезон',
  `jersey_number` tinyint unsigned NOT NULL COMMENT 'Игровой номер игрока',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Когда запись создана',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Когда запись обновлена',
  PRIMARY KEY (`id`),
  KEY `idx_pcs_season_id` (`season_id`),
  KEY `idx_pcs_player_season` (`player_id`,`season_id`),
  KEY `idx_pcs_club_season` (`club_id`,`season_id`),
  CONSTRAINT `player_club_season_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_club_season_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_club_season_ibfk_3` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Связывает игрока, клуб и сезон с указанием игрового номера';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_club_season`
--

LOCK TABLES `player_club_season` WRITE;
/*!40000 ALTER TABLE `player_club_season` DISABLE KEYS */;
INSERT INTO `player_club_season` VALUES (1,1,1,1,9,'2025-06-22 00:13:31','2025-06-22 00:13:31'),(2,2,1,1,15,'2025-06-22 00:13:31','2025-06-22 00:13:31'),(3,3,2,2,10,'2025-06-22 00:13:31','2025-06-22 00:13:31'),(4,4,3,3,7,'2025-06-22 00:13:31','2025-06-22 00:13:31'),(5,5,4,4,11,'2025-06-22 00:13:31','2025-06-22 00:13:31');
/*!40000 ALTER TABLE `player_club_season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор игрока',
  `full_name_ru` varchar(100) NOT NULL COMMENT 'ФИО на русском',
  `full_name_en` varchar(100) NOT NULL COMMENT 'ФИО на английском',
  `weight` decimal(5,2) NOT NULL COMMENT 'Вес игрока в кг (до граммов, например: 80.75)',
  `height` decimal(5,2) NOT NULL COMMENT 'Рост игрока в см (например: 182.50)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_players_full_name_ru` (`full_name_ru`),
  KEY `idx_players_full_name_en` (`full_name_en`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Иван Иванов','Ivan Ivanov',82.50,185.50,'2025-06-22 00:41:38','2025-06-22 00:41:38'),(2,'Пётр Петров','Pyotr Petrov',78.20,178.00,'2025-06-22 00:41:38','2025-06-22 00:41:38'),(3,'Алексей Алексеев','Alexey Alexeev',90.00,190.30,'2025-06-22 00:41:38','2025-06-22 00:41:38'),(4,'Дмитрий Дмитриев','Dmitry Dmitriev',85.70,182.00,'2025-06-22 00:41:38','2025-06-22 00:41:38'),(5,'Сергей Сергеев','Sergey Sergeev',88.40,187.20,'2025-06-22 00:41:38','2025-06-22 00:41:38');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seasons`
--

DROP TABLE IF EXISTS `seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seasons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор сезона',
  `start_date` date DEFAULT NULL COMMENT 'Дата начала сезона',
  `end_date` date DEFAULT NULL COMMENT 'Дата окончания сезона',
  `name_ru` varchar(100) NOT NULL COMMENT 'Название сезона на русском (например "Сезон 2023/24")',
  `name_en` varchar(100) NOT NULL COMMENT 'Название сезона на английском (например "2023/24 Season")',
  `is_playoffs` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Флаг плей-офф: 1 — да, 0 — нет',
  `description` text COMMENT 'Дополнительное описание сезона',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Когда запись создана',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Когда запись обновлена',
  PRIMARY KEY (`id`),
  KEY `idx_season_name_en` (`name_en`),
  KEY `idx_season_name_ru` (`name_ru`),
  KEY `idx_seasons_period` (`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Справочник сезонов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seasons`
--

LOCK TABLES `seasons` WRITE;
/*!40000 ALTER TABLE `seasons` DISABLE KEYS */;
INSERT INTO `seasons` VALUES (1,'2023-09-01','2024-04-30','Сезон 2023/24','2023/24 Season',0,'Обычный сезон','2025-06-22 00:13:29','2025-06-22 00:13:29'),(2,'2023-04-15','2024-06-15','Плей-офф 2023/24','2023/24 Playoffs',1,'Плей-офф сезона 2023/24','2025-06-22 00:13:29','2025-06-22 00:13:29'),(3,'2022-09-01','2023-04-30','Сезон 2022/23','2022/23 Season',0,'Обычный сезон','2025-06-22 00:13:29','2025-06-22 00:13:29'),(4,'2022-04-15','2023-06-15','Плей-офф 2022/23','2022/23 Playoffs',1,'Плей-офф сезона 2022/23','2025-06-22 00:13:29','2025-06-22 00:13:29'),(5,'2021-09-01','2022-04-30','Сезон 2021/22','2021/22 Season',0,'Обычный сезон','2025-06-22 00:13:29','2025-06-22 00:13:29');
/*!40000 ALTER TABLE `seasons` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-22  0:46:14
