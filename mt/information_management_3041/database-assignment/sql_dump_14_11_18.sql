-- MySQL dump 10.13  Distrib 8.0.13, for macos10.14 (x86_64)
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `home_team_id` int(11) DEFAULT NULL,
  `away_team_id` int(11) DEFAULT NULL,
  `stadium_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fixture_id_UNIQUE` (`id`),
  KEY `Fixtures - Home Team Id_idx` (`home_team_id`),
  KEY `Fixtures - Away Team Id_idx` (`away_team_id`),
  KEY `Fixtures - Stadium Id_idx` (`stadium_id`),
  CONSTRAINT `FK_Away_Team_Id` FOREIGN KEY (`away_team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `FK_Fixtures_Stadium_Id` FOREIGN KEY (`stadium_id`) REFERENCES `stadiums` (`id`),
  CONSTRAINT `FK_Home_Team_Id` FOREIGN KEY (`home_team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fixtures`
--

LOCK TABLES `Fixtures` WRITE;
/*!40000 ALTER TABLE `Fixtures` DISABLE KEYS */;
INSERT INTO `Fixtures` VALUES (1,1,6,3,'2017-12-01','16:30:00'),(2,1,8,3,'2017-11-11','16:30:00'),(3,1,10,3,'2017-11-24','16:30:00'),(4,2,10,2,'2017-11-11','16:30:00'),(5,3,2,8,'2017-11-24','14:15:00'),(6,3,4,8,'2017-11-11','14:15:00'),(7,3,5,8,'2017-12-08','16:30:00'),(8,3,6,8,'2017-12-08','12:00:00'),(9,4,1,5,'2017-12-08','16:30:00'),(10,4,8,5,'2017-11-24','16:30:00'),(11,5,9,1,'2017-11-11','12:00:00'),(12,6,5,4,'2017-11-11','16:30:00'),(13,6,7,4,'2017-11-11','16:30:00'),(14,7,4,7,'2017-12-01','12:00:00'),(15,7,9,7,'2017-11-24','12:00:00'),(16,8,2,10,'2017-12-01','14:15:00'),(17,8,7,10,'2017-12-08','14:15:00'),(18,9,3,9,'2017-12-01','16:30:00'),(19,9,10,9,'2017-12-08','16:30:00'),(20,10,5,6,'2017-12-01','16:30:00');
/*!40000 ALTER TABLE `Fixtures` ENABLE KEYS */;
UNLOCK TABLES;
--
-- WARNING: old server version. The following dump may be incomplete.
--
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`dooleyb1`@`mysql.scss.tcd.ie` */ /*!50003 TRIGGER `process_fixture_goal_difference` AFTER UPDATE ON `Fixtures` FOR EACH ROW BEGIN
    IF NEW.result = 'win' THEN
  		-- If the home team won update goal difference accordingly
  		IF NEW.winner_id = NEW.home_team_id THEN
  			UPDATE Teams
  			SET goal_difference = CASE
  				WHEN id = NEW.home_team_id THEN goal_difference + (NEW.home_goals - NEW.away_goals)
          WHEN id = NEW.away_team_id THEN goal_difference - (NEW.home_goals - NEW.away_goals)
          ELSE goal_difference + 0
        END;
  		-- If the away team won update goal difference accordingly
  		ELSEIF NEW.winner_id = NEW.away_team_id THEN
  			UPDATE Teams
  			SET goal_difference = CASE
  				WHEN id = NEW.home_team_id THEN goal_difference - (NEW.away_goals - NEW.home_goals)
          WHEN id = NEW.away_team_id THEN goal_difference + (NEW.away_goals - NEW.home_goals)
          ELSE goal_difference + 0
        END;
  		END IF;
	  END IF;
END */;;
DELIMITER ;
--
-- WARNING: old server version. The following dump may be incomplete.
--
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`dooleyb1`@`mysql.scss.tcd.ie` */ /*!50003 TRIGGER `process_fixture_win` AFTER UPDATE ON `Fixtures` FOR EACH ROW BEGIN
    IF NEW.result = 'win' THEN
		    UPDATE Teams
			SET points = points + 3
			WHERE id = NEW.winner_id;
	END IF;
END */;;
DELIMITER ;

--
-- Table structure for table `Managers`
--

DROP TABLE IF EXISTS `Managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Managers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manager_name` varchar(25) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `salary` bigint(10) DEFAULT NULL,
  `country` varchar(25) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `manager_id_UNIQUE` (`id`),
  KEY `team_id_idx` (`team_id`),
  CONSTRAINT `FK_Managers_Team_Id` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Managers`
--

LOCK TABLES `Managers` WRITE;
/*!40000 ALTER TABLE `Managers` DISABLE KEYS */;
INSERT INTO `Managers` VALUES (1,'Eddie Howe',40,500000,'England',2),(2,'Javie Gracia',48,4000000,'Spain',9),(3,'José Mourinho',55,15000000,'Portugal',7),(4,'Josep Guardiola',47,15300000,'Spain',6),(5,'Jürgen Klopp',51,7000000,'Germany',5),(6,'Marco Silva',41,3000000,'Portugal',4),(7,'Mauricio Pochettino ',46,8500000,'Argentina',8),(8,'Maurizio Sarri',59,4500000,'Italy',3),(9,'Nuno Espírito Santo',44,3000000,'Portugal',10),(10,'Unai Emery',46,6000000,'Spain',1),(11,'Brandon',21,97000000,'Ireland',1);
/*!40000 ALTER TABLE `Managers` ENABLE KEYS */;
UNLOCK TABLES;
--
-- WARNING: old server version. The following dump may be incomplete.
--
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`dooleyb1`@`mysql.scss.tcd.ie` */ /*!50003 TRIGGER `process_new_manager` AFTER INSERT ON `Managers` FOR EACH ROW BEGIN
  -- Update manager id in Teams
	UPDATE Teams
    SET manager_id = NEW.id
    WHERE id = NEW.team_id;
END */;;
DELIMITER ;
--
-- WARNING: old server version. The following dump may be incomplete.
--
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`dooleyb1`@`mysql.scss.tcd.ie` */ /*!50003 TRIGGER `process_manager_delete` BEFORE DELETE ON `Managers` FOR EACH ROW BEGIN
  -- Update manager id in Teams
	UPDATE Teams
    SET manager_id = NULL
    WHERE id = OLD.team_id;
END */;;
DELIMITER ;

--
-- Temporary view structure for view `managers_overview`
--

DROP TABLE IF EXISTS `managers_overview`;
/*!50001 DROP VIEW IF EXISTS `managers_overview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `managers_overview` AS SELECT 
 1 AS `manager_name`,
 1 AS `team_name`,
 1 AS `salary`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Players`
--

DROP TABLE IF EXISTS `Players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(15) NOT NULL,
  `second_name` varchar(15) NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  `position` varchar(10) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `player_id_UNIQUE` (`id`),
  KEY `Players - Team Id_idx` (`team_id`),
  CONSTRAINT `FK_Players_Team_Id` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Players`
--

LOCK TABLES `Players` WRITE;
/*!40000 ALTER TABLE `Players` DISABLE KEYS */;
INSERT INTO `Players` VALUES (1,'Aaron','Ramsey',1,'Midfielder','Wales','8'),(2,'Alexandre','Lacazette',1,'Forward','France','9'),(3,'Alexis','Sanchez',7,'Forward','Chile','7'),(4,'Álvaro','Morata',3,'Forward','Spain','29'),(5,'Artur','Boruc',2,'Goalkeeper','Poland','1'),(6,'Ben','Ashley-Seal',10,'Forward','England','24'),(7,'Cenk','Tosun',4,'Forward','Turkey','14'),(8,'Claudio','Bravo',6,'Goalkeeper','Chile','1'),(9,'Daniel','Drinkwater',3,'Midfielder','England','6'),(10,'Danny','Welbeck',1,'Forward','England','23'),(11,'David','de Gea',7,'Goalkeeper','Spain','1'),(12,'Dejan','Lovren',5,'Defender','Croatia','6'),(13,'Diogo','Jota',10,'Midfielder','Portugal','18'),(14,'Eden','Hazard',3,'Forward','Belgium','10'),(15,'Fabian','Delph',6,'Midfielder','England','18'),(16,'Fernando','Llorente',8,'Forward','Spain','18'),(17,'Gabriel','Jesus',6,'Forward','Brazil','33'),(18,'Harry','Kane',8,'Forward','England','10'),(19,'Heurelho','Gomes',9,'Goalkeeper','Brazil','1'),(20,'Hugo','Lloris',8,'Goalkeeper','France','1'),(21,'James','Milner',5,'Midfielder','England','7'),(22,'Jermain','Defoe',2,'Forward','England','18'),(23,'John','Ruddy',10,'Goalkeeper','England','21'),(24,'Jordan','Pickford',4,'Goalkeeper','England','1'),(25,'Joshua','King',2,'Forward','Norway','17'),(26,'Kieran','Trippier',8,'Defender','England','2'),(27,'Léo','Bonatini',10,'Forward','Brazil','33'),(28,'Marcus','Rashford',7,'Forward','England','10'),(29,'Marcus','Rojo',7,'Defender','Argentina','16'),(30,'Marouane','Fellaini',7,'Midfielder','Belgium','27'),(31,'Matt','Doherty',10,'Defender','Ireland','2'),(32,'Miguel','Britos',9,'Defender','Uruguay','3'),(33,'Mohamed','Salah',5,'Forward','Egypt','11'),(34,'Morgan','Schneiderlin',4,'Midfielder','France','18'),(35,'Moussa','Sissoko',NULL,'Midfielder','France','17'),(36,'Nathan','Aké',2,'Defender','Netherlands','5'),(37,'Oumar','Niasse',4,'Forward','Senegal','34'),(38,'Petr','Cech',1,'Goalkeeper','Czech Republic','1'),(39,'Raheem','Sterling',6,'Forward','England','7'),(40,'Rob','Holding',1,'Defender','England','16'),(41,'Roberto','Firmino',5,'Forward','Brazil','9'),(42,'Ryan','Fraser',2,'Midfielder','Scotland','24'),(43,'Seamus','Coleman',4,'Defender','Ireland','23'),(44,'Simon','Mignolet',5,'Goalkeeper','Belgium','22'),(45,'Stefano','Okaka',9,'Forward','Italy','33'),(46,'Tom','Cleverly',9,'Midfielder','England','8'),(47,'Troy','Deeney',9,'Forward','England','9'),(48,'Victor','Moses',3,'Defender','Nigeria','15'),(49,'Vincent','Kompany',6,'Defender','Belgium','4'),(50,'Willy','Caballero',3,'Goalkeeper','Argentina','13');
/*!40000 ALTER TABLE `Players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Results`
--

DROP TABLE IF EXISTS `Results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fixture_id` int(11) DEFAULT NULL,
  `home_goals` int(11) DEFAULT NULL,
  `away_goals` int(11) DEFAULT NULL,
  `result` varchar(45) DEFAULT NULL,
  `winner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `FK_Results_Fixture_Id` (`fixture_id`),
  KEY `FK_Results_Winner_Id` (`winner_id`),
  CONSTRAINT `FK_Results_Fixture_Id` FOREIGN KEY (`fixture_id`) REFERENCES `fixtures` (`id`),
  CONSTRAINT `FK_Results_Winner_Id` FOREIGN KEY (`winner_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Results`
--

LOCK TABLES `Results` WRITE;
/*!40000 ALTER TABLE `Results` DISABLE KEYS */;
/*!40000 ALTER TABLE `Results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stadiums`
--

DROP TABLE IF EXISTS `Stadiums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Stadiums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stadium_name` varchar(25) NOT NULL,
  `city` varchar(25) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `opened` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stadium_id_UNIQUE` (`id`),
  KEY `team_id_idx` (`team_id`),
  CONSTRAINT `FK_Stadiums_Team_Id` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stadiums`
--

LOCK TABLES `Stadiums` WRITE;
/*!40000 ALTER TABLE `Stadiums` DISABLE KEYS */;
INSERT INTO `Stadiums` VALUES (1,'Anfield','Liverpool',5,54074,1884),(2,'Dean Court','Bournemouth',2,11360,1910),(3,'Emirates Stadium','London',1,59867,2006),(4,'Etihad Stadium','Manchester',6,55097,2003),(5,'Goodison Park','Liverpool',4,39571,1892),(6,'Molineux Stadium','Wolverhampton',10,31700,1889),(7,'Old Trafford','Manchester',7,75643,1910),(8,'Stamford Bridge','London',3,41631,1877),(9,'Vicarage Road','Watford',9,21977,1922),(10,'Wembley Stadium','London',8,90000,2007);
/*!40000 ALTER TABLE `Stadiums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teams`
--

DROP TABLE IF EXISTS `Teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(25) NOT NULL,
  `stadium_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `city` varchar(25) NOT NULL,
  `position` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `goal_difference` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_id_UNIQUE` (`id`),
  KEY `Teams - Stadium Id_idx` (`stadium_id`),
  KEY `Teams - Manager Id_idx` (`manager_id`),
  CONSTRAINT `FK_Teams_Manager_Id` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`),
  CONSTRAINT `FK_Teams_Stadium_Id` FOREIGN KEY (`stadium_id`) REFERENCES `stadiums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teams`
--

LOCK TABLES `Teams` WRITE;
/*!40000 ALTER TABLE `Teams` DISABLE KEYS */;
INSERT INTO `Teams` VALUES (1,'Arsenal',3,11,'London',4,25,11),(2,'Bournemouth',2,1,'Bournemouth',6,20,7),(3,'Chelsea',8,8,'London',3,24,17),(4,'Everton',5,6,'Liverpool',9,15,2),(5,'Liverpool',1,5,'Liverpool',2,26,16),(6,'Manchester City',4,3,'Manchester',1,26,24),(7,'Manchester United',7,4,'Manchester',8,17,0),(8,'Tottenham Hotspur',10,7,'London',5,21,8),(9,'Watford',9,2,'Watford',7,19,4),(10,'Wolverhampton Wanderers',6,9,'Wolverhampton',10,15,0);
/*!40000 ALTER TABLE `Teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `teams_overview`
--

DROP TABLE IF EXISTS `teams_overview`;
/*!50001 DROP VIEW IF EXISTS `teams_overview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `teams_overview` AS SELECT 
 1 AS `team_name`,
 1 AS `manager_name`,
 1 AS `stadium_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Transfers`
--

DROP TABLE IF EXISTS `Transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Transfers` (
  `id` int(11) NOT NULL,
  `player_id` int(11) DEFAULT NULL,
  `old_team_id` int(11) DEFAULT NULL,
  `new_team_id` int(11) DEFAULT NULL,
  `transfer_fee` bigint(10) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Transfers - Player Id_idx` (`player_id`),
  KEY `Transfers - Old Team Id_idx` (`old_team_id`),
  KEY `Transfers - New Team Id_idx` (`new_team_id`),
  CONSTRAINT `FK_Transfers_New_Team_Id` FOREIGN KEY (`new_team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `FK_Transfers_Old_Team_Id` FOREIGN KEY (`old_team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `FK_Transfers_Player_Id` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transfers`
--

LOCK TABLES `Transfers` WRITE;
/*!40000 ALTER TABLE `Transfers` DISABLE KEYS */;
INSERT INTO `Transfers` VALUES (1,1,1,2,5000000,'2018-11-06'),(2,1,2,1,5000000,'2018-11-06');
/*!40000 ALTER TABLE `Transfers` ENABLE KEYS */;
UNLOCK TABLES;
--
-- WARNING: old server version. The following dump may be incomplete.
--
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`dooleyb1`@`mysql.scss.tcd.ie` */ /*!50003 TRIGGER `process_player_transfer` AFTER INSERT ON `Transfers` FOR EACH ROW BEGIN
    UPDATE Players
    SET team_id = NEW.new_team_id,
			changed_at = NOW()
	WHERE id = NEW.player_id;
END */;;
DELIMITER ;

--
-- Dumping events for database 'premier-league'
--

--
-- Dumping routines for database 'premier-league'
--

--
-- Final view structure for view `managers_overview`
--

/*!50001 DROP VIEW IF EXISTS `managers_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dooleyb1`@`mysql.scss.tcd.ie` SQL SECURITY DEFINER */
/*!50001 VIEW `managers_overview` AS select `m`.`manager_name` AS `manager_name`,`t`.`team_name` AS `team_name`,`m`.`salary` AS `salary` from (`teams` `t` join `managers` `m`) where (`t`.`id` = `m`.`team_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teams_overview`
--

/*!50001 DROP VIEW IF EXISTS `teams_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dooleyb1`@`mysql.scss.tcd.ie` SQL SECURITY DEFINER */
/*!50001 VIEW `teams_overview` AS select `t`.`team_name` AS `team_name`,`m`.`manager_name` AS `manager_name`,`s`.`stadium_name` AS `stadium_name` from ((`teams` `t` join `managers` `m`) join `stadiums` `s`) where ((`t`.`id` = `m`.`team_id`) and (`t`.`id` = `s`.`team_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-14 20:47:27
