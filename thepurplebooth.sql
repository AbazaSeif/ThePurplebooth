-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 30, 2013 at 12:21 PM
-- Server version: 5.5.29
-- PHP Version: 5.4.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `thepurplebooth`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_MAX_IMAGE_ID`()
BEGIN
	DECLARE count INT;
	SET count = (SELECT MAX(image_id) FROM thepurplebooth.imageinfo);
	
	IF count > 0 THEN
		SET count = count + 1;
	ELSE
		SET count = 1;
	END IF;

	SELECT count;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `editrequest`
--

CREATE TABLE `editrequest` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `request_user_id` int(11) unsigned NOT NULL,
  `request_image_user_id` int(11) unsigned NOT NULL,
  `request_image_id` int(11) NOT NULL,
  `request_status` tinyint(1) NOT NULL DEFAULT '0',
  `request_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`request_id`),
  KEY `request_user_id` (`request_user_id`,`request_image_id`,`request_image_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `imagecomment`
--

CREATE TABLE `imagecomment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_user_id` int(11) unsigned NOT NULL,
  `comment_text` varchar(200) NOT NULL,
  `comment_image_id` int(11) NOT NULL,
  `comment_timestamp` datetime NOT NULL,
  `comment_user_name` varchar(45) NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_user_id` (`comment_user_id`),
  KEY `comment_image_id` (`comment_image_id`),
  KEY `comment_user_id_2` (`comment_user_id`),
  KEY `comment_image_id_2` (`comment_image_id`),
  KEY `comment_timestamp` (`comment_timestamp`),
  KEY `comment_user_name` (`comment_user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `imageinfo`
--

CREATE TABLE `imageinfo` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `editor_id` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `content` varchar(45) NOT NULL,
  `edited_img_link` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `editor_description` varchar(200) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `deletable` varchar(1) NOT NULL,
  `created_on` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `closed_project` int(1) DEFAULT NULL,
  PRIMARY KEY (`image_id`),
  KEY `user_id` (`user_id`),
  KEY `user_id_2` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `from_user_id` int(11) unsigned NOT NULL,
  `to_user_id` int(11) unsigned NOT NULL,
  `notification_image_id` int(11) NOT NULL,
  `notification_type` enum('COMMENT','REPLY','REQUEST_NEW','REQUEST_APPROVED','REQUEST_DENIED') NOT NULL,
  `notification_read` tinyint(1) NOT NULL DEFAULT '0',
  `notification_timestamp` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `from_user_id` (`from_user_id`,`to_user_id`),
  KEY `notification_image_id` (`notification_image_id`),
  KEY `to_user_id` (`to_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `rated_by` int(11) DEFAULT NULL,
  `rating` int(5) DEFAULT '0',
  `comments` varchar(200) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Table structure for table `replycomment`
--

CREATE TABLE `replycomment` (
  `reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `reply_user_id` int(11) unsigned NOT NULL,
  `reply_user_name` varchar(45) NOT NULL,
  `reply_comment_id` int(11) NOT NULL,
  `reply_text` varchar(200) NOT NULL,
  `reply_timestamp` datetime NOT NULL,
  PRIMARY KEY (`reply_id`),
  KEY `reply_user_id` (`reply_user_id`),
  KEY `reply_comment_id` (`reply_comment_id`),
  KEY `reply_user_name` (`reply_user_name`),
  KEY `reply_user_name_2` (`reply_user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `full_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `active` int(11) NOT NULL,
  `profile_picture` varchar(200) DEFAULT NULL,
  `profile_url` varchar(160) DEFAULT NULL,
  `provider_id` varchar(150) NOT NULL,
  `about_me` varchar(200) DEFAULT NULL,
  `class` varchar(25) NOT NULL,
  `creativity` varchar(10) NOT NULL,
  `rating` varchar(10) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`notification_image_id`) REFERENCES `imageinfo` (`image_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
