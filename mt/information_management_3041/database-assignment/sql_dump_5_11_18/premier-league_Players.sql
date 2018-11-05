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
-- Table structure for table `Players`
--

DROP TABLE IF EXISTS `Players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(15) NOT NULL,
  `second_name` varchar(15) NOT NULL,
  `team` varchar(25) DEFAULT NULL,
  `position` varchar(10) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `player_id_UNIQUE` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Players`
--

LOCK TABLES `Players` WRITE;
/*!40000 ALTER TABLE `Players` DISABLE KEYS */;
INSERT INTO `Players` VALUES (1,'Aaron','Ramsey','Arsenal','Midfielder','Wales','8'),(2,'Alexandre','Lacazette','Arsenal','Forward','France','9'),(3,'Alexis','Sanchez','Manchester United','Forward','Chile','7'),(4,'Álvaro','Morata','Chelsea','Forward','Spain','29'),(5,'Artur','Boruc','Bournemouth','Goalkeeper','Poland','1'),(6,'Ben','Ashley-Seal','Wolverhampton Wanderers','Forward','England','24'),(7,'Cenk','Tosun','Everton','Forward','Turkey','14'),(8,'Claudio','Bravo','Manchester City','Goalkeeper','Chile','1'),(9,'Daniel','Drinkwater','Chelsea','Midfielder','England','6'),(10,'Danny','Welbeck','Arsenal','Forward','England','23'),(11,'David','de Gea','Manchester United','Goalkeeper','Spain','1'),(12,'Dejan','Lovren','Liverpool','Defender','Croatia','6'),(13,'Diogo','Jota','Wolverhampton Wanderers','Midfielder','Portugal','18'),(14,'Eden','Hazard','Chelsea','Forward','Belgium','10'),(15,'Fabian','Delph','Manchester City','Midfielder','England','18'),(16,'Fernando','Llorente','Tottenham Hotspur','Forward','Spain','18'),(17,'Gabriel','Jesus','Manchester City','Forward','Brazil','33'),(18,'Harry','Kane','Tottenham Hotspur','Forward','England','10'),(19,'Heurelho','Gomes','Watford','Goalkeeper','Brazil','1'),(20,'Hugo','Lloris','Tottenham Hotspur','Goalkeeper','France','1'),(21,'James','Milner','Liverpool','Midfielder','England','7'),(22,'Jermain','Defoe','Bournemouth','Forward','England','18'),(23,'John','Ruddy','Wolverhampton Wanderers','Goalkeeper','England','21'),(24,'Jordan','Pickford','Everton','Goalkeeper','England','1'),(25,'Joshua','King','Bournemouth','Forward','Norway','17'),(26,'Kieran','Trippier','Tottenham Hotspur','Defender','England','2'),(27,'Léo','Bonatini','Wolverhampton Wanderers','Forward','Brazil','33'),(28,'Marcus','Rashford','Manchester United','Forward','England','10'),(29,'Marcus','Rojo','Manchester United','Defender','Argentina','16'),(30,'Marouane','Fellaini','Manchester United','Midfielder','Belgium','27'),(31,'Matt','Doherty','Wolverhampton Wanderers','Defender','Ireland','2'),(32,'Miguel','Britos','Watford','Defender','Uruguay','3'),(33,'Mohamed','Salah','Liverpool','Forward','Egypt','11'),(34,'Morgan','Schneiderlin','Everton','Midfielder','France','18'),(35,'Moussa','Sissoko','France','Midfielder','France','17'),(36,'Nathan','Aké','Bournemouth','Defender','Netherlands','5'),(37,'Oumar','Niasse','Everton','Forward','Senegal','34'),(38,'Petr','Cech','Arsenal','Goalkeeper','Czech Republic','1'),(39,'Raheem','Sterling','Manchester City','Forward','England','7'),(40,'Rob','Holding','Arsenal','Defender','England','16'),(41,'Roberto','Firmino','Liverpool','Forward','Brazil','9'),(42,'Ryan','Fraser','Bournemouth','Midfielder','Scotland','24'),(43,'Seamus','Coleman','Everton','Defender','Ireland','23'),(44,'Simon','Mignolet','Liverpool','Goalkeeper','Belgium','22'),(45,'Stefano','Okaka','Watford','Forward','Italy','33'),(46,'Tom','Cleverly','Watford','Midfielder','England','8'),(47,'Troy','Deeney','Watford','Forward','England','9'),(48,'Victor','Moses','Chelsea','Defender','Nigeria','15'),(49,'Vincent','Kompany','Manchester City','Defender','Belgium','4'),(50,'Willy','Caballero','Chelsea','Goalkeeper','Argentina','13');
/*!40000 ALTER TABLE `Players` ENABLE KEYS */;
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
