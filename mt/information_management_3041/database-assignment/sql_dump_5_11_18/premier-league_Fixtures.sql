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
-- Table structure for table `Fixtures`
--

DROP TABLE IF EXISTS `Fixtures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Fixtures` (
  `fixture_id` int(11) NOT NULL AUTO_INCREMENT,
  `home_team` varchar(25) NOT NULL,
  `away_team` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `time` time DEFAULT NULL,
  `stadium` varchar(25) DEFAULT NULL,
  `home_goals` int(11) DEFAULT '0',
  `away_goals` int(11) DEFAULT '0',
  `winner` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`fixture_id`),
  UNIQUE KEY `fixture_id_UNIQUE` (`fixture_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fixtures`
--

LOCK TABLES `Fixtures` WRITE;
/*!40000 ALTER TABLE `Fixtures` DISABLE KEYS */;
INSERT INTO `Fixtures` VALUES (1,'Arsenal','Manchester City','2017-12-01','16:30:00','Emirates Stadium',0,0,NULL),(2,'Arsenal','Tottenham Hotspur','2017-11-11','16:30:00','Emirates Stadium',0,0,NULL),(3,'Arsenal','Wolverhampton Wanderers','2017-11-24','16:30:00','Emirates Stadium',0,0,NULL),(4,'Bournemouth','Wolverhampton Wanderers','2017-11-11','16:30:00','Dean Court',0,0,NULL),(5,'Chelsea','Bournemouth','2017-11-24','14:15:00','Stamford Bridge',0,0,NULL),(6,'Chelsea','Everton','2017-11-11','14:15:00','Stamford Bridge',0,0,NULL),(7,'Chelsea','Liverpool','2017-12-08','16:30:00','Stamford Bridge',0,0,NULL),(8,'Chelsea','Manchester City','2017-12-08','12:00:00','Stamford Bridge',0,0,NULL),(9,'Everton','Arsenal','2017-12-08','16:30:00','Goodison Park',0,0,NULL),(10,'Everton','Tottenham Hotspur','2017-11-24','16:30:00','Goodison Park',0,0,NULL),(11,'Liverpool','Watford','2017-11-11','12:00:00','Anfield',0,0,NULL),(12,'Manchester City','Liverpool','2017-11-11','16:30:00','Etihad Stadium',0,0,NULL),(13,'Manchester City','Manchester United','2017-11-11','16:30:00','Etihad Stadium',0,0,NULL),(14,'Manchester United','Everton','2017-12-01','12:00:00','Old Trafford',0,0,NULL),(15,'Manchester United','Watford','2017-11-24','12:00:00','Old Trafford',0,0,NULL),(16,'Tottenham Hotspur','Bournemouth','2017-12-01','14:15:00','Wembley Stadium',0,0,NULL),(17,'Tottenham Hotspur','Manchester United','2017-12-08','14:15:00','Wembley Stadium',0,0,NULL),(18,'Watford','Chelsea','2017-12-01','16:30:00','Vicarage Road',0,0,NULL),(19,'Watford','Wolverhampton Wanderers','2017-12-08','16:30:00','Vicarage Road',0,0,NULL),(20,'Wolverhampton Wanderers','Liverpool','2017-12-01','16:30:00','Molineux Stadium',0,0,NULL);
/*!40000 ALTER TABLE `Fixtures` ENABLE KEYS */;
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
