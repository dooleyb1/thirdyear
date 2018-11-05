-- MySQL dump 10.13  Distrib 8.0.12, for macos10.13 (x86_64)
--
-- Host: 127.0.0.1    Database: premier-league
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Stadiums`
--

DROP TABLE IF EXISTS `Stadiums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Stadiums` (
  `stadium_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `team` varchar(25) DEFAULT NULL,
  `city` varchar(25) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `opened` int(11) DEFAULT NULL,
  PRIMARY KEY (`stadium_id`),
  UNIQUE KEY `stadium_id_UNIQUE` (`stadium_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stadiums`
--

LOCK TABLES `Stadiums` WRITE;
/*!40000 ALTER TABLE `Stadiums` DISABLE KEYS */;
INSERT INTO `Stadiums` VALUES (1,'Anfield','Liverpool','Liverpool',54074,1884),(2,'Dean Court','Bournemouth','Bournemouth',11360,1910),(3,'Emirates Stadium','Arsenal','London',59867,2006),(4,'Etihad Stadium','Manchester City','Manchester',55097,2003),(5,'Goodison Park','Everton','Liverpool',39571,1892),(6,'Molineux Stadium','Wolverhampton Wanderers','Wolverhampton',31700,1889),(7,'Old Trafford','Manchester United','Manchester',75643,1910),(8,'Stamford Bridge','Chelsea','London',41631,1877),(9,'Vicarage Road','Watford','Watford',21977,1922),(10,'Wembley Stadium','Tottenham Hotspur','London',90000,2007);
/*!40000 ALTER TABLE `Stadiums` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-05 16:26:12
