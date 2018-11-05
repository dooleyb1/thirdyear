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
-- Table structure for table `Teams`
--

DROP TABLE IF EXISTS `Teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Teams` (
  `team_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `stadium` varchar(25) NOT NULL,
  `manager` varchar(25) NOT NULL,
  `city` varchar(25) NOT NULL,
  `position` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `goal_difference` int(11) NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `team_id_UNIQUE` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teams`
--

LOCK TABLES `Teams` WRITE;
/*!40000 ALTER TABLE `Teams` DISABLE KEYS */;
INSERT INTO `Teams` VALUES (1,'Arsenal','Emirates Stadium','Unai Emery','London',4,22,11),(2,'Bournemouth','Dean Court','Eddie Howe','Bournemouth',6,20,7),(3,'Chelsea','Stamford Bridge','Maurizio Sarri','London',3,24,17),(4,'Everton','Goodison Park','Marco Silva','Liverpool',9,15,2),(5,'Liverpool','Anfield','Jürgen Klopp','Liverpool',2,26,16),(6,'Manchester City','Etihad Stadium','Josep Guardiola','Manchester',1,26,24),(7,'Manchester United','Old Trafford','José Mourinho','Manchester',8,17,0),(8,'Tottenham Hotspur','Wembley Stadium','Mauricio Pochettino','London',5,21,8),(9,'Watford','Vicarage Road','Javier Gracia','Watford',7,19,4),(10,'Wolverhampton Wanderers','Molineux Stadium','Nuno Espírito Santo','Wolverhampton',10,15,0);
/*!40000 ALTER TABLE `Teams` ENABLE KEYS */;
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
