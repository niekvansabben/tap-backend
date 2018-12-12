# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 206.189.106.84 (MySQL 5.7.24-0ubuntu0.18.10.1)
# Database: tap
# Generation Time: 2018-12-12 11:12:37 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table points
# ------------------------------------------------------------

DROP TABLE IF EXISTS `points`;

CREATE TABLE `points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `hint` text,
  `latitude` double(11,8) DEFAULT NULL,
  `longitude` double(10,8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

LOCK TABLES `points` WRITE;
/*!40000 ALTER TABLE `points` DISABLE KEYS */;

INSERT INTO `points` (`id`, `description`, `hint`, `latitude`, `longitude`)
VALUES
	(1,'blablabla','hint',60.22136800,24.80688000),
	(2,'blalabla','hint',60.22085100,24.80633800),
	(3,'blalabla','hint',60.22136800,24.80688000),
	(4,'blalabla','hint',60.22085100,24.80633800),
	(5,'blalabla','hint',60.22136800,24.80688000),
	(6,'blalabla','hint',60.22085100,24.80633800),
	(7,'blalabla','hint',1.00000000,2.00000000),
	(8,'blalabla','hint',1.00000000,2.00000000),
	(9,'blalabla','hint',1.00000000,2.00000000),
	(10,'blalabla','hint',1.00000000,2.00000000),
	(11,'blalabla','hint',1.00000000,2.00000000),
	(12,'blalabla','hint',1.00000000,2.00000000),
	(13,'blalabla','hint',1.00000000,2.00000000),
	(14,'blalabla','hint',1.00000000,2.00000000),
	(15,'blalabla','hint',1.00000000,2.00000000),
	(16,'Point 1','Starting point',60.22085100,24.80633800),
	(17,'Point 2','You can hear cars above you',60.21916500,24.80242860),
	(18,'Point 3','Can you feel the concrete jungle and huge cracks under your palm',60.21951570,24.80763820),
	(19,'Point 4','You can smell a gas in the air',60.22104680,24.81291110),
	(20,'Point 1','Starting point',60.22121670,24.81103430),
	(21,'Point 2','You can feel that forest is watching you.',60.22206060,24.80546890),
	(22,'Point 3','You have to escape from the car labyrinth.',60.22442580,24.80218810),
	(23,'Point 1','Starting point',60.22013330,24.80653930),
	(24,'Point 2','You can smell the forest and nature or you can hear noisy students.',60.22271620,24.80237320),
	(25,'Point 3','You can see something growing.',60.22361690,24.78658800),
	(26,'Point 1','Starting point',60.22075270,24.80861690),
	(27,'Point 2','Look at the highest thing in the sky.',60.22083080,24.81464750),
	(28,'Point 3','Feel the red bricks.',60.22263270,24.81586440);

/*!40000 ALTER TABLE `points` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ratings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ratings`;

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` tinyint(1) DEFAULT NULL,
  `route_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `route_id` (`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;

INSERT INTO `ratings` (`id`, `rating`, `route_id`, `user_id`)
VALUES
	(1,2,1,NULL),
	(2,2,1,NULL),
	(3,2,1,NULL),
	(4,3,1,NULL),
	(5,2,2,NULL),
	(6,2,2,NULL),
	(7,3,2,NULL),
	(8,1,2,NULL),
	(9,3,3,NULL),
	(10,2,4,NULL),
	(11,2,5,NULL),
	(12,5,7,NULL),
	(13,3,1,NULL),
	(14,2,4,5),
	(15,5,7,6),
	(16,5,7,6),
	(17,5,7,6),
	(18,5,7,6),
	(19,5,7,6),
	(20,5,7,6),
	(21,2,1,6),
	(22,3,1,6),
	(23,1,1,6),
	(24,3,1,6),
	(25,5,7,6),
	(26,2,7,6),
	(27,2,1,6),
	(28,5,7,6),
	(29,3,7,6),
	(30,5,7,6),
	(31,5,7,6),
	(32,5,7,6),
	(33,5,7,6),
	(34,3,7,6),
	(35,2,7,6),
	(36,5,7,6),
	(37,5,7,6),
	(38,5,8,6),
	(39,4,9,6),
	(40,4,10,6),
	(41,5,7,6),
	(42,6,4,5),
	(43,3,3,6);

/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table route_points
# ------------------------------------------------------------

DROP TABLE IF EXISTS `route_points`;

CREATE TABLE `route_points` (
  `route_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `order_number` int(11) DEFAULT NULL,
  KEY `route_id` (`route_id`),
  KEY `point_id` (`point_id`),
  CONSTRAINT `point` FOREIGN KEY (`point_id`) REFERENCES `points` (`id`),
  CONSTRAINT `route` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `route_points` WRITE;
/*!40000 ALTER TABLE `route_points` DISABLE KEYS */;

INSERT INTO `route_points` (`route_id`, `point_id`, `order_number`)
VALUES
	(1,1,1),
	(1,2,2),
	(1,3,3),
	(1,4,4),
	(1,5,5),
	(1,6,6),
	(2,7,7),
	(2,8,8),
	(2,9,9),
	(2,10,10),
	(2,11,11),
	(3,12,12),
	(3,13,13),
	(4,14,1),
	(5,15,2),
	(7,16,1),
	(7,17,2),
	(7,18,3),
	(7,19,4),
	(8,20,1),
	(8,21,2),
	(8,22,3),
	(9,23,1),
	(9,24,2),
	(9,25,3),
	(10,26,1),
	(10,27,2),
	(10,28,3);

/*!40000 ALTER TABLE `route_points` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `duration_time` int(3) DEFAULT NULL,
  `duration_distance` int(2) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;

INSERT INTO `routes` (`id`, `name`, `description`, `duration_time`, `duration_distance`, `timestamp`)
VALUES
	(1,'This is gonna take some time','This a placeholder',240,10,'2018-01-05 20:09:13'),
	(2,'Blue','This a placeholder',60,3,'2018-10-19 13:06:40'),
	(3,'Fresh air','This a placeholder',15,1,'2017-07-12 10:05:57'),
	(4,'Belicimo','This a placeholder',30,2,'2018-11-20 11:06:09'),
	(5,'Hyvä','This a placeholder',120,5,'2018-09-23 09:21:43'),
	(7,'Full experience','This route enhances your navigating skills with smell, touch and sounds!',60,2,'2018-11-22 12:00:00'),
	(8,'Best of both worlds','This route will give you the best combination of nature and city.',50,3,'2018-12-11 00:00:00'),
	(9,'Green route','This route makes you experience the nature.',45,4,'2018-12-12 00:00:00'),
	(10,'Sky is the limit','This route will make you more aware of the thing that are above you. There is no nature but the route is still beautifull.',50,3,'2018-12-12 00:00:00');

/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
