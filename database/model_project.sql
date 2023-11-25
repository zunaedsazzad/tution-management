DROP DATABASE IF EXISTS `tution_management`;

CREATE DATABASE `tution_management`;

USE `tution_management`;

ALTER DATABASE `tution_management` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(300) NOT NULL,
  `password` varchar(40) NOT NULL,
  `contact` varchar(30) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `birth_date` date,
  `profile_photo` MEDIUMBLOB,
  `address` varchar(200) ,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_0900_ai_ci;


CREATE TABLE `user_type` (
  `ut_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL UNIQUE,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`ut_id`),
  CONSTRAINT `fk_user_type` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE TABLE `teacher_info` (
  `ti_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `salary` INT NOT NULL,
  `time` varchar(100),
  PRIMARY KEY (`ti_id`),
  CONSTRAINT `fk_teacher_info` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `day_teacher` (
  `day_id` INT NOT NULL AUTO_INCREMENT,
  `ti_id` INT NOT NULL,
  `day_name` varchar(100) NOT NULL,
  PRIMARY KEY (`day_id`),
  CONSTRAINT `fk_day_teacher` FOREIGN KEY (`ti_id`) REFERENCES `teacher_info` (`ti_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `rate_parents_teacher` (
  `rpt_id` INT NOT NULL AUTO_INCREMENT,
  `point` INT NOT NULL,
  `text` varchar(200),
  PRIMARY KEY (`rpt_id`)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE TABLE `rpt_junc` (
  `rpt_junc_id` INT NOT NULL AUTO_INCREMENT,
  `user_id_giver` INT NOT NULL UNIQUE,
  `user_id_receiver` INT NOT NULL UNIQUE,
  `rpt_id` INT NOT NULL,
  PRIMARY KEY (`rpt_junc_id`),
  CONSTRAINT `fk_rpt_junc_id` FOREIGN KEY (`rpt_id`) REFERENCES `rate_parents_teacher` (`rpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rpt_junc_giver` FOREIGN KEY (`user_id_giver`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rpt_junc_receiver` FOREIGN KEY (`user_id_receiver`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `degree` (
  `deg_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` varchar(100) NOT NULL,
  `institution` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date,
  PRIMARY KEY (`deg_id`),
  CONSTRAINT `fk_degree_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE `post` (
  `post_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` varchar(100) NOT NULL,
  `class` varchar(40) NOT NULL,
  `date_time` datetime NOT NULL,
  `time` varchar(50) NOT NULL,
  `salary` INT NOT NULL,
  `subject` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `duration` decimal(3,2) NOT NULL,
  PRIMARY KEY (`post_id`),
  CONSTRAINT `fk_post_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `day_post` (
  `day_post_id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `day_name` varchar(100) NOT NULL,
  PRIMARY KEY (`day_post_id`),
  CONSTRAINT `fk_day_post_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `subject` (
  `sub_id` INT NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`sub_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE `comment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `commenter_id` INT NOT NULL,
  `text_body` varchar(500) NOT NULL,
  `date` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL,
  PRIMARY KEY (`comment_id`),
  CONSTRAINT `fk_comment_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_commenter` FOREIGN KEY (`commenter_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE `teacher_subject_junc` (
  `tsjunc_id` INT NOT NULL AUTO_INCREMENT,
  `teacher_id` INT NOT NULL,
  `sub_id` INT NOT NULL,
  PRIMARY KEY (`tsjunc_id`),
  CONSTRAINT `fk_tsjunc_sub_id` FOREIGN KEY (`sub_id`) REFERENCES `subject` (`sub_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tsjunc_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `subject_junc` (
  `subjunc_id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `sub_id` INT NOT NULL,
  PRIMARY KEY (`subjunc_id`),
  CONSTRAINT `fk_subjunc_sub_id` FOREIGN KEY (`sub_id`) REFERENCES `subject` (`sub_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_subjunc_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE `class_junc` (
  `classjunc_id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`classjunc_id`),
  CONSTRAINT `fk_classjunc_class_id` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_classjunc_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 ;
