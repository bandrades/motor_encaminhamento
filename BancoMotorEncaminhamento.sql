-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (i686)
--
-- Host: 127.0.0.1    Database: motor_encaminhamento
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_areaTarifaria`
--

DROP TABLE IF EXISTS `tb_areaTarifaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_areaTarifaria` (
  `areaTarifaria` int(11) NOT NULL,
  `ddd` int(11) NOT NULL,
  `prefixo` varchar(45) NOT NULL,
  `sufixoStart` varchar(45) NOT NULL DEFAULT '0000',
  `sufixoEnd` varchar(45) NOT NULL DEFAULT '9999',
  `cidade` varchar(45) DEFAULT 'UBERLANDIA',
  PRIMARY KEY (`areaTarifaria`,`ddd`,`prefixo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_areaTarifaria`
--

LOCK TABLES `tb_areaTarifaria` WRITE;
/*!40000 ALTER TABLE `tb_areaTarifaria` DISABLE KEYS */;
INSERT INTO `tb_areaTarifaria` VALUES (342,34,'3210','0000','9999','UBERLANDIA'),(342,34,'3211','0000','9999','UBERLANDIA'),(342,34,'3212','0000','9999','UBERLANDIA'),(342,34,'3213','0000','9999','UBERLANDIA'),(342,34,'3214','0000','9999','UBERLANDIA'),(342,34,'3215','0000','9999','UBERLANDIA'),(342,34,'3216','0000','9999','UBERLANDIA'),(342,34,'3217','0000','9999','UBERLANDIA'),(342,34,'3218','0000','9999','UBERLANDIA'),(342,34,'3219','0000','9999','UBERLANDIA'),(342,34,'3221','0000','9999','UBERLANDIA'),(342,34,'3222','0000','9999','UBERLANDIA'),(342,34,'3223','0000','9999','UBERLANDIA'),(342,34,'3224','0000','9999','UBERLANDIA'),(342,34,'3225','0000','9999','UBERLANDIA'),(342,34,'3226','0000','9999','UBERLANDIA'),(342,34,'3227','0000','9999','UBERLANDIA'),(342,34,'3228','0000','9999','UBERLANDIA'),(342,34,'3229','0000','9999','UBERLANDIA'),(342,34,'3230','0000','9999','UBERLANDIA'),(342,34,'3231','0000','9999','UBERLANDIA'),(342,34,'3232','0000','9999','UBERLANDIA'),(342,34,'3233','0000','9999','UBERLANDIA'),(342,34,'3234','0000','9999','UBERLANDIA'),(342,34,'3235','0000','9999','UBERLANDIA'),(342,34,'3236','0000','9999','UBERLANDIA'),(342,34,'3237','0000','9999','UBERLANDIA'),(342,34,'3238','0000','9999','UBERLANDIA'),(342,34,'3239','0000','9999','UBERLANDIA'),(342,34,'3244','0000','9999','UBERLANDIA'),(342,34,'3253','0000','9999','UBERLANDIA'),(342,34,'3254','0000','9999','UBERLANDIA'),(342,34,'3255','0000','9999','UBERLANDIA'),(342,34,'3256','0000','9999','UBERLANDIA'),(342,34,'3257','0000','9999','UBERLANDIA'),(342,34,'3258','0000','9999','UBERLANDIA'),(342,34,'3259','0000','9999','UBERLANDIA'),(342,34,'3291','0000','9999','UBERLANDIA'),(342,34,'3292','0000','9999','UBERLANDIA'),(342,34,'3293','0000','9999','UBERLANDIA'),(342,34,'3299','0000','9999','UBERLANDIA');
/*!40000 ALTER TABLE `tb_areaTarifaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_portabilidade`
--

DROP TABLE IF EXISTS `tb_portabilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_portabilidade` (
  `operadora_anterior` enum('OI','TIM','VIVO','CTBC','CLARO','NEXTEL') DEFAULT NULL,
  `operadora_atual` enum('OI','TIM','VIVO','CTBC','CLARO','NEXTEL') DEFAULT NULL,
  `numero` varchar(45) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_tb_portabilidade_1_idx` (`operadora_anterior`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_portabilidade`
--

LOCK TABLES `tb_portabilidade` WRITE;
/*!40000 ALTER TABLE `tb_portabilidade` DISABLE KEYS */;
INSERT INTO `tb_portabilidade` VALUES ('CTBC','OI','03496368299'),('OI','TIM','06481550932');
/*!40000 ALTER TABLE `tb_portabilidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_rangeNumero`
--

DROP TABLE IF EXISTS `tb_rangeNumero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_rangeNumero` (
  `ddd` int(11) NOT NULL,
  `operadora` enum('OI','TIM','VIVO','CTBC','CLARO','NEXTEL') NOT NULL,
  `prefixoStart` varchar(45) NOT NULL,
  `prefixoEnd` varchar(45) NOT NULL,
  PRIMARY KEY (`ddd`,`operadora`,`prefixoEnd`,`prefixoStart`),
  KEY `fk_tb_rangeNumero_operadora_idx` (`operadora`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_rangeNumero`
--

LOCK TABLES `tb_rangeNumero` WRITE;
/*!40000 ALTER TABLE `tb_rangeNumero` DISABLE KEYS */;
INSERT INTO `tb_rangeNumero` VALUES (34,'OI','8701','8702'),(34,'OI','8719','8720'),(34,'OI','8721','8722'),(34,'OI','8800','8869'),(34,'OI','8871','8879'),(34,'OI','8881','8889'),(34,'OI','8891','8899'),(34,'TIM','9100','9291'),(34,'TIM','9293','9339'),(34,'VIVO','9800','9831'),(34,'VIVO','9901','9959'),(34,'VIVO','9981','9989'),(34,'CTBC','3210','3215'),(34,'CTBC','9630','9699'),(34,'CTBC','9762','9782'),(34,'CTBC','9789','9799'),(34,'CTBC','9891','9898'),(34,'CTBC','9960','9979'),(34,'CTBC','9990','9999'),(34,'CLARO','8441','8442'),(34,'NEXTEL','7400','7401');
/*!40000 ALTER TABLE `tb_rangeNumero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_rotas`
--

DROP TABLE IF EXISTS `tb_rotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_rotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` enum('FIXO','CELULAR','RADIO','SATELITE','DESCONHECIDO') DEFAULT NULL,
  `ddd` int(11) DEFAULT NULL,
  `operadora` enum('OI','TIM','VIVO','CTBC','CLARO','NEXTEL') DEFAULT NULL,
  `areaTarifaria` int(11) DEFAULT NULL,
  `peso` int(11) NOT NULL,
  `insert` varchar(45) NOT NULL,
  `offset_rotas` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_tb_rotas_1_idx` (`operadora`),
  KEY `fk_tb_rotas_2_idx` (`areaTarifaria`),
  KEY `fk_tb_rotas_3_idx` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_rotas`
--

LOCK TABLES `tb_rotas` WRITE;
/*!40000 ALTER TABLE `tb_rotas` DISABLE KEYS */;
INSERT INTO `tb_rotas` VALUES (1,'FIXO',NULL,NULL,342,9,'98A',1),(2,'FIXO',NULL,NULL,NULL,8,'10012',1),(3,'FIXO',NULL,NULL,NULL,7,'10023',1),(4,'FIXO',34,'OI',342,10,'10033',1),(5,'FIXO',34,'CTBC',342,10,'96C',1),(6,'CELULAR',NULL,'CLARO',NULL,8,'99A',1),(7,'CELULAR',NULL,'CLARO',NULL,9,'10013',1),(8,'CELULAR',64,'TIM',NULL,10,'10013',1),(9,'CELULAR',NULL,'TIM',NULL,9,'10021',1),(10,'CELULAR',NULL,NULL,NULL,7,'10031',1),(11,NULL,NULL,NULL,NULL,2,'10033',1);
/*!40000 ALTER TABLE `tb_rotas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-25  9:55:21
