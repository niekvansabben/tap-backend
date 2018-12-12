# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 206.189.106.84 (MySQL 5.7.24-0ubuntu0.18.10.1)
# Database: tap
# Generation Time: 2018-12-12 11:11:19 +0000
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

CREATE TABLE `points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `hint` text,
  `latitude` double(11,8) DEFAULT NULL,
  `longitude` double(10,8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;



# Dump of table ratings
# ------------------------------------------------------------

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` tinyint(1) DEFAULT NULL,
  `route_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `route_id` (`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;



# Dump of table route_points
# ------------------------------------------------------------

CREATE TABLE `route_points` (
  `route_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `order_number` int(11) DEFAULT NULL,
  KEY `route_id` (`route_id`),
  KEY `point_id` (`point_id`),
  CONSTRAINT `point` FOREIGN KEY (`point_id`) REFERENCES `points` (`id`),
  CONSTRAINT `route` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table routes
# ------------------------------------------------------------

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `duration_time` int(3) DEFAULT NULL,
  `duration_distance` int(2) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
