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
-- Table structure for table `Managers`
--

DROP TABLE IF EXISTS `Managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Managers` (
  `manager_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) NOT NULL,
  `second_name` varchar(25) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `team` varchar(25) DEFAULT NULL,
  `salary` bigint(10) DEFAULT NULL,
  `country` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`manager_id`),
  UNIQUE KEY `manager_id_UNIQUE` (`manager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Managers`
--

LOCK TABLES `Managers` WRITE;
/*!40000 ALTER TABLE `Managers` DISABLE KEYS */;
INSERT INTO `Managers` VALUES (1,'Eddie','Howe',40,'Bournemouth',500000,'England'),(2,'Javie','Gracia',48,'Watford',4000000,'Spain'),(3,'José','Mourinho',55,'Manchester United',15000000,'Portugal'),(4,'Josep','Guardiola',47,'Manchester City',15300000,'Spain'),(5,'Jürgen','Klopp',51,'Liverpool',7000000,'Germany'),(6,'Marco','Silva',41,'Everton',3000000,'Portugal'),(7,'Mauricio','Pochettino',46,'Tottenham Hotspur',8500000,'Argentina'),(8,'Maurizio','Sarri',59,'Chelsea',4500000,'Italy'),(9,'Nuno ','Espírito Santo',44,'Wolverhampton Wanderers',3000000,'Portugal'),(10,'Unai','Emery',46,'Arsenal',6000000,'Spain');
/*!40000 ALTER TABLE `Managers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-05 16:26:13
