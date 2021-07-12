-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 07, 2021 at 03:38 PM
-- Server version: 8.0.23-0ubuntu0.20.04.1
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lms`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts_user`
--

CREATE TABLE `accounts_user` (
  `id` int NOT NULL,
  `first_name` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(225) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(6, 'company_admin_group'),
(3, 'company_instructor_group'),
(2, 'end_user_group'),
(7, 'test_role');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add site', 7, 'add_site'),
(26, 'Can change site', 7, 'change_site'),
(27, 'Can delete site', 7, 'delete_site'),
(28, 'Can view site', 7, 'view_site'),
(29, 'Can add perm', 8, 'add_perm'),
(30, 'Can change perm', 8, 'change_perm'),
(31, 'Can delete perm', 8, 'delete_perm'),
(32, 'Can view perm', 8, 'view_perm'),
(33, 'Can add activity adding', 9, 'add_activityadding'),
(34, 'Can change activity adding', 9, 'change_activityadding'),
(35, 'Can delete activity adding', 9, 'delete_activityadding'),
(36, 'Can view activity adding', 9, 'view_activityadding'),
(37, 'Can add answer', 10, 'add_answer'),
(38, 'Can change answer', 10, 'change_answer'),
(39, 'Can delete answer', 10, 'delete_answer'),
(40, 'Can view answer', 10, 'view_answer'),
(41, 'Can add categories', 11, 'add_categories'),
(42, 'Can change categories', 11, 'change_categories'),
(43, 'Can delete categories', 11, 'delete_categories'),
(44, 'Can view categories', 11, 'view_categories'),
(45, 'Can add categories hirerchy', 12, 'add_categorieshirerchy'),
(46, 'Can change categories hirerchy', 12, 'change_categorieshirerchy'),
(47, 'Can delete categories hirerchy', 12, 'delete_categorieshirerchy'),
(48, 'Can view categories hirerchy', 12, 'view_categorieshirerchy'),
(49, 'Can add chat activity', 13, 'add_chatactivity'),
(50, 'Can change chat activity', 13, 'change_chatactivity'),
(51, 'Can delete chat activity', 13, 'delete_chatactivity'),
(52, 'Can view chat activity', 13, 'view_chatactivity'),
(53, 'Can add classroom', 14, 'add_classroom'),
(54, 'Can change classroom', 14, 'change_classroom'),
(55, 'Can delete classroom', 14, 'delete_classroom'),
(56, 'Can view classroom', 14, 'view_classroom'),
(57, 'Can add content video', 15, 'add_contentvideo'),
(58, 'Can change content video', 15, 'change_contentvideo'),
(59, 'Can delete content video', 15, 'delete_contentvideo'),
(60, 'Can view content video', 15, 'view_contentvideo'),
(61, 'Can add course enroll', 16, 'add_courseenroll'),
(62, 'Can change course enroll', 16, 'change_courseenroll'),
(63, 'Can delete course enroll', 16, 'delete_courseenroll'),
(64, 'Can view course enroll', 16, 'view_courseenroll'),
(65, 'Can add courses', 17, 'add_courses'),
(66, 'Can change courses', 17, 'change_courses'),
(67, 'Can delete courses', 17, 'delete_courses'),
(68, 'Can view courses', 17, 'view_courses'),
(69, 'Can add courses end user', 18, 'add_coursesenduser'),
(70, 'Can change courses end user', 18, 'change_coursesenduser'),
(71, 'Can delete courses end user', 18, 'delete_coursesenduser'),
(72, 'Can view courses end user', 18, 'view_coursesenduser'),
(73, 'Can add file activity', 19, 'add_fileactivity'),
(74, 'Can change file activity', 19, 'change_fileactivity'),
(75, 'Can delete file activity', 19, 'delete_fileactivity'),
(76, 'Can view file activity', 19, 'view_fileactivity'),
(77, 'Can add language', 20, 'add_language'),
(78, 'Can change language', 20, 'change_language'),
(79, 'Can delete language', 20, 'delete_language'),
(80, 'Can view language', 20, 'view_language'),
(81, 'Can add language course', 21, 'add_languagecourse'),
(82, 'Can change language course', 21, 'change_languagecourse'),
(83, 'Can delete language course', 21, 'delete_languagecourse'),
(84, 'Can view language course', 21, 'view_languagecourse'),
(85, 'Can add organization', 22, 'add_organization'),
(86, 'Can change organization', 22, 'change_organization'),
(87, 'Can delete organization', 22, 'delete_organization'),
(88, 'Can view organization', 22, 'view_organization'),
(89, 'Can add person in room', 23, 'add_personinroom'),
(90, 'Can change person in room', 23, 'change_personinroom'),
(91, 'Can delete person in room', 23, 'delete_personinroom'),
(92, 'Can view person in room', 23, 'view_personinroom'),
(93, 'Can add question', 24, 'add_question'),
(94, 'Can change question', 24, 'change_question'),
(95, 'Can delete question', 24, 'delete_question'),
(96, 'Can view question', 24, 'view_question'),
(97, 'Can add spin activity', 25, 'add_spinactivity'),
(98, 'Can change spin activity', 25, 'change_spinactivity'),
(99, 'Can delete spin activity', 25, 'delete_spinactivity'),
(100, 'Can view spin activity', 25, 'view_spinactivity'),
(101, 'Can add topic', 26, 'add_topic'),
(102, 'Can change topic', 26, 'change_topic'),
(103, 'Can delete topic', 26, 'delete_topic'),
(104, 'Can view topic', 26, 'view_topic'),
(105, 'Can add user categories', 27, 'add_usercategories'),
(106, 'Can change user categories', 27, 'change_usercategories'),
(107, 'Can delete user categories', 27, 'delete_usercategories'),
(108, 'Can view user categories', 27, 'view_usercategories'),
(109, 'Can add topic relation', 28, 'add_topicrelation'),
(110, 'Can change topic relation', 28, 'change_topicrelation'),
(111, 'Can delete topic relation', 28, 'delete_topicrelation'),
(112, 'Can view topic relation', 28, 'view_topicrelation'),
(113, 'Can add topic details', 29, 'add_topicdetails'),
(114, 'Can change topic details', 29, 'change_topicdetails'),
(115, 'Can delete topic details', 29, 'delete_topicdetails'),
(116, 'Can view topic details', 29, 'view_topicdetails'),
(117, 'Can add sub topic', 30, 'add_subtopic'),
(118, 'Can change sub topic', 30, 'change_subtopic'),
(119, 'Can delete sub topic', 30, 'delete_subtopic'),
(120, 'Can view sub topic', 30, 'view_subtopic'),
(121, 'Can add spin activity enroll', 31, 'add_spinactivityenroll'),
(122, 'Can change spin activity enroll', 31, 'change_spinactivityenroll'),
(123, 'Can delete spin activity enroll', 31, 'delete_spinactivityenroll'),
(124, 'Can view spin activity enroll', 31, 'view_spinactivityenroll'),
(125, 'Can add spin activity answer', 32, 'add_spinactivityanswer'),
(126, 'Can change spin activity answer', 32, 'change_spinactivityanswer'),
(127, 'Can delete spin activity answer', 32, 'delete_spinactivityanswer'),
(128, 'Can view spin activity answer', 32, 'view_spinactivityanswer'),
(129, 'Can add session activity', 33, 'add_sessionactivity'),
(130, 'Can change session activity', 33, 'change_sessionactivity'),
(131, 'Can delete session activity', 33, 'delete_sessionactivity'),
(132, 'Can view session activity', 33, 'view_sessionactivity'),
(133, 'Can add activity type', 34, 'add_activitytype'),
(134, 'Can change activity type', 34, 'change_activitytype'),
(135, 'Can delete activity type', 34, 'delete_activitytype'),
(136, 'Can view activity type', 34, 'view_activitytype'),
(137, 'Can add country', 35, 'add_country'),
(138, 'Can change country', 35, 'change_country'),
(139, 'Can delete country', 35, 'delete_country'),
(140, 'Can view country', 35, 'view_country'),
(141, 'Can add state', 36, 'add_state'),
(142, 'Can change state', 36, 'change_state'),
(143, 'Can delete state', 36, 'delete_state'),
(144, 'Can view state', 36, 'view_state'),
(145, 'Can add city', 37, 'add_city'),
(146, 'Can change city', 37, 'change_city'),
(147, 'Can delete city', 37, 'delete_city'),
(148, 'Can view city', 37, 'view_city'),
(149, 'Can add activities', 38, 'add_activities'),
(150, 'Can change activities', 38, 'change_activities'),
(151, 'Can delete activities', 38, 'delete_activities'),
(152, 'Can view activities', 38, 'view_activities'),
(153, 'Can add topic wise answerpaper', 39, 'add_topicwiseanswerpaper'),
(154, 'Can change topic wise answerpaper', 39, 'change_topicwiseanswerpaper'),
(155, 'Can delete topic wise answerpaper', 39, 'delete_topicwiseanswerpaper'),
(156, 'Can view topic wise answerpaper', 39, 'view_topicwiseanswerpaper'),
(157, 'Can add assignment activity', 40, 'add_assignmentactivity'),
(158, 'Can change assignment activity', 40, 'change_assignmentactivity'),
(159, 'Can delete assignment activity', 40, 'delete_assignmentactivity'),
(160, 'Can view assignment activity', 40, 'view_assignmentactivity'),
(161, 'Can add assignment answer', 41, 'add_assignmentanswer'),
(162, 'Can change assignment answer', 41, 'change_assignmentanswer'),
(163, 'Can delete assignment answer', 41, 'delete_assignmentanswer'),
(164, 'Can view assignment answer', 41, 'view_assignmentanswer'),
(165, 'Can add drag drop activity', 42, 'add_dragdropactivity'),
(166, 'Can change drag drop activity', 42, 'change_dragdropactivity'),
(167, 'Can delete drag drop activity', 42, 'delete_dragdropactivity'),
(168, 'Can view drag drop activity', 42, 'view_dragdropactivity'),
(169, 'Can add drag drop activity elements', 43, 'add_dragdropactivityelements'),
(170, 'Can change drag drop activity elements', 43, 'change_dragdropactivityelements'),
(171, 'Can delete drag drop activity elements', 43, 'delete_dragdropactivityelements'),
(172, 'Can view drag drop activity elements', 43, 'view_dragdropactivityelements'),
(173, 'Can add drag drop activity answers', 44, 'add_dragdropactivityanswers'),
(174, 'Can change drag drop activity answers', 44, 'change_dragdropactivityanswers'),
(175, 'Can delete drag drop activity answers', 44, 'delete_dragdropactivityanswers'),
(176, 'Can view drag drop activity answers', 44, 'view_dragdropactivityanswers'),
(177, 'Can add user', 45, 'add_user'),
(178, 'Can change user', 45, 'change_user'),
(179, 'Can delete user', 45, 'delete_user'),
(180, 'Can view user', 45, 'view_user'),
(181, 'Can add user information', 46, 'add_userinformation'),
(182, 'Can change user information', 46, 'change_userinformation'),
(183, 'Can delete user information', 46, 'delete_userinformation'),
(184, 'Can view user information', 46, 'view_userinformation'),
(185, 'Can add assesments', 47, 'add_assesments'),
(186, 'Can change assesments', 47, 'change_assesments'),
(187, 'Can delete assesments', 47, 'delete_assesments'),
(188, 'Can view assesments', 47, 'view_assesments'),
(189, 'Can add question', 48, 'add_question'),
(190, 'Can change question', 48, 'change_question'),
(191, 'Can delete question', 48, 'delete_question'),
(192, 'Can view question', 48, 'view_question'),
(193, 'Can add question set', 49, 'add_questionset'),
(194, 'Can change question set', 49, 'change_questionset'),
(195, 'Can delete question set', 49, 'delete_questionset'),
(196, 'Can view question set', 49, 'view_questionset'),
(197, 'Can add question paper', 50, 'add_questionpaper'),
(198, 'Can change question paper', 50, 'change_questionpaper'),
(199, 'Can delete question paper', 50, 'delete_questionpaper'),
(200, 'Can view question paper', 50, 'view_questionpaper'),
(201, 'Can add question option', 51, 'add_questionoption'),
(202, 'Can change question option', 51, 'change_questionoption'),
(203, 'Can delete question option', 51, 'delete_questionoption'),
(204, 'Can view question option', 51, 'view_questionoption'),
(205, 'Can add file upload', 52, 'add_fileupload'),
(206, 'Can change file upload', 52, 'change_fileupload'),
(207, 'Can delete file upload', 52, 'delete_fileupload'),
(208, 'Can view file upload', 52, 'view_fileupload'),
(209, 'Can add answer', 53, 'add_answer'),
(210, 'Can change answer', 53, 'change_answer'),
(211, 'Can delete answer', 53, 'delete_answer'),
(212, 'Can view answer', 53, 'view_answer'),
(213, 'Can add answer paper', 54, 'add_answerpaper'),
(214, 'Can change answer paper', 54, 'change_answerpaper'),
(215, 'Can delete answer paper', 54, 'delete_answerpaper'),
(216, 'Can view answer paper', 54, 'view_answerpaper'),
(217, 'Can add quiz', 55, 'add_quiz'),
(218, 'Can change quiz', 55, 'change_quiz'),
(219, 'Can delete quiz', 55, 'delete_quiz'),
(220, 'Can view quiz', 55, 'view_quiz'),
(221, 'Can add choice', 56, 'add_choice'),
(222, 'Can change choice', 56, 'change_choice'),
(223, 'Can delete choice', 56, 'delete_choice'),
(224, 'Can view choice', 56, 'view_choice'),
(225, 'Can add poll', 57, 'add_poll'),
(226, 'Can change poll', 57, 'change_poll'),
(227, 'Can delete poll', 57, 'delete_poll'),
(228, 'Can view poll', 57, 'view_poll'),
(229, 'Can add discussion', 58, 'add_discussion'),
(230, 'Can change discussion', 58, 'change_discussion'),
(231, 'Can delete discussion', 58, 'delete_discussion'),
(232, 'Can view discussion', 58, 'view_discussion'),
(233, 'Can add forum answer', 59, 'add_forumanswer'),
(234, 'Can change forum answer', 59, 'change_forumanswer'),
(235, 'Can delete forum answer', 59, 'delete_forumanswer'),
(236, 'Can view forum answer', 59, 'view_forumanswer'),
(237, 'Can add notes', 60, 'add_notes'),
(238, 'Can change notes', 60, 'change_notes'),
(239, 'Can delete notes', 60, 'delete_notes'),
(240, 'Can view notes', 60, 'view_notes'),
(241, 'Can add grade range', 61, 'add_graderange'),
(242, 'Can change grade range', 61, 'change_graderange'),
(243, 'Can delete grade range', 61, 'delete_graderange'),
(244, 'Can view grade range', 61, 'view_graderange'),
(245, 'Can add grading system', 62, 'add_gradingsystem'),
(246, 'Can change grading system', 62, 'change_gradingsystem'),
(247, 'Can delete grading system', 62, 'delete_gradingsystem'),
(248, 'Can view grading system', 62, 'view_gradingsystem'),
(249, 'Can add room', 63, 'add_room'),
(250, 'Can change room', 63, 'change_room'),
(251, 'Can delete room', 63, 'delete_room'),
(252, 'Can view room', 63, 'view_room'),
(253, 'Can add chatmessage', 64, 'add_chatmessage'),
(254, 'Can change chatmessage', 64, 'change_chatmessage'),
(255, 'Can delete chatmessage', 64, 'delete_chatmessage'),
(256, 'Can view chatmessage', 64, 'view_chatmessage'),
(257, 'Can add room_ user', 65, 'add_room_user'),
(258, 'Can change room_ user', 65, 'change_room_user'),
(259, 'Can delete room_ user', 65, 'delete_room_user'),
(260, 'Can view room_ user', 65, 'view_room_user'),
(261, 'Can add layer', 66, 'add_layer'),
(262, 'Can change layer', 66, 'change_layer'),
(263, 'Can delete layer', 66, 'delete_layer'),
(264, 'Can view layer', 66, 'view_layer'),
(265, 'Can add tag', 67, 'add_tag'),
(266, 'Can change tag', 67, 'change_tag'),
(267, 'Can delete tag', 67, 'delete_tag'),
(268, 'Can view tag', 67, 'view_tag'),
(269, 'Can add tagged item', 68, 'add_taggeditem'),
(270, 'Can change tagged item', 68, 'change_taggeditem'),
(271, 'Can delete tagged item', 68, 'delete_taggeditem'),
(272, 'Can view tagged item', 68, 'view_taggeditem');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$216000$LppnwxUvG5yn$YdXM7VP88SxpkizYhuCfQNnTfshcK8e6n7c6IaH7yFU=', '2021-03-05 06:58:12.988909', 1, 'root', 'root', 'root', 'root@gmail.com', 1, 1, '2021-02-11 17:02:57.525330'),
(2, 'pbkdf2_sha256$216000$jfybTzvGxNnW$u1IsTHU8lgu3pV5/nCsFBGjUkc7WPTPLAubXrwBVyp0=', '2021-02-25 00:27:03.170439', 0, 'first@gmail.com', '', '', '', 0, 1, '2021-02-11 18:16:57.398758'),
(3, 'pbkdf2_sha256$216000$Gv7a9r5Ei4Yb$Ao+jr6D8ZdMIZWCK9F96DKenpjg7j6IEvmD5YiKa/i4=', '2021-02-12 04:38:22.380868', 0, 'second', '', '', 'second@gmail.com', 0, 1, '2021-02-12 04:31:41.221298'),
(7, 'pbkdf2_sha256$216000$bmk7qkFvsIOq$xZDzU8pzhBvaRnCR11iI5Klq/GKPQrdR+wMH2JDWv3c=', '2021-02-12 04:46:21.044633', 0, 'test', '', '', 'test@gmail.com', 0, 1, '2021-02-12 04:46:12.184301'),
(8, 'pbkdf2_sha256$216000$Ate7iKlwYvuh$CLwJ4NYpCVeizQntRkj9fsFKW4JNnTBe7aqnPGrkGSk=', '2021-02-12 04:54:57.819755', 0, 'kalu', '', '', 'kalu@gmail.com', 0, 1, '2021-02-12 04:54:49.491737'),
(9, 'pbkdf2_sha256$216000$x7pDXedfl2wF$VG8HNQANF4D97KXohZfuhaZi+S/7gX7Wc7bPvpTH0ss=', '2021-02-12 06:56:47.631289', 0, 'saket', '', '', 'saket@gmail.com', 0, 1, '2021-02-12 04:56:54.204491'),
(10, 'pbkdf2_sha256$216000$v5N6cFL47xBW$TfsR9Dw2cMXNra0vxs/+qODbYsNO+eN2cLhTQNwQUZ8=', '2021-02-24 09:16:29.458544', 0, 'seconds@gmail.com', '', '', '', 0, 1, '2021-02-12 05:07:40.180412'),
(11, 'pbkdf2_sha256$216000$M0RkbaODnEF7$jeebFcnpfGnY5dKof+jvg2GJ/mQnl5DWXXqnSAPA3+8=', '2021-02-24 10:40:22.898480', 0, 'test1@gmail.com', 'test 1', 'test 212', '', 0, 1, '2021-02-12 06:07:11.407632'),
(12, 'pbkdf2_sha256$216000$YZF5fkqHyz1S$5ItsSuDvK72ZVcDLaqaHYlwii5gxjmJvmrs5UoQZq6c=', '2021-02-24 11:42:52.776315', 0, 'zkhan1044@gmail.com', 'zubair', 'khan', '', 0, 1, '2021-02-22 12:09:58.183859'),
(13, 'pbkdf2_sha256$216000$js3WFsqLKJUw$ppbUNncKfvchMtzC9yxkraTiWNjM0EelQHFf4G4Xg4o=', '2021-03-01 09:02:32.126704', 0, 'student2@gmail.com', 'Student 2', 'test', '', 0, 1, '2021-02-23 06:15:40.498220'),
(15, 'pbkdf2_sha256$216000$3heRwudvvLSW$Z9GiBraNQ17HamOESOEgFk8MKpbVJ71C1FcYfjzIRDY=', '2021-02-24 09:11:12.862966', 0, 'studfent2@gmail.com', 'qasd', 'asd', '', 0, 1, '2021-02-23 06:24:10.262419'),
(18, 'pbkdf2_sha256$216000$FpCvq8BNexse$vTOn6I66lWXBDq2/AD5QJ8stZupMh9ojWUDlzrinotk=', '2021-02-24 09:12:25.404230', 0, 'user.testone123@gmail.com', 'user test', 'one test', '', 0, 1, '2021-02-23 07:41:05.236714'),
(19, 'pbkdf2_sha256$216000$RrsTsgNcDhFV$JoFviI9tCiGqZ6mw4PJm35nG6smn/Zgr6OL8iN0qKPs=', '2021-02-24 05:59:25.924731', 0, 'teacherone@gmail.com', 'teacher', 'test', '', 0, 1, '2021-02-24 05:44:36.976109'),
(20, 'pbkdf2_sha256$216000$TS5zOh53UobO$cebqLqtVCi8LrmsD+HMIzSKCzYdYfad7Pa4v4xHdFig=', '2021-02-24 10:44:09.465198', 0, 'twostudent@gmail.com', 'student', 'two', '', 0, 1, '2021-02-24 06:46:20.072352'),
(21, 'pbkdf2_sha256$216000$xLHdQCHK3OVt$bssPQyKloynO/8E24MvT9lcSIC2Cz6++b+EfQq4TuXg=', '2021-02-24 09:12:07.167628', 0, 'user4@gmail.com', 'user', '4', '', 0, 1, '2021-02-24 06:46:59.034068'),
(26, 'pbkdf2_sha256$216000$VkxKcIp0YCSZ$qWrk0WHNt/uKdVCOjlzxbPdimQ8JLwcZ/lwE84igQO4=', NULL, 0, 'asd@asd.asd', '', '', '', 0, 1, '2021-02-24 12:39:34.162855'),
(27, 'pbkdf2_sha256$216000$TGIr8Np2aZ2N$tno+CmcXpqnju0wt/oS4a+XT+ThJFc9yQEv6Alc1ZNg=', NULL, 0, 'njdjndce@gmail.com', 'dcdnjdnj', 'njdejnn', '', 0, 1, '2021-02-25 00:09:42.589159'),
(28, 'pbkdf2_sha256$216000$BecnixxZBhhn$w/7VWEW0FCVqPcH144mPBnBVj4UpJfnGsmTCt8kFMmo=', NULL, 0, 'sdvf@gmail.com', 'dcsvfbg', 'dfdgh', '', 0, 1, '2021-02-25 00:30:43.098070'),
(29, 'pbkdf2_sha256$216000$WnnsqLm5wR8X$qehXHmnjdRfR1ztl7ku3RaXRtgjaXgc2rczmg7B5Ekc=', NULL, 0, 'dfgh@gmail.com', 'dsfn', 'fdg', '', 0, 1, '2021-02-25 00:32:17.059521'),
(31, 'pbkdf2_sha256$216000$gLJdLr9WISn6$uRkEZxPWsACD612Dc6+9K9N+2W2XSY4IcWRNOkfDvUw=', NULL, 0, 'firstss@gmail.com', '', '', '', 0, 1, '2021-02-25 06:10:14.843994'),
(32, 'pbkdf2_sha256$216000$X0DXnS8oZGxA$kCpAAiM7DDQ/3sKfQyu2/2F2IgKlfkVNzpCAsdtXUlo=', '2021-02-28 22:26:14.049575', 0, 'dndcnj@gmail.com', '', '', '', 0, 1, '2021-02-25 10:43:53.653800'),
(33, 'pbkdf2_sha256$216000$J3mpJBCsw8W3$ex1GUk4Cza/nKEqKwklqwaqXr9v3qHVXKMihkZychNY=', '2021-03-01 05:35:24.110318', 0, 'dcnjdcnjnj@gmail.com', 'dcnjdc', 'njnjdnjd', '', 0, 1, '2021-02-25 10:44:35.927349'),
(37, 'pbkdf2_sha256$216000$bsTcZGLMxUnm$Fz591mA3FX8zOZGwWEj/PS92oz/ezpCZCL4AS9kcIDI=', '2021-03-01 05:51:06.915760', 0, 'adobe@gmail.com', 'Adobe', 'Adobe', '', 0, 1, '2021-02-26 06:15:59.529288'),
(38, 'pbkdf2_sha256$216000$IlqeQwNt5xPG$Ia71oAKbSEwVmAIJSr54BYWXvkf/Ev0+p1p76OkNnmg=', '2021-02-28 22:08:05.130871', 0, 'adobe_t@gmail.com', 'adobe', 'adobe', '', 0, 1, '2021-02-28 17:07:36.127549'),
(39, 'pbkdf2_sha256$216000$BpIxoAjKUfKA$D92TP8WtjMWVJPig6gAu6F0vEh+EmJLaJnuHvefAWp8=', '2021-03-01 06:07:56.298696', 0, 'testest', '', '', 'test@gmail.com', 0, 1, '2021-03-01 05:33:26.342645'),
(40, 'pbkdf2_sha256$216000$OOorojiWc6MT$lYTIm4+NsdBx2Vh9rfRZ1Lr+Jj1t0RzBm7iqDxyoYl8=', '2021-03-01 06:24:56.570450', 0, 'firstcheck', '', '', 'firstcheck@gmail.com', 0, 1, '2021-03-01 06:24:47.091613'),
(41, 'pbkdf2_sha256$216000$wYaLmdJuA8qa$nlajP4DmKBTWtBhvguPLHytmYjZck0CTQz5BpSqb9WA=', NULL, 0, 'orgadmin@gmail.com', '', '', '', 0, 1, '2021-03-01 06:44:50.645186'),
(42, 'pbkdf2_sha256$216000$V11Zn8L1yuK1$AOYFJX7jQGqW8EjoBujiq8ILZ2tHwIV9N2nGxUNS+4M=', NULL, 0, 'dcjdcnj@gmail.com', '', '', '', 0, 1, '2021-03-01 06:54:01.312448'),
(43, 'pbkdf2_sha256$216000$QpQG2kgTMAb8$G4BnX87E5UbNrZmCKk0dd6qqzRuEBhh98UOxHsdz3Ro=', '2021-03-01 07:00:12.050326', 0, 'test23', '', '', 'test23@gmail.com', 0, 1, '2021-03-01 07:00:03.335839'),
(44, 'pbkdf2_sha256$216000$67hqZIZaHlAo$Yo+Xrt5J/MK558E0PHTtqxlCZFKFFm319nQ93CAe0f4=', '2021-03-01 07:02:09.214087', 0, 'test24', '', '', 'test24@gmail.com', 0, 1, '2021-03-01 07:02:00.649493'),
(45, 'pbkdf2_sha256$216000$Zax8iP15xjto$7APVtZDHe5lARl4VW9FXYPjeDyxw4MwjA8DjJNbaheU=', '2021-03-05 06:55:18.695440', 0, 'adminorg1@gmail.com', '', '', '', 0, 1, '2021-03-01 07:03:21.050713'),
(46, 'pbkdf2_sha256$216000$vKSqP1xHwpcu$w8DHy140hxiEz5a8bDe/P5zbjkcR8+SBzRJ/efNwWOY=', '2021-03-01 10:20:47.678693', 0, 'studentone@gmail.com', 'Demo Student', 'one', '', 0, 1, '2021-03-01 07:04:21.359510'),
(47, 'pbkdf2_sha256$216000$Z1fh9FBKB0nu$0DA4zkLaDUsDf53FNMydXRy21FDprlof16/+IryQGgs=', '2021-03-01 07:12:24.776735', 0, 'test25', '', '', 'test25@gmail.com', 0, 1, '2021-03-01 07:12:17.597198'),
(48, 'pbkdf2_sha256$216000$I8iNgH0BolZq$ju4ii5lTC6qutMx6m8hStAMzM/kAOrJsxGHf9FZYpbA=', '2021-03-01 07:19:38.140957', 0, 'test90', '', '', 'test90@gmail.com', 0, 1, '2021-03-01 07:19:20.689954'),
(49, 'pbkdf2_sha256$216000$0IvW0BQrUfSz$5FNZYPxvRDuw2FJIEOX7bUrocVjcSDSMaHQUM5yXvsE=', '2021-03-01 11:08:10.120449', 0, 'studenttwo@gmail.com', 'Demo Student', 'Two', '', 0, 1, '2021-03-01 07:28:45.505169'),
(50, 'pbkdf2_sha256$216000$y1xn86QOvcOC$vU4AafpLCJtl//OGvIFpTjbCq5HezJBUcnEErnVKI+s=', '2021-03-01 07:36:45.450456', 0, 'test26', '', '', 'test26@gmail.com', 0, 1, '2021-03-01 07:36:37.348840'),
(51, 'pbkdf2_sha256$216000$ywtLevS2tFYy$I2DujHqXiIRsPMBI12JD3F8dEJf25WJSexGGOWHWxT8=', '2021-03-01 07:43:22.107726', 0, 'test91', '', '', 'test91@gmail.com', 0, 1, '2021-03-01 07:43:11.155650'),
(52, 'pbkdf2_sha256$216000$853efNC6GFQh$cfwVtOLtIjPlWUiIJc/Ll7WWSwDu/EgF3CKEvVZF82Y=', '2021-03-01 08:30:55.327081', 0, 'test28', '', '', 'test28@gmail.com', 0, 1, '2021-03-01 08:30:46.905649'),
(53, 'pbkdf2_sha256$216000$m4Z6rxzSUaXi$+ZjdYCaXvrc8QMNmpYQiBclHmGSM3y5C5PEl4mbaouY=', '2021-03-03 06:45:30.906334', 0, 'test29', '', '', 'test29@gmail.com', 0, 1, '2021-03-01 08:37:56.058689'),
(54, 'pbkdf2_sha256$216000$Ixl2Z4O0UL6f$IL/seJhRH2QMqxekL5fgKa0mThifpPrJSaXznX1DQJg=', '2021-03-05 07:10:23.930006', 0, 'talento@gmail.com', '', '', '', 0, 1, '2021-03-01 11:39:43.310403'),
(55, 'pbkdf2_sha256$216000$zWZQH9RBiBl1$Gr9EUZrhhrw/vw7TSWIcKhSEevHJyX+5DEgmphKJkNY=', '2021-03-02 06:24:27.550323', 0, 'talento1@gmail.com', 'talento1', 'talento1', '', 0, 1, '2021-03-01 11:41:25.602210'),
(56, 'pbkdf2_sha256$216000$BhdlZ9tiEhvw$DNN2eqow2Gr7KuwhLXAdw92Zya0Tz68i+RD12dg27cw=', '2021-03-02 07:28:25.917612', 0, 'teacher1@gmail.com', 'teacher1', 'teacher1', '', 0, 1, '2021-03-01 11:50:40.801624'),
(57, 'pbkdf2_sha256$216000$DHO5yUMmE10l$cOAOt5pJeS884WySi2Q46qOt/MD8j7Pg5OXRRLRW0co=', '2021-03-02 08:53:09.241416', 0, 'test30', '', '', 'test30@gmail.com', 0, 1, '2021-03-02 08:53:02.324002'),
(58, 'pbkdf2_sha256$216000$FWbQAGqhujpG$aSnR1GG9YeS5BoYgSCdhp0C93j+mxSK/L+ncGCMy4vM=', NULL, 0, 'minus@gmail.com', '', '', '', 0, 1, '2021-03-05 07:23:15.457330'),
(59, 'pbkdf2_sha256$216000$UXmnmdhyjGLB$jszWRT/t502Nc3xjf092Mg5RzzUE/o0l845bINVY7/U=', NULL, 0, 'minus1@gmail.com', '', '', '', 0, 1, '2021-03-05 07:48:26.888310'),
(60, 'pbkdf2_sha256$216000$R0LlGxEHuuy6$pTgb4+DqwZrhLxZvueeKk1MS98IK/0Dkm4yLhFeVzdI=', NULL, 0, 'plus@gmail.com', '', '', '', 0, 1, '2021-03-05 09:02:01.003369');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(2, 3, 2),
(3, 7, 2),
(4, 8, 2),
(5, 9, 2),
(7, 11, 2),
(8, 12, 2),
(9, 13, 2),
(10, 15, 2),
(11, 18, 2),
(12, 19, 3),
(13, 20, 2),
(14, 21, 2),
(20, 27, 3),
(21, 28, 2),
(22, 29, 2),
(25, 33, 2),
(30, 38, 3),
(31, 39, 2),
(32, 40, 2),
(34, 42, 6),
(35, 43, 2),
(36, 44, 2),
(37, 45, 6),
(38, 46, 2),
(39, 47, 2),
(40, 48, 2),
(41, 49, 2),
(42, 50, 2),
(43, 51, 2),
(44, 52, 2),
(45, 53, 2),
(46, 54, 6),
(62, 55, 2),
(54, 56, 3),
(63, 57, 2),
(64, 58, 6),
(65, 59, 6),
(66, 60, 6);

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_chatmessage`
--

CREATE TABLE `chat_chatmessage` (
  `id` int NOT NULL,
  `chatmessage` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `chattime` datetime(6) NOT NULL,
  `course_id` int DEFAULT NULL,
  `userfrom_id` int NOT NULL,
  `userto_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_chatmessage`
--

INSERT INTO `chat_chatmessage` (`id`, `chatmessage`, `chattime`, `course_id`, `userfrom_id`, `userto_id`) VALUES
(1, 'him under the nose ?', '2021-03-03 06:02:28.776510', 105, 1, 53),
(2, 'frytuygihuji', '2021-03-03 06:03:02.946373', 105, 1, 53);

-- --------------------------------------------------------

--
-- Table structure for table `chat_layer`
--

CREATE TABLE `chat_layer` (
  `id` int NOT NULL,
  `layer_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `course_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_layer`
--

INSERT INTO `chat_layer` (`id`, `layer_name`, `user_name`, `course_id`) VALUES
(1, 'specific.d692703ce693446cac514d53fef4f415!5244ea191f974088b2c8f307cf4c6297', '1', 105),
(2, 'specific.7bc4ad0adfd94e93b13db6cc2402008c!410c5fa6917d4e459b690e9daf8aeb8b', '53', 105),
(3, 'specific.29aa2a09b3254409820838fba8b1c7ac!7884b06045654631a42826f8d37cad8c', '1', 98),
(4, 'specific.29aa2a09b3254409820838fba8b1c7ac!734bff4abb694cfb9c6af068aa21771e', '53', 98),
(5, 'specific.d692703ce693446cac514d53fef4f415!c6e156c772144f1ca6bc4630df758b68', '1', 107),
(6, 'specific.d692703ce693446cac514d53fef4f415!7bca75d298ad4173890fada352a0ebfb', '1', 110),
(7, 'specific.d692703ce693446cac514d53fef4f415!68777e11915e4d319b2548fbb29b6db1', '1', 108),
(8, 'specific.dd705ec905d54f2c88863da00eb8820f!b922c3017baf4a8197c1a22b7f6a8ef8', '54', 110),
(9, 'specific.d692703ce693446cac514d53fef4f415!f8b3d6eabdbb4f8ba93c0cb584a44f73', '45', 110),
(10, 'specific.d692703ce693446cac514d53fef4f415!e6a77b905f4949719b7da28caa0b1abf', '54', 108),
(11, 'specific.d692703ce693446cac514d53fef4f415!64d096a081504dd1962365079f81c248', '54', 107),
(12, 'specific.d692703ce693446cac514d53fef4f415!fe881b21d4e44c1d89b8b92b7a90e8c3', '54', 105);

-- --------------------------------------------------------

--
-- Table structure for table `chat_room`
--

CREATE TABLE `chat_room` (
  `id` int NOT NULL,
  `room_id` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `course_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_room`
--

INSERT INTO `chat_room` (`id`, `room_id`, `is_private`, `start_time`, `end_time`, `status`, `course_id`) VALUES
(49, '105DemoCourse6', 0, '2021-03-03 05:33:40.211446', NULL, 'True', 105),
(50, '98DemoCourse1', 0, '2021-03-03 06:39:37.252769', NULL, 'True', 98),
(51, '107DemoCourse8', 0, '2021-03-04 06:26:59.120160', NULL, 'True', 107),
(52, '110talentocourse', 0, '2021-03-04 08:56:53.703545', NULL, 'True', 110),
(53, '108DemoCourse8', 0, '2021-03-04 08:56:59.881771', NULL, 'True', 108);

-- --------------------------------------------------------

--
-- Table structure for table `chat_room_user`
--

CREATE TABLE `chat_room_user` (
  `id` int NOT NULL,
  `room_id` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `channel_name` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `course_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_room_user`
--

INSERT INTO `chat_room_user` (`id`, `room_id`, `channel_name`, `user_id`, `status`, `course_id`) VALUES
(1, '105DemoCourse6', 'specific.d692703ce693446cac514d53fef4f415!5244ea191f974088b2c8f307cf4c6297', '1', 0, 105),
(2, '105DemoCourse6', 'specific.7bc4ad0adfd94e93b13db6cc2402008c!410c5fa6917d4e459b690e9daf8aeb8b', '53', 0, 105),
(3, '98DemoCourse1', 'specific.29aa2a09b3254409820838fba8b1c7ac!7884b06045654631a42826f8d37cad8c', '1', 1, 98),
(4, '98DemoCourse1', 'specific.29aa2a09b3254409820838fba8b1c7ac!734bff4abb694cfb9c6af068aa21771e', '53', 0, 98),
(5, '107DemoCourse8', 'specific.d692703ce693446cac514d53fef4f415!c6e156c772144f1ca6bc4630df758b68', '1', 0, 107),
(6, '110talentocourse', 'specific.d692703ce693446cac514d53fef4f415!7bca75d298ad4173890fada352a0ebfb', '1', 0, 110),
(7, '108DemoCourse8', 'specific.d692703ce693446cac514d53fef4f415!68777e11915e4d319b2548fbb29b6db1', '1', 0, 108),
(8, '110talentocourse', 'specific.dd705ec905d54f2c88863da00eb8820f!b922c3017baf4a8197c1a22b7f6a8ef8', '54', 1, 110),
(9, '110talentocourse', 'specific.d692703ce693446cac514d53fef4f415!f8b3d6eabdbb4f8ba93c0cb584a44f73', '45', 0, 110),
(10, '108DemoCourse8', 'specific.d692703ce693446cac514d53fef4f415!e6a77b905f4949719b7da28caa0b1abf', '54', 0, 108),
(11, '107DemoCourse8', 'specific.d692703ce693446cac514d53fef4f415!64d096a081504dd1962365079f81c248', '54', 0, 107),
(12, '105DemoCourse6', 'specific.d692703ce693446cac514d53fef4f415!fe881b21d4e44c1d89b8b92b7a90e8c3', '54', 0, 105);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_activities`
--

CREATE TABLE `customadmin_activities` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `activity_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `activity_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL,
  `topic_id` int DEFAULT NULL,
  `content_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_activities`
--

INSERT INTO `customadmin_activities` (`id`, `start_date`, `end_date`, `activity_type`, `activity_name`, `author_id`, `course_id`, `organization_id`, `topic_id`, `content_id`) VALUES
(1, '2021-02-25 07:07:58.298497', NULL, 'spin_activity', 'dcncdn', 1, NULL, NULL, 2, '1'),
(5, '2021-02-25 09:18:08.358038', NULL, 'quiz', 'dcjndcnjcd_quiz_check', 1, NULL, NULL, 4, '1'),
(7, '2021-02-26 12:46:51.269937', NULL, 'quiz', 'vfjnvfnjvnf', 1, NULL, NULL, 2, '3'),
(8, '2021-02-28 21:31:06.614481', NULL, 'spin_activity', 'spin', 37, NULL, NULL, 6, '2'),
(9, '2021-03-01 05:38:35.353571', NULL, 'spin_activity', 'Spin Activity', 1, NULL, NULL, 11, '3'),
(10, '2021-03-01 05:44:38.787487', NULL, 'quiz', 'Quiz', 1, NULL, NULL, 13, '4'),
(11, '2021-03-01 06:17:14.786610', NULL, 'quiz', 'Quiz', 1, NULL, NULL, 15, '5'),
(12, '2021-03-01 06:25:41.693948', NULL, 'spin_activity', 'Spin Activity', 1, NULL, NULL, 15, '4'),
(13, '2021-03-01 06:38:04.398768', NULL, 'spin_activity', 'Demo Spin Activity ', 1, NULL, NULL, 19, '5'),
(17, '2021-03-01 08:51:58.016068', NULL, 'spin_activity', 'Demo Spin ', 1, NULL, NULL, 21, '6'),
(18, '2021-03-01 08:53:53.487380', NULL, 'spin_activity', 'Demo Spin Activity B', 1, NULL, NULL, 23, '7'),
(19, '2021-03-01 09:05:27.172464', NULL, 'quiz', 'Demo Quiz A', 1, NULL, NULL, 25, '8'),
(20, '2021-03-01 09:18:49.802658', NULL, 'spin_activity', 'Demo Spin A', 1, NULL, NULL, 28, '8'),
(21, '2021-03-01 09:20:26.684364', NULL, 'quiz', 'Demo quiz', 1, NULL, NULL, 28, '9'),
(22, '2021-03-01 09:27:18.747866', NULL, 'quiz', 'Quiz A', 1, NULL, NULL, 30, '10'),
(23, '2021-03-01 09:28:21.426276', NULL, 'spin_activity', 'Demo Spin ', 1, NULL, NULL, 31, '9'),
(24, '2021-03-01 10:14:14.279374', NULL, 'quiz', 'Quiz', 1, NULL, NULL, 33, '5'),
(25, '2021-03-01 10:14:14.284598', NULL, 'spin_activity', 'Spin Activity', 1, NULL, NULL, 33, '4'),
(26, '2021-03-01 10:26:02.288991', NULL, 'quiz', 'Demo Quiz', 1, NULL, NULL, 36, '11'),
(27, '2021-03-01 10:28:04.330590', NULL, 'spin_activity', 'Demo Spin ', 1, NULL, NULL, 37, '10'),
(28, '2021-03-01 10:43:33.874674', NULL, 'spin_activity', 'Spin Activity A', 1, NULL, NULL, 42, '11'),
(29, '2021-03-01 11:05:14.108873', NULL, 'spin_activity', 'Spin Activity A', 1, NULL, NULL, 44, '12'),
(30, '2021-03-01 11:05:54.838031', NULL, 'spin_activity', 'Spin Activity B', 1, NULL, NULL, 46, '13'),
(31, '2021-03-01 11:06:43.636956', NULL, 'spin_activity', 'Spin C', 1, NULL, NULL, 48, '14'),
(32, '2021-03-01 11:22:52.456004', NULL, 'spin_activity', 'Spin Activity', 1, NULL, NULL, 50, '15'),
(33, '2021-03-01 11:23:26.149820', NULL, 'spin_activity', 'Spin Activity B', 1, NULL, NULL, 50, '16'),
(34, '2021-03-01 11:36:12.477205', NULL, 'quiz', 'ygqhahba', 1, NULL, NULL, 52, '12'),
(35, '2021-03-01 11:48:56.132487', NULL, 'spin_activity', 'Spin Activity', 1, NULL, NULL, 54, '17'),
(36, '2021-03-01 12:32:30.286360', NULL, 'Assignment', 'Assignment', 1, NULL, NULL, 54, '1'),
(37, '2021-03-02 12:57:10.703478', NULL, 'spin_activity', 'him', 1, NULL, NULL, 56, '18'),
(38, '2021-03-04 06:35:20.136371', NULL, 'drag_and_drop', 'dchdh', 1, NULL, NULL, 15, '1');

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_activityadding`
--

CREATE TABLE `customadmin_activityadding` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `course_id_id` int NOT NULL,
  `topic_id_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_activitytype`
--

CREATE TABLE `customadmin_activitytype` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `name` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int DEFAULT NULL,
  `thumbnail` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_activitytype`
--

INSERT INTO `customadmin_activitytype` (`id`, `start_date`, `end_date`, `name`, `author_id`, `thumbnail`) VALUES
(1, '2021-02-18 07:31:49.454439', NULL, 'drag and drop', 1, 'categories_file/898403.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_answer`
--

CREATE TABLE `customadmin_answer` (
  `id` int NOT NULL,
  `answer` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_assignmentactivity`
--

CREATE TABLE `customadmin_assignmentactivity` (
  `id` int NOT NULL,
  `description` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `question_file` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `no_of_submission` varchar(2) COLLATE utf8mb4_general_ci NOT NULL,
  `activity_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_assignmentactivity`
--

INSERT INTO `customadmin_assignmentactivity` (`id`, `description`, `question_file`, `no_of_submission`, `activity_id`, `created_at`) VALUES
(1, 'Assignment', 'assignment_file/Question.docx', '1', 36, '2021-03-01 12:32:15.818528');

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_assignmentanswer`
--

CREATE TABLE `customadmin_assignmentanswer` (
  `id` int NOT NULL,
  `answer_file` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `answer_date` datetime(6) NOT NULL,
  `activity_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `submission` varchar(2) COLLATE utf8mb4_general_ci NOT NULL,
  `answer_file1` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `answer_file2` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_assignmentanswer`
--

INSERT INTO `customadmin_assignmentanswer` (`id`, `answer_file`, `answer_date`, `activity_id`, `user_id`, `submission`, `answer_file1`, `answer_file2`) VALUES
(1, '', '2021-02-18 12:48:06.680691', NULL, 1, '1', '', ''),
(4, '', '2021-02-18 13:00:49.730670', NULL, 1, '2', '', ''),
(5, '', '2021-02-18 13:21:32.889898', NULL, 1, '3', '', ''),
(6, '', '2021-03-01 12:36:23.926267', 1, 49, '1', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_categories`
--

CREATE TABLE `customadmin_categories` (
  `id` int NOT NULL,
  `name` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `category_type` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  `category_image` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category_about` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `organization_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_categorieshirerchy`
--

CREATE TABLE `customadmin_categorieshirerchy` (
  `id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `category_father_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_chatactivity`
--

CREATE TABLE `customadmin_chatactivity` (
  `id` int NOT NULL,
  `max_user` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `room` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `activity_id_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_city`
--

CREATE TABLE `customadmin_city` (
  `id` int NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL,
  `state_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_city`
--

INSERT INTO `customadmin_city` (`id`, `name`, `status`, `state_id`) VALUES
(4, 'djnjdc', 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_classroom`
--

CREATE TABLE `customadmin_classroom` (
  `id` int NOT NULL,
  `sessionactivity_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_contentvideo`
--

CREATE TABLE `customadmin_contentvideo` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `video` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `topic_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL,
  `thumbnail` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `duration` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_contentvideo`
--

INSERT INTO `customadmin_contentvideo` (`id`, `start_date`, `end_date`, `video`, `description`, `topic_id`, `course_id`, `organization_id`, `thumbnail`, `language_id`, `duration`) VALUES
(3, '2021-02-28 21:43:51.017611', NULL, 'course_video/earth_xjQ2XMq.mp4', 'himmm', 9, NULL, NULL, 'course_video_thumbnail/5548.jpg', 1, '30'),
(6, '2021-03-01 05:44:20.464948', NULL, 'course_video/SampleVideo_1280x720_1mb_d1zEZIS.mp4', 'abc', 13, NULL, NULL, '', 2, NULL),
(7, '2021-03-01 06:34:15.567637', NULL, 'course_video/file_example_MP4_640_3MG_bgjc2hU.mp4', 'Demo Video', 17, NULL, NULL, 'course_video_thumbnail/8877.jpg', 1, '30'),
(8, '2021-03-01 06:35:17.509376', NULL, 'course_video/file_example_MP4_640_3MG_vc6z2Jf.mp4', 'Demo Video', 16, 98, NULL, 'course_video_thumbnail/6187.jpg', 1, '30'),
(9, '2021-03-01 08:51:29.661725', NULL, 'course_video/SampleVideo_1280x720_1mb_ZkcwlSb.mp4', 'Demo Video 1', 21, NULL, NULL, '', 1, NULL),
(10, '2021-03-01 08:54:18.598631', NULL, 'course_video/file_example_MP4_640_3MG_lWLSCPM.mp4', 'Demo Video B', 23, NULL, NULL, 'course_video_thumbnail/7009.jpg', 1, '30'),
(12, '2021-03-01 10:26:46.898510', NULL, 'course_video/SampleVideo_1280x720_1mb_m871Ue7.mp4', 'Demo video', 35, 104, NULL, '', 1, NULL),
(13, '2021-03-01 10:27:07.430074', NULL, 'course_video/SampleVideo_1280x720_1mb_BUvq7QO.mp4', 'Demo Video A', 36, NULL, NULL, '', 1, NULL),
(14, '2021-03-01 10:28:39.712857', NULL, 'course_video/SampleVideo_1280x720_1mb_HWc1m7t.mp4', 'Video Topic B', 38, 104, NULL, '', 1, NULL),
(15, '2021-03-01 10:39:14.389453', NULL, 'course_video/SampleVideo_1280x720_1mb_aHp5EGp.mp4', 'Video Demo', 39, 105, NULL, '', 1, NULL),
(16, '2021-03-01 10:39:42.787974', NULL, 'course_video/file_example_MP4_640_3MG_p8v7SrW.mp4', 'demo video 1', 39, 105, NULL, 'course_video_thumbnail/6459.jpg', 1, '30'),
(17, '2021-03-01 10:40:34.363970', NULL, 'course_video/SampleVideo_1280x720_1mb_DbPPCxu.mp4', 'Demo A', 40, 105, NULL, '', 1, NULL),
(18, '2021-03-01 11:22:04.179666', NULL, 'course_video/SampleVideo_1280x720_1mb_30j31zy.mp4', 'Video', 49, 107, NULL, '', 1, NULL),
(19, '2021-03-01 11:24:00.621084', NULL, 'course_video/SampleVideo_1280x720_1mb_3tB1GEk.mp4', 'Video', 50, NULL, NULL, '', 1, NULL),
(20, '2021-03-01 11:25:58.819550', NULL, 'course_video/file_example_MP4_640_3MG_ixm1DXI.mp4', 'Video a', 50, NULL, NULL, 'course_video_thumbnail/6241.jpg', 1, '30'),
(21, '2021-03-01 11:34:53.393060', NULL, 'course_video/earth_NLQfP7r.mp4', 'frdghj', 52, NULL, NULL, 'course_video_thumbnail/669.jpg', 1, '30'),
(22, '2021-03-01 11:49:18.615369', NULL, 'course_video/SampleVideo_1280x720_1mb_lg7Y08U.mp4', 'abc', 54, NULL, NULL, '', 1, NULL),
(23, '2021-03-01 12:30:44.219140', NULL, 'course_video/SampleVideo_1280x720_1mb_RXN1wVE.mp4', 'Video', 50, NULL, NULL, '', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_country`
--

CREATE TABLE `customadmin_country` (
  `id` int NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_country`
--

INSERT INTO `customadmin_country` (`id`, `name`, `status`) VALUES
(1, 'India', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_courseenroll`
--

CREATE TABLE `customadmin_courseenroll` (
  `id` int NOT NULL,
  `date_registered` datetime(6) NOT NULL,
  `course_id` int NOT NULL,
  `user_id` int NOT NULL,
  `is_completed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_courseenroll`
--

INSERT INTO `customadmin_courseenroll` (`id`, `date_registered`, `course_id`, `user_id`, `is_completed`) VALUES
(63, '2021-03-01 06:38:20.135491', 97, 40, 0),
(64, '2021-03-01 07:00:48.793416', 97, 43, 0),
(65, '2021-03-01 07:02:12.244070', 97, 44, 0),
(66, '2021-03-01 07:05:06.815101', 97, 46, 0),
(67, '2021-03-01 07:12:27.409253', 97, 47, 0),
(68, '2021-03-01 07:19:42.407495', 97, 48, 0),
(69, '2021-03-01 07:19:58.386430', 98, 46, 0),
(70, '2021-03-01 07:29:06.762533', 98, 49, 0),
(71, '2021-03-01 07:36:50.676947', 97, 50, 0),
(72, '2021-03-01 07:43:27.961788', 97, 51, 0),
(73, '2021-03-01 08:30:58.303840', 97, 52, 0),
(74, '2021-03-01 08:38:05.778568', 97, 53, 0),
(75, '2021-03-01 08:38:53.218064', 98, 53, 0),
(76, '2021-03-01 08:54:33.089052', 99, 46, 0),
(77, '2021-03-01 09:00:24.217220', 99, 1, 0),
(78, '2021-03-01 09:02:35.147648', 98, 13, 0),
(79, '2021-03-01 09:03:20.419515', 99, 13, 0),
(83, '2021-03-01 09:29:12.750422', 99, 53, 0),
(86, '2021-03-01 10:28:54.372982', 104, 46, 0),
(87, '2021-03-01 10:44:06.161633', 105, 46, 0),
(88, '2021-03-01 10:45:44.066405', 105, 1, 0),
(89, '2021-03-01 11:04:14.445676', 106, 46, 0),
(90, '2021-03-01 11:08:39.019179', 106, 49, 0),
(91, '2021-03-01 11:20:09.198436', 106, 1, 0),
(92, '2021-03-01 11:24:42.825040', 107, 49, 0),
(93, '2021-03-01 11:42:12.690615', 108, 1, 0),
(94, '2021-03-01 11:43:34.446060', 107, 1, 0),
(95, '2021-03-01 11:46:00.729477', 98, 1, 0),
(97, '2021-03-01 12:08:10.297924', 110, 54, 0),
(100, '2021-03-02 08:49:52.183644', 104, 1, 0),
(101, '2021-03-02 08:50:06.413044', 110, 1, 0),
(104, '2021-03-03 05:40:50.989591', 105, 37, 0),
(105, '2021-03-03 05:48:58.242038', 105, 53, 0),
(106, '2021-03-05 06:35:09.415989', 110, 45, 0),
(107, '2021-03-05 07:08:05.277573', 108, 54, 0),
(108, '2021-03-05 07:08:09.480286', 107, 54, 0),
(109, '2021-03-05 07:08:13.582458', 105, 54, 0);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_courses`
--

CREATE TABLE `customadmin_courses` (
  `id` int NOT NULL,
  `creation_for` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `about` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `thumbnail` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `self_enrollment` tinyint(1) DEFAULT NULL,
  `is_trial` tinyint(1) NOT NULL,
  `author_id` int NOT NULL,
  `courses_category_id` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_coursesenduser`
--

CREATE TABLE `customadmin_coursesenduser` (
  `id` int NOT NULL,
  `name` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `about` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  `thumbnail` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `self_enrollment` tinyint(1) NOT NULL,
  `total_view` int NOT NULL,
  `web` tinyint(1) NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  `price` double DEFAULT NULL,
  `discount_price` double DEFAULT NULL,
  `duration` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `language` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `overview` longtext COLLATE utf8mb4_general_ci,
  `highlights` longtext COLLATE utf8mb4_general_ci,
  `post_achievement` longtext COLLATE utf8mb4_general_ci,
  `link` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `star` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `author_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `access` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `registration_enabled` tinyint(1) NOT NULL,
  `state` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `course_slug` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_coursesenduser`
--

INSERT INTO `customadmin_coursesenduser` (`id`, `name`, `about`, `created_date`, `updated_date`, `thumbnail`, `self_enrollment`, `total_view`, `web`, `mobile`, `price`, `discount_price`, `duration`, `language`, `overview`, `highlights`, `post_achievement`, `link`, `star`, `author_id`, `category_id`, `access`, `registration_enabled`, `state`, `course_slug`) VALUES
(97, 'Demo Course', '<p>This is demo course&nbsp;</p>', '2021-03-01 06:11:25.010594', '2021-03-02 11:13:33.692797', 'course_images/download_5.jpg', 0, 5, 1, 0, NULL, NULL, NULL, 'English', '<p>This is demo course&nbsp;</p>', '<p>This is demo course&nbsp;</p>', '', '', '', 1, NULL, 'STUDENTS_ONLY', 0, 'DRAFT', ''),
(98, 'Demo Course 1', '<p>This is demo course 1</p>', '2021-03-01 06:27:52.455955', '2021-03-02 11:14:19.691931', 'course_images/images.jpg', 0, 5, 1, 0, NULL, NULL, NULL, 'English', '<p>This is demo course 1</p>', '<p>This is demo course 1</p>', '', '', '', 1, NULL, 'PUBLIC', 0, 'DRAFT', ''),
(99, 'Demo Course 2', '<p>This is demo course 2</p>', '2021-03-01 08:49:32.485527', '2021-03-02 11:14:31.168372', 'course_images/download_4.jpg', 0, 2, 1, 0, NULL, NULL, NULL, 'English', '<p>This is demo course 2</p>', '<p>This is demo course 2</p>', '', '', '', 1, NULL, 'PUBLIC', 0, 'DRAFT', ''),
(103, 'Demo Course', '<p>This is demo course&nbsp;</p>', '2021-03-01 10:14:14.240966', '2021-03-02 11:14:35.031065', 'course_images/download_5.jpg', 0, 5, 1, 0, NULL, NULL, NULL, 'English', '<p>This is demo course&nbsp;</p>', '<p>This is demo course&nbsp;</p>', '', '', '', 1, NULL, 'PUBLIC', 0, 'DRAFT', ''),
(104, 'Demo Course 5', '<p>This is demo course 5</p>', '2021-03-01 10:23:52.947997', '2021-03-02 11:14:38.025241', 'course_images/download_5_8jcqZOo.jpg', 0, 0, 1, 0, NULL, NULL, NULL, 'English', '<p>This is demo course 5</p>', '<p>This is demo course 5</p>', '', '', '', 1, NULL, 'PUBLIC', 0, 'DRAFT', ''),
(105, 'Demo Course  6', '<p>This is demo course 6</p>', '2021-03-01 10:34:21.167800', '2021-03-05 05:29:02.573290', 'course_images/download_2_meKkOpJ.jpg', 0, 4, 1, 0, NULL, NULL, NULL, 'English', '<p>This is demo course 6</p>', '<p>This is demo course 6</p>', '', '', '', 1, NULL, 'PUBLIC', 0, 'PUBLISHED', ''),
(106, 'Demo Course 7', '<p>This is demo course 7&nbsp;</p>', '2021-03-01 11:02:25.971544', '2021-03-02 11:14:26.425277', 'course_images/download_1_Zi1ynxN.jpg', 0, 0, 1, 0, NULL, NULL, NULL, 'English', '<p>This is demo course 7&nbsp;</p>', '<p>This is demo course 7&nbsp;</p>', '', '', '', 1, NULL, 'PUBLIC', 0, 'DRAFT', ''),
(107, 'Demo Course 8', '<p>This is course 8&nbsp;</p>', '2021-03-01 11:18:25.376082', '2021-03-05 05:29:05.368717', 'course_images/download_1_Wdi9xCw.jpg', 0, 2, 1, 0, NULL, NULL, NULL, 'English', '<p>This is course 8&nbsp;</p>', '<p>This is course 8&nbsp;</p>', '', '', '', 1, NULL, 'PUBLIC', 0, 'PUBLISHED', ''),
(108, 'Demo Course 8', '<p>rty</p>', '2021-03-01 11:33:53.869698', '2021-03-01 11:33:53.869738', 'course_images/898403_1j9OnCX.jpg', 0, 0, 1, 0, NULL, NULL, NULL, 'English,Hindi', '<p>gtyuj</p>', '<p>uhuhu</p>', '', '', '', 1, 24, 'PUBLIC', 0, 'PUBLISHED', ''),
(110, 'talento course', '<p>talento course</p>', '2021-03-01 11:52:51.853835', '2021-03-01 11:52:51.853900', 'course_images/898403_ibqsbcs.jpg', 0, 0, 1, 0, NULL, NULL, NULL, 'English', '<p>talento course</p>', '<p>talento course</p>', '', '', '', 54, 24, 'PUBLIC', 0, 'PUBLISHED', '');

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_coursesenduser_rejected`
--

CREATE TABLE `customadmin_coursesenduser_rejected` (
  `id` int NOT NULL,
  `coursesenduser_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_coursesenduser_requests`
--

CREATE TABLE `customadmin_coursesenduser_requests` (
  `id` int NOT NULL,
  `coursesenduser_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_coursesenduser_students`
--

CREATE TABLE `customadmin_coursesenduser_students` (
  `id` int NOT NULL,
  `coursesenduser_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_courses_rejected`
--

CREATE TABLE `customadmin_courses_rejected` (
  `id` int NOT NULL,
  `courses_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_courses_requests`
--

CREATE TABLE `customadmin_courses_requests` (
  `id` int NOT NULL,
  `courses_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_courses_students`
--

CREATE TABLE `customadmin_courses_students` (
  `id` int NOT NULL,
  `courses_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_dragdropactivity`
--

CREATE TABLE `customadmin_dragdropactivity` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `name` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `settings_data` json NOT NULL,
  `activity_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_dragdropactivity`
--

INSERT INTO `customadmin_dragdropactivity` (`id`, `start_date`, `end_date`, `name`, `settings_data`, `activity_id`) VALUES
(1, '2021-03-04 06:35:20.141644', NULL, 'dchdh', '\"{\\\"title\\\": \\\"dchdh\\\", \\\"width\\\": \\\"800px\\\", \\\"height\\\": \\\"400px\\\", \\\"background[image]\\\": \\\"false\\\", \\\"background[src]\\\": \\\"\\\", \\\"background[isColor]\\\": \\\"false\\\", \\\"background[color]\\\": \\\"#ffffff\\\", \\\"topicid\\\": \\\"15\\\"}\"', 38);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_dragdropactivityanswers`
--

CREATE TABLE `customadmin_dragdropactivityanswers` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `answer_data` json NOT NULL,
  `grade` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `dd_activity_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_dragdropactivityelements`
--

CREATE TABLE `customadmin_dragdropactivityelements` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `label` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `settings_data` json NOT NULL,
  `dd_activity_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_fileactivity`
--

CREATE TABLE `customadmin_fileactivity` (
  `id` int NOT NULL,
  `file` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `activity_id_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_language`
--

CREATE TABLE `customadmin_language` (
  `id` int NOT NULL,
  `language_name` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `language_code` varchar(2) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_language`
--

INSERT INTO `customadmin_language` (`id`, `language_name`, `language_code`) VALUES
(1, 'English', 'en'),
(2, 'Hindi', 'hi'),
(3, 'Bangali', 'bn'),
(4, 'Tamil', 'ta');

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_languagecourse`
--

CREATE TABLE `customadmin_languagecourse` (
  `id` int NOT NULL,
  `course_id` int NOT NULL,
  `lang_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_organization`
--

CREATE TABLE `customadmin_organization` (
  `id` int NOT NULL,
  `organization_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `website` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `address` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `no_of_candidates` int DEFAULT NULL,
  `logo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_person_email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_person_phone` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_person_name` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pin` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sector_type` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `unique_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `certificate` longtext COLLATE utf8mb4_general_ci,
  `logo1` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `show_second_logo` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_organization`
--

INSERT INTO `customadmin_organization` (`id`, `organization_name`, `website`, `address`, `start_date`, `end_date`, `no_of_candidates`, `logo`, `contact_person_email`, `contact_person_phone`, `password`, `contact_person_name`, `pin`, `sector_type`, `unique_code`, `city_id`, `country_id`, `state_id`, `certificate`, `logo1`, `show_second_logo`, `is_active`) VALUES
(2, 'dndcj', 'http://wdfvnjvsjdjjndjdcnvjnef.com', 'him undwhbrhb', '2021-02-25', '', NULL, 'organization_logo/898403_g35sUNY.jpg', 'dndcnj@gmail.com', '9873545678', 'root@123', 'dnjdcnj', '8484884848', 'government', NULL, 4, NULL, 7, '<div class=\"certificate\" id=\"certificate\" style=\"border: 6px groove rgb(255, 213, 0); height: 580px; width: 780px;\">\r\n\r\n                        <svg width=\"780px\" height=\"580px\"><g transform=\"translate(179,253.20001220703125)\"><text style=\"font-size: 18px; fill: rgb(0, 18, 255); font-weight: 700; font-family: sans-serif;\" text-anchor=\"start\">ejonnjf wvefwv feh vhef vnf fn nfv</text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(258,195.20001220703125)\"><text style=\"font-size: 18px; fill: rgb(255, 0, 0); font-weight: 700; font-family: sans-serif;\" text-anchor=\"start\">hi jjdjjjdc jdc  cj dcj</text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(21,14.199996948242188)\"><image xlink:href=\"data:image/jpeg;base64,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RdSgBFRQlRZSKASgJUssqVLFlgmOeI6dO3XpZjnx48pAAAAAAALAAAAAAAAAAAAAAAAAAAAAAK1rW9apZUpKSgAAAACUlihCywVBYLLAAAAAAAlACLKCWWAWCwWWAWIpKBNwUJZYVBZSKARQJQSgJUsVAmeeMG+vbr00zz5cOWIAAAAAFgAAAAAAAAAAAAAAAAAAAAAsAC27vTVtEVLKSxQAAAARUpLKlRZZYWFgBKAAAAAAlAEFCKiypYACpYWEpKSyqsCpYoAEoAgUSgIWVKEAGM88SXXXv166uefHjxxkAAAAACwAAAAAAsAAAAAAABYAAAAAAAAVbvetrZRKlASgAAACUEoSxYsCwsBYAAAAJQAASglEKSwpAsAXNAlQoKAWKhUpKAASkoBKQssssABMYxiLevbv13py4cePKQAABYAAAAAAAAAAAAAABYAAAAAAALAWAAt1rettQolBKAAAAEoEsqKIsoIAAAEoAAAEoAAEqUlIABKAlIpKizVlgollABLLKASgARQgABKxnnnMNdO/bt13nnx48OWEAAAAAAAALAAAAAAAAAAAAAAAAAAAAALda3vVsspKSglBKAEoAAIsURYVAAAAAAAAhZQCVKARUWAWWAAIolljSxYqVAoEsoAAEoJSLLCwACYxnEhenbv37amOfDhw5oAAAAAAAAAAAAAWAAAAAALAAAAAAAAABV3retaikspKSglAAAEoCUlRYqVALAEsSwWgAAAAllAASywKgsBKsAAiqqKSxZSUQsUAACKEoSosAAYzjOELrr6PR21rPPh5+HLICwAAAAAABYAAAAWAAAAAAAAAAFgAAAAALd66atUIUJUsoCUAAAlSoAWALABGZILdVQAAASgCFEVLFikBKFgAlllTVAEsVKAACKAAAJYWLACLnOcZygvX0ej0dNTnw8/DhmAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVret6uoUikWUAAAAELLKlhYVACwBM4zJS71skWgBKAlAILCoBUEpKlASghZdSgCKSiVKRQAJQJSUlQACAzMZzmBeno9Hp67Y4eXy8MgFgBUAAAAAAAAAAAAAAAsAAAAAAAAAACwVret61ZZUUEoAAAAACAKRSAAZzjGYN66auYXVSgBKAAlJQlJYpEUQpKigAqykoSgAAAAAABCyoCWEIziZzAu+/p9Xfpefj8Xl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KQoqrWqq0UoAAAAAAAFlgWLLBYogCNFgpFgqFlgFllSospFEosSiUCWUShLLBYsLKllihCygQWWLKIUiyyxYFhZYsFgVAWAssAVFgAAogBYBYBYWAWAUSwAAAAAAAgznOc5Si2IppSJIAtVbbTSxaAAAAAAWACxYsBUqWFQWApYAAAACwKixUFiooRSFlgsFJRCyhYAlCUlAIAsLLKgVKgABYFQFgAFgWLCoAsFiwAAsAAAAAAWAAAAWAAEVJJjMzALZFW0hEgKVbbaW2UoAAAAALAACyoChLFllhYE0AAKgABUFlQVFSywWKiygEFgssKllWEoASoVFSwVLFSiAWFiosAAVAsAAqAKlgAWAAABYAALLAWAAAAAALAACUzmZxmAUSrasiEhRS1poqi2WWUSgABNQWAAsFgLFEsKShALYqCwCkWLBUAKRRKEpUiyyyhFiiCksqURZRFSywpFllhUWwlQLLCwsBYACwWAAWFgAFQAAABYAACwAAACoVAABYAAEsmcZzkCkLa0SRCKKW1dFoooABYACwWAsFgqALFJZYVFlJUoAsApCwFQolIqLKsSykCiWKJSCxRKEqFBKASkFllBFmslipQlgALBYWCwsCoWLCwCoLAAAsFlgAFgKlgFgALAAAAsAAlkmcZzBLbEW2qkiQUWaVbapVKEoAAsFQCs2ywFIKECxYsKEVCgFgLFllgAUQWUgFJVksolioqwAEsLBYstlgSyggUWBCkWKgKgALFixYBYKgqWFEAWAsLKgWAFQFJZYKlgAsAAAAAAAAkznEwCgLdEkZCqFW22mgVKAACwAFQKgpALLLCwCpYssKi1AFiwWUQKliyhKhZUpCks1EsUQpFSrEsoiyixLZKllCFiykVCyyosFlQAWAAUQAAFgAWUhYFgAAACwFgAWBYAAAFgAAARM4znIUEttpJJAqppWlpopZQAFIAAAWKgqALFQAACoLNSxYLBZUFgFgFRQBApKSkKslALAIUiiVFCKlQoEUlJZZYsWABUsUgCwAsACwsFgWAFgCxQgACoAsLACwsCwAAWAABLBM4zmQUlLV1GUSUpSrbVVRQAFgLAAsBZUAsCxUVAAsssWVCgLFIAABSAUgCktysqwlllCUlsBBSDSJQJSVLKCKAllJULFRSVKlQAogAFQqABYCwABYFQWAABZRCwFixYAAAAAEqVJ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AAgIIAAIzy+f4958HNm7YvX1+jfRWpnzXrwrd5ebz88Fa7er2ev07toAAAAAAAAAAAAABMyC3VACgABAAAAAACkKQAApaAAlAAAAAoCAKACAqApCiCgioAAqFgAAAICAogoKAAAAgICAACTPLwefhnhx7deV7e36XXy569FcvB87fThynOZG+3r9vr77aKAAAAAAAAAAAAAAEhGbWqAKAACAAAAAqAqAAAAtoAAAACoAAoIAoAICoKEKIKCKgACoAAAAICAKgoKAAAlIAgIAAETOfP5fL5+Lfbfu93XyfI69pM+Dl57UL27+r1evtutSgAAAAAAAAAAAAAACERZqgAoAACAAAACoKgAAALaAAAAAqAAKCCooAgCiKACKgogAKgAAABAKyoImiKCoKAAAIAiAAAgzGeXDz88XXpx5XflHi893vp17+j09ultKAAAAAAAAAAAAAAAAQgWgAUAAAIAAAFIWAAAAqgKAAAqKICoAoIqKAIAoigAioKIACoqAAAAgKgCAKCoKAAAIAgIAACBmSY585cpbvet3VWigAAAAAAAAAAAAAAAKIhBaABQAAAIAAAUioAAACqAoAACoogKgCoqKCKioqCgCCoqAKgAAAAAACAAgAoCgAAAAIIIAAAISIii0oKAAAAAAAAAAAAAAAALKIQCgAChFIUAIAAACoKIAALQoAAAAqCooIAqKCKioqCgCCoqAAAAAAAAAgAIAKAoAAAACAiAAAASAAqgAAAAAAAAAAAAAAAFILKEAAAACxSFAAgAAApKACKgpQoAAAAqCooIAqKCKioqKCAoiggAAAAAlBYAIogARYKJagKAAACAgQAAACKgKAAAAAAAAAAAAAAABQAgAAAAAAFAAIAAKFCoAAkKooAAAAKIKCAAKCKioqKCAoiggAAAAAAAAiiABFgolqAoAAAICKkAAAAAAAAAAAAAAAAAAAACiFACAAAAAAAUAAlgAKoloAADNgooAAAAKIKCAAKAACAogCggKgAAAAAAAAgAgKAAKigAAAgIgAAAAAAAAAAAAAAAAAAAKKIAIAAAAAAAAKihAAKKAoAAqEAoJQAAACiACiAoCKAgKIAoICoAAAAAAAAIAII0AAKigAAAgDIAAAAAAAAAAAAAAAAAAoAKIAgAAAAAAAAAKQCoKKCCgKCiICiFJQAAAogAogKAAAiiCggKCAAqAAAAAAgAIACgCiCooASgCCIAAAAAAAAAAAAAAAAAKAoAgIAAAAAAAAAAAAoACAoiqpQIgCgAACoKIqKgoCKAAAiiCggKCAAqAAAAAAgAIACgCiCooAAAgggAAAAAAAAAAAAAAAAoAKAICAAAAlAAAAAAAAoACAoigtloiAKAAAKgoiggoCKACAWKAAgKCACoogAAAAAgBAiqgoqAAKIoAAIIQAAAAAAAAAAAAAAAoAoACAgAAAgI0AAAAAAUigIUQAAAo0WCAoAAAAogoAICgAgFigAICggAqKIAAAAAIAlICoKKgACiKAACCEAAAAAAAAAAAAAACgAKAAggAAAICLQAAAAAFIoIFIAAAKirQgFEoAAAogoAICgAIAoIoIKJYAqKCAsAAAAAgAQAqoAqAACgAAggIAAAAAAAAAAAACgqCgAAECAAAAICLQAAAAAoCAFIAAAAKUACgAAKIKgKIAKAAgCgiggoQAqCiAWAAAAEqABAKAAqAACgAAggIAAAAAAAAAAACooCoKAAAkAAAAAgIWgAAAAUAgAAAAAABSgiqAAAogqAogAoAAAIoCAKgogKAIqAAAACKgAgqJSgAAACgAAgIgAAAAAAAAAAAKKigAqAgCAAAAAIAQNAAAACiKQAAAAAFgKiqgCqAAACiCiKgCgAAAigIAqCiAoAioAAAAIqAIIqFKAAAAKAACAggAAAAAAAAAAKAqKCoKgIAgAAAACAEClAAABQioAAAAAAAqKACqAAACiCiKgCgAIoCKIoCCggqKEKgAAAACKIIICiooAigACgAAIgIAAAAAAAAACgoAKIAAgIAAAAACAACgAAFBAAAAAAAAFICgKoAqAKgoIqACgAIoCKIoCCggoBCoAAAAAiiCCAoqKIoigAAoAAIgCAAAAAAAAAKAoAKIAIAIAAAAACAABQAAFBAAAAAAAAFCCgKoAqAKgoIqACgAACKAigIoACCoAAKgAACAIQKACopCwKAAoAAgCCAAAAAAAAqKoACiACAAgAAAAAAIoiiKlAAChABYAAAAAAKKhCgLQAKioCkCgAAAACKAigIoACCoAAKgAACAIsgq5oCopCwKAAoAAgCCAAAAAAAoAKCoCiACArIAAAAAAAiiKIqUAAKIA0kAAAAAACioQoBaACoqApAoAIKAACAqAoIKAAIAKioAAAIAIrIqKACoCKLAKAo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KJQAALBAmW8XHj306828yWaSNTnzd7LefZi76zOOc30qyCTV1cMrboFAjEmi2lAAEc9aAAAAAAAmcta0IKsgFioqAUCKAKAKAJQAAAAskQLaASCigLKAAAAAACKAAAAACCoKgqCoAAAzKgk0KJQIqChBLKTOmceTz5+lx469FuZuS852Y573qpz3rs545J011sxJdatpMNW2AUCCZZx12KAARi6AAAAAABnMutUIoQBQCKJQAqAoAoAAAAAAskQLaCEgCgqqAAAAqAAAigAAAJQACKIAKgsAEyAxqqAAiiFgJKqKc5c5ce2bMVbJ5u3eTVpZjp0z5N6q9LMjWqAAsBYqGcY0mrulAAIY1QAAAAAAxGrQKEAKogqAAoACooAAAAAAqBMgXQkgAAKrQAAACoAAAAAAAJQAACCoKgACSAcnWgAACACSqypnLKcO9k53c0zxuzWpNHXTn4e3p6Bm0AAoQLComed3pQUAAhm0AAAAAAky1oAogAqgioACgCgigAAAAACoEyBbZEAAAK2AAAAlSgACoAAAAKgAAgogogAMwDPDt0AAAEAAkCmc5xreZcaussY6JaXM3rejJaAAAKgCwqJzje5nDerQAEEoAAAAABiLdAKBADQAAAAACgAAAAAAAEyAqAAAAOgAAACVKAAKgAAAAqAIoIKIKIADMA557gAACAAEgozOMtmePbp0Z589rrLG+l6b0uciAAAAAFgMykzpqWqigEEoAAAAADGWtagCgQA0AAAAAAoAAAAAAABMgAAAAA6AAAABKAAAAAAAAAIqAKCAEoiIDnd0AACAABzm6KMc0ktzdWZmda0turemkkhICAqAAAAmc6jdzm6oWCiCKAACqKlSM8rpk1sAC0kANKgCoKgqKASgAAAAAAAJIAAAAADoAAAAEoAAAAAAAAAioAoIAAmagOXVQAAgAAJybo0JmySTjntoW1Yl1ei6skSAgiggACoMYxvpbM897oWAqCKACqoiBUc/H87t136Ou9wAC0kANKgKIKgqKASgAAAAkIKACAAAAAAOgAAAAAAAAigAAAAAIAqKAgCZAYx3CoKgIAACc86tzaJ5+nQMzeZbaIkuta1uokggIqACKiiE5cs260xz16dgAAlAKtCQgCOPyvD6b4PV9f2bIAKqpCAtqKAIqCooAAAAKgMwAAACoAAAAA6AAAAAAAACKAAA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AoioKgqAACKIqAKgCKCKCKCKgCKIqKCCoACgUoAEkgAAAAABFBFAAAAAAAAAAAAAAAAAAAAA6CKAACoAqAAqACoAAACoohQgoiiCkqKgCooioKIqAACKAgqKioAAAAACKiiAAACAoKKAAhJAAAAAAEUAAAAAAAAAAAAAAAAAAAAAA6KgCKAAEoAAAAAAJQAFIKAipQIoAJQioqKigIpAqKMigogJQAAAAiiKgAAAiiFBAoFAWAiRAAAAAAAAAAAAACoAAAAAAWCoAAKIAAAA6KgACKAEoAAAAAAJQAFIKIoEoIoAhQAIoAIpAqKICoogJQAAAAiiKgsAAAAAsAKWAWAiRAAAAAAAAAAAAACoAAAAAAUgAACqggAAA6AAAAAKgAAAAAAAKITQigAACCoqKigIoCCiKCAoIoIqKAQWWAAAAAAAAAAAAAACDMAAAAAAAAAAAAACiAAABSAAAAACgqQAAA6AAAAAKgAAAAAAAKISqigAACCooMtCKigIKIogKAigiooBBZYAAAAAAAAAAAAAAITIAACkAAAAAAAAAAogAAAUCAAAAAoKkAAAOgAAqAAEUAAAAAACoKEKAigBKAigiKqUSgJQCAoICoKIsqKIKAhQgI0iiAAAoISgAigABEyAABdIkAAAAAAAAACggAAAUoiAAAAKAAgAAOgAAqAigRQAAAAAAKgoQoCKAEoCKCCiUSiUlCKIKCAqI0IUiiCiKhQCCoogCggoIsAAKIAISQAAKWmUAAAAAAAAAFAgAAAUoIIAAACgiiAAqDoAKgAAAlAAAAACpKqJaIsAqKIoIoAACBQCKlABBQgJSgAIolAAlIoEKIAqWAolioKEKCAJYygABVohIAAAAAAAAAKAIAAAKCgiAAAAKioAAojoAKgAAAlAAAAACpKqJaIsAqKIoIoIoAMqUACUAEFgAUAIoiiUACUy0CWKIoBACpYqChAKgCJIAApVDJAAAAAAAAAKAAgAAAoKAyAAAAqKgACiOgAAAAAAAAqAAlAKCAoAQKIKihKAAigAAJQQKIoACFEKACKAgqKgoAioKAIqAAAKkTIABTQhIAAAKgAAAACgJaJAAAAoCgJAAAAAAAAOgAAAAAAAAqAAlAKCIqgBAqAqKEoAAAAAJQlIKigAIUSgAIoAigAgoioKAIqAAAKyzAAFUqIQAAAKgAAAACgJaJAAAAKAopIgAAAAAAA6CKAAACUAAAAAAACgAASpSCiCoKSjKqgEqgCUEVAFSgSoKlCKigAAEUBCoAUlACKiiBSQTIAiy6AiAAAAAAAAAAUACAAAAAKKoJIAAAAAACzoAAAIoJQAAAAAAAKAABKlIKIKIpKIKgLCiKEqLFQBUoEoipQioKAAgsUBCoAUSgIKgohSQZgAFoDIAAAAAAAAABQCAAAAAAoLQQkAAAAAADqgqAAAAAAAAAI0goigAgKM2iKCCgARYoCFkWgQLKIolACVFIoCFAAIpAoAIqKigSWkKICohmAALayIAAAAAqAAAAAAogAAAAAAC0qCIAAAAAA6oKgAAAAAAAAAqCiKIoICjNoiggoIoRQIqFktAkoUAM2gIVFIKAQqCgCUiggoIqKBJaQogKykgAKVKyAAAAAAAAAAAAogAAAAAABSqDMAAAAAA6CkKgAAhQAAAAIoCgigAAAAlAAhQAIUABAKiggCiKAhQCAoACUAgloBKIoASgJCSACioIAAAAAAAAAAAAFCAAAAAAAC0qpIgAAAAA6CkKgAAJQAAAACoCgigAAAAlAAEoAIUAgsAqKCCgIoCFAAAACUAipQBKAAEoCQzAKCjIAAAAAAAAAAAABQgAAAAAAAU0qDMAAAAAOgAAAAAAigAAKgKAAAAgoAiiKAABFAJSCwUQUCKJQigAAAASiKAigAJSKCFIKhDKAKKJAAKIAAAAAAAAAACiAAAAAAAALVAMwAAAAOgAAAAAAAAACoCgAAiggoAijLQAAEUASoFhRBQIKSgCKIoigIpKIoCKAAlIKIUIERCAqgiAAKIAAAAAAAAAACiAAAAAAAAFUoESAAAAOgogAAAAAAAAqSgKAhQioqFEoICoKAAIoAIolihFBKQsoikUlIKCAUIoCKAJSFECkqKyMoqKC2FkgACoAAAAAAAAAAAKIAAAAAAAACqUCJAAAA6CiAAAAAAAACpKAoCFigCFEoCCoKAAIKAIolARSLKQUIpLBSCggFAAgoiiUhYsI0lIIkgqKC2EgAAqAAAAAAAAAAACiAAAAAAAAAKWiwkgAAA6ACoAAAAACoAAAoAJQACCooAighUoCKyoVBQACUlEUCUgCgSoAogoAIKIJaCFIqIjIKiqAkACoAAAAAAAAAAAAoIAAAAAAAAAKooIkAAA6ACoAAAAACoAAAoAJQCKIKiiKIogVKAiooSwUIoipSURQhQgKBAAogoAICoJaCFIISICgoIgAKgAAAAAAAAAAACggAAAAAAAAAoKoJIAADoAJQAAAAACiAAqCgMtIKCKigAIKIoJQIoIoCKioBSUIoAIogKICiKEqKACCkoECBIgoqgiIAoCAAAAogAACgAgACgCAAAAAAAAAKAoQgAA6ACUAAAAAAogAKgoCAjQIqKAAgoiglAigigIqKioUlAAAiiAogKigSgACKEoEDIQgqigygKACAAqAoCAAKIoKICACgCAAAAAAAAAKACwgAA6CFAEoiioAAKiiCoAoigiiKCLCiUCKEUAAAgoEoAAEKCCgAihLKElqKM2hCwoM2gAkEiAKoCyICgIAACoqgIAAACgIqCAKAIAAAAAAAAACgCAAA6ASgJQAqAACoogqAKACKIoIWKhQAEUIoACCgQoAAQogKAIKJUoSWgM2oUQoJKoAkJCAooIsgCgIAACgoCAAAAoKgggCgCAAAAAAAAAAoAgAAOgAAAAAAqKgqCiCgAAAlAIoigAAAhRFAAAIoIoigAiggqKASgCKAgoCKICMkAqgCICgBAAAqgAsAAAAoikARBagAIAAAAUgAAAAoIAAA6AAAAAACoqCoKIKAAigJQACKAAAAlEUAAAAIoAAIoIoigEoigAIKAijIJBAqgIIAoAgAKCgoAAgAAoAIBEFAAIAAAAsAAAAAKIAAA6oBKAAAqAKgACoCgAAAEKAAASggUIolAIoAAQoCVCgCBRAoSoUAigAlARIIgoNCDIKAqIACgoKAAACKIqKCoAgkKAAIAAAAAAAAAAAAADqgEoAKgKgCoAAqAoAIoAEKgoABKCBQigigAigCUAJUKCKCUQoiyjNoCKACUCRIIDQKIiAoAIAKCgoAqAAAIoAqAIJKAIoIAAAAAAAAAAAAADoSgAAAAAAAogCkUIoCUlQqKigEqKAgoAIoAIUAIoigAADNsolIoAEoIUyooiEyKKLAIgCggACgpQKAgAAACgAgEkKARQgAAAAAFqIAAAAAAA6EoAAAAAAAKIApFCKAlJUKiooCUACCgACKAhQIqKIoCKAIlUEoIoBKCFIqKIiSCqKQggAoIAAoKoCgIAAAAoAIBJCioRQgAAAAAFoiAAAAAAA6AAAAAAAogogCgAigACKiooipQACCgAigIKJSChAqAsKAIoAhQSNAJLQM0QiINAqCCAqAACliigoACKigAAAAioIkChAqCoAAAAAq0kgAAAAAAOgAAAAAAKIKIAoAIoAAigiiKlIoAgoCAoICiUAECoCwoAigIFCWKARQJBLIAooiIAKgAApQoCgAAAAAAAAIiQKECoKgAAAAClqSAAAAAAA6AqAAAAI0gKgAKigAiooAIoIoCKgoCLCgiglIKJQACUAgUASxUE0IqFAACVEJAKKIIgAqAAqKFoKACoKiKAAAAAAiSAqyAqUIAAAAAKqAgAAAAADoCoAAAAKgKgAKigAiooAIoAAioKAEKiooJQiiUAAzaAgsoIVFQloioWKAAlSIkKKoIiAAqAAooUKAAqCoAAAAAACSQCkAqUIAAAAAKAIAKgAAADoAAAAAKioAACooIKAipQIKAiooAAEFIoCVFABFAAiiCgIoAlIKBFAM2pUkyoKogiACoAAKpRQAAogWAAAAAACEyBRAKIKgAAAACgCAKQAAAA6AAAAACoqAAAqKCCgIqUCKAgqKAAAEqKAlRQARQAIoIoAACUABFAM2kRmKooIiAAqAKAqgUAAKIFgAAAAAAiSAUQCiCoAAAAAoAgCoAAAAOgAAAAAqAAAqKACKlAJSLCgCCgACVKAikoigQsoAAIoIqKiopKIoSgAgqKiJI0AEIKiiAAqgKoKIogqAoioAAjQgACEiALAoAIAAAAACoAACoAAADoAAAAAKgAAKigACUAlBCgCKAigJUoCKSgASkoIoCKACKigSgBKAACKiJCgCSoKiiACiqAoKIogqCgCAACiAAISCAsCgAgAAAAAAAACoAAADoAAAAAqAogKigAAAAEoJQCKAAEoAAAAEoAAlASgCKAigAlAACKiIFEIgKCAA0CqAAKIqCoAoIqACooICKiSAAUAACKCAAAAAAAAAAADoAAAAAqAogKigAAAAEoJQAAABKAigAAJQigDNKEoIqKAigAlAIoiKIgUkIAoIAooooAAoiiKgAAqACoKIAhJAAFAAAiggAAAAAAAAAAA6AEoAKIAKICoqKAigAigCKAAAAAIoASkUAJQAAIoCKAARYFAACKCCECjMAAogKooAoCoKioALChAKQCiAFgiSAAFAACCkAACoAAAAFgAAAOgBKACiACiAqKigMtAAigAAAIqKigCKAEpLKAiygAAigAAARQSgACAqCECokAAqAqigoACoKioigsKEApAKIAlIJIAAUAAIKQCgAioAAAAAAAA6AKglAogAKgJQAKAAlSgigAIoEoikUACUAAAAAAiiKAlJKoAAgoCKgqIgKyIAACqoUCoqAqKIoipKqAApAAqAqEDMAWAoAAEAAoCoCAAAAAAAAOgCoEoKIACoCUACgAJUoIqKAABKIqWUCKEoAAAAACKAAQljQAAgoIKgqIgCCAACqoFAqKgKgAqKzSoACkACoCiQjIBYCgAAQAKCggqIAAAAAAADoqAAsCNIqCiAqAoACCiUACKAAAiiKAAlAAARQAAIoSgAAAAQKCKIKhCIAikAqqCgAqKgsoIqUAioqAoAIoCKgkkAAKAAAIWCigqAIIqAAAAAAA6KgALAKioKICoCgiggoQoAigIoIKCKAAlAAASgAIoihKAAAABAoIoAiDIAikCqoCgAACygipQCKioCgAigIAkkAAKAAAIWCigqAIAgAAAAAAOgKgBKKIKgAAqKIKIoigigglsoCUQoIoAAAlACKACUIoAigihCkolRSKAAIiEAIKjQooKAioqACoKhLSFIKgqAKhNCIoiSAACgICiAA0CggAgAIAAAAADoCoASiiCoAAoiiCiKIoAioEtAJRCooAigiglAAAAlAACKABCkolRSKAADKEAIKKoKCgIqKCAoihFIUgqAAKhNAgJJAAAoCAAAKoKCACAAIAAAAAOgAAAAAAAKIAAoAAhQigiopKIoAACUgoktigAAAAIoCKAACKigJSLAiICCqqWgCiKBAoCKIogoCIoAAKigEiSAABQIAAoJSqACKIAioqAiiAAADoAAAAAAACiAAoAAIUIoAikoCKAAJSCiS0AIoAAAACKAAAIoCUECIgAqgoKiiCosCgIoioCgioACoCoqKJCSAABQIAAoFCgAAgCKioKgEAAAOgBKigACNCCoqCiCgCKAAAAJQAAAgoAAIKAAAAAAlJQCUiooCUQqKlEIgAoqKolBKIoCColoQIoogKgKJUqAKgiJAAAoBAAKAqgAAASoKgAgCAAA6AJQAigCiCoqCiCgigAAAAJQAAAgqKAAAAAAAAASpQCUCCglAIqUQIAAoKEKSiKAgqFJUACiAAKJUoCKiDJAAAoBAAKAqgAAASoKgAAiAAA6CoKCAqAqAoyqiKAIKAIqTQAAikpKABKAAAACUCKigRQCUAgTQIoIoAAAJSKgAoIqCkoCKICygAIqCoBQCACiIRIAACiKQACgooCoAAAAABAiAADoKgoICoCoCiCiKAIKAIpKAAIpKSgASgAAAAlIqKAEUIqUAGVoIoIoAAAJSKgqCgioKSggogLKAAioKgFAgAKgiRAAAKIAACgooCoAAAAABAiAADoKIAAqCoAKgAKAighSKACKAigAgoCUSgAIoAAAACKligAIoCKIqCiUCKgAUhQiglShKhQICpNAAiwKgCoCoAhJAAAAAAACqKCiKICoACggAgggAOiNCAAKgqACoACgIoIUAAIoCKACCgJRKAAigAAAAIoAigIoCKAgqLCiKCAUhQiglQpKEoICpNIKCFiiAogKgCJEAAAAAAAKooKIogKgAKCACCCAA6CgCAAogqKACCgigAAEoIoAAAAAIoAAICgCUIoAAAJQAAigAAhQlCKgok0ioCgIqKiiKABAKAAgCpYAiQgAAAAAAKKooACKACKAAIEAggDoKAIACiCooAIKCKAAASgAAAAAIoigAAgoAJQAAAAJQAAAAABKJQiooJNIqAoIKiooigAQCoCggCpYAiSAAAAAAKAKooACKACKAAIAgggDoKIAACiKlAigIoAigAAAAigIoAIoAAAAAAAAAAIoSgAEoACKigJQAAAEFiooAlEKAIAAKgAohYKiEyAAAAACgKi0KAAAAAAAAgICIA6CiAKgCiKliiKAigCKCKAAAIoCKAAAAAAAAAAigACKEoACUAACKAQoACKCWFAACUQoCAACiAqKIWCpCSAAAAAAoChQoAAAAAAACAgIgDoKgAAAKCACggKIUAgUIoIoCKAioWUAAlACKAASiCiWKlAAAABFAAigCCoqAWKJRKAIolAIqAIoCoKCACoIiQAAAAAKKAoqKAAAJagAAiggqIqIIOgqAAACNAgAoICiFAIFCKCKAigAJUoCKJQAigCKQoCFCUAigAARQAIoIoioqAsKJSUAIoligioAKgKgogAKhEJAAAAAAoooCooAAAlqAACKioKgIgg6AACiKgoIqAUgqIooAIoAEoAIoAAAgKiiUSWooIKIpKAAAIoAlCUAShCooAIWAoAioogoAgUEFAQoIUgqACESAACiAAKooKAAAAiikAAAAiggIgjoAAKIqCgioBSKIAoCKiooBKCCooAAAiooCURQAIoBKCKAAAAlCUAlCUAIoIsAKIqKiiCiCiFikKIqWKioUgqACEkAAKCAAoooKAAAAiikAAAAiggIgOgIAKgKiiKIAoIqKACKACKAAAASgiiKigCCgAAACUASgEoAAioFCKAAAAgASgUCFIFCAqUgKipQIqAAIkgABQIogKKUCgAAAAAAAAAAgAgjoCACoCooiiAKCKigAigAigAAAEoIoiooAAAAAAJQIUASgAACFIKCKCUACALAqUCFIFAgFICglACAAIkgABQIogKKUWKAAqAAAIoAAAAgAgjogACoAAKAIlslAoIogqKICgCKCUCKAAAigAAIoAEVFAJLQEoACUSgiypQAIoCKEsKACFAAiiKSoKiooioKioIiQAAoAgCiigoAAAAAAAAAAAioAjaACoqAACiKIlslAoIogqKICgAAlAiooAigCCgAAAEVFAEsKEoAIsqUASpQAACChFAighYKCCgEqCoqKIqCoqIQyAAKAIAoooKAAAAAAAAAACKioAjQCoCNIKgqKIoiooIoAIoIoIKigAIqCgAAACUAAEoASgCKAAlAACUASgigAIKAIoAEoCCgIpAoAioKgIISAAFAIAKooCgAAAAAAAAAAAEAKAqAKiNCKiiKIqKCKACKCKCCooCKIqKCCgAAJQAASgBKAIoAIUCKBFAJYoAIoIoAgoCKSgAAIpAKACCoICJAABQCACqKAoAAAAAAAAAAABACiooCCoKiiAKiiKIogqCgAAigCCgAiiKAJQAACKIoIqUIFDNoCWUABFARQCKQKIoigAAAAIoCKigiglAIlIhIAAFCABQqgFAqACoAAAAAAAAAgCiooCCiKiiAKiiKIogqCgAAigAAAIoigikqCgAAAAJQIUJQBFAihKIpFAgqUAgqKAAigACKAAAioFAIlIhIAAqUIAFCqAUCoAKgCoAAAAAAAILCgCoqAogAAAqBSCgCAAKgACgIogKigAQoAAAACKAJUKigAAAAAASgACKAACKAAQKIoAgAqVKJKJEgCoCoqAAKqgCgAAqACwAAAAAAAAgoAqKgKIAAAKgUgoAgACoAAoCCoCooAEKAAAAigACVKAAAAigAIoSggoAAAAAAEKCKAIAKlk0JKREgCoCoqAAKqgKAAArKgEoAKgAAAAAINCCgiKKIAKAigACKigIAKigAAgoIqUAAIoAiglAigAJQIUgqUAAihCgIoCK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ACoACiAAogAAigiiKCCooigIUEoAAAWCoKiCooCAoACVCqgoNAAAiA0AAAAAAAAAAAAAAAyC0AAAAAigAADIAAAAAAAAAAASgEACoAAAAAEoAACKAgKAIKgoCKSooACKiiKCAKAAhQigAiioKWgABESlKAAAAAAAAAAJQAAACIBaAAAAAAAADIAigAAAAAAAACUIpAAqAAAAABKAAAigICgCCoKAipSKAAiooAIAoACFCKACKKgtoAAJCVVAAACKAAAAAACUAAAAggKoAAAAAAAAyCKAAAAAJQAAAAAICoKgKiUWAAAACKCKIoAIqKACKAgCgCCiKACKSyqiKAAAAIoqBVoABIBaAAAAAAAAACKAAAAAAgIFoAAAAAAADIIoAAAigCUAAAAACAqAAqJSUAAAAgogoigAigACKAgCgCCiKACKRSoigAAACKKypbQACQC0AAAAAAAAACKAAAAAAgIA0AAAAAAADIIoAAiiCgAAAAAAAgAKgAAKIAlASopKAiiCgAlSgAECgAigCCgICkKAACKgoAiqDQAqDIUoAAAAAAAAAAAAAAAAAIQDQAAAAAAAyCKAAAAAAAAACCgCAAqAAAogIUBKBKAiiCgCFSgAECgAiggqKAgKQoAAAgoCCqLQBYJAtAAAAAAAAAAAAAAAAAABIJQ0AAAAAADIIKAAAAAAACUACKCSgCiAAAAAASgilglAiqgCKACLKgKJSACoKiggoCCgABKAAiy0tAAJBaAAAAAAAAAAAAAAAAAAAEgBVAAAAAAMggoAAAAAAAJQAIqKkoAqAAAAAAEoAlBKAKgAAigSoChKgoCCooIKAgoACLKAAhaWygILJRQAAAAAAAAAAAAAAAAAAASoglKoAAAAAMiCooAAAAASgAJUWKgKIAiioAAigAACwAiiUjSAAIoAqIoigCKAigqCCggqKEoIoCUipVWgCIUoAAAAAAAAAAAACFAAAAAAACIgW0AAAAAMiCooAAAAASgAEsUICiAIoqAAIoAigBKAiiUKgACKAAAigCCgigqAAIKihKCKAlIpS0Agi0AAAAAAAAAAAAAIUAAAAAAACRApaAAAAAyCUAAAAAAAAAAImggAAKgQqoEoiooCKAigFgiooACKAIoAgAoAIoigIoIAKAKhQqgIgWgAAAAAAAAAAAAAAAAAAAAAAkAFUAAAAMglAAAAAAAAAACAqAAAqCWKqCwIoAIoCKAlCKigAIoAigCACooIKIoCKCACgCooqgDIpQAAAAAAAAAAAAAAAAAAAAAAEQIUtAAAAMoqKAAAAAAAAQKAQAIoAKgACiCKioqKiooCKgoigioKgKioqKAAioqKgKEoIqACgigUqgCIFoAAAAAAAAAAAAAAAAAAAAAAAAiBKpQAAAyiooigAAAAAAJQAEAAAAqAAKIIoIqKiooCKgoigCCiCoqKigAAiggKEoIqACgigqqAIgLQAAAAAAAAAAAAAAAAAAAAAAAAJBCi0AAAyAIoAAAAAJQAAiorJQCoAogAAAAgoBAKioKAAEKCFIoqAiiKKgqCUAWQqKCCgAqqAiAKoAAAAAAAAAAAAAAQoAAAAAAAAACIgo0AAAyAIoAAAAAJYoAIKioSgKgCiAAAAAigEAqKIoAAQoIUAqAiiKKgqCUAWSgAgoAWigiADQAAAAAAAAAAAAAAEKAAAAAAAAAAggCqAADKKJQAAAAAAAACKAiiKgCoAAKIIoAAqABCiKAASgACKAAACCgAgUACAolLSgIgAqgAAAAAAAAAAAAAAAAAAAAAAAAAIIA0AADICUCKAAAIoAAAIoCKIqAKgAAogioKAKgAQKigAhQAIqKAAAAigIqKSgAgKFKKAyAKoAAAAAAAAAAAAAAAAigAAAAAAAACAio0AADIigCUAEKAACCgACAJagAAAAAAAAAEqKigSgjSQKCKAAAICgiygioUAQKiihaAIIAqgAAAAAIqKAAAIAAoAAAAAAAAAAAAAIqCgAAMjOiKCUAJQAAAAAAgBNIAAAAAAAAACUigCUCNJAoIoAAAgKCFACFAECoootAIgCigAAAAACKigAACAAKAAAAAAAAAAAAACKgoAADIIoCKAAAAACKiggAABYAAigACFAAEoIoACKCKigAAAAigAAAiiKAIoKNAJAA0AAAAACAgAKCKIKIAAoUAhSKAAAAAAAAAAAAAAMgigAAAAIoAIqKCAAAFgACKAAIUAASgigAIoIqKAAAACKAAACKIoAChSgiACqAAAAAioIAAAKIKgAAKUAhSKAAAAAAAAAAAAAAMUAAAAAAigAACCoAqAAAlCUAAJQigAAiooAAAAlAAIFRUKBAoAAAAoqgMgCqAAAAAICAAAAAAAAAqgCKAAAAAAAAAAAAAAAMUAAAigAAAAACAAKgAAEoSgACUIoAAIqKAAAAEoACBUWUAlgoAAAAtKAMgDQAAAAIoggAAAAACKAAKoAigAAAAAAAAAAAAAADIAAAAACKJQCKAIJSiAAKgJQAAAogAAAigiooAlAIKIoSggoIoCwAAAotAIQCqAAAAAggAAAAAAAIUAFUAAAAAAAAAhQAAAAAADIAAAAAACUAAAglKIAAqASgAACiAAACKCKigBCggqCiUCCggoJQAigKLQDIA0AAAAAgIAIoACKAAAhQAVQAAAAAAAACJSgAAAAAAyAAAAAAIoSoKAgAogAAqAAKgAAqACKqAKkKgoIoAAgoABKAigACKigK0AiACqAAAACQAAAAAAigAAABaAigAAAAAAAyLQAAAAAAMgAAAAAADNqCgCAKIAAKgACoAAKgAiqgCpCoKIKAAIKAASgAAAgqKFFoIgCigAAAAJAIqKigAACKAAAAFoCKAAAAAAACItAAAAAAAyAAAAACKACUCKQogKgAIoACUqAAAgoACFAIKAIoJSKAACChKsgoAAFKKIgBaAAAAAyAAIIoqCgICgAAAFUAAAAAAAAAAAAAAAAAMgigAAACKAAACWKICoACKAAlKgAAIKAAhQCCgCKipSKAAAihKQKAACqoIgClAAAAAMgigIIqiCgCCgAAAFUCKAAAAAAAAAAAigAAADIAAAAAIqKAAAgKCCoqI0ipKAqAAAIKAiiKIoAIoiiKgoAiiKAAIoACoC2giAFoAAAAIgAkqUpCUCwKgqKAigCAq0BKAAAAAAAAAAAAAAAAMooAAAACKAAAAgoIKiiKipKAqAAAIKAAigAAiiKIqCgCKIoAAigAKgVaIgBVAAAACIACSkqpYSgzojSCooCKAICrQEoAAAAAAAAAAAAAAAAyAAAAAIoSiKAIoIqKgAAKgAslAJQCUIoBCiKAiiAqFAACoAAAAIoAFFqQANAAAACCABAAqAAlAizQCEWgIoFoAAAigAAAAAAAAAAAAAMgAigAAAEoigiooIqKgAAKgARQBKAlCKAQoiiAoIKhQCKCoACKAAiooBRakAooAAACIACLAAqAAlAhaAhFoCKBaAAAIoAAAAAAAAAAAAADIAQoAAABCgiggBKAigAACKAqAAigIoAAAAAACUAAEKAAigigAUqAKoAAAAiACKgqSgACUAgUEooQKihSgACKAAAAAAAAAAAAAAAyAEoAACUCUAiggBYAAAAAAAAAigIoAAAAAACUAAEKAAigigAUqAWgAAAIIIKIArNACKEoCKSiUKJKKihaAACKAAAAAAAAAAAAAAAyAAAAAAiiCooIogAKgKgEoKIJQIoAAAlSgiiKAAAACCiVFEoJQiiCgBQBaAAAAggCATSAKkqCiUCKigCoCKAoqgAAAAAAAAAAAAAAAAADIAAAAACKIKAIogAKgKgEoKIFgIoAAAlSgiiKAAAAioKEsUSglACKABQBaAAAIIAioBSAKkoihKAIoAqAACloAAAAAAAAAAAAAAAAAAMggoAAAAigAigIsAAqAAAACoAACKIKgoigIoCKACKARQAACKAAAUAtAAAIgBKIAACKAEqKACKAqCKBQWgAAAAAEoAiiKAAAAAAAAAyCCgAIoAAACKCCwACoAAAAKgAAIogqCiKAigIoAIoBFAAAIoCKAqUKFAAAMgIUIAACKCKSooAIoCoIoJaFoAAAAABKAIoigAAAAAAAAMgAAAgoIoAAgKgoIAACoAihCgKiCiKIKAAAhSUigCKAAAAAAiiKlSiiqAAAIgAgqBKogCKJQAAIsoAACoFKoAAAAAAAIIoKAAAAAAAADIAAAIKAAIoICoKCCKACoAAlACogoiiCgAAIUlIoAigAAAAAIoipUooqgAADIAIjSBKoyqKiiUAACFAAAKgVaAAAAAAAAggooAAAAAAAAMgSgAAAACKAgogqKIAAqAAAWKgCKlAACCiABYoEKigIoAigIKAAAAo0AAAiACAEtIAqAWAACiABGiSioKilUAAAAAAAJKgACgoAAAAAAAyBKAAAAAAAiggqKIAAqKgACUqAIqUAAIKIAFAEKigIoAgoIKAAAAo0AAIIIKIARayqKqAlIoAKIAJSs0KgqKVQAAAAAAAkAAAooAAAAAAAyAAAAAAAAAIoCAqAqKgASgAAAAAAI0gAzqCgIoAAikoAAAEolSiNAWgAiAIKgCCgAAACFIoAigqJSoIopaAAAAAAAEgAACoKCooIoAAADIAAAAAAAAIqKIqAqAqKgASgAAAAAACsqAsgoCKAAIpKAAABKEsoKiloAMiKIKyoIoAAAABAoAigqEqoIpS0AAAAAAAEgAACoKCoAKAAAAzKlAACFAAAAAIAqSgAAColACKACoAAigCKikoAAgCypSCiKCoiiCgEKlFCoAElCKigAIqoIAoKIKMigCKAKIotAAAAAAAAiAAAAKIAAooAAA52pQAAhQAAAACAKkoAAAqJQAigAqAAIoAAJQAAgCykqCiAqoiiCooQqUFiooQRQCKAAiqggCgoyqjIKAigCiKLQAAAAAAAIgAAAAAAANAAADKFCKAIoIoACCgIKCAKiiAKkqoAAAKgAAAAigSoKCCgAIoICgigCLKiiKALASoUqAAICgCUAAAqAAAWBSCilAAAAAAACIAAAAAAAAFoAAMoUIoAigigAIKioCiACooCAlKgAAAqAAAACKBKgoIoAAiggKCKAIsqKIoAsgUi2KgACAoAWAAAAAACUJagpRQAAAAAAAyAIoAAAAAAFoAAMgigSgigEoAAAiwqAqAqBKKICoACiAAigAAAIKIoAAAAAAAhQqAIoEKKyoIoAIUIKIKCwAAKgIWiAAKhRaAAAAAAACIAAJQAAAAACqAAMgigSgigEoIoAAQqAqAqBKKICoACiAAigAAAICooAAAAAAAJQqAIoJYorKgAigi2CCiCgsAAiqgIWiAAKhRaAAAAAAACICKAlAAAAIqKA0AAMUigiooAAEpKCKEpKQAAAAAAAAogSgAAACKIKAlAAAIKgUAAAqCKigIKACKigigAIoJQCKigBCiKCoAKWgAAAAAAAiAAAAAlAAIoACqADFIoIqKAIoIpKCKECkAAAAAAAAKILAAAAAiiCgJQAACCoFACKAqIKigIKACKigiooAiglAAigBCiCioAKWgAAAAAAAyAAAAAlAAIoAA0ADIgoAACKDKqIoCAogBUAAAAEqoKgBKSiKAAAIoiioAACoAgoiiCiKAAAigACKJUKAAAAACoAAAIWiQqKpaAAAAAAAggAAAAAAIoIKACqAMgAAACKCCiKAgKIAVAAAACUqCoAlEoigAAACKKgAAKgCCiKIKIoAAAAAABLCgAIoAACoAAABQzQKFoAAAAACAIAAAAAAAiggoAKoAyAAAIKgCoqKgoIKQKgqAAAAKghQAAAIoiiFAIoAAIoAAgCgAAIoIoIoioKigIqKCUAIoAoCFgi0gKCJQULQAAAAAIgAAAAAAigigIrNoAAqgyIoAIqCiAoAJQCKQKgqAACoAqAWAAAAigCFAIoAAIoAAgCgAAIoIoIoigIoAIoEoAAAoCJQhagKCJQVRQAAAAAIgAAAAAAiggKIqTQAANAyIqKAioKgoAACUAEAogAAACoAAAqCoAAAiiKAigAAAigCAKiooICooIoAAJQgoAAACKsAIsqWWoigKgFWgAAAAAMgAARQACUIloCAlqFAAApTIigAiooiaAigAlABAoIAAAAqAAAKgqAAAIoiiKigAAAigCAKiooICooIoAAJSAoigCKIqKQoIUllqAAqAq0AAAAAAyAIoEUAAlCJaAgJahQAAKUyIoAgoEFIqKAAiiACoqKihAAAKyqUCoAAAAAACKigAAAACKCKCKgoAAigABKlIKAAIqBQigigAACkKFoAAAAAAyAAAEoAJQASKKAgCooAKMqigICgQUiooACKIAKioqKEAAArKpQKgAAAAACKiooAAAAAigigioKAAIoAAsJSKAACKgUAiooACKCkKFoAAAAAAyAAAIoAJQAQCgICNIoAKIAIKgoAAgqKAAgogoiooAEAACKAAABKCKAAIoIoAIoAAigAigIVCooICoWoBKiiUiiKIoAAKioAKiWwCpS0AAAAAAiAAAIKAkqoKSgAAIBYoCUAAIKigigCCgAAgoigiooAEAAAAAAASgiiKAIoIoAIoAAigAigIVCooIKIWoBKiiUiiKIoAAKgACoSyoqpS0AAAAAAiAAAIKAkqoKigAAICwoCUAIqKCCiCgCCgBCiAoigBCiKgACggCBQigBCgIoAioKAAAioKAAlAIKACKIKAAAiggoJbAAIqwAAAKhS0AAAAAAiAAAAAJKUAgpKgCgAAAACKiiAogoAgoAQKgKIoAQoioAAoIAgUIoAQoCKAAgoAAioqCgAJQCCgiiKIKAAIqKCCglSgAirAAIoCoUtAAAAAAIgAAAADNFAIKSoAoAAAABCiAogqBUogFAQoCKCKiooSyiCKAAqEoACCgCAoigAiiChKACKigiggKgCgAAQqKi2AgKAgoigIKCwIKAAo0AAAAAAiAAAgqKgoCAAKgItIhaIqCgAQogKIKgVKIBYoQoAAioqKIUIAAAqEoACCgCAoigAiiChKACKigiggKgCgAAQqKhQICgIKIqogKBKCKAiiloAAAAACIAACCoqCgIAAqAJaiLNCKgoAAIKiUqKCUAAIoAAAAAIqUACFioUIAAAAAAACKigASkCyiKAhQAAiiUAIoAiiKIoCCiUAlIKEKogiooU0AAAAAAggAAiiKIoII0iKKRZKWAlqKJKKAACCoWKiopKAAIqKAIoigAIqUACFioUIAAAAAAAAIoAEpAsoigIUAAAEoAigCKIoigIKJQCUgKQqiCKiqlNAAAAAAIIAAIoiiCiAqAKkWUWAlqKJKKAIKICgAAAIKiiAAogKAEKAIogoCKgAACKAAAgqKAAAigAQKCKICgAAAiiKhSCgigCFIUiiKAIoACi0AAAAAAiACKgKIASqiNAIokqooIlqKiKKJYWCiAoAACCoKiiAqCiAoAQoAAgoIKgAACKAAAgqKAAAigAQKCKICgCKACKIqFIKAACFIUiiKACCgCi0AAAAAAiAAICiAJQCoqI0EoighNIqIooQAKiglIoCKhQioKIUgoCCgABCiCgECoKgiooACUAAgoACKAKgAgoAAIoCKigAIKRUCgCCgACKAAAJaA0AACCgAIIAAAhYoIlWCpKoIqUgAqSgIqLQCAqKBKigIqFCKgohSCgIKAAJQIKAQKgqAqAACUAAgoACKAKgAgoAAIoCKAACCktkCgCCgACKAACKloKoAAIKAAggAAioWKAktiiSqCKlIAKQCCiWgAIqFAIogqCiKAkoqKCKAAAAIoAioKAiiAAIoAIAoACKEoigJQCKAigihKCKBKACNIAAgqUIKAigCoigpaAAEoAAICAAAgqAogogqCWggAKgogACpYoioUAiiCoKIoCWCooIoAiiKAIoAioKAAgACKACAKAAihKIoCUAACKCKEoIoEoAI0gAAikogoCKAKiKCloAASgAAgIAACCoAoiiCoE0CCKrLSCiAIorNCoKiooiiKAIKCKgqCooAAIoAAigipNCKIKgCKAAigAigAAgoCFQoAEKAigAioKAIqKAigAACKEKAlAFLQAAgoACIAEoIAhSyUKCIqWiFgI0AhKrNJUWggKgqKiiKIoAgoIqCiKigAAigIoIoASgICoAigAIoAAAACCgIVCgAQoCKAIKgoAiooAAAACKEKAlCoUtAACCgAIgASggAUSUKCAUIWAjQCEqpKWRaCCiKAAigioqKIoCAqCosqCiKigACKJQBKCAAAiooCCgAigSoogKAIoACCoCooCCpaiAKgqAoAACKqCKACKCrQACJaAAiAAACKAIKigipSChKQCoiqzSiFgIqoKACCgioqKIoCAqChKgoigAAIoSgEoIAACKACKAAigQKCCgCKAAgqAqKAgqWsgCoKgKAAAiqgigAigq0AAhQACIAAAIoAgqKIjSUgoQsAAKkqiLCKP/EACoQAAICAQIFBQEBAAMBAAAAAAERAgMSAAQQEyBgcAUwQFCAFBWQoNCw/9oACAEBAAECAepecn5qXZB/cB/cB/6Oj/5w3+Kkv2+kl+3UQl+3iCEvGj/E6SIX7Xb4pEEEeNH+ImCOggggheNX+IAQQeKIRBH7WBBB6EQQR+1mCC+KIII8bN/h4EEEHiiCCF42b/DwIII4oggheOG/w2wQQRxRiQQQvGzb/DgIIII4kEEGJHjhv8NggggvgQQYmJHjht/hpgxkC+CIMTEjxy2+3G347BEokHgjExMSCPHLb7dfjsGJiQeCIMZCQ8dtj8MgxlGQIOkRMSB8etv8LgxlGUZROlMTEvID7TPkUSjKMonUhOM4EePm32ifIwMZQlGWjGVc65QXj5t9nH4I8bgxlCcJDSlXOqdRHj9t/hVxlCcJxKMJ1WUyh5AYIPZJ0fgDx3GUJ12QkNGMqbdvZSR5AbfY58miUJ12V2R0pV20XbeUPILfYp8ngwnXZVbCejCym/bWVeQWC32EdHyhGVdlV1dg0Yzr3G3tpI8gtg9hHyjGVdlN1NwJ1OF9F1BHkJt/MbeWWWTyyeTbfwG35TBrspupuEtShbRftpw8htv5Dyb9tt5ZN+ZITpvqvjPRjZVftrKvFCw5fK5fL5eC+G2D8Rt/DbbyfmGM6bqrq7QVOu+m6rxNCuFIp5eBjgIcs0ypNa+C238Akn5beWTfl2JquqvrujMm7V4mPEkBTCMEeGOGC1jKqyqUfhgt+4zJ/QNt+XAYWVXQvjdOdurIkeI69USiZaloaHGXCJ1ZG2PxG37RJP4EjKFtductTEgR4gWAhAwuz1iuBGIGVk7ZfGYLfUST+BnCcbMyTogjw/XGuvkyplEWRuFvM5nMz5hslbKyUvkNg9BP4KjPPJ6IIXgkRFRrXsCsUGiUOiuVVkJKdVlJ1nzebzubzTYZv5YIPAn8GAtvgQvA9caqI7ee3u28orEVij+edUdUiMDXbRZURxhOq6u3UoW0zqP0g0CT+EAXwWJj4FrO3srkrK7dsNrHbCjlkWieq7K7YyIsqtplHiJV213RkRZVbTKP42b0NCJhKBHgSuyncV2sxxlqVsr5XztlJwsquhZqULaZ1rg4zquhZqULaZ1/jZ6GoaUq5wI76WIqG3G1/l/lO3NajKq+q+MtWC6Mzk+MZV3V3CRFlVlEq8cRCEKxDhIWxsHcbHlJgwlA6nGcCO9xXHbw2cNpHbinl4cs0y29m0so1XZTuIWanXdt519I1Cyu+FrMZVGjkCkVgZG2V1lsz3K2/J4MTCQk5CUTHvSIp21e1jRgSbZbg7r+sbqF4kY2U37acIzqvruBlG2i2gjgo1ikwFkbxeLubzeabjebjaZvuht+ThqMozEiSDEwI7sjGG2hs57OyrUNbWys6Or9XWStNmYshfVua7tSjdt7aRqq6q+MzqdU9sdt/NHbRowsjaHnzOZzOZnk+7m35NEoyEtDWE6pQ7rp1t9RiYX7a6jVdm33VVupR3G2up6IypvqvEiLabtuRCyvcQ3AsfBmyV075z75Bfk0ESEomGiLK5wI7PWC94ajTHaHZ2U9ETRuKdwJEXUbjbERlRuabwSLqL9uRxddtO4hPVld+3lFiyN43H9H9BvNxsJ78YPkxiUZVyyOpxnAjswaq29WyOyv2ko+7XrbCMDC+i6gjiDVdt9zCerK9xtpwBpvo3MZ6tq3G2lHohOncV3Gyyd3Q2/ATB8mAwlGYloxlCUey462c6+Fle52llfBCAoG1/j/AIztDtzWhqi+nciZ1bVftyOiFm33NdrlHcbayvVdlG5rt1OO421lfQDC7+iVxl4KBB8lgxlGQOiJwlAjsqq3bbuFmpQ3O1tor29Wyr2cdvysMOWaZbazZ2bYxrso3MLNWV37eUOiMqdxVeDIX0W06jKncVX5znudHwoCD5MjKE4y0RKMoEdlRntt1VfoizbwoETKW4lvDvf7RvI7kTOp13ba2qMqNxXbqUbtvZSuMRTqos6urvhoGu7+mW4lZ4WB8mCUZxm9GMoSiuxRCNEqEDRuNvuRLhdO/dTvNmWWcbqt1VuGdXVX1Oq+rcCep1z2x2v8o20aI1jRslfZuLJ8X4ZBB8lgxnCYOiJQlWY9h7eFW1jRZRudrKOqrttu4Tc47rbTh0g1W7e5nW4rmNRsr3MNyLs8nmbTuJbmV8rSfvcRXDbDZWR7dBB8mCUJxkNIVWbeyv7tLpqntt1Cepw3O0nXqE9vuq7dSjuNtbV0jW00OFxu6BIWi/8Ao55vNub+7WMaY7SHp9fp8NlGi8XHt4EHyYDGcJxNWpRupsrI+3rrr2cNlbsraumE9vuq7dSG421tWgaNzTeyL9vdStKNdW3qhqUr7ZnsRRrr2lfplfpkNkKMFw9Ruke34nydGULKrBOWp12Uyj9ttp0zGiL9vdQugGjc07hnV+3voWqrqNyJatpltBtI7aNKyndbuJz7BQrjt69jD0+nZwpEdMyJ0jr1GzuGJ8nCVVtduWpQtpnBfaA07ijcg6tp3G2I6artvuQdW1bjbEars2+6jNnRkbZbiW5nuJWv75CEaIbKvYw2kaIwQLfRkbbb9xLuEaifJwNdldsZgyFlVlRj9rXbtt1Gepw3G1nX01z224idThudtIajKvc/1ndHcG3N/eoQjRDZ17GGzjQIAcIgxEVrKVk9xPdT3k91K2XccfKMZ12wsepQtplD7WMtvuq7dEW7azaGjlCiO1r2ldA1lK27cWHsJCMaYbSvYw2caBBcMRHHQJkbTuJ7ue+s3ktybjOJs0e4xqPlEGFldkZaMbKbKiPtAatxVu42NGvk8vFyunup7ud5l2AIiqG1r2NeyjthWuCEcFrKVsrzu576e8lupXmzLjVq0nuSPlJxnXbCY4TqtolH7UShuIbwb3+z+w72W8luZWmT++xFUNrDY17GG2FS4LHHHWZtluJbqe8nvJbk3GzJ9VWrNHuQaHlMSrtrsB1KNtFlX27yyb+9WIrhtq9hXsIbQVY8AMRDHRlK6W5nu57ye7luZXGxv2RqvU9HuWPlQGFlV0ZcLaLaDHvTEVw21fp9fp0NmKceCxwx0ZG6W5nvJ72e7luDaZv3oajqWj3LHytGVV0LAQZV37adfd+Iqhta/Tq/TYbKNGOnwS0Zm+W6nvZ72e7luDaZv4VcQJaPZiS+NHQ8rA121XRlGSv2ltBHcK4LgliK4bSv0yr0uGxjRjpvozN8t1Pez3s93LcGzJ/FGkNS1LsofLGh5YhOq+E4yhOzb7nZyh2+ljjhgKYbKHpdfpUNjGhPIzMuORulup72e9lupXmzL5UNTENS0eyh0H5EfLIlVdXbGVVkxuNjbR22gMYwjt4bKHpcfSoemx2Ypx0SZ5Pg5Wy3Nm9nvZbqVxm/nU6t1VqwS0eyR8yPlp12VXQlXIa3G23O1I7WSEY11bWr0ur0uvaiCWiTM2Gb05WT3Nm+s3092bzN/RbfVmqtT1LR7JHzI+XIypvqnXZlfG/azr7RSQhDb1em1ekV+nxpXQZysMtHRlPcT31m/nvJXmb+mo4UzkZaPcsfLoNV+2v1IxN+0u25HZqxjVV6fV6PV6ZDbiPB5Z8zmGWjKd9m+s9QnvJXmb+qp1HU9SMtHskfMj5fqto3eThZOvdbWUeyFjCmvYVekVelQ2ghwyz5hsy4ZG6zfWepWb+e4Nj+uq1Xq4PsofMj5gjKrc126jKZs2lu3I7DxjXXsqvSavSq9qIayM+YbM8uBJ3E9/Z6nPfy3Jtyf2NWhqzswfMj5irtpv4Uyntt36dOtfeqNdeyr9Kr9Jr2Qr088zPN6RMtzP1Cz1Szfy3Bsyb+0r4S1LgOzT8iPmOMqdxCyGqJY7v0/cbUj7hRqr2VfpVXpUNmIaMuYbOZm+GUt1P1Kz1Oe+lebMn9zDTOjo9yjUfMjquovolHhdt956dKtfYrGNVewr9Jr9KhsxXrM2GeeT4SnLdz9Ss9SnvDdm/voafAjQ7JHA/Jj5mrs2m7puHAx3Hpu69PlBfVrGO3r9Nq9Ir9LhtBB5mZmZN8DOe8s9Sn6hPdG3J9hQ6ZAdkjgfkDQ8zxltt3td0CNDVkN16XfszBL6NIQr2lfpVfo9fpsaEzIzM8suMpz3k/Up7+W5Nj7HhxPE6HZA4H5A0PNA1RudpvozjJ6nVf6VuPTJ1GK+YljGqGwr9Hr9Ir2UatMyyMjLNoRM572z1Ozfz3Bm+y49Z7KPyB5rrs2u/ovGgeBFm0v9Iv9LnRiuhJLil1JLEQjtavSY+i1+lQ2mGssm2ZEpSss31nqdm/leZvs8ewuxRwOj8gebAdtu9rv4kafE6nRb6bP0iXpEvTDsuRyuXhhhhhhhjiK+SNvHYR9Lh6ND0WHpY2gqTyyyPE8Z3Weo2+q2b+Vxm+3COxBwPyR5tddu09So3j02zohAvXL/n/AJf5Jem/5f8Al/5X+WfSh6V/nw2/J5WK4E5ZPpc9xZ6lZ6rZv5XZPtgdmjgfkjzeDXfR6nR6lGxYkA6WOIiuDbbbJyybybfQTPd2eqWeq2b6Vxk+3B0N9kn5A0POLFlW8q9Wr9Whvo28EOD0etvg+gmV8/UJ+r2eqz3srcn4uPyR51eQsjuYeo1+rw9Yj6pDeC8Tbem2ZGfOO5O9l6jL1Wfq8/VZ7+V5m35LHnp5CYtG4jvv9D+8eo/6f+l/on1E747s7k3c3PJvygPPzbbbb8sD9opJL2h+wEkkkkkkkuhJJL9Cns9JJJJJJJcB+gSOx37iSS4JfoMjsBttttttt+yl+hiOy22223+jSOzm223+iyO0G23+i12k23+iyPtSfmtv9FL7N/q1fuFfuFfuFf8AO4l+wxE+0veA6l+vYwlL2RwXuAfsMwEZS6V0j3VwP7AUISlKXQBo/CAWieA/XoAgZaPRGOifgjUNKXEfr0CMZS0ZcYx0T8MGOreo9iD86gCJJJPGMTonoAXvMTJ/XsYiMiSTxjEk9I1GBjIfAAR/XUIxhORJPGETo9W2gaZ1W/CGpfrmEK4zmSTxhHRL6Brb6EibD1D2m/1xCFULZyJPGMdEnqjqBE7b+3B+box2sdxcSTxhEknrjoHKR/ZMRRTfdIk8YQOiT7A0ye3x+aoxp291xJPGESSSf2mBRXuNwSTxhA6JJ7sHkFttttttttviscMcMOXhil1LSSSxWKWlpJJYpLHHDl8vHDl8vlcvDDHHDl8vlYYcvl8vl8rDljbnbjb/AMp2n8o2h2f8Z2n8o2g2h2vJ5fLwSSX223r3N5JPGETqRJ9tLuAeLzLJttttvJ5NtttttvLJ5NtxmLOaLo3jdf0x3f8AZ/YdybudK3m83PPMWRuhPIW83mCznG43m3nTsjeLf6P6RuP6hu/7Jbr+j+n+r+mO6/r/AK/6f6f6v6/6zujuf6Ofz+fz/wCj+k3i3+jn8/8Ao/o53PG6luxuv7f7hvf7j6h/oS3/APdHf/3n1D+z+r+r+jnc3nc3m83mZ8zmZ55Z555CX1FVVlhJPGECZE/APcA8WMn5b6223lk3lllk22wW3llllk8ssnllllk222223xfuPi+lt8X8sH6auudmieMYuRJ9saHFnuAeKySetJJJJJJLFY4444444444444444444rHHHHHHHHHHHHHHFY44444444YYYYYYYYYYYYYYYYYYYYYcvDDDl4YcvDDDl4YYcvDl4YYcvl8vDDDDDDl8vl8vl8vl8vl8vl8vl8vl8vl4YdYP0lcbLNE8YR0SToe0uJ7iGh4oZPXHTbbbbbbeWWWWWeeWWeWWWeWeWWWTfB8cm8ssssnwHAgAkAl8HlkODy022223llnnnnnnnnnnnnnnnnnnnnnnnnnlllllllllnnnnnzOZzOZzOZzOZzOZmfYifoq4TkdE8Yx0ST7YiuBPcQ0PE5k/Zbbbbbb4v2H0vTbyzzz5nMzyybeTeQmLMzZzYTnKF05vPPJsSzestPTbbb+cvi1ylDriR9BGORJPGI0SToD2FGtI6J7kGh4lJ7DiZH2X8RRhprqXtDQLiDQa8F8CqdkOsEH5o1HUpEniBok8AOtUbWOxlTKMtSl3MPEZJP0oBH3i0JHQHQuD915ZZLBYke7VKyHWND5ohKRJPAAaJJ0B7G0p2tF1dsL9Tn3OPERL+kAMY6sA1LghqehFfDEI0fzyjCv+c0mGKxw5eGKXUl1gcQPhiIo5HKUIy1zZW5ZP3QYG2H0cIWTJPQASeA0PYrhshCQ1vzdb3ONDQ8QSP0q1loS0+GOsifdShGOzOxns4RG4q3NsYmFtuhqUJBuMjLUa58MeAjiS+oDpfSlpJakekahuJXm3LJ/DqnKMo9cflQjZYyeI0dE8AOuEaxVKu7ceo7jc90jQ8PyP0wL62fdxxxiGhu/7o7yUzwhKRrFlkdC06xkXp80nUdJacuse2ul9B6AORyeVhy+VyjDFfA2lm8o6wfebbyyyyyygZyMugDRPAexEDQInbuTLukaGh4ekfqY6XVIe0hGOjoanHVcpA6jo6rjOJ0NGcTI6joy1RC3amBCTlJ6ekBo8Ron2lxS6xqmX9MtwbpWCw2i2U8jo/Arlsxvtt1x9ptv2gTLoHAngB1gDQ1lKfdo8Oyl9UC+k6J6xpaQ0NPTQjLWOL1iyQNHT0IyEJQ3Vk5aZlxS9he6OCMV0jg/YfwfTd56juOsaHU2/hjpA9rInu0aHhyR+xGpdOPGIMQFoalwayGmJEITloafQ9JkvgBhj7i6l0vIyyfQNJL5NZl1gYDg8m/lAe0T3eNDQ8NE/ZR1LogAJwWhpgaGstcsxEiI6WJIIEo6jox4xjIGXERx1nlo6HwFxbbfWNDR+WNAnqiTJv5oA9p95DwydE9a+iS4DhIajqWqazsv4pUNGGI0tPLgJZEajLUBPbGMeB0OEtR0dCyc+CEMBqYWsmNJcBo6eT0lxyyb92MiRohY4EfFjo/TDQ9l95j2W22222234CkfYf0CXU+BFZju6t3dYRGcDcEeCMOCQjOBESJf0GbJbeClI8BEV4aMmZE6Eceh5PoEjLLJ/DHEcJfGjqX0wHsPvUdTb9ptttt9+SPsI/PHux0eEdZR1OkaJesNZEaEhoRs6TpaPADmSnqEf5jHI2iRnloDWWWRk/m4irlGMdE5GZL+JHR+ufxB3COlt/Eb77l7EIz+Wkl7wOktA8+RemLJSGidKJEzogakBqWgdHQ1lI8KpjcWTlLpyy+hjoHM2GTfBfFjo+Jm2/CUj1jQ1I/WDgOB4R1KIGHBtx0dHQ08nlwWsjInivq46EUIzGgBHFEL4Y7EHcbfhM6PsV6sP1zcNGKGia9OYPEajo6Q0dLFAE5mXW39SNZ55sDWWeT+IPmJLqAGl8weeJezHUj9KAfajLPJ8MmscVrJ6Jyyyy4L7MQ5ePAnQjhj8MfESxxS4JYmKSr28qVivmjsdttttttttvw/L2Bo6P00dHSXsY8HlwrEx0PJ/cDWMTkS+Cjpn4g99Y44rg8sssssssnoRp2lcLqRsLKSDp/CPsjsRtttvT4tttvw+dH2Ian9PAy6UtLQ1HUtJLTjM2vivuo6GhHDDAxxQERPUvhjrfBJJaeWWTfsqqnZ7OUZyquGtzTeCfhn2RodgnRPjOXsw1M/JXFtt9DyfAe2+mPEaRGKX2o04280WGwzyyy5hsPwh7A0BweWeTfWklwA221223sF++N0Jbfcb7eTn84dgnxrL2RqXysZD3gWNHqB9p8IEjgIyiuD4JdK+miMMeBLb4n4I0PYGnk/eb4DVMdpK67db8yhLOVxPzx2CfGsvaPyozkffGoaOiF0Me5E5ZMTz0dHrfB/TxOUpPqb+CPnjVchubtxwGn8g+yNDsA+NDqX20NPR0ekaGl7I4ACsw0Do9CxMccUl9KOKXyAPnDiT9MND78+NTqX2w4vqj0rpHCvhPUuK6GSODf0w4DgscccUvgj6I/QH2R9+fGp1L2j9g30DT4gGKMeLeZlwH2jyEmeCSII94aHYR9kaHnM6PtH6d9LfWOmMsnwSxEOVy8V1tt/TgYYLQ6Ms8ifdXxz9YdH2R50l7Z+2beWWT03piXMMzJvLLJtv6qPEl5Z5P4AHyD9afZHZqXiU+2fvXwbbb+0b+KB2MfZGh2EfcPw2/CB0faPYaX2qSSSWK9tYr5J+uPsjs4+Jj7Z+nXWklisRHAxxSSSSEcTFJJJL6JJaSSSSxxxxETFYmKSSS0kOB+vHyT7I0OwiOsafic9gMHInqbyE88sm22229N8G22222222/Zbem228ssshISyyyJftPsRtv2h2CtSHjA/fNttvT4Ntttttt/WNttttv7N9Q+E2237rbbb+4HE6PjA/bJJJJJJJJJJJJJJJJJJJJLHFJJJJJLHFJJJJJJJJJJJL2kkkklpL7x/HbbbfmxY4YYYYYY444YYY444444444444444444444rHFJJJJJJJJJJJJJJJJfHS9lJcEkkkkkkkkkkkkkksVjjjjjjjiiO2m232Ol4fGh774tttttttttttttttvLLLLLLLLLLLLLLLLLLLJ5ZZPLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLJtttttvLJ5ZZPJtnt5vshJeHXlnnlnnlllllllllk3llk22222222222222222229NttvT+vfBtttttttttttt5ZZNv4z+hHW2/oH2QkvMq9ld9DvZJeIl9AvDj6hwPdzfUkl+W37A0BLR7TfzG+lJJfmEahqQI7Qen85t9KWKX5fiXLtF/RNtvoSxxX5OXvD7NtvsFgt9KSS/JUdDR0fdHvpfTttt/ett9CSxS/JDfsrsNv7ttvpSxxS/KY7Fb+6bb6UsUl4Db4ttt6bbbbb02223pvg3pvg2222222+LbfQ2+D4vT0+p+4/Yenp9Db4Nvi2+D9t/cN9jtv7dtt9KS/azbb6F+Mn4mbbf4xJf2B77bb8ApaSSS0kuteGCfsB4AfhZcEktLpS0l4EOj9iOB/Fa611LvE6P5/XhF/wDdiSX7Hfwkku4F+Zm38BJJdxJfmJt++kkuLfcS/L70/fSSXFt/sN++kl0t90pL8sP3UuC6W+7kl+ZF0t6feCSX5Qfxn3e+tJfkxt+CG+pJL8kN/Hfejb6Ukl+Q2/CDb6kkl+1G31IhJftVt9KWKS/Ia8INvrSSX4+XsPwW231pJL8VvxO231JJL9qNvqSSS/HLfhpv9wN/jNeLW3/9FR+yvFC/cCX/AJTIv/c5/wD/xAA2EAACAgAEBQIGAgIABQUAAAAAAQIRAxAhQRIgMVGAMFAEIkBCUmAyYRNwFCNikNAzcZGw4P/aAAgBAQADPwH/AMxWV5xV5uXlebXm/eVFebl53k4+bl8ljj5uXyWNFebl5WXk15s1neVl5OP+qnzPwprkvKxM4X/qe80LkXhVRWafJr/qXX00868J6yotFl/6m1y08NK/1SxjjlYvQo08K6/1Os3ErkWSFyX5eWMa9JsYxrlrJMTLycfMW2JiFRRWTGPJo1EIWVctZWWXk15iU8k0WWXmhIQimVleV5Vy1lZedeYdZWXnRWdl5VlZZeTXLWVll5NeXTGxjGMkthooaKLLzY0PlorKyxPJoYxjHyLw80/e2xvJdhC7ERERCycRorJMsvJx56yTExMQhCEJCQsrL8tLZxCEhISEhCzTEyxPJxY1lZZZY0VyNjHEcc0IQvLWxsZoOOVMQms2STGMYxrKyyyxxGhrJMsT5UJCzY8n4kXlX7ZqRaEJljiUOLyUsrLHF8tDRZaLEyhorJCYhCEIWV+UT+hlIk9h0OPLRwiaLLFJHCUNFbikiyxSRwlcrWSeVrKnk0PyoczuKug4jXrakWhCE0OL5nHJSyUkdhxZQ4l7ieSkdhx5ayTEKheVWohVkpHYcXyMkyXYl2JEuxJbDWfCJossUiiuVxyTysscXk45KSytFnC+WhoYy/KtxeSkskziHFkpbHciiKIkSIiJFiHEcRxO4nlaOw1y0UcRZYpDi8qKE0IRE18tGhrqxSWVkZCjsJCQoizRFieSYmOI4so4llZY1yskmOs00U8qHEYy/LJsk9iUdiihxYpF58KGNjGMY0NCki8lJHCyhxExPJPlSEhISEsuLxzr9EUmRIojJdCug1k4l9S1lxI3Q4vncWcSztFPJoaEIQhCEhZMb/QGyTHwnDKvDG1lX6Hws2YpLJSR2HF5OLK6iksrRY4PnefynzcjGMYxjH78yT2JvYllFbEUKGEz534ZJrKveXIby00HF8ziV1YpLKzi6Dg8qHEUsrFJDi82N5cK5Lf6NJ7E5bEn1EuqIR2IrYQs+GHCW/C+s7RZeVe7qMiMlmpIcHzUOLFJZWKaHB5uLFIvJSRrkhISEhLK/wBDbJPYk8orYithc9I4sV+GNct5V7u4sUi8lNDi9CuZwYpLUvJTQ49CsnFmzE8kRIoWTG/0FknsN5RWxFbCXooQuFnFiN+Gdcizr3ZxZejE8lJG6HHmaH0ZeSkjdFPKhrJj7jH+gMk9iT2O4kRQl6KEhdxdz+xvcf8AjNfDSuVPKvdmiuopLKxS2GuhJbEuxIk8lErJLcVFv9EbJMk8ktiKEheghCW4kf2PuPuNjLZUfDuyyvdqHET6ieSZEj2IiEhLcSGN/oTGyT2ySIoSFzIQhC7iW+X9j7je4+XXw7vNNZV7s0SW48kLJkmNj/QW9iT2GJEVsJeghCEI/sYxj8Q6yvO8mv3xslLYbEupFEULnQhISF3yfcb3G9x+rp4eVleVikhor92bJy2JMW5FbEVsJcyEISEsv7GNjH9D8vh7WV5qaOw4/uLexOWxN9RbkFsRQudCQkIWTGxsf0nymnh/Reaki9UOP7Y3sTlsTfUiuphx2IR2EudCQkJC75NjY2P6fUrCPlNfD+srysjiIceg4/s0nsYkvtJvqJdTDjsRj0Ql6CEiKF3ybGP6z5j/AJZcMuvh/RReccRF6ocH+wOXQm/tMRncwktUYcftIrYXoIS3IoQyT3Gx+wfMfJZ8pXiFXJaIzQ4Mr9aZiT6RZN9SK/kYcNiK29NLcitxZNje4/ZPmP8AlH/J8RKys0yU0bocf1acukWYs9qPyMOGxGPRcy5YrchHcS3yk9yT3G/aNy4HDJx8RaHEjOOa3IzVocH0/UZPojGn9o/vZhQ2IR6IXoPJIhHcijsSZJ7j9s0NCpmniM4F6MTWhTyhixOF6FfpcpdEY0/tJP8AkzCj1VmHDpFCXO80QW5CO52Jvck9xv3D5c9PEehrcUs+LqcStEoPoV+it7GLPpEm/wCRhR/krMOHSKEhczzS3IR3ILodib3Jvcb3900NctfElxZfUvLuQxY9Bx1iOL/QG9jEn9rJv+RBfyMKH2kVsL0Yow47kI9DsTluSe4/eNPE1rJSydCktSOIrj1J4T1Xvcn0Riy+0m+phx/kYUNiK2ELmeUVuYcdyC6D2Jvck9x++acleJbiJ8kMWNNEoax6DW3ujJPYxZ/aSf8AIhHqYUftIrYS9GMerMOO5FdCTJvck9x/oGnJfiY4srqRmuuakYeKuzJ4W2hXtzJy6RZjS2H9xhRMOGxGIhehCO5hR3FsSZOW4x/omnijRKEupHEj15IzVNCnrAxMJ6x9pb2MWfSDMaXXQj9xgw+0hHpEihejCPVmFEX2k3uTe43v+k6eKcsN9RSWrFJackZr5kYc9Y6GLh9FxIcXqq9ilLojGn9hiP8AkzDj11MKHSKIx6IXOxn9kI9WYUdz8Sb3JS3H+oaeKLi9BrqRxVo+VMwp9Yow5fw0MXD6ak4dYv6pvojFl0gzGl/LQV6y0MGOxhw6RQhc7Hlhx6yMKPTU/FGJL7iUurH+o6+KtEsOXUjiKn1E+nNZhy6xMKXRH4sxDHjsYy+xk11gyXZj7ek+xL8WYj6QZjtf+mzHltRifdIhu2YEfsMJdIIithenhw6yRhR6aj+1GJL7iT3H5WOPQlDSXQw8VdRPmZJEt1lHsQexh/ijC/BGD+CMB/YfD/ifD/iYH4nw/wCJgfiYH4mCvsRhR+xf/Bh/iiHYXYXqJbmFDrJGFH+Oo/tRiz+9kn1Y/LKUHoycersw59dCE+jFyIWS+piurMKHWRhr+JN9NDFl9zJPcflw1uYkOkjEXXUw5fyMKX3EJbi+nRhx6yMKO9kftRiPpoYsusmSe/mCycekmYq+4kv5Ih9yMF7mDL7jD/JEXuIQskIQu5HuQ/JGEvuMFfcYS3MNHZGIzFl9xKW4/Mt9yS3MWPSRjfkY35mN+RjdzF7mN+RjfkYr+4xPyZPuS7j7j/8ACE9eb+y83Wstl5uqKtl+bts4FbL56+lTK8wLFBWzi+u18v7YoRtlvX65ovy+t6Cw1bOLV+tplXma5PQWDG2ccrfrXLUjWmWvmY5ukQwcK5dRzlb6c3f0Vw/3klhtsub8y3N0iHw8Lmf5J3t9BSydV5luTpEMFN4g8aX/AEr6PXzKt0iGHhccup/ll/X0enmU5OkLCjxyP8j06ebtukLD+aQ8V0v481a+Iz7D7EuxLsT/ABJ/iyf4skth9h9h9hj5H2H2H2H2H2H2H2H2JdiXYlXQfYfYY+w+w+w+w+xLsS7Euw+w+w+w+xLsS7EuxLsMl2JdiXYl2JEhjGMZLsS7DQxkhjJdh2MmySJEydE+xNmIjEJp0YnYm42TZiLYl2JEuw8n71Xzs/yOo6LxGWSERRHsQvoYfYwuxgbo+G7Hw258KfCnwskfDGAYGxgdj4cwDAPhz4dHwu58K1Wh8LXVHwndHwndHwvdHwndHwneJ8J3R8J3R8KfCnwrjofD8PzGBHF06Hwx8N2MC3oYH4mB+Jg/iYd6RIfiR/Eg1/Ej2EvtP+k/o/o06DRKxjJMkSJEiRImSY0SJdyRPuTJEia3MR7mItzFqrMWqsxVuYt9TGe5jdzFl1Zi9zFjdMxe5itkyRNkhjGMY/S0yXtOnEz7Y9PN69WacK568KmMYx8zGMYxjGMYxjGMYxjGMYxjGMYxjGMYxjGMYxjGMYx5PN+wvJ5MYxjGMYxjGMYxjGMYxjGMYxjH7bYkuFeFtERCIkRESIhCEIQhCEIQhCEIWSF9MxjGMdDYyTGsmMebHm8n77foV7HxCiqXPXiWxjGMfptFGtlsdUNdBtjicTyY+Sh5vJ+zsf0tPUvVe08R/jjRevjPRfsFnC/pURoixd8n9Fszdez2KCLd/Ryx/wCI4fzKyrwysr33TJxLfo6eu+4xjf0V6MrX2WzhjbL+jeJiUQw42kKcSnTOAt+GFjRRxRsrlRf0rZJol2GmOQxoaHyMftdkmPLUhWpFPQSL+hpixI0OL9k0svTmr1eJig0XlHDw+IeJLwwTRRcctMtM9MqL9dnE83HUUYihoQ+4jOVxFEtia0E2RrQSzrKy0U+avrFw81HDGix5P6XhkLFw9DhdP2OlS+kooSVshhx+V2Txn8z08MaL9DT13kkRN4koqiZxKmOy8qRbEo2XoilqakJLKuRpFv2hvoTJEhjGMaH9FrTPl417DbFGGn01D6RG/DS+fT1tChMpZa0a5a5LcXFoaZOqNebjdDStDXJXPp9eoy1MOiLIiYhUITF9FUiPxHw+o/h8Vrbb2Chv6Whvw2r6SuT5C2U8rGsrNxCrJctDi7RaqQryr9E/wcUZK0z/AIhp9vdaL8Q3yaio1Fw5UKuW0cLFKJrlpTNcqy0zZfo1+gUy489+NuvLGhbFZvJlZqijbK4GpWd5UWyuSyuesr/QdPHC+XjZpoSJYe2TGNeg8ryos4tDS0NFGuWvLwnFy6c15PlXK/pkIX1eniRp7ZZwMe4r1IzifOJIgyO3LpyalCrKhrVDrUT5bLOF+hp7Y/JGXctjqxpjyvKi+T5hcJXoVnwl5cTHVnCVzr2VCWS8YK9wrKi46mudZWa8ldTTRl82nocErIuIva6zvxgtlIt+53m/SrN170uVC8W9fcry0KzVGvqIXCV7wy/GCl7lRfPfJRfO/d75795lPohx6+EVL2fT1Hz3+lv3axtptEcOPQeI9ES3RweD+pp7lqKhXzOJf6ChCEIWSEIXukpvQUf5kUtEJPUSn/Qmqy4ZeI9+hpm6/SaK52NDfubm+mhCOwoxIxjS6jxHqUxVwyf/ALEFH5XbHKVvw50K9qVC/crZGKohhK7JYjqOiG8kkPbw70ov2auW/daF75wnCiWI9X402Ma83lfviF5SMb94f/eGo0/7/rGPyWXqL3hZqjUVdBV0F5KIXpoQvdUIQhCFZGuohf8A3pWnnBp5wV/+/wD/AP8ANGP/xAAlEAEBAQACAgMBAQEBAQEBAQABABEQIDBAITFBUFFgYXBxkYH/2gAIAQEAAT8QiyCCCIEEEEEEEHJ331znY43xHGcEeBlllll/+RjDDDDEGGPQPVPTPGR6h5T+QekemcHQ908xBBBBECCyCyDqdz0d6njPRDjOHgzP/wAmGGGGGGGGPQO5wdz0DwnunJ6R5T0M9s/tnQIIIIILILPIeDeTsegdToeI6PBn/wCUjDDDDDDD6/77B6Z/AOpwec856B4Dy/n9UIIILLOh0PLvffKds8JHY5zozwZ/+UnAwwwwww2++e0dzg9Hf6R6h/DP4eQWWWdDk6b123jbe2+MPAd84OTzskz/APLBhhhhhhh9M8p2P4Zwegf8OeLPN+9d9/PNtttvO+c5yODvnTOh2/fMkkkkn/y0YYYYgww+ye4eyeqdz+Ye6cHuHob23kfTyILII7B0zsdjqdTskkkkkn/y7YYYYYYYjseE851PQ+u5yf1PzsRPB0Ox5DwHc/vbxvTbfMcBZZZZyHXO5fkcZ65yySSSSf8Ay8YYYYgww+X/AM5PfPEeI8J2PRP+AP5p4Ntt43jfPnOQQc5HQ5zgjuekeXJJjEks/wDlwwwwwwww+Y9XfW/f4p5D2TynJ/A/PbOTk52PPkRHByRzkcZxkclnkz2yLLJjGMT/AOXjDDDDDDD6B5z/AKA/lHuZ6J4znLLLIs6Z0PMdz3SLJJ4LGJ/8wGGGGGGGPdOT0z+ieidD0jsef49Q986EHJwHOR6J/HPAMMPDJacDGJ/8vGGGGGIMPQ6nb89A9V/lHqHc/nHjP4BxnBxnGd8s8B4T2Tg9Fthhh4zZjXiMT/5gQwwwwww+Q/knJ4D0j0jqen+eI/4Q6HOWdM4zzniPTPZZtighizZjwV4E/wDmOwwxBhht/wCRPJ+e6e6e+ewc5FnGcnnO5x+dD0N9dngcjgPYbfyzb5ProoxP/mIwwwxBhh8v5ydjwHqPlOT0T1Dk8pwcfnrHpn8nOTxZ5j+McHhZmYeTCGHZJ4Dx8JP/AJiQwwwwwww+geE986nkPTOTk8x5N9s9E908H74T2T2CPQSZmHh/14B2GySehxP/AJmMMMMMMMeA8J4j1PzznR7nnPaP4J6x/UPAf0WSSeBjmpr7h4SeCPAln/zMYYhBhh8R65/A++D0z+If1TseP8907fvhOD1M8h1OGSSSeBsOjg33Js9CqiT/AOaDDEIMMPo/XQ651PGeY8e+udj+acHY77/RPAdTynJ7B2PIkkkzwQ9PFFmz0ftT/wCabDDDEINvjI4PI/3jpnrnpn8Yj0/3g4I5O52PKcEfzWSSSTodDahg2d9b1RP/AMzLYYhCDDD/ABD+Ae99ev8AnJ655Tqf0v8A88h4Tg8x4zucsySTyQ8vnaSIk7Lxn/zUYYYhBh32zocH16x5P3p+eie0eI4P7X76B5jueofwEkkk6j0H3Imk9npT/wCbDDEIQYfOdz2TodPz0TxHd52222G22H3zg9Y9M8G/0TwnnPRZJJJOo5C2zeTNRZs7j6Vp4D/nj/kRhiEIMPqn/BNttvQbbDDDEf8AAHc4PAfzzwn8FJJJLOpC2fMlDZOuhWdhZ/8ANxhiEINvjODexydT3j0DwHRlllttt4bDDHXbYf4r3/OT+ERweD69g8ex7G+VmSSSzsPVXHY+SdfnD99jYSf/ADkYYhFDHJ5Tg9Y9PeD0zlmWWW222GGIhtttthhh5P8Alt6niOx/U3okkklnYbPkP92Bj5nXTYz/APORhhiEIPgPEeA9M9c7HJ0eGSexDDDbLLLDDDD4PzynJEeM5PRPF8eA850PYO/+9d9LfSSZJO4thYX6bwgxOjh++GM//O9hhhiDD4D0/v8AjHkOWeDPUhhttllthhhjg9M/r/v807HP7/A3h4Zks8I50n1j5LS1nnGT/wCDn9UYYhCjDx+ekfwTg8p1OrMpexDDDbbLwRER7p5z+EeQ7HhP4x7DPCeAZxsbHLeEfqBtr7fiUZx/89GGIQgx6x4Tg4/f4hy8MpZ7nG9TgRHB6pyeT87HJ5z3jwHkOT2j1d6vD4hnLH9votZjJfyJ/L/xk1hKbsn/AM8IYYhCDHrHrnnPMsssvQ6nUIiI/kvlP4h/FPRJ8r3fOMIsf2xjQgT7gJGkbvxL8oTpkyz/AOejDHIB4/PAeM/pspS9SODqRwIiPTPUPOeQ7nkPGd8j1y/fSPI+uQpKNjl/7w4spCIn8tBwtn4lPuT/AOfDDEIQY/gffgODyHmZZS+YiIYYY8R5D+Ge8fxzw75d6PZ9ghmLFvp+YXJjZT6jEKJku0JG6Sf9Yf8AJjDEIMPjP6J3eCzPlIhhhhh9Q8h0Oxwf0zyHr/Vn9UZRsf2xT5vr1gPwwCRo/EIfi+1CZdJE/P8A6AMcAhB6kejvU5OM7HJ67yM+UjjYYYYYfGec4fRPP+R6ZydDr8+I856R1/P5g5KMo2eCxk+ZiQJGn1CFyZfiwZP/AJ/sMQ4Awx4DqelttttttsPhPHtttssvB8hHLbDDDDD6x0I4OX+qfwiO57+eudBkP2QSQT5iJrGkBI0Yi/Ei4Tp2z/6AMMQpBjwHJ5ttkSZrHqIUUhShgW2+A6rLw+nBZZ8hEcPBEREeE/hnlOD1zwHgzseDOp/Jyz2icZBLLPm1AWMfDPzGIw/EpqEqiSf/ACvOM5z0RhiFNQx0Ox4f3jZQmsbu1ttttttththiDhxCFKMPgZlltttl6HhI4epER7J7J2PUO5Z/DJ99/iCk6PmwwW2D5jPww6RCMPxG6hOOkmf/ACfIb+Q35DhS7VqQln5Y+iMMU4gnoHKyZqpbfQ2GIOHFIFhLeDhmZJ85HYIIIiOToekesec9I/jPlP65wM36sXFtARhQFhH3IRiH1GPxKmEmdj/4+GuS3/UiD6svyS/I5gS35E/l/iTH5LPv0RjEUpB5PItjKy2+vsMMIikIcW2zMz5SI6kEEEERye8cnpHY/vHlP6pDKtGVBtp+31iwnwwJARy32xU//Iy0ESDkISQmEfLO5vw/JzAWSFPqx/JH6Qw8JCD3OqA4mb7uwwxDnLLwvlIjh4IiIiOD3z1zg9E6HY5P7B4X03h9EZCVHzY4LP8AqH7rBDTfI2En/wAjWagwhY/hk7NHZmQDIFiXHjASFGMWft9MYhSjsPgWxtZf4ew2222+Yjh5IiOCI8B6hycnqZ7J/FPOdj+sQy/qUMWb62Nk9t9eVT/5AJ+iG/IbKfMWBsH9WKBGI0nW0m4wBDqBWfUGGOCU1HJwtnaW8n8Ut8pETPBERERHuB4zk6HpHqHQ8h4vzk4PCcfvsnp57AwiREafc6ImI23Gif8AxgLOpEpsog59X7hJuTr5Yj9jftgsQiaQjIbcfmReuQxDiDyuca7/AD98JHLwRERHBHQ947nQjxn8k5P4RZ4zueR756pDkhFNft8p+bTgZn/wgJPxJPq/OlH2dcs4Bb6kmfkQ+pV0k5LV/kXwLCSSIPxIOhFoZC/2H/tr/Zf+yn9lZH9ls+yMPKjst+cu/wBggiegQRHBEdD+t++wfwSP+RGQhxSbJ8cDE/8AgxAV+RAPqd9J9IStEhw35K/Gb+Ss4EYBmZuWT8lH1AjhK1CQXTkcZUWP7APuEP3AH4hRQmXCCONra2trb7wy4fhZd/skdQggjk4Oh5j+OeB9z/fEdw8mdTz/AL/ZGF4CDJO/yXkhJ/8ABkEwWESRCX4hWhf7kB+RPyBfUc+ieMBMthG5rCIEgD8SmoSt0s4GYfuVEaHzCYRAj8Sm4SvEs/hEMv8Aa2GG2HsRHk3g5Oh/OP5JwcHrnjOT+qQxSDHWFONBcJD/AL7LLLLOD4ZGWSaxk+YAhfySfkjbkOiE/b/1v9VoYwyKX4FjJaCP8Qu4Tr8Sh5EM6lP2Ml8CMMLqE7J/BP7+wwwwxEcHB4z1TzHQ/hnUj+Odj/gSGIM/kkOQUiSxZx/7sTDfRfnM38ZP5f5kj+W5PzmV+JGdGseNYRoz8jKjHVJZGU+2U8jKpkawOCxH7jF+JKahKfUl+RxDSR8tZ83xkKOzhhH+Af0j0BhiKGGI9U8JweY9o/gnJ5D+m8574wuLDIWwYLYL8Wayf9sC/RNfBfnMzikL7g/wgn0gvy/8yUkj8T/wi+cJZwkX50lf3fgsb9zgiLpF8oTj8SPVJIpj4WEPmCcIr8JX5H+UL8jfOcpDfsf+3yrU/wDSjEICGHyHB4j0zs9D2z3M9rP470zrnrjwY/tikefchjePL8kz/ryB/wAkecAiAwgUij4j8lo7l+8Qv2N+2P8AYn9v1IWAQOZfahKtJH4ZzBYSfJCIRFr4kXCVIllkN+i/AlF9PNYs59sf+yv21/S/9JoT9v8A3n/2d/Z39lv7Lv8A04xClEjznoHJx+RydDznsHB5mODk9E8R1D0M8WfySWWFhawMDa/k8p+WZ/1iPC/DlfkpoJV0kyWDGAYRkB+X1gRSRbsv9ZH7f+0D9kPu/NYCfNpDP1EVCRZLI5saAsLAF+DGqhOQoIn5BPqx/kYuWhcYD9iNz/tLlv7Lf2Vb/HP+FGGKU1bye5+9D+Sex+9z2t4OM6nvnd4z1hSy4dCHYDfFYH1OpM/6TLLOhMDtkWL4CMTIi4T78SKdhFlgsAYwiRnGAqEu+JEUeRlfwyoLGQWDYjhr8TNQkfmSuZrI/b9aX/ZH/lh/yTh/sI+7bQbQy9N/7MYeEoxwf8Qe4dz0j0c75488r4M9QZTpyhI0g/CUkFM/48hv0Th9Sj784VwvrC+0h9ZNukmdNWzIFjQsQ+GAOyL4lShO8TJXRneMMawiIYzj4nShOsToInT5t8FhfhkGFrLUJ8khl+5C/Zf1t/7Lz7lf2Z/ZH9lf23+6f3dhh8IjH/EnrHjPaP5L7xiy/eVCllIXc4XFs/4wa5flX7iTW4hKolnXLOMs6YzsU0LHoEgzCdYTrCQUeiDsofMLgsIIziSjSz1EgEkXxInzHgYL8MgkA6SionEToOSs+ZzBYH5bL9k9TS5P22wwrVq1t/mH/JjDF1h8B6Z1Ox6JEeMjg8B5jodHk9I4P6OWdc9gZxsf20Pu0J+Y041H6kT/AItYVsYMnosIdEvuRKhJLIT+S/ovzGf+o/Sf+UA2fqLW0ln2WhmYLEhYjZDGvxM1CdonQcmBGxwWF+GwkZdIgoTrS1JQ+b6xYA7aJCwkGkJGEno60v1Zb9lfs+tf/hIw8IP7D4Dk8h4Tk6/nlP5RHtnQ9U6nQ9XPYLDl94+YXhYkLP8AiSBI2mCxrG+4lEhChLzGRIr8iE+S/GID8LL8OBx+iZul+KTtQt5CYdJU+ZUBQMokFfeiZROgyP4ZmCxg1IRowCEUJ05In3KxGdAsC+ZQ+5I62m5HOobW3/nz+YQ2HCOn8s9s5HxH8A6H9XPeIclL6IWEYGFvvnJP+JJkRlQgl8wiQ62V1L64Qt+/fvF+Nh/2Pzs79v2Yv7gMC6RihKuF8IZcCwB8wiQl0j0hLuEsfkkbGBvxESfcobEwjsm0hbOEXw36ksZsj9n+7Lr/AFz/AJ0h4x3semeQ7HU9Y/jno/XnPPnrZ7I5MWf7aH3AfqQYn841JR/woL9X0BfL6iNVKWJOtGPfMKCxHS+OFZIKgy/3L/bb9v8A2gv2/TswWBGwRsRJR8StCc4fMCCwOjIJDukL9cA4774vwpSBGfdroNuZ421a2/2sfMf8cQ2MD7R3P5Z5c5Oc98/sZZ6gyEh+2v7ChYJC/kLs5uE8T/giBjZRwvzCUGJWolUSHJMxiAKHYb6RIJsroTgSeN4GQ/YR82FGjbDErlvQpfo3xCyvtkn3C/tr/kmfZY/pDfZG+mX8ZX7foSv7L/XLLILIIT+X1w34MFL+Fof4n/nBsrb0j+Seh+dj2Xk6nl+I8h5s9/PTHJh4RQ+ZCWH8grM0JWyJ/aDYb9Es+yzoSGjE4kIRvhnQl9iJkJfUIRnwKNY26QMJGVCSCSdS78QGLP4liFszXBCkL9gfsH9j/Wf95H7I/Zb9lv7a2/1jjIITDfl9Cp3NyPshPuwp9OSTh9QLH+z/AMUemNlaHpHnPQ+/4h5M8x/FPLnovtDKfs5+wv7CyHJREihKmUbP6xI4HBD+wCRKhJM6EoIz4IPYw7CUSMKJ5pIjO9GdBfiNPmAkQxJlhKviUOZAw30X40iikIAQ4QAqx4g2p2223+yWWQQ36L6VWLjshFhQZAfgSP5ISktqTYZ/54bFh098908x5Tk/tZ5c9XPXHJVFFFGIP4nNclUn9UhWxrMgZ8Qo7OkJx8Shd6utGJCwL5gJAGMk+JxhKPuFPkY98xgLENGQSbfE+kn/AGF+X48fkkH3BPzaaDK35l3/AIAIb+X5TfurB0iPu+1hpggXwSCElbFiYRYQH5M/8ieYcvxh3/hP3xnYjwHlODn48Z4T2T+gMy+7BLU+4L+wjCHS+7CVyiz+og6X3KLBYRoyaTTSdInaJ1FI5jCBfMZ0ZNnAhMKJ0iQ5CkYHEhdHZP7Kg/S/cIH0w/jK/b9CW/bb4T2j2cghv5K+i+lV90Q/pZmi+lF9IQD8iPqLuVZFk/2UJL9I37Cwfy/94Zn2T/h1aHuHc9I9I9c8x2P6ucZ6Oepsg/cuLTNY39hT7lELvxKL8TKz+oORZGHCQojfc6EvvCRxLLOCJMxZmRi3hkJYaErDwrEY0Fls/wCmbsX+y37Lf219097IITI+i+hV9lP1F9kQvwF+VBsGRaFpGfcEnCQ/b7Zg78IX1A+Yo5EJX7nqZ/mH9ZYw788HB7B5j3zseDOh4jucHhfGeQ9z55fG+qcDkn6sc+YH9gtgkK32oTuT+oM7ozoFDkS3YwiR6k3sTH2j/ZK/G+8If2x0IgyQfbHuiegdhZORbW3+5lkJ/L6Qb6Ub8Zl/Sxtn4pfnQVkCwmfiAMQRv2F9pHPwtbGL8ityP2fuSv2YyYZ/5fNnzn/JqXgOT3TsR6Q+0dvzjfIdzqec/knbPXJScS1z5gT7h2IOwBQkb8Sjln9MkWk2fMaCh/hgM/klfZf+SC/IH6J/cWv8L6RnaDfZs7+y7757wWQMr6L64bF+Uv6X2xfkkd8EEfBIWMN/J/2BBWiSPuB+kJhjkL8ZXci9n2Ud+sp/ZVt4O6kfvg/9ES+Yf4Z651PC++eM8Z/EPWzpnlPCI+px+4vjWAHzLSQR2RTGoSrEs/qDfWN+ih/bxFtFfiv3L7dZX7KbfdPfCBhLfVKX+0/FLC0hD4X1YQQ+CAI+YT+QmKE+5TIf5G/SF+xvpvtyI3GT+zv1kfsplW9SP7fZ/pD+kSnp5Q9Q4Or7p4DudM9rOTgs6ngP4WeI82emOT/qcTWEET+wkJ+rXUJF+JEf6wwv9tf7a/23/tq23+UePO2QoT+T3wMsfKxlLExfi31oEB+ThGyMNv8ASAWiGX6F+9fin+Lfimkz7aI/Zb+2m23wfaGbvl/0gifi/f4R2PCeI9E8zEcnB5Tscn8jP5RIP3OoENYQYw7ADEkGE6oTJEs/6Es5PDnGcEDCb64ZQxX2RkLGY+z68QD4IDhT9QmB+wUY/SH+37xa3zCfsv5F/t+tP/ZX7LfttbfKNhk+Q8H/AKMlEeueI/in/wANFlX3IILCD5jfpiz5vrnzOaiQRJE/6EsssssssssssggYT+X1SsXFYmIWQ2fQhA/AEoHxN1YFihCcfd/jX7RH/YX7L+Mv9v1r96R+y39t9Ek2wpIJpkcn/ig2OQmdzzEpaR0Op5DyHkPZOp5zwHQ6nJ2P7+fwRlH4lQbAAWFPhsL4ZIihPukh9n/PhBBMCzhllqHDfye+E317slnylN+l9AL8wShJl2rBthaPuf0X3SX0zC+o/wCN+lfpN+5Lfsttt9QaIJP+xwqfd8F8Q+XJ/wCIIawZZw5MnqHB6ec8B4z2TueQ5zseidz2Dueiepnjz2CHJWX5LCPux/YRiSrCXUTCJJ/zYQQQRqXDhwob+X1rb6NWUxLb9KYL4I+oSCSX+ErKr82yh9yX2375fqRtyK7jfvS/1lfsp/ZVtt9choP/AGPOfkPtfkj+wN1P3Of8OcThZQ8J6ZF9PRPGdjy765yeucHhOu+icn8DPVPfGb9WoFhP3f4yibYJD5syM+ESRF0/5Yggggiaw5X8ghG306vsDOPktW+pF9CLKcIyxly1llkt1tNxGfZA3GV9M5PtmV+y39lW232yGmPxB9kF3+fUuvn4ji8H/iRwzESSekRfXudz3DqeoeT88B5N4OHg5zwHtnd5+/TfAcPg/PcESv7jQFhTRvrFs/ObOsDZchOnSz/kwggiD/ydZX0LKBDGblsFwN9ICz/liQISI+uBX9lv7wg+209EP9IP0yu436d90pX7Lf21tt433SA/MvsH8nqQ0fv/APbOcRP/ABI4Z4Ikk9EjiegeA/gHTfOfwN8S+kR0PQOT+HnsDK/hs8FhIjYYWSkkEJfkJBEyT/jgsgiEHO/l9zL7hT9lflYv4CCWHOhE/eBV+5VHZZutqKISHORfxvq59yr9yWytv8U4sUcT7JmH4fyLEcNsbwf+IImeGIbb7k9Aj3h2PRPY/f4BwR6Z2PbPLniz+G6+JwNhQvzLhp9W5M0+kyGbbEFE/wCLyCCGw2dxW/VhMxj/AGzA4JC+ggDjBJJJ+zdMqd+9vsm+0Fr4zuk/fvtkzv2W/srbb/HJ5FuD/Iu58bajXeRP+HL7cLPJx+xM+gf2R4jsdjjfGdn1Tw7/AADyPs52zznQhlhGMCzrKFCD8vxOhAZWRK0Sz/hgghMN/L7ff/wvrEWYxksCgBfTAQBCFgkn7Jl/Lb9tX7vr9kj5SNdNqBPzmzk19d94y39lbbf5ZA0N8j7mTf8ALT9of9mST/hji/U8MxyPD5iI9YfwT+ccnonsHgPLnt574yv4YMGAnzCn1KfsBwRsE61SrEss/vhZBCfyXwS2ZrZqsshgXhL6MCESCEm/+ku0jWA/WPVm9pt3V+E+tn2rmnUy39lP7LLb3PCe8XyzNPgw0yfhHB8kkyWf8IXwJ4yeCJi2fOR52+A989043wHgOT1s8Jyewfx89kU+oF8xkEQg0eC+hfIpphpJhEZmWWf1Tgsgghv5L4JsLIyWZTADBfVgjH1JJB+2eBTKYFg/rfIqF9iL4yJ9TXn26k/bLf2W/vBbbZf6BLBAYJb2PxsSzSbJJ/4QOGJ5ETwT5jg6D+B+eseM949U9c978919kZURlMFhiX6WAM4Q2UBkckKNlln9PLIGG/RI4jYuKyG/MTMw314LR9YQpH+ySpT+22NSB9sj1BfezUIr4m+Vf5bI/ZT9tq2222G223+iXwEIMmv7HSGv/IY+SeEn/giJiCZ4IZ9Ejxh/eL/eT1j0DwfvQ9c9A8OWf1hDoyHyxBrGhn1L4jEmQm0R2Poolklkn8zLIIX+Q0vgm+pnzUyp9aIvAFv1ZJIJWU/sp/YTOsZ+t9AR/wBLUDaWWrrmdVKfbLf2Vtttht53+qSh8Pm+5+rFlmKTn54Z/knkzsdzoL6TEdHzERF9I8Byfzfzg7nQ/jHtnjOT3M8Oei+0MKRjQKIZqQl8WoJo2gAhdflHTpk4ksss8JycZ3PHnGcZZBAw2Gfgvu1fI/G+0r7Q2xsMR8AWMh+8KyPFV8tgfbCakgfjUD4N9c32ik/st+yv9tt/4FQYtkv0llonxM8Z/SC+pfIRyI4sQcr6Y4cH9c9Q4O2eMjg6Hc9A4Pd/e55ny56OesMr0YFAHw2FJYlhPiUCS/KWdDZOSz8mJZ72WWQQob+Xxwn/APDhZ8wSfcUhsGwI+oBJQ5fjP/s5/ZTasC2GKsBoxqbt9QW7mL7V32ylv2yttvG/1zyKDDLLfiQSP6St4Th/nkEvmI4OH5xYjjfUfTxn8A9A4ODsekeE7Hh+uTqeA9U8hyeTPBnkzjOM657ZJGJZCRRpW2JkajGfAI26l1WBMOpT8mJJZxlllllllllllllllnGQWWWWQRBwn8kAdf8AwvrkWQ4WY7m/APAIB9Ek4Fyn7f8AvPwlvot/tyD9n16QqGoPoWvk+2TL+2W/bbb/AMUsYdiQUw5O/cw/Yb84eE/mhfUvnI4CCfqV+xwvpnE+rf6p2/P4b6J5s6nrHtZ7WeycEOQpWS4KIobJIGJITE2+XZab8tuozIIT/wDSUTMsgsjoGWWcmWWWWNkTUNhymI//AIWaJ2yfgYR+WYTW9BBnwBfCR+TqVMTF+fMj8l7J8rCuBa4iL8gEg4iedWV+y39ttt/436ochtZtn5kPknH1Dby/ywgvgl9AjgQXwJRw+kcEed7HjOpyeie2cEeQ4OTzHU674yznOzHP52Oxn75TwP8AKfSIZ1pAshJcguqSSLbb4iDE2JQmXXCF1gH03+pvu6fjB/8A8sPv/wDlYfaLf+NqODXFf+Tm3I+k/wD+Qn0n/wDl9qf/APLXEfaGIyPsOvyzfSn/APC+oFhYsEv8ty20tJO/E6/sgarkPpMh3cR8YWvs11T/APrI+20/tttv909Mj4YfiGEmCeMsH4ht/mBHxLb6JwR4cxw+mR7E9c6noHU9Q7fngPMeXY8J5Tg/p53z0yGMS+pMlRNhPDsB+GRJY241wd9T9KEn0WM+TYF9z9xhPv8A/hL/AH//ABtzG09xMSD9sIp+oP7h9KhcP/4oB0//AIWH0YMzFl9BYXxYcFW2222+Zn7gITYO4o3TC3tCV1H/APWW/ZTbb/y704IYd4+rZkvqH+Scbb6IWcnAnMcPonJCO5/zh7P34Tg7nU7/AJ/yQwyn0wBQs8wQOPUJoNt9Wj9ki/ZFbQGKGCWE/EGzYsWLEiwOBDcqVLtf7Kl3jJz/AGE0C1cLdPlbBmfY0jqmVustl23/AJonjNuQsKPgmcsyWJ/IDwHkCyeCIllweqcPp59t/wCJz+IeyeiX36ZwfzTk4GGGft9cpMVvgcz4ifRi+mLCvpsFtfjahSC2kzJyOjKJb92WwiFk4+CH9oWrhfXwTSdIRFVlqqmW/sq223/nSL7njYeVmZmP7BBBw2xBwpY4fUIxydjk6n/EZ6RHiPSOh1ODk/ifXrPkyzxnQ67DDDIZ+w/pZzQX69v3CbwEFMEj6/8A6ROgZ/0J/wByG+ktP94v/aS/SL9iH9mR+4+9F+Avp9X0BfbxBoapbVsr9lv7Kttt/wCMzuWdcs4DjLLOMiTgthhmeH+0EHDLwETL0fSODzd6H8Y7fvgPMe0R1PG/yDodR5PYz+MddthhhhkOQi/SP/y+qd8Ak0f2UD9R9Vbv+y/1b7lSPukfuV9qV/Ut+y39lyrbbbf+APOd84OA5yyznI6/LJyR0f5p5CDhngjhZgsn0zg8g+uDwb5R4PAdDsdjodjscno/nmPSPCen9el++d7n8F9TYYYYYUO30GuGrbbbbbbbf+MPROM4Czgs4znLLIkngjh43+TnlLII5ZiDjfibILLLLLLLLLLPEcEI8RwesdD2/mI9U4Oh2O54/wA/knJ2P+OO2222222222229d/4M8R4s5yDplkFnOcZZZZZZ0STnYf7AcBwRzlkHGWWWWWWWWWWcjyMs7kcDuR4zyHk/ep/KOx4SPGeT87ngPZOzHQ6MeQ4f6Z13ned/wCLO2ds6FnTODjOMs4yCyyzjOCyLLLOE0kz2D38sss4yyILIhCHPKeH+ZZZZ2C1OhEcnsbHhPAfwzqfwj+J/wDn9E4yzs/94dznODnILIss4zpkWcBxkFllnOWc5yJM/rZwFkEFkEEFkFkEFkFkFllllljhjwhzHc5nFnAjseQ67/MPEeicHQ67yec854Tyni/fLkebPez/AKkOcjnOMsssjgLLOSyyyzjLOAsssgggss4yzjI8GnySZ/SyyCCCCyCCDgjgththtt4bDCW2xxlnxZZBEBJmtSSYzIjwkfwT1j0TscnU4zudTodT1Tk9M6nJ4z2D/vDrnU5znLLOMss65ZZZxnOWQcBwefSTP55BBBBZBBHXYbbewR8S7ilKUhNhiIsskkmMSSSzk9k8hwfyTxHc9A5I5/OT+EeE5O56p7B2z/njwZ4s4yzgLI4yCyyyyCyCyyCyyzrnXPIDJj/MCCCCCyzrttttttttttttttsNtttsQhSlIQhB5ZJJLLJJOTwnY4PePWPSP4B6Xz/DP4R42zh4f+qznOcss4yCCCyzjLILLOAssssssss4yyCz00Gw/kEEEEEHOeEs4222222222G223ptsMQhSlKfC3jJJJOU4OTsH8H86nQ8p5Tg4Ox4TwHJ4zqdzw52PUODwfXqH/cnAdiyyyOA4yOToFlllllnGQWQcZZzkWcnhfK/N+pJ/GCCIg8W2wQTMtttttttttttttttvI22wxBRSk3eWSSec4I8ZwcHnODxHsHonH54zudTyHJ7J2PPvqHjzseLPA/8geXOh3zjLLIIIggssgsgggjnI5zjIs9tDJjP8AiCCDgOA67bbbbbHzBZMsvG287xtttttsNttsMNvGwwxClJvDMklnQh4I9Q7b6h1Of/AHyngOp3PMewR5yPIcHo5znU/jBZ/wAxnOcZZFlkcZHGcZBZBwEFkEFlllkHGcZxnOdD3EGws94ggg4CyOm2222228EMMPAvoDENsNvG8jDDEITbeGTqcHuk+wdN9c8RyR4jpnl+OD0Pv2j+Tn/PHGcZ0zg6ZxnOWQWQWWQQWWQQcZBZzkdc8h5Hys6kz3CCCCI67bbLbb2GGZvr7DDbbxsMMMNsNsyddhh9nep/O3ocHU5PZPKeF5fdOT+Lnd6n/FFnOcBFlllnIWQc5xllnAcBZZxlnAcZZByeQ8L7SDP+ZPZCCCIs6bbbbb4t9o42I6DDDDDbw9hjk949I7HJ5w9/68BzkfwzscH8fP8Ang5OM6ZxnGcHIcZZBBZZFnGcZyHJwFnfOD+F+90mJ6xBBZHXbZbeSz+HsPAx1GGGG23qcDD6J4z2DxngPFnmPUO50PKeA851PKfyc/oHmO+cZ4AssiD45yLLILLOAss4OMs6ZZH9Y5Sf8SemQQR122223ggg4Z8O+4RznIwww29TgYY8R0OD3zy/npHgOh5zsdz+EeA6HnP98R/Dz+rlnXO4cZZFkFkFnAWWQWWc5znGcZ0zgLI4PKfzsmJ6BBBHTbZbegQQcPJZZ/BPCRDD2GGIeTyH9n78B7Z7x4jk9HPdzy5/wYcZwFlllkWcZZFllkc5xlkFlkHGWWRznXI4z1vvqeB/gISEnlCCDrstsvIQQQcM8BBw/wAA4I65xnGxDD1GGGGPTPTPAeT9/g74Tqeh+eM8h4/zg4P7Oejn8ws6llkHAWc5ZZxlkFllnTLLOMs6Z/IfA+B4fKssCz4iCCI6LbL0CITJlmyCzh/gEdDtlnUeowwww8Hc9M945Ox7BwfxjxnQ9k7Hc8D5M75/OznOpZ1yzpnAWcZHJxkEEEclllkFkdc4zrnmPAeI4PIeyt9y/bY0TwEmdhWQRwcrLw8hwBZPxLwETOFm3+CdTrk8nA9Rhhhj56H8Z5OTscnJ2OxwekR4TueA9Q4PGeLPaI/m54s8Wds5ztnkCCyyyyyCznLIILOM4OgdMsjg4OTg5Op/YbFv2bAh1mC3J+eo+YDJ1JkdFl6hwBBLLfcEFnC2y/xTg7pJ0OHkYhjsdT0zyfvob3Od9w8Z4TznQjzHU6ncPEcZ/BzrnOdc7Z3yzwZZzllnBZZ3zpllnAc5wWc5BZZZznBZZEcHJZ5TxHqnX/ffBXAgBT7iPlv/AMyz9mL6g3gnAWQZL/bQFl1jlZeoRAvqUvAQcPxLLL/HPCnQjqMQw9zucHc8R5A8RyeY83z1OT0f3g7HQ8Z4DtnQjyH9nOudMss5zpngzgLOM4yDnOmWWWc5ZBZZxlllkFkFlnGQc5wdjg7HmOh0Y7HiPM9nu9iEuBsgnR/gfUjofV+/Mt92yNgSlgg6a9Fl6hsr9EM+yPjgW+4QcLLMv8I6HY7JZ2eCGGGHeDwH8U8x2PUODk755Tg8v54zjPEcnJ6B4TwnH++o850zs85ZzlnGWWWWWc52CyyLOcs4yCyyyCyyCzpllkWWWcZ1DtnqH8XPA+ogAQfvTPX4P8n5mG5Lxtp8s4PjkCCPmzh6LPUI/MADSTOGRWkt9wgslllt/hHQiI8Ocp0JJOBhhhjoR6Z4TwHvHh/Oh4jqeA988B755DyPrZxnGWWc5ZZZZZZZxllllllnOcZZxlnGWcZZwRzkFnQPBnGWdM5D3s/hvoE6Av1dI9fr/JQvyJY+eEflL4C2smCPmDh6r1CCL/aWvxM4BBEspZeH+AdTqeDOEk5Ik+J4GGGUPkf4p2OTscnuHlOTync8p0OTy5weicvuZ585yznLLLILLLOM4zjLLILLOMs4znLLLILOQssg7nQjy54jpnU9A7nB7uT4F+qJ9vp+Fla7ksEW/wAssJmCWInb4kkxyvJwEEW8BHGR6wQcLLM2/wAI7nJ5EiONmeBhhjueT85/3k9I7Z6BweA6nob6Z6RycHAcHffT/wD3wD/FzjLOM6Z4csssssssssss4yyyyzjOMsg4yCyyCCyyyyOM4yzrkcHGeA9R5J7HrnpZ4iQgX6klSnx/kHEsF9w/bAHxPZt5GuFj8iwsE/ccL0IIONl4INggI5fCWWWf5B0OTw5JZjDbwzyMMMdD+Ee0x5jzHYjxfvQ4PXPF9egeI9A8LZxnJZ1LOc65Z4M5yyyyyznLLLLLLOMsg4yDnLLLLILII5zxB3OTqeA6fPbOocl8+U9Uny5CgQjJZU+I/C/M4F2Dg/tkHwS+JZd5IDxpfMTE0PqeI5ehBBxtvBBESxl8yyz/ABTwnlS+urwMMMPr/nmPH+ekdT1TxnhP4x/Izk8GWWWWWdc4zxZZxnGWc5Z0yzplkWQRxlllllnGWdznOMg8h0PGeQ7HiDqeg+A82MNnRn/j/wBnXx/gvz4F2I1cIDUSh9Wc7t3khrZ/4g/V9YGRMP8AeV5CHK2xEERyLsv8M6HQ5Op4ckk8Awww9z3jtvBHoHY8x/JPCeI5OTofxS/PCeDODjPFnlzwZZZznGWWcZ0yyOTjOM7Zyer+ehnr/PgPC+Y+Gzs9clZ/H4OSXYgVyENZQ41vUhrYEhbpfhl1WZ5CDlcl4CDnbbf4B4TxHjyZJ8Ayhjodz0jznU9A5Ov73PXPTPMcPhPOc/fc9o65ZZ0ec4eM8eWdA4zjLOc6ZZznGc51zk8mcn8A5O55Tx53/Xzmg1Yufmc/nwBZ/XHqwQa4WPy2XEt9wdfg7Yk/C04PIQcrPzBBBbxvR/inJ0PQOEkkk6vAwww8npHpHtHrnQ7noHB1PMdD1Doec8B4zjLO5xnOd/2zx5znTOM6hxng++2eL8Y6ZHmzoeN8m+2eipBq26jH5IyGD6sfgt51ggVwsPlkBxK+4M6ksjgn54eAg42XgIILbZbY43+YRyRydDg4OjMk8PUYZQ/HtHiY8RxnU5/Ox1Oh6J2zqeA7HiPCec7ngOx0Hwf+djznnOM65yHxZHhzgs6nc9QnsegcnkJ8J1O2+gx3++oANWY/ibrM4sP5Z6HGuwQL9QhrZ/Vu8B8sHYi2eHgI4WXgII4WXg43+Adzk5OSPRZk5egwww876B3PGdfrk4OT0TwHhODwnp57B4Tq9jk5PROp6T5GznOc6ZFnIWWWWc5Zz8cZ1fGcZ5z3jxnqPJ6TkGrGY4luLBGGHGuwQK4QjUs+rfg+4I8WNlnLLwEHKy8H8E7nJydc8BHJ3ZJOHoRDKPSP4RweyR4j1SPAckc/nUjsemcHBwePbS0tLS0tLS0tLbSEhLS0tLEj/bH+wP8AbNizZs2LFizYyzZsnEV+csX8sX8j8lf4qEN3f+2G+lflQ0LsXH6q/wDbYb8rPpjZ/hvn5MbH/GN+wYP9L7/l/wDyD7aj81H++N83Jnyo/FR/p/8A5f7P/wDkfM3l8n2v/RAvxkz5caUEx/vv/ff5q/yV/k4b9yb8qf8ARH+6R/UflB/qGeisdVW4uWBrByD/AEol8+JJPySZuWZ9R/nC/jH+LfgT/VSjEyEcCR/L/wAmF/L/AM2w+1DIz5vnzMvpDb7IkTQ9YpIgk+nvzGG/LbiS+4kJ+/U/gfNoCpPdUNuEkbM/yWKZG31Lz6t7asZE4DbLeB23j/8AbdjudjxnJ4HsCuEWfgz5vggD4ciPg4l2CDfgsTWWF+PAfMEHcIGFH+rJM6LwEF9cbL4X0TqcHmO5HY7fkdckknh6EMofYPGcHQ6nZ/n732ODucnU7nQ5PWOh4Vywl27du3bt/wC2/wDbcOKzcK3x3fP9v/305/7s2bMGzYswDiD+Ft+QR82wJsRGfagH4p/ul0kbT6P/AJDMEQhpbyTuQbmGS3RP2wW+ef3CKe+csCImCQFlqPtSaSufM/OLCp9iEhLokY/knWaXwwk6NciaE5ZTg/Gw0+RE3ah9VepUdAWZmNjIQWXwGVdCSX6E/wDmxlUPzO8J2PzEBrCP3CX8gHE7mbOWaQXEFf8AvBfsz8stoyv7H7wMcZyj/tLO78y58v1Z6QWGYT5km6RMIHon2E+IJm4SxjQB9kAiTSKXzrBz8RZczZd3i+PIpSAlLuW4RatbLhlq3l8wZBkT8G/kPD4jxZ3ef3sRf4J3Uz9WInEuwQbfFrAFqyvuCO5BB8WcBtkJZeCCC+uFl4P5ZHc6EdyOh1SZOHqQyjqPJ4zg8h4Dj49g8Z4j0N5PNvY9n95OTwnBw1/xl3jbed5222222222222222GG2JttttsMPIZ/eJT4fdv9ih3dkf7M3kKafH7m42X+NqfMi+UY/Yx+y8Tb/EYs5ln7mCPmWsbPuGN9PueJct/Zf+w44NQy+XDVqGftraw8NttbYbbbbbbbYm2wpw22G23kItsvDbbW1tttttttthttttttt7ENn8L8R8fJ9Q2xPY8z3/Oc5LBDmr4Jc4l2C+/i+fWyEtV4PuDxfaFkzgks8EEHOzEegfx88R1OjJJy9CGUO+n+eicHY6HU5PJntnQ/iHB1+/AcHJ9cHJydlwsZGedtjX8sbVr/AC1f+HWq3btw7fER/wCUR/4cH/l1CP8Aw8EEV/5Xzcgcwf8AhwEsnPRR0qDuVVPFBQni3b4tW7XAbbtwrcO3bhW4duHat27dq3btW7cPbVst2+DcRs5oTiQhOIafPUQ38ydMHH84/h3JEUYehDZv/kO/J9R/BeNev1fo3/Zf14l1g40+WUDnPthB4TRBltvxIJdl4II42Xoe+ekdiOp1OxykycJ1JSt9w4/3v99T2j2DscnpvrHc7njQFv8AVvCy28BIXzGX1y//AJcj/wCV831xtln+ZZ/hPGA/l/43/lD/AJH+F/4HEV8H1fE/BFB/wtPzixZswLJ+E7dj4/Uu/kKH1a/yBc+JUH4td+rR+TR27cq1ahCFDkDFCSctDifMPSRTkBRhdJhEy3GzbTJWrTJfUgFln7ajRsPckjYa2xlHzDy3Dt27Uv8A21az7tQrVu3bt5btwrduHDt8NWrUKFDvl+xxEeaf++P/AO7/APV/+7/9+D/mPzZswN4nehJjHQi3Y/Vv6fUcEPVj1s4Rb+X6Il8q/fCusHGjraDDnD5gg8ATP5GbJMgJd6BFvG8EeM9g8xwR4T0EkmeHoch88H8c4PF++c8h0PKdzwnP1651PVXIMcnVtssvGQW5K2v9tf7a/wBtf7CtWrVq1atWtra2rW1hbW1tbW1tWtra2trC/wBhbUOHHEHFBGW2uW8t7uSm3bt2mGMOETi5OlyEYEmyS2x8S2i1KZB4BLsmMMgjJaU/lqFL9JU2UsLBGSurLGfkKSn5lpDBLRDtWrXJW1tbW222GBfqRPs53jedtt42221tbWF/2Ff3gwWt8/7a/wC2tra/7a2tr/trbxtvUYdgw+kZhEcjoQ2Pwy5PSOS3h6M6wkMA2dK+3iXYNi1fmMDnPvgDk6ZDfyT7S+P0T8G+G7fmTydXgIP4J3I5PCR5TgjwMkknDPJDLoPIeU6keZ6H8E9wjqeqcHfPOuX+dvGy8kEuS/zjk6FtsPBv5jekYk4PgEGcEefOA3gv1vlBLKZkmzrlrJ8X3jfcOhl8XJxoZzcZpZ+WNnlG/wDbF/C0cvifh6HBbGdY67PQ8Dw9WCsJa37kZcS3gtmAC/OV+8AdiGmltA1IdBF9SxUsF1tnD6nk/qniDyJsGcHOQWdWZnh6DDL8j+AfyjynU6HQ5OcjscntnjPAJMy2yy8EFksvuMsJ1iQL9SJ8PIbIn31H0DuernAbYQGOwa/EAjM6SWWA+5myDjnCfhnGeEcttf8AYQ/DBnDM8SC7lr9JOyc+7EckzxjDjCIVI+upwS0lvtrArCCjS/5wacEiww5D7tIM758x4kKEKfMgw+ZWD/8AGYlWVs+pZ8J/QOTxEcHh3g4OyTJw9COB9fxjyHqHjI9c8X51/eM6HU5O53ODxbZnxKZZbZ5C+pbfZyxtWX3hfJsBG+aO4kGxSDtofEn0lDjznJHiyyxi9C1QTnvylQnzKScjiTGZJD8Wv8hQ0hjcnb6lG6W5R2BbcsNssmCMCfliIN/ZbZNbDh+C+VgmGXjFssssZE+zqHEE0L/UlgrBMX2A2fxkDTINYTtlS3ykgJbx930r46kQ4w4wj8+i9yb5Wz1l+J+DgXAQawQCV+w2GdwnDSWM+SEfHw/st/8AyepN/CcKz4Qs/mHhODqdj0mZ4Z6lyI7HnPEdjwnB6f74D3yPGdf32jg6r8PCq/Lwy28EHC2+0OJCTBr4k5P3PwuSmH6lsOI+InGyWNfi37zlnhCE/Rf+Vmkzj+M+Q/8AiXaFoAJikefRfC3wOfEdAh8yR9EjI/CFlghGXUukdCzYaKSWWkabf5RoxkLOC3j9pfy2+2AC3h8sYSzA7G/uASDMG2CMGT8PuToTMMMFThKMlLs/7S37bX00N/IujXJ3DOpEPxLfiOxw8nbbThbeFLZX5fqVGngfcEGwyWcCwa9wg1lXYcZGiGp9fcsATLVX8E8ZPB0LP5p3Oc6HoHiZmZnoch5/rynh/wDe54Tg6HmL97Hg/ex6R6h4/wA8y4bfiMuvzwy9AkyX3X+kcDZZHBa+Kzt5Ibb765CYoQ/JfIJH1oQRoJ/iUMmexI/JqWFGVt/eG0hlanxZRUAh+p/Y+YIuQ/A+bTZhrGVyHg+pGWCTiSddJMIfHD7Q2aQSZPA1sAlg2DLZYLSXgF8W2rBfE4lW+4ICzvxyfd8LBPxk3EZ/wZP7IeRNyE/L7Q4lG7PoZlrQDJjnQiGwYdOd6vTZSxwa3XBUuHFAdhwplVl4INsJcOBYNjHUIL5dY4fHEHzWVsIKvyy/xT0ToR2O5HrszPD3B22H2frxnz1PEeF9U9M8Rfr5f3ocnlOfzhcvxnhbehwvtHUcsCanQYRxZdc+OoMOV+YDjPm+T6t2PxfNH1L8sxo/DCah8uXwDBUvkwi1tsxD41tgPxOaZX6kdgn2zZhbrFuc4YqokZEAfMBQp8W5WFOsLgJjfKSDYYX4Qax8EsfMnIFkbwC2BfqH+2P2QCc/LbeoWjSAABfjE53CS0hSsZC+M+L67iQvokJGTn7+FvnZp+U9COF+Q9svi3LEmap/bW1no8Dwq0vtGXeAiMvAsG8R2DYD7lktkndnUH4t8Z7h5DocnB1ODqeXfMzJM9COB/JJ5PKeI/hHBycHc53ueA9BjouX4Sr88MvQOF/gsvi2lvJBLGVMeoxwBZIbAb9X03JQ78kjEST5+GA4fu+QWAzVjb4n7hByE+koP1f6WkH3aqs4+JGaXw/Ld+C3+4VC0koboyQvxIEjDwDEBAHB8TIWEEt8rMmSNLbZFsYy2+7IMlO/kNnz5mpPUtq1tbWFtf8AbW1tYRLvnI+GMwL48wj1IljLTkLS2a1TK2vV6M9iIW4SywW8GdggDgZhfs8ZzvhPePQOhycHU8Rx++U4SZme4eieM7HU9o5J9A9E4DqfXH71PMeAjk6ndsSXXlZ5OF6HgOh6RHU7fboGx/hIj8wQEGNvnRv3Wn/qDVIfeTafcuMa+NvjqStiaJP0WWD9xiyMfJFv7L7MjrPzBYrYn0kH6tT6i8x82CSPxx7ZdstmDJEjrkEFtrBrJBxkTfKAJLLAhvliZBAyQgyb4/UqTHoOPzZZa6kT0zzqN8zZPnqT6yUOxwy0JMxqm3ws8s9yH4lljiDOwbBPH+Fu/fc6vB1O57GcnbOCCyIOTudjg9NmZ4eT1xnlODocnB4jk8Z6R6p4j+LmSq8s9Al/hBBwGzvGz+HmyIl+b4hnaxaYIORpmy5sn4YK3J1AJ92mtn1l8Wi+fSAH+yvgyhpLsv7C9HLBzZMfEPiYT/so3xYMI+JHwrt9wMjDmCGLQiH1YZC0t6BwsMtpxkEfCTOBJM1rWa9jgH7t/wCcJ1PUWMrmHz1IyFJeym2OGPK+EZeNmGdg4JcnX11WeQ6byR0OcjyZ4zwEeUjk7nBwds5I7nKTPDPBEcDwbbbaWlttsNtvc6HB6p0OD1T0c8JwR4yOT2TklhbL3C+BLPv5BGomXxMH5vhWPych8xmP7a6m1vqshrn7Dm/kofhhmJA/ZO6WoWixnySC/EaDBM2N/DH8iXNGRp+MB84Rr7sEnGtiqtgRz4S6Y32+LS5DCdyrgPyGzKWzVk0bR+JxDkv8lTVtbLOCfthJJE6hYaH+wWEoNnJXFqttvhIYQjOfi2IFswWWSllnpkp9meSI9Fnl8JZDWGHYMhhkEusRzvP7Zy2zyR4Q4yPCeHOc8h1OTtnc8x4WeGeTgR9dlyY149cDjKU4yEJsNvsHiOToeQ9Q8R5DzHiPAuX5ncgnEX2joQRQkAXxJO8CjOj5sIcbFpPsQgIvMeji5GbPrYYN96328WFcikfP3BbPQwZAbjJCA4mRv1L1+x/kvxZWBMCEbKsJuQlgEaYQR937vq3MLSwKzrHtgNhCFxkjWK3fiBZH7gEAWkpkpOfq3LfttbbYYwhl7LtWtr6JtsbF+oD+RdvxvlYTk+mvjsI9F6PiDbKODgON4cHxLvRZeQ5W3h6EdjvnuZweHOx0/Y9lmeXkjgc7LMaq222222222HgQhDgKUg8HH11POe0eueidDwHJHlOuJLq9w1vgS193IIQRw8hZZ0Xwk8Ydkj8OSxmrZjCyksVlBrGGFXzGiRo1jN9z8N8WMDCfUmb0DpCj82b825P/AJaIWbkCvzDECsp82vg8cb4qywm/EtSJkP2sWSl+51b/AHgBIILJLWXKvO22222vpZwGxq2gDjcD82aSQ45avBbfT+naQcnJ53wkR9dA42+Jmww8bLyHO29zgcZ6pxkHIeEOToHB1PAeY4PGzM8PBHAi2WYxm222+HeBhhhhhiHaemeF43xnlPXPMdTk4PKcrhLWOXktTZfIl9cLLOQhAILGNht5DotvEgxdQcfmFCT8D7WjYCREGCMJ0nmrcS+W3C8gmIY9YMgD/wCQ/kg0ZH5D8L4+WKxAkFq222avq+4BPVHYVZbWViHIxKZdhlttttt6npHIiXzBCVPgnm5b+2rA2rPVXx2HpPR8JERBBlvC5K9C23gIOjwcPQiLO55Szg8eQcZ4Czg9E9VmZ6ERDEY1Uvp7bDDb4z0zsc765HhP4h6Fuvc4FjweHohBZB03gbeC+MmHLYbZtnDKwyM6X2F8Er9QJoTo4kj9wiKJlr9SA+Yxd+5cW7jbJbDYvzkCxmfgkH3f42k8BsCxPpnf9ngtJltttt6HB7QgT5slg2E+rJW/3jCS0jmvp/WehHiPA9HwEEEHxBZk8KS8h02I6Z8STy9DgWdsjrncjqds8Jye+eRmZ6HBDMZvsj4DuescHc8H34zxHmODsekcHVYT1iOw+0OZL5DxhBB0yyyyzkifplt42XgcilWfuI+RsvyiL4tLH7BISB0RwldYZQNImfPAY/Udig/bBkwnP+LUlVgYIJLEtbU8t5yyzw77BLC+H5KYhX3vj+YwkEu3bbZ9I4PQiOMsss7Ntttt82NjY2Nq1Ks6ZA8Aj9Wzwu/XTOdl4IeAgs+JmJnocDxZxnTPaz1D2mZ4ez750I9E4PCdDljvnrnhODwnonifxbrHD0DibPqFlkEEeQbQ2IScBZZZBZZI/i2OBRG3PplH7G2YTm5Ivgwv0tfCPl82mQExctgzBnXVbJgQScpJZZZZZznOegcnlIdsmzkviwASha268QMgn4n0vkwT0Iiyzo2223zfMKGxMWZEBAQILI4msEt9mTeDIo4zPC5LvOeAiCCzhk8I7Z1znLOSznLIO+ds6HgzynXZfi3kD4o5jsBZZ8D7pHnODqdSPdPQPng9s6nG8Hd+CeuWdzqFqVq+oR8ycbkMcbDbLb1G+d+86vtZZZZ0DYw0sT7hSHHw+bdj4Yh8wh8MspKQ47P+Zf5KYWeNhvuyzhgs5SyyyyzxZznsDWFm2JjIS+ZyVn1OtjC/y0fl/wCE2Z9I2/E9CIbbSW21sW2xCggFgWkkn/MuVahQo43d9yvA2+OBBgG24gnzThAkHGGT/ju9Qgggg6HucDseA75/MXJZj3wbw223oDgODbbf5xycnh/eDoeI8565weieQ4zk5OX8T+Y7jZ8I8nohBxkkQ9g522Eg1IQyRAJMVB+S4L4RH5GxSSeEqJbzJT4ZxbWNbMsmJlnOWQMEzMrsNvOWSWWWcZ/BOB87bTvyfyL/AMpL8hMj/Ir/ACEn5QiNwLGz6IbCeoxNYFhMOKGBfBZkk/5ly39lW28NkEW8CfqBAshE7AyUCiO/OsYbgYmjEakCGyL2OwQQQQR0PL2KPIeY7nrnQ6L44Ft8W22222222wwxH8Q7HY9I8R6Zxkeget+djzKftjv8NbQ9MiLYeE2UQ229QZttsLDGcNiiJwviZY+HZR0cBsInzvA59yJ+STgLJYYyyz2d/PCJvja/yyCCywksvgiOcksiSyCbLPeOPgQ/pKMlsuWpI27Vl+x+7i1vz6Rj4nrsNYP2wLQkn7JlS5bLtth6ZGouZxMW3xDVUHBAy50MmSbNSr5eeAGfazhfpMk+/GEEEEEdX6meHqcDw5xkds4zk7nok+dlPrHB13h944PQOh5TscnU/mM+w/TLuRPCWvqnBbCQHVuctttt8I2yjGownj54FIfptMtJ4PqbI4HL4QiMONoRJABfCzfkX4pzJKlpnjTagbPiTIsJiW986HslrJScMGWhwsFAbdg2Ah6I1hhL1XhYxmVbtbeMs8I4xxLPzCM9jKCdYf6TJGFFXbBj5lm6JCV1W2WW3wBBBBnJwcMzw9SceQf4Z6DKZ9YiOi2/yyOp4jodz1joe+X53Op4X6eJ3LcJfPU85bEMsNik+iljISxafk4k422Ytjjec4eDSfm3SEsfUVScoRh/kICQvjYyUlsSwsTZ5Szk6Z4c9EPngGUD9TV6jkcC76GQvyXg4Xk5CCyyyySyyzkjovAtww6DbJMlYkn1bfttltt4Is6BBBBEeATw9Tgo8p/ReD65HR/mB2PEf0D1T0t6fTgdyX4nwHmLZ4POcpGNQn7YhMsssr5SrOMgk+LLJJYf5Yz/AEl33pKjwr8X2gmSNPI024NmcbZ1z+B83hFt2/8AJGyz1TgDCejwcHAx3zh6nC8DYDJclfjeCONtltiCDqEEEEeJk4eylHU6HgPVPH+eEjoZn1SI5Z/iZHTPQPCdzqdDqeM4PIe2eT6cDuT9T6x6GWcBBBDIYZ/MuzLLwSg0ksgiJk8LbEv2Q+0ZgiTEb7MEbwySyOOkpZxBl2fHnOWWWcZ6XxtMsWQM+pT8mkzd27Gz0DrBPLNvYjwM8ERxvAQZbP8AzgIONll4CCDjbeAggjyJCZ5I4Jx/UJ6HReDJPrEcMz/EPSPWOh6Z/GOh5Ajr+8j+MFllnBH1DbbwYvJfGFluzH3bk/2R/uLFJ2IcLUI+oM+77ZlX7iUWz88ZJBygknYLOM6HtErCGIYPmCsP8s3gGTHET5hsJ+C3ovBMckdTlt4GG22GItl4DnZbYgjjbeAgggjnfE8GexOXkOTyHlPAeVmSSSfVIiZngIILLLP4R2O56p6h1PAcHmOp4Txb1TqRHB/jDE2WGGHgzZepIhiICA+GQkmXSTeI4iMJNLX6TjgEcNtsvBu+O9iZ6nsltAZBJGC+kfJPwyh+zj9jMlImfKQOF5XkJ6kMc7b3HJDC2rEEHCy8ZBxttvAQQR0Y849RlHGdj0zg7Hss8JJPqnL0IiLJJLP4B3PF+9T2D0j0Nt8R6b0HJwcJD59Q8h33kbbfAMMUpzNRuXYECEgbwgmNhYlsWbFmTZ454Pi33iJAwkpFxMNuWy2223zaQX1NttvIX1PYjl4G3qOgQQQcbbLwEHC2xBBBHc8bCe5KHjfAdR8R6B4Dxs8MkknhCKsN8Jy9Nhhhh4eE9c858fwTzbHlPGe+x+Gfhjg7B8R+P7A228DltthYVq1Dt2rW3+iMOQz9lv7a29zsd/8ASDL4JeFl5Dhe5HRJOHoRwRHG2y8ZBBwzEEERwdTyP1Ce5KUeX88J6p0OTws85JDJ7kGFtuwx8Jw9thiE33Dg6HU8x4Dk93eDueM8f3HpPAR2IYeCfPvnG+M8OMD/AJA2NnU4xgYduxsbGxsbGxsssbGy+bLILLLGyyyyxssbGxsbLGBssss65Y8ZZZY2WNjY2NjCh27X+Wv8t/5H+V/5Th9Wv8sbGxssg65CYnwvqXneCC+peh0CI6ZZDkJItttttt4CCDhltiCI6HpJDl6jKHseE9d9Z4OEk2TO5DpZZl8l9QYYbfWDk8p7J/whxvgZI37ydDjdhZZ0znPBnIWQWWWWWWWWWWWWWWWQcMsssgsg6EO2IMCGMPqE3JFmzYsWIEFPqDFn1OX1ASbFixAsZJsWFhZZYWQcFllhZBYf5ZZZYWXxZZIWWWQWWWWWWQLFj/ICxYiYswYMHPqUPqx/kF/ITCRHyLK/UfEho/EGuEk/JO/UmRY/yxwQ/wAiEAQSDSXleCDhepyERwdWeBl5OSyCDnZbbY5EcHQ7HhYT4FKPfOToeq8lll8e5J2JZwXZ7n8b88R7B4zsemPU9Q8fzyeNjJwRwRHKWWWWWWWWWWWWWWWWWWWWWWWWWWWQWWWWWFlllkFlkFlllkBGcfEZKZ9wn+wOEQco2lpKWlpAIJ+wIUuJLaWLNmDBsybMmzYlLFi0bSAQZFixFDYkSLFixBs2LFi0hLSEtLS0tISxIsWliBYsQYow+74s4isf3fLL8SnxiI/MbRa/MiUtJScvi0ngS0Jcu8LLwEEy9Tk4I6nDJ2IiI422W2W3giOCPPtp1NdnwDKGHw7/ACTwM8EGkRyM+TuW2z0z+oeqcHJ4Dk8x2PQfAek+Jkhyc7bbbb0223jbbeNhttttt422222222222G2222222222222222221teArVu1aibw23kHbtf7ajoGrXJtsNttttsMNttsMNttttsNttttttttttttttttttttsNrwJr/bXDX+2v8Abdu1a/21ttttttthttttt5CC2XscEcHgZJ7EMMNvBbehCODqR4FmNattcNbbej1IYhziEINtsdDqezvjI5Z5eOS8fWGPfbeTjLLLOcss/iH8g9I/hHQ9J5ZhJHi+e+WWXzG2NjZfNjYwNljZY2NjY2NjY2NjY2NjY2NjY2NjY2NqFatQrf8Alq1atWrdq1atQ7du1btWrVq1Ct2rVu1bt27drhu3bhcN27cOLu3b47t27Vq3bt2/8t27du3bt27du3/lu3btWrdq1asbGxsYGxsbGxsbVq1atWrVq1I2uGcMvGT2ONhhjukng223qEEEEdzg4ONllmKt8+kNtsMQhSkIQYeN8e8nb99A8Bw8kO/cpLPzPiILOMssks5yznP5GeL/AHvvYt6HmHjOTyb0PWO76DwyWQbFNxd27dq1xONh1O8ZTjzZ/wAs8+bOWI4Mf5AscA2LHPmDZs2YFmxxDBsWbNizZsWOkBYsWLHQYssLLCwgLCAsLCyywsLCwgLCAssLCyREALCAsLCAsLCwscEWEBYsWIFjgCxY4AsWOObHHNmRxzZs2bNmzBgwINizZs2bMmQSYJMngg4ep1GGGOCOGSyTxhBBEcEcHUjjbZZZssssss9TYbYYYhSEIMPiO54D0v3hORl2WZPERzlkWcGZZ3z+Mdf31DqeA67/AAiPIeLfCzZEpkJl8XxfBOWkpaWkpaWlpj8wn+2LSUhIFj/ZFizZs2ZMmzZswbNmzZs2bNmDZs2bNmzZgwJNiLixYsWIubEHo82bFieIHDPnAADxsHKd/wDmBxzZs2bFmzZswbFixYgQLECTZs2bNls2YMGzBgf7Zs2LEGzIkyZEpYjlks8QwwwxzlkklnfIILODg4I4OhblsttjLbDbGWFlkllniPBllicDDDDEIMMMPmOT1jlnkZmZLPCWxEWWWWcGMyzvnuHB2P8AjDznY5ezyzwOQyHCtW/94at27dq1atW7dq3btf7atf7bt/7bt27du3/tu3btWrdu3DtcNWrVrk1a475BcNWo5GobVq1w1CtWtq1tttbW1tbW21tbbbW22G2G21htbW2223jW22+bW1tbW1ttbW2221tbW1bDw1C4a4atW7Vq1bt27du3b/23bt27cO1atW7fBeTonmGIMNvOWSWWWWQWQdSODocbLLLbfJk+JnkeQm3xxllnk222OU5LYYYYYgww7HB/FZnrkknc6kNsRFnGTGtST+AX7/IPQI8p6ZyX76b1eMssbGyyyxsbLGyyyyyCyyyxssssssssssssssssssssssgssssssssssssssgsssssssssssssssss4BZBZZZZZZwyyyyyyyyyyyyyyyyyCyyyyyyyyyyySyyyyyyyyyyyyyyyyyyyyzjPQIjrlnl2GGGHnLOMs8BER0222WW2OOfEkncthttt85DbPcYYYYYYYep4TzfvQ7s+gR1GGGHg4CQkzWZZ65/FPCe1nlLLOpB4DrvleHlLLLLLLLILLLLLOGWWWWQWWWWWQWWWWWWWWWWWWWWWWWWWWcMsssssssgssssssssgsssssssssssgssssss4yzkOTnOueDLOcs5yyyyyyyyyyyyyyyyyyyyyyyCyyyyyyyyyyyyyyzoR1CZ5zjLLLLOMs5IYbbfBvJERwMsvDbeci+0HxCSfFtttvXOr13xbDDDDDDDwfw1lnu+AiOwxCDGRxkkia1UjZ7pweZg6B3PAeU7HjzwHQ6npHTezPkPAcZ5c9o6Z/VPGdM4Omc5ZZZZZZZZZZZZZZJ0I7LwWcZZZZZZZZZZZZZyNtttttvJHBFtssxYfA21DGEz4d6D0LOT0SGGIYYYexyPs7LMW2Hq+AiGG2O2wxCDDzkxrWsyz1jwHBHB4M8p/ROxxnQ8B5GeDqekeyeoeH87nY85/EPMycERwcvULILLLLLLLLLLLLLLLLLLLLLILIIjhltl4OxwQ4jxbKSzjOrPY4I4T1SHgYYYfAevssxZmwww+fYbfAMMQpRIeMsnUmY1clnpHQ6HJ499g9k7f8A52PUO52ZmPEf9YfxUkmI4zhnoREEFllkFllkllllllllllllkFnQiZ5I7EcI2fMNkks7vhI9cjkYYeNt9rZZZi9CGPCcZ0IbbfCMQhSEGLLJE7mMUSeT96HqHjOhZyeL/wDfQPKeweD/AHuz7B6J6Z4zk5PSPAeM6npHjOmdWSyCONl4OCIIOAgjg7ZZ49tltj5YiSdDuQyc+5ZJJLJ7ZZZZZxlkHrBB1GGHoCDbbbbHhPDsssvD1GPJlncYfBsMcEhBh4ySa1rVEjZ4PyPCeb86EeA6HqZ5D3z0WZ6H8U9s/lHonvJZHCy8kQcEQRwch5lltttt4XzfSELLIIgssg4IjgzMz4QiMyILPTIgg77a222ww8hCEIMNsPQ6HOyyy2+Ah8Bwdc77Dwd9hilKQTnJEiaxrM8J5D/gDqeueJ6Mz5jxH8E8Z/xZ584WXoREcBEHBZwcPiWWW3qR8MfGdy7ycBZZZMyIIJZeXh8A2zEebOc4yOTjfAd9thhtiEGG06nDLLLL2fKPhzsREPgGIUpRhOAJJjWMazLPCdvzqR1OpyeQ6Hf8j+CR6z4cmZONht6bzsW29N43jbbbbbbbbeNttttttttttttttttttttttLbS222222222222222222222G222222222222222G22222222222222222G22222222G22222222222222223pvG22w+Fltt6kQEQRxlkeJ4WWWW3oWWREWWWcBZHGQdQy9Hh7ketnXbed75ZZxnOdRhhiEGG23hZZZeSOHuejngG23wbDkQpSDDHCScmsa16D0DwniP+SeGZJONttt5Ntt7gb4wA3wgG8m28Cbybb6AAA223qG2229BtvDbbeG8N4bbbbbbE222G222G2223htttttttvDYm8Nttt6Dbeg2G3oNt4bDbbbbDbbbbwW3qcEQRwQdDwrLLLLbwch0I5edthhtjhYhu3s9yOr5zwbb3CDtlni2GGIcCy2+B9I5OuWdi2PAWxClKQYeUkzXzzo8nuHP75iOx4ToeQ42PCeVkknwbbzvO28a8non/P7xttsW2228bbbbbbbbb3IggiCOCPHsssssvQ6kRFvxbxttvBFtts8HD5CPFvB1z0iPV22223sRw+c6HizqdN4I7DEKUpBjjJ6jwnsHg/89I9Ij0j0fvvkkkklnGWcZZxnTLLO2WcZznbOc7lnQ8OfzD+mdCCIIgsjg5O6yyzFtt8RFttttvQIOuWRDbsEk+EIJPjg98iPLvO222+i9T+GeAYhSlNw29HqeP8AeDk/pnQ/mZwlklllllllllllllllllllllllllllllllllllllllllllkFkHGWWWWc5Z0OuWdcs9LLP4We6cHAQQWQcB414GLb6xEdnghyGZ8JF9J/gER5Ntttttt9vY/hHQ42GFFKev/I909g9c6nfPPllnJncDOgyyyyyyzhlllllllllllllllllllllkFllllllllllllkFllllllllllllnGWWWWWWc5ZznGeHPJnQ/jHQggggiPIvAvrnJDb1XgiJSeuWcjhZ8B230iPBvG22222+oeI93PAQ9xhY8gjwn13PAeAPCeydj2D0ssssssssssssssgsssssssss4JZ1DOGWWWWcmcmWWWWWWWWWWWWWWWWWWWWQWWWWWWWWWWWWWWWWWWWQWWWWWWWWWWWWWWWcZZxlllllnTOAs4yyzrnGdc4znOmehlkEEdj0Is9MiHnbbeCLeAssss6EMLb7PfOu2+mRweDfGRZP9TPARydTk5PKeI6HU8p3ODxPk3xHQ8O+A4OweLOMss4yyyyyyyzjILLLLLLILLLLLLLLLLLLLLILLLOGWWWWWWcMsssss4ZZZZZZZZZBZZZZZZZZBZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZxnGWWWWWWcZzlnGWWWWc5ZzllkWcFnBBZBBBFkFnlEJOxzngOTwHYjggjjJnhbYj6mepZ0231CPBvG+M5J/pnXOpztsPT96Hh3g6ffO/wA6nm/OD0Dk6HkPQPJnxx8R1O+cZ0LLLOMssssssssssssssssssssssssssssssgsssssssss4ZZZBZZZZZZZZZJZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZBZZZZBZZZZZZZZZZBZBZZxllkFkEFlkHnZkn0DyHgI4GZZeogtnwbb65HJ6RwT6gQWdDk5P4JDbbb7B6Z6B4TwHc8Oe6ec7HP75M9LLOmcZZZxlnGWcZZZzlllkFlllkFlllnOWWWWWWWWWWWWWWWWWWQWWWWWWWWWWWWWWQWWWWWWWWWQWWWWWWWWWWWWWWWWWWWQWWWQQQQWRwRZ1O7MknOWWegeA77DbbbPU4O2y22+wRBPpkW2+cgsssiIkk8JwR0CyyzrnpnG9T+UcnU/gHGeM6nQ9PLP5mcnTPBnbPJnTOTvlllnGQcZZZZZZZxllllllllllllllkEFllllllk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DGDy3VcALbSF7YyrGTefMlwrEb7B7oyIidp2E+ZByEIRtvOLsGDvGRIJlM+Y4wZCEI32ntJHsjBgJPmTCMIX2krtA8Nku9JdiSxe2kkl7SS+KC/ybhGqFtr7CfDVJJLXXXXXXXXjFfFxcPDwcHBwcXFxcXFxcXFxcPFxcHBwcHBwcPDxcXFxcPDxcXBwcXFw8PDw8HBw8PBwcHBwcHBwcPDwcHEKuDg4ODg4BQP8/pvTem9N6b03pvTen9P6f0/p+Dg4OE1cXFpppprrrrrrrql9QMArhbcSB2ge4AAl4NNttttttg7bPbZtiYmJiYnvts29tnts29tn2nBjez2e2++/Jy8vLzc3Ly8vNzc3Nz85v5+fm5ufn5+c3C3m5ubm5uYXC/1A/wBHPz+o9R6j1HqPUeo9R6j1HPz8/Ny8vLy8m+++++++++7BMD9MBXCywnsJ90YAAsPhewR0be++22+++++27222225N+Tk35DMT5N999999m9m2228beDo+19G228eMH5y6AkL6SuE7CQO0D3BgGEsnwUbb7m22222222222299nttvttttttts229tgdttm2SC2222222222222222222222222222222233Aoj6EZXCdhPwwAOhPg8l3JJewklrpppx8emmuqSSQjrpppoIGArMNdNNUhDRLVJJJJJJJJJJJJJJJJJJJa6pa6666pJJJJJIgDvEiPoa4zM5L4QiBhJPhq3sJb7778m++7bbe2++4mLBZKYnKYkJ77Nie5L3Mttm22/aAS99t4m2237sCYEdwJBA+aMhAmcvgLAIViOHCfDl/EBJ7X2HoOxtL2gBFDF8EEFo1GswI94YDXOcO4YCR80AZZNfAEYUiGhEjKT8LhgBilhwBfHaPR9z6N9q9hAHASQOxLH7jBE9mAYa6r3AYSnBdwJHymBGM5fAGDKYTlAg2mc/C5IiJQBGIAhfEFYoP+eVcKvTmkw01EBXxcWmqXcl3AE4u5te2AKeE1awBItNhLfuHAYm2HcCvlAQhbM/BArgBKJys3WeF4BGxwE42METjJHsrrrrCEP8/pz/nEDMTlEYDLCNJwwAYTghMLUgYBqfYA9oBdElhJHZExuNxsJBfw65EWQfaPhpdEhgEIWWEge+BCEACYqdvhgCu1DAScXsgCIhoAxnLzi2UyRgLhhkCLHqS0CLDI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\" height=\"150\" width=\"150\"></image><g><g transform=\"rotate (45,4.166666666666667,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><defs></defs></svg></div>', '', 1, 0);
INSERT INTO `customadmin_organization` (`id`, `organization_name`, `website`, `address`, `start_date`, `end_date`, `no_of_candidates`, `logo`, `contact_person_email`, `contact_person_phone`, `password`, `contact_person_name`, `pin`, `sector_type`, `unique_code`, `city_id`, `country_id`, `state_id`, `certificate`, `logo1`, `show_second_logo`, `is_active`) VALUES
(3, 'oracle', 'http://jjndjdcnvjnef.com', 'kdmkdmkmkdmcd', '2021-02-26', '', NULL, 'organization_logo/898403_1OqpQDp.jpg', 'oracle@gmail.com', '7575757835', 'root@123', 'oracle', '7477477474', 'government', NULL, 4, NULL, 7, '<div class=\"certificate\" id=\"certificate\" style=\"border:red 6px groove;height: 580px;width:780px;\">\r\n\r\n                        <svg width=\"780px\" height=\"580px\"><g transform=\"translate(274,41.19999694824219)\"><image xlink:href=\"data:image/jpeg;base64,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RdSgBFRQlRZSKASgJUssqVLFlgmOeI6dO3XpZjnx48pAAAAAAALAAAAAAAAAAAAAAAAAAAAAAK1rW9apZUpKSgAAAACUlihCywVBYLLAAAAAAAlACLKCWWAWCwWWAWIpKBNwUJZYVBZSKARQJQSgJUsVAmeeMG+vbr00zz5cOWIAAAAAFgAAAAAAAAAAAAAAAAAAAAAsAC27vTVtEVLKSxQAAAARUpLKlRZZYWFgBKAAAAAAlAEFCKiypYACpYWEpKSyqsCpYoAEoAgUSgIWVKEAGM88SXXXv166uefHjxxkAAAAACwAAAAAAsAAAAAAABYAAAAAAAAVbvetrZRKlASgAAACUEoSxYsCwsBYAAAAJQAASglEKSwpAsAXNAlQoKAWKhUpKAASkoBKQssssABMYxiLevbv13py4cePKQAABYAAAAAAAAAAAAAABYAAAAAAALAWAAt1rettQolBKAAAAEoEsqKIsoIAAAEoAAAEoAAEqUlIABKAlIpKizVlgollABLLKASgARQgABKxnnnMNdO/bt13nnx48OWEAAAAAAAALAAAAAAAAAAAAAAAAAAAAALda3vVsspKSglBKAEoAAIsURYVAAAAAAAAhZQCVKARUWAWWAAIolljSxYqVAoEsoAAEoJSLLCwACYxnEhenbv37amOfDhw5oAAAAAAAAAAAAAWAAAAAALAAAAAAAAABV3retaikspKSglAAAEoCUlRYqVALAEsSwWgAAAAllAASywKgsBKsAAiqqKSxZSUQsUAACKEoSosAAYzjOELrr6PR21rPPh5+HLICwAAAAAABYAAAAWAAAAAAAAAAFgAAAAALd66atUIUJUsoCUAAAlSoAWALABGZILdVQAAASgCFEVLFikBKFgAlllTVAEsVKAACKAAAJYWLACLnOcZygvX0ej0dNTnw8/DhmAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVret6uoUikWUAAAAELLKlhYVACwBM4zJS71skWgBKAlAILCoBUEpKlASghZdSgCKSiVKRQAJQJSUlQACAzMZzmBeno9Hp67Y4eXy8MgFgBUAAAAAAAAAAAAAAAsAAAAAAAAAACwVret61ZZUUEoAAAAACAKRSAAZzjGYN66auYXVSgBKAAlJQlJYpEUQpKigAqykoSgAAAAAABCyoCWEIziZzAu+/p9Xfpefj8Xl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KQoqrWqq0UoAAAAAAAFlgWLLBYogCNFgpFgqFlgFllSospFEosSiUCWUShLLBYsLKllihCygQWWLKIUiyyxYFhZYsFgVAWAssAVFgAAogBYBYBYWAWAUSwAAAAAAAgznOc5Si2IppSJIAtVbbTSxaAAAAAAWACxYsBUqWFQWApYAAAACwKixUFiooRSFlgsFJRCyhYAlCUlAIAsLLKgVKgABYFQFgAFgWLCoAsFiwAAsAAAAAAWAAAAWAAEVJJjMzALZFW0hEgKVbbaW2UoAAAAALAACyoChLFllhYE0AAKgABUFlQVFSywWKiygEFgssKllWEoASoVFSwVLFSiAWFiosAAVAsAAqAKlgAWAAABYAALLAWAAAAAALAACUzmZxmAUSrasiEhRS1poqi2WWUSgABNQWAAsFgLFEsKShALYqCwCkWLBUAKRRKEpUiyyyhFiiCksqURZRFSywpFllhUWwlQLLCwsBYACwWAAWFgAFQAAABYAACwAAACoVAABYAAEsmcZzkCkLa0SRCKKW1dFoooABYACwWAsFgqALFJZYVFlJUoAsApCwFQolIqLKsSykCiWKJSCxRKEqFBKASkFllBFmslipQlgALBYWCwsCoWLCwCoLAAAsFlgAFgKlgFgALAAAAsAAlkmcZzBLbEW2qkiQUWaVbapVKEoAAsFQCs2ywFIKECxYsKEVCgFgLFllgAUQWUgFJVksolioqwAEsLBYstlgSyggUWBCkWKgKgALFixYBYKgqWFEAWAsLKgWAFQFJZYKlgAsAAAAAAAAkznEwCgLdEkZCqFW22mgVKAACwAFQKgpALLLCwCpYssKi1AFiwWUQKliyhKhZUpCks1EsUQpFSrEsoiyixLZKllCFiykVCyyosFlQAWAAUQAAFgAWUhYFgAAACwFgAWBYAAAFgAAARM4znIUEttpJJAqppWlpopZQAFIAAAWKgqALFQAACoLNSxYLBZUFgFgFRQBApKSkKslALAIUiiVFCKlQoEUlJZZYsWABUsUgCwAsACwsFgWAFgCxQgACoAsLACwsCwAAWAABLBM4zmQUlLV1GUSUpSrbVVRQAFgLAAsBZUAsCxUVAAsssWVCgLFIAABSAUgCktysqwlllCUlsBBSDSJQJSVLKCKAllJULFRSVKlQAogAFQqABYCwABYFQWAABZRCwFixYAAAAAEqVJ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AAgIIAAIzy+f4958HNm7YvX1+jfRWpnzXrwrd5ebz88Fa7er2ev07toAAAAAAAAAAAAABMyC3VACgABAAAAAACkKQAApaAAlAAAAAoCAKACAqApCiCgioAAqFgAAAICAogoKAAAAgICAACTPLwefhnhx7deV7e36XXy569FcvB87fThynOZG+3r9vr77aKAAAAAAAAAAAAAAEhGbWqAKAACAAAAAqAqAAAAtoAAAACoAAoIAoAICoKEKIKCKgACoAAAAICAKgoKAAAlIAgIAAETOfP5fL5+Lfbfu93XyfI69pM+Dl57UL27+r1evtutSgAAAAAAAAAAAAAACERZqgAoAACAAAACoKgAAALaAAAAAqAAKCCooAgCiKACKgogAKgAAABAKyoImiKCoKAAAIAiAAAgzGeXDz88XXpx5XflHi893vp17+j09ultKAAAAAAAAAAAAAAAAQgWgAUAAAIAAAFIWAAAAqgKAAAqKICoAoIqKAIAoigAioKIACoqAAAAgKgCAKCoKAAAIAgIAACBmSY585cpbvet3VWigAAAAAAAAAAAAAAAKIhBaABQAAAIAAAUioAAACqAoAACoogKgCoqKCKioqCgCCoqAKgAAAAAACAAgAoCgAAAAIIIAAAISIii0oKAAAAAAAAAAAAAAAALKIQCgAChFIUAIAAACoKIAALQoAAAAqCooIAqKCKioqCgCCoqAAAAAAAAAgAIAKAoAAAACAiAAAASAAqgAAAAAAAAAAAAAAAFILKEAAAACxSFAAgAAApKACKgpQoAAAAqCooIAqKCKioqKCAoiggAAAAAlBYAIogARYKJagKAAACAgQAAACKgKAAAAAAAAAAAAAAABQAgAAAAAAFAAIAAKFCoAAkKooAAAAKIKCAAKCKioqKCAoiggAAAAAAAAiiABFgolqAoAAAICKkAAAAAAAAAAAAAAAAAAAACiFACAAAAAAAUAAlgAKoloAADNgooAAAAKIKCAAKAACAogCggKgAAAAAAAAgAgKAAKigAAAgIgAAAAAAAAAAAAAAAAAAAKKIAIAAAAAAAAKihAAKKAoAAqEAoJQAAACiACiAoCKAgKIAoICoAAAAAAAAIAII0AAKigAAAgDIAAAAAAAAAAAAAAAAAAoAKIAgAAAAAAAAAKQCoKKCCgKCiICiFJQAAAogAogKAAAiiCggKCAAqAAAAAAgAIACgCiCooASgCCIAAAAAAAAAAAAAAAAAKAoAgIAAAAAAAAAAAAoACAoiqpQIgCgAACoKIqKgoCKAAAiiCggKCAAqAAAAAAgAIACgCiCooAAAgggAAAAAAAAAAAAAAAAoAKAICAAAAlAAAAAAAAoACAoigtloiAKAAAKgoiggoCKACAWKAAgKCACoogAAAAAgBAiqgoqAAKIoAAIIQAAAAAAAAAAAAAAAoAoACAgAAAgI0AAAAAAUigIUQAAAo0WCAoAAAAogoAICgAgFigAICggAqKIAAAAAIAlICoKKgACiKAACCEAAAAAAAAAAAAAACgAKAAggAAAICLQAAAAAFIoIFIAAAKirQgFEoAAAogoAICgAIAoIoIKJYAqKCAsAAAAAgAQAqoAqAACgAAggIAAAAAAAAAAAACgqCgAAECAAAAICLQAAAAAoCAFIAAAAKUACgAAKIKgKIAKAAgCgiggoQAqCiAWAAAAEqABAKAAqAACgAAggIAAAAAAAAAAACooCoKAAAkAAAAAgIWgAAAAUAgAAAAAABSgiqAAAogqAogAoAAAIoCAKgogKAIqAAAACKgAgqJSgAAACgAAgIgAAAAAAAAAAAKKigAqAgCAAAAAIAQNAAAACiKQAAAAAFgKiqgCqAAACiCiKgCgAAAigIAqCiAoAioAAAAIqAIIqFKAAAAKAACAggAAAAAAAAAAKAqKCoKgIAgAAAACAEClAAABQioAAAAAAAqKACqAAACiCiKgCgAIoCKIoCCggqKEKgAAAACKIIICiooAigACgAAIgIAAAAAAAAACgoAKIAAgIAAAAACAACgAAFBAAAAAAAAFICgKoAqAKgoIqACgAIoCKIoCCggoBCoAAAAAiiCCAoqKIoigAAoAAIgCAAAAAAAAAKAoAKIAIAIAAAAACAABQAAFBAAAAAAAAFCCgKoAqAKgoIqACgAACKAigIoACCoAAKgAACAIQKACopCwKAAoAAgCCAAAAAAAAqKoACiACAAgAAAAAAIoiiKlAAChABYAAAAAAKKhCgLQAKioCkCgAAAACKAigIoACCoAAKgAACAIsgq5oCopCwKAAoAAgCCAAAAAAAoAKCoCiACArIAAAAAAAiiKIqUAAKIA0kAAAAAACioQoBaACoqApAoAIKAACAqAoIKAAIAKioAAAIAIrIqKACoCKLAKAo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KJQAALBAmW8XHj306828yWaSNTnzd7LefZi76zOOc30qyCTV1cMrboFAjEmi2lAAEc9aAAAAAAAmcta0IKsgFioqAUCKAKAKAJQAAAAskQLaASCigLKAAAAAACKAAAAACCoKgqCoAAAzKgk0KJQIqChBLKTOmceTz5+lx469FuZuS852Y573qpz3rs545J011sxJdatpMNW2AUCCZZx12KAARi6AAAAAABnMutUIoQBQCKJQAqAoAoAAAAAAskQLaCEgCgqqAAAAqAAAigAAAJQACKIAKgsAEyAxqqAAiiFgJKqKc5c5ce2bMVbJ5u3eTVpZjp0z5N6q9LMjWqAAsBYqGcY0mrulAAIY1QAAAAAAxGrQKEAKogqAAoACooAAAAAAqBMgXQkgAAKrQAAACoAAAAAAAJQAACCoKgACSAcnWgAACACSqypnLKcO9k53c0zxuzWpNHXTn4e3p6Bm0AAoQLComed3pQUAAhm0AAAAAAky1oAogAqgioACgCgigAAAAACoEyBbZEAAAK2AAAAlSgACoAAAAKgAAgogogAMwDPDt0AAAEAAkCmc5xreZcaussY6JaXM3rejJaAAAKgCwqJzje5nDerQAEEoAAAAABiLdAKBADQAAAAACgAAAAAAAEyAqAAAAOgAAACVKAAKgAAAAqAIoIKIKIADMA557gAACAAEgozOMtmePbp0Z589rrLG+l6b0uciAAAAAFgMykzpqWqigEEoAAAAADGWtagCgQA0AAAAAAoAAAAAAABMgAAAAA6AAAABKAAAAAAAAAIqAKCAEoiIDnd0AACAABzm6KMc0ktzdWZmda0turemkkhICAqAAAAmc6jdzm6oWCiCKAACqKlSM8rpk1sAC0kANKgCoKgqKASgAAAAAAAJIAAAAADoAAAAEoAAAAAAAAAioAoIAAmagOXVQAAgAAJybo0JmySTjntoW1Yl1ei6skSAgiggACoMYxvpbM897oWAqCKACqoiBUc/H87t136Ou9wAC0kANKgKIKgqKASgAAAAkIKACAAAAAAOgAAAAAAAAigAAAAAIAqKAgCZAYx3CoKgIAACc86tzaJ5+nQMzeZbaIkuta1uokggIqACKiiE5cs260xz16dgAAlAKtCQgCOPyvD6b4PV9f2bIAKqpCAtqKAIqCooAAAAKgMwAAACoAAAAA6AAAAAAAACKAAA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AoioKgqAACKIqAKgCKCKCKCKgCKIqKCCoACgUoAEkgAAAAABFBFAAAAAAAAAAAAAAAAAAAAA6CKAACoAqAAqACoAAACoohQgoiiCkqKgCooioKIqAACKAgqKioAAAAACKiiAAACAoKKAAhJAAAAAAEUAAAAAAAAAAAAAAAAAAAAAA6KgCKAAEoAAAAAAJQAFIKAipQIoAJQioqKigIpAqKMigogJQAAAAiiKgAAAiiFBAoFAWAiRAAAAAAAAAAAAACoAAAAAAWCoAAKIAAAA6KgACKAEoAAAAAAJQAFIKIoEoIoAhQAIoAIpAqKICoogJQAAAAiiKgsAAAAAsAKWAWAiRAAAAAAAAAAAAACoAAAAAAUgAACqggAAA6AAAAAKgAAAAAAAKITQigAACCoqKigIoCCiKCAoIoIqKAQWWAAAAAAAAAAAAAACDMAAAAAAAAAAAAACiAAABSAAAAACgqQAAA6AAAAAKgAAAAAAAKISqigAACCooMtCKigIKIogKAigiooBBZYAAAAAAAAAAAAAAITIAACkAAAAAAAAAAogAAAUCAAAAAoKkAAAOgAAqAAEUAAAAAACoKEKAigBKAigiKqUSgJQCAoICoKIsqKIKAhQgI0iiAAAoISgAigABEyAABdIkAAAAAAAAACggAAAUoiAAAAKAAgAAOgAAqAigRQAAAAAAKgoQoCKAEoCKCCiUSiUlCKIKCAqI0IUiiCiKhQCCoogCggoIsAAKIAISQAAKWmUAAAAAAAAAFAgAAAUoIIAAACgiiAAqDoAKgAAAlAAAAACpKqJaIsAqKIoIoAACBQCKlABBQgJSgAIolAAlIoEKIAqWAolioKEKCAJYygABVohIAAAAAAAAAKAIAAAKCgiAAAAKioAAojoAKgAAAlAAAAACpKqJaIsAqKIoIoIoAMqUACUAEFgAUAIoiiUACUy0CWKIoBACpYqChAKgCJIAApVDJAAAAAAAAAKAAgAAAoKAyAAAAqKgACiOgAAAAAAAAqAAlAKCAoAQKIKihKAAigAAJQQKIoACFEKACKAgqKgoAioKAIqAAAKkTIABTQhIAAAKgAAAACgJaJAAAAoCgJAAAAAAAAOgAAAAAAAAqAAlAKCIqgBAqAqKEoAAAAAJQlIKigAIUSgAIoAigAgoioKAIqAAAKyzAAFUqIQAAAKgAAAACgJaJAAAAKAopIgAAAAAAA6CKAAACUAAAAAAACgAASpSCiCoKSjKqgEqgCUEVAFSgSoKlCKigAAEUBCoAUlACKiiBSQTIAiy6AiAAAAAAAAAAUACAAAAAKKoJIAAAAAACzoAAAIoJQAAAAAAAKAABKlIKIKIpKIKgLCiKEqLFQBUoEoipQioKAAgsUBCoAUSgIKgohSQZgAFoDIAAAAAAAAABQCAAAAAAoLQQkAAAAAADqgqAAAAAAAAAI0goigAgKM2iKCCgARYoCFkWgQLKIolACVFIoCFAAIpAoAIqKigSWkKICohmAALayIAAAAAqAAAAAAogAAAAAAC0qCIAAAAAA6oKgAAAAAAAAAqCiKIoICjNoiggoIoRQIqFktAkoUAM2gIVFIKAQqCgCUiggoIqKBJaQogKykgAKVKyAAAAAAAAAAAAogAAAAAABSqDMAAAAAA6CkKgAAhQAAAAIoCgigAAAAlAAhQAIUABAKiggCiKAhQCAoACUAgloBKIoASgJCSACioIAAAAAAAAAAAAFCAAAAAAAC0qpIgAAAAA6CkKgAAJQAAAACoCgigAAAAlAAEoAIUAgsAqKCCgIoCFAAAACUAipQBKAAEoCQzAKCjIAAAAAAAAAAAABQgAAAAAAAU0qDMAAAAAOgAAAAAAigAAKgKAAAAgoAiiKAABFAJSCwUQUCKJQigAAAASiKAigAJSKCFIKhDKAKKJAAKIAAAAAAAAAACiAAAAAAAALVAMwAAAAOgAAAAAAAAACoCgAAiggoAijLQAAEUASoFhRBQIKSgCKIoigIpKIoCKAAlIKIUIERCAqgiAAKIAAAAAAAAAACiAAAAAAAAFUoESAAAAOgogAAAAAAAAqSgKAhQioqFEoICoKAAIoAIolihFBKQsoikUlIKCAUIoCKAJSFECkqKyMoqKC2FkgACoAAAAAAAAAAAKIAAAAAAAACqUCJAAAA6CiAAAAAAAACpKAoCFigCFEoCCoKAAIKAIolARSLKQUIpLBSCggFAAgoiiUhYsI0lIIkgqKC2EgAAqAAAAAAAAAAACiAAAAAAAAAKWiwkgAAA6ACoAAAAACoAAAoAJQACCooAighUoCKyoVBQACUlEUCUgCgSoAogoAIKIJaCFIqIjIKiqAkACoAAAAAAAAAAAAoIAAAAAAAAAKooIkAAA6ACoAAAAACoAAAoAJQCKIKiiKIogVKAiooSwUIoipSURQhQgKBAAogoAICoJaCFIISICgoIgAKgAAAAAAAAAAACggAAAAAAAAAoKoJIAADoAJQAAAAACiAAqCgMtIKCKigAIKIoJQIoIoCKioBSUIoAIogKICiKEqKACCkoECBIgoqgiIAoCAAAAogAACgAgACgCAAAAAAAAAKAoQgAA6ACUAAAAAAogAKgoCAjQIqKAAgoiglAigigIqKioUlAAAiiAogKigSgACKEoEDIQgqigygKACAAqAoCAAKIoKICACgCAAAAAAAAAKACwgAA6CFAEoiioAAKiiCoAoigiiKCLCiUCKEUAAAgoEoAAEKCCgAihLKElqKM2hCwoM2gAkEiAKoCyICgIAACoqgIAAACgIqCAKAIAAAAAAAAACgCAAA6ASgJQAqAACoogqAKACKIoIWKhQAEUIoACCgQoAAQogKAIKJUoSWgM2oUQoJKoAkJCAooIsgCgIAACgoCAAAAoKgggCgCAAAAAAAAAAoAgAAOgAAAAAAqKgqCiCgAAAlAIoigAAAhRFAAAIoIoigAiggqKASgCKAgoCKICMkAqgCICgBAAAqgAsAAAAoikARBagAIAAAAUgAAAAoIAAA6AAAAAACoqCoKIKAAigJQACKAAAAlEUAAAAIoAAIoIoigEoigAIKAijIJBAqgIIAoAgAKCgoAAgAAoAIBEFAAIAAAAsAAAAAKIAAA6oBKAAAqAKgACoCgAAAEKAAASggUIolAIoAAQoCVCgCBRAoSoUAigAlARIIgoNCDIKAqIACgoKAAACKIqKCoAgkKAAIAAAAAAAAAAAAADqgEoAKgKgCoAAqAoAIoAEKgoABKCBQigigAigCUAJUKCKCUQoiyjNoCKACUCRIIDQKIiAoAIAKCgoAqAAAIoAqAIJKAIoIAAAAAAAAAAAAADoSgAAAAAAAogCkUIoCUlQqKigEqKAgoAIoAIUAIoigAADNsolIoAEoIUyooiEyKKLAIgCggACgpQKAgAAACgAgEkKARQgAAAAAFqIAAAAAAA6EoAAAAAAAKIApFCKAlJUKiooCUACCgACKAhQIqKIoCKAIlUEoIoBKCFIqKIiSCqKQggAoIAAoKoCgIAAAAoAIBJCioRQgAAAAAFoiAAAAAAA6AAAAAAAogogCgAigACKiooipQACCgAigIKJSChAqAsKAIoAhQSNAJLQM0QiINAqCCAqAACliigoACKigAAAAioIkChAqCoAAAAAq0kgAAAAAAOgAAAAAAKIKIAoAIoAAigiiKlIoAgoCAoICiUAECoCwoAigIFCWKARQJBLIAooiIAKgAApQoCgAAAAAAAAIiQKECoKgAAAAClqSAAAAAAA6AqAAAAI0gKgAKigAiooAIoIoCKgoCLCgiglIKJQACUAgUASxUE0IqFAACVEJAKKIIgAqAAqKFoKACoKiKAAAAAAiSAqyAqUIAAAAAKqAgAAAAADoCoAAAAKgKgAKigAiooAIoAAioKAEKiooJQiiUAAzaAgsoIVFQloioWKAAlSIkKKoIiAAqAAooUKAAqCoAAAAAACSQCkAqUIAAAAAKAIAKgAAADoAAAAAKioAACooIKAipQIKAiooAAEFIoCVFABFAAiiCgIoAlIKBFAM2pUkyoKogiACoAAKpRQAAogWAAAAAACEyBRAKIKgAAAACgCAKQAAAA6AAAAACoqAAAqKCCgIqUCKAgqKAAAEqKAlRQARQAIoIoAACUABFAM2kRmKooIiAAqAKAqgUAAKIFgAAAAAAiSAUQCiCoAAAAAoAgCoAAAAOgAAAAAqAAAqKACKlAJSLCgCCgACVKAikoigQsoAAIoIqKiopKIoSgAgqKiJI0AEIKiiAAqgKoKIogqAoioAAjQgACEiALAoAIAAAAACoAACoAAADoAAAAAKgAAKigACUAlBCgCKAigJUoCKSgASkoIoCKACKigSgBKAACKiJCgCSoKiiACiqAoKIogqCgCAACiAAISCAsCgAgAAAAAAAACoAAADoAAAAAqAogKigAAAAEoJQCKAAEoAAAAEoAAlASgCKAigAlAACKiIFEIgKCAA0CqAAKIqCoAoIqACooICKiSAAUAACKCAAAAAAAAAAADoAAAAAqAogKigAAAAEoJQAAABKAigAAJQigDNKEoIqKAigAlAIoiKIgUkIAoIAooooAAoiiKgAAqACoKIAhJAAFAAAiggAAAAAAAAAAA6AEoAKIAKICoqKAigAigCKAAAAAIoASkUAJQAAIoCKAARYFAACKCCECjMAAogKooAoCoKioALChAKQCiAFgiSAAFAACCkAACoAAAAFgAAAOgBKACiACiAqKigMtAAigAAAIqKigCKAEpLKAiygAAigAAARQSgACAqCECokAAqAqigoACoKioigsKEApAKIAlIJIAAUAAIKQCgAioAAAAAAAA6AKglAogAKgJQAKAAlSgigAIoEoikUACUAAAAAAiiKAlJKoAAgoCKgqIgKyIAACqoUCoqAqKIoipKqAApAAqAqEDMAWAoAAEAAoCoCAAAAAAAAOgCoEoKIACoCUACgAJUoIqKAABKIqWUCKEoAAAAACKAAQljQAAgoIKgqIgCCAACqoFAqKgKgAqKzSoACkACoCiQjIBYCgAAQAKCggqIAAAAAAADoqAAsCNIqCiAqAoACCiUACKAAAiiKAAlAAARQAAIoSgAAAAQKCKIKhCIAikAqqCgAqKgsoIqUAioqAoAIoCKgkkAAKAAAIWCigqAIIqAAAAAAA6KgALAKioKICoCgiggoQoAigIoIKCKAAlAAASgAIoihKAAAABAoIoAiDIAikCqoCgAACygipQCKioCgAigIAkkAAKAAAIWCigqAIAgAAAAAAOgKgBKKIKgAAqKIKIoigigglsoCUQoIoAAAlACKACUIoAigihCkolRSKAAIiEAIKjQooKAioqACoKhLSFIKgqAKhNCIoiSAACgICiAA0CggAgAIAAAAADoCoASiiCoAAoiiCiKIoAioEtAJRCooAigiglAAAAlAACKABCkolRSKAADKEAIKKoKCgIqKCAoihFIUgqAAKhNAgJJAAAoCAAAKoKCACAAIAAAAAOgAAAAAAAKIAAoAAhQigiopKIoAACUgoktigAAAAIoCKAACKigJSLAiICCqqWgCiKBAoCKIogoCIoAAKigEiSAABQIAAoJSqACKIAioqAiiAAADoAAAAAAACiAAoAAIUIoAikoCKAAJSCiS0AIoAAAACKAAAIoCUECIgAqgoKiiCosCgIoioCgioACoCoqKJCSAABQIAAoFCgAAgCKioKgEAAAOgBKigACNCCoqCiCgCKAAAAJQAAAgoAAIKAAAAAAlJQCUiooCUQqKlEIgAoqKolBKIoCColoQIoogKgKJUqAKgiJAAAoBAAKAqgAAASoKgAgCAAA6AJQAigCiCoqCiCgigAAAAJQAAAgqKAAAAAAAAASpQCUCCglAIqUQIAAoKEKSiKAgqFJUACiAAKJUoCKiDJAAAoBAAKAqgAAASoKgAAiAAA6CoKCAqAqAoyqiKAIKAIqTQAAikpKABKAAAACUCKigRQCUAgTQIoIoAAAJSKgAoIqCkoCKICygAIqCoBQCACiIRIAACiKQACgooCoAAAAABAiAADoKgoICoCoCiCiKAIKAIpKAAIpKSgASgAAAAlIqKAEUIqUAGVoIoIoAAAJSKgqCgioKSggogLKAAioKgFAgAKgiRAAAKIAACgooCoAAAAABAiAADoKIAAqCoAKgAKAighSKACKAigAgoCUSgAIoAAAACKligAIoCKIqCiUCKgAUhQiglShKhQICpNAAiwKgCoCoAhJAAAAAAACqKCiKICoACggAgggAOiNCAAKgqACoACgIoIUAAIoCKACCgJRKAAigAAAAIoAigIoCKAgqLCiKCAUhQiglQpKEoICpNIKCFiiAogKgCJEAAAAAAAKooKIogKgAKCACCCAA6CgCAAogqKACCgigAAEoIoAAAAAIoAAICgCUIoAAAJQAAigAAhQlCKgok0ioCgIqKiiKABAKAAgCpYAiQgAAAAAAKKooACKACKAAIEAggDoKAIACiCooAIKCKAAASgAAAAAIoigAAgoAJQAAAAJQAAAAABKJQiooJNIqAoIKiooigAQCoCggCpYAiSAAAAAAKAKooACKACKAAIAgggDoKIAACiKlAigIoAigAAAAigIoAIoAAAAAAAAAAIoSgAEoACKigJQAAAEFiooAlEKAIAAKgAohYKiEyAAAAACgKi0KAAAAAAAAgICIA6CiAKgCiKliiKAigCKCKAAAIoCKAAAAAAAAAAigACKEoACUAACKAQoACKCWFAACUQoCAACiAqKIWCpCSAAAAAAoChQoAAAAAAACAgIgDoKgAAAKCACggKIUAgUIoIoCKAioWUAAlACKAASiCiWKlAAAABFAAigCCoqAWKJRKAIolAIqAIoCoKCACoIiQAAAAAKKAoqKAAAJagAAiggqIqIIOgqAAACNAgAoICiFAIFCKCKAigAJUoCKJQAigCKQoCFCUAigAARQAIoIoioqAsKJSUAIoligioAKgKgogAKhEJAAAAAAoooCooAAAlqAACKioKgIgg6AACiKgoIqAUgqIooAIoAEoAIoAAAgKiiUSWooIKIpKAAAIoAlCUAShCooAIWAoAioogoAgUEFAQoIUgqACESAACiAAKooKAAAAiikAAAAiggIgjoAAKIqCgioBSKIAoCKiooBKCCooAAAiooCURQAIoBKCKAAAAlCUAlCUAIoIsAKIqKiiCiCiFikKIqWKioUgqACEkAAKCAAoooKAAAAiikAAAAiggIgOgIAKgKiiKIAoIqKACKACKAAAASgiiKigCCgAAACUASgEoAAioFCKAAAAgASgUCFIFCAqUgKipQIqAAIkgABQIogKKUCgAAAAAAAAAAgAgjoCACoCooiiAKCKigAigAigAAAEoIoiooAAAAAAJQIUASgAACFIKCKCUACALAqUCFIFAgFICglACAAIkgABQIogKKUWKAAqAAAIoAAAAgAgjogACoAAKAIlslAoIogqKICgCKCUCKAAAigAAIoAEVFAJLQEoACUSgiypQAIoCKEsKACFAAiiKSoKiooioKioIiQAAoAgCiigoAAAAAAAAAAAioAjaACoqAACiKIlslAoIogqKICgAAlAiooAigCCgAAAEVFAEsKEoAIsqUASpQAACChFAighYKCCgEqCoqKIqCoqIQyAAKAIAoooKAAAAAAAAAACKioAjQCoCNIKgqKIoiooIoAIoIoIKigAIqCgAAACUAAEoASgCKAAlAACUASgigAIKAIoAEoCCgIpAoAioKgIISAAFAIAKooCgAAAAAAAAAAAEAKAqAKiNCKiiKIqKCKACKCKCCooCKIqKCCgAAJQAASgBKAIoAIUCKBFAJYoAIoIoAgoCKSgAAIpAKACCoICJAABQCACqKAoAAAAAAAAAAABACiooCCoKiiAKiiKIogqCgAAigCCgAiiKAJQAACKIoIqUIFDNoCWUABFARQCKQKIoigAAAAIoCKigiglAIlIhIAAFCABQqgFAqACoAAAAAAAAAgCiooCCiKiiAKiiKIogqCgAAigAAAIoigikqCgAAAAJQIUJQBFAihKIpFAgqUAgqKAAigACKAAAioFAIlIhIAAqUIAFCqAUCoAKgCoAAAAAAAILCgCoqAogAAAqBSCgCAAKgACgIogKigAQoAAAACKAJUKigAAAAAASgACKAACKAAQKIoAgAqVKJKJEgCoCoqAAKqgCgAAqACwAAAAAAAAgoAqKgKIAAAKgUgoAgACoAAoCCoCooAEKAAAAigACVKAAAAigAIoSggoAAAAAAEKCKAIAKlk0JKREgCoCoqAAKqgKAAArKgEoAKgAAAAAINCCgiKKIAKAigACKigIAKigAAgoIqUAAIoAiglAigAJQIUgqUAAihCgIoCK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ACoACiAAogAAigiiKCCooigIUEoAAAWCoKiCooCAoACVCqgoNAAAiA0AAAAAAAAAAAAAAAyC0AAAAAigAADIAAAAAAAAAAASgEACoAAAAAEoAACKAgKAIKgoCKSooACKiiKCAKAAhQigAiioKWgABESlKAAAAAAAAAAJQAAACIBaAAAAAAAADIAigAAAAAAAACUIpAAqAAAAABKAAAigICgCCoKAipSKAAiooAIAoACFCKACKKgtoAAJCVVAAACKAAAAAACUAAAAggKoAAAAAAAAyCKAAAAAJQAAAAAICoKgKiUWAAAACKCKIoAIqKACKAgCgCCiKACKSyqiKAAAAIoqBVoABIBaAAAAAAAAACKAAAAAAgIFoAAAAAAADIIoAAAigCUAAAAACAqAAqJSUAAAAgogoigAigACKAgCgCCiKACKRSoigAAACKKypbQACQC0AAAAAAAAACKAAAAAAgIA0AAAAAAADIIoAAiiCgAAAAAAAgAKgAAKIAlASopKAiiCgAlSgAECgAigCCgICkKAACKgoAiqDQAqDIUoAAAAAAAAAAAAAAAAAIQDQAAAAAAAyCKAAAAAAAAACCgCAAqAAAogIUBKBKAiiCgCFSgAECgAiggqKAgKQoAAAgoCCqLQBYJAtAAAAAAAAAAAAAAAAAABIJQ0AAAAAADIIKAAAAAAACUACKCSgCiAAAAAASgilglAiqgCKACLKgKJSACoKiggoCCgABKAAiy0tAAJBaAAAAAAAAAAAAAAAAAAAEgBVAAAAAAMggoAAAAAAAJQAIqKkoAqAAAAAAEoAlBKAKgAAigSoChKgoCCooIKAgoACLKAAhaWygILJRQAAAAAAAAAAAAAAAAAAASoglKoAAAAAMiCooAAAAASgAJUWKgKIAiioAAigAACwAiiUjSAAIoAqIoigCKAigqCCggqKEoIoCUipVWgCIUoAAAAAAAAAAAACFAAAAAAACIgW0AAAAAMiCooAAAAASgAEsUICiAIoqAAIoAigBKAiiUKgACKAAAigCCgigqAAIKihKCKAlIpS0Agi0AAAAAAAAAAAAAIUAAAAAAACRApaAAAAAyCUAAAAAAAAAAImggAAKgQqoEoiooCKAigFgiooACKAIoAgAoAIoigIoIAKAKhQqgIgWgAAAAAAAAAAAAAAAAAAAAAAkAFUAAAAMglAAAAAAAAAACAqAAAqCWKqCwIoAIoCKAlCKigAIoAigCACooIKIoCKCACgCooqgDIpQAAAAAAAAAAAAAAAAAAAAAAEQIUtAAAAMoqKAAAAAAAAQKAQAIoAKgACiCKioqKiooCKgoigioKgKioqKAAioqKgKEoIqACgigUqgCIFoAAAAAAAAAAAAAAAAAAAAAAAAiBKpQAAAyiooigAAAAAAJQAEAAAAqAAKIIoIqKiooCKgoigCCiCoqKigAAiggKEoIqACgigqqAIgLQAAAAAAAAAAAAAAAAAAAAAAAAJBCi0AAAyAIoAAAAAJQAAiorJQCoAogAAAAgoBAKioKAAEKCFIoqAiiKKgqCUAWQqKCCgAqqAiAKoAAAAAAAAAAAAAAQoAAAAAAAAACIgo0AAAyAIoAAAAAJYoAIKioSgKgCiAAAAAigEAqKIoAAQoIUAqAiiKKgqCUAWSgAgoAWigiADQAAAAAAAAAAAAAAEKAAAAAAAAAAggCqAADKKJQAAAAAAAACKAiiKgCoAAKIIoAAqABCiKAASgACKAAACCgAgUACAolLSgIgAqgAAAAAAAAAAAAAAAAAAAAAAAAAIIA0AADICUCKAAAIoAAAIoCKIqAKgAAogioKAKgAQKigAhQAIqKAAAAigIqKSgAgKFKKAyAKoAAAAAAAAAAAAAAAAigAAAAAAAACAio0AADIigCUAEKAACCgACAJagAAAAAAAAAEqKigSgjSQKCKAAAICgiygioUAQKiihaAIIAqgAAAAAIqKAAAIAAoAAAAAAAAAAAAAIqCgAAMjOiKCUAJQAAAAAAgBNIAAAAAAAAACUigCUCNJAoIoAAAgKCFACFAECoootAIgCigAAAAACKigAACAAKAAAAAAAAAAAAACKgoAADIIoCKAAAAACKiggAABYAAigACFAAEoIoACKCKigAAAAigAAAiiKAIoKNAJAA0AAAAACAgAKCKIKIAAoUAhSKAAAAAAAAAAAAAAMgigAAAAIoAIqKCAAAFgACKAAIUAASgigAIoIqKAAAACKAAACKIoAChSgiACqAAAAAioIAAAKIKgAAKUAhSKAAAAAAAAAAAAAAMUAAAAAAigAACCoAqAAAlCUAAJQigAAiooAAAAlAAIFRUKBAoAAAAoqgMgCqAAAAAICAAAAAAAAAqgCKAAAAAAAAAAAAAAAMUAAAigAAAAACAAKgAAEoSgACUIoAAIqKAAAAEoACBUWUAlgoAAAAtKAMgDQAAAAIoggAAAAACKAAKoAigAAAAAAAAAAAAAADIAAAAACKJQCKAIJSiAAKgJQAAAogAAAigiooAlAIKIoSggoIoCwAAAotAIQCqAAAAAggAAAAAAAIUAFUAAAAAAAAAhQAAAAAADIAAAAAACUAAAglKIAAqASgAACiAAACKCKigBCggqCiUCCggoJQAigKLQDIA0AAAAAgIAIoACKAAAhQAVQAAAAAAAACJSgAAAAAAyAAAAAAIoSoKAgAogAAqAAKgAAqACKqAKkKgoIoAAgoABKAigACKigK0AiACqAAAACQAAAAAAigAAABaAigAAAAAAAyLQAAAAAAMgAAAAAADNqCgCAKIAAKgACoAAKgAiqgCpCoKIKAAIKAASgAAAgqKFFoIgCigAAAAJAIqKigAACKAAAAFoCKAAAAAAACItAAAAAAAyAAAAACKACUCKQogKgAIoACUqAAAgoACFAIKAIoJSKAACChKsgoAAFKKIgBaAAAAAyAAIIoqCgICgAAAFUAAAAAAAAAAAAAAAAAMgigAAACKAAACWKICoACKAAlKgAAIKAAhQCCgCKipSKAAAihKQKAACqoIgClAAAAAMgigIIqiCgCCgAAAFUCKAAAAAAAAAAAigAAADIAAAAAIqKAAAgKCCoqI0ipKAqAAAIKAiiKIoAIoiiKgoAiiKAAIoACoC2giAFoAAAAIgAkqUpCUCwKgqKAigCAq0BKAAAAAAAAAAAAAAAAMooAAAACKAAAAgoIKiiKipKAqAAAIKAAigAAiiKIqCgCKIoAAigAKgVaIgBVAAAACIACSkqpYSgzojSCooCKAICrQEoAAAAAAAAAAAAAAAAyAAAAAIoSiKAIoIqKgAAKgAslAJQCUIoBCiKAiiAqFAACoAAAAIoAFFqQANAAAACCABAAqAAlAizQCEWgIoFoAAAigAAAAAAAAAAAAAMgAigAAAEoigiooIqKgAAKgARQBKAlCKAQoiiAoIKhQCKCoACKAAiooBRakAooAAACIACLAAqAAlAhaAhFoCKBaAAAIoAAAAAAAAAAAAADIAQoAAABCgiggBKAigAACKAqAAigIoAAAAAACUAAEKAAigigAUqAKoAAAAiACKgqSgACUAgUEooQKihSgACKAAAAAAAAAAAAAAAyAEoAACUCUAiggBYAAAAAAAAAigIoAAAAAACUAAEKAAigigAUqAWgAAAIIIKIArNACKEoCKSiUKJKKihaAACKAAAAAAAAAAAAAAAyAAAAAAiiCooIogAKgKgEoKIJQIoAAAlSgiiKAAAACCiVFEoJQiiCgBQBaAAAAggCATSAKkqCiUCKigCoCKAoqgAAAAAAAAAAAAAAAAADIAAAAACKIKAIogAKgKgEoKIFgIoAAAlSgiiKAAAAioKEsUSglACKABQBaAAAIIAioBSAKkoihKAIoAqAACloAAAAAAAAAAAAAAAAAAMggoAAAAigAigIsAAqAAAACoAACKIKgoigIoCKACKARQAACKAAAUAtAAAIgBKIAACKAEqKACKAqCKBQWgAAAAAEoAiiKAAAAAAAAAyCCgAIoAAACKCCwACoAAAAKgAAIogqCiKAigIoAIoBFAAAIoCKAqUKFAAAMgIUIAACKCKSooAIoCoIoJaFoAAAAABKAIoigAAAAAAAAMgAAAgoIoAAgKgoIAACoAihCgKiCiKIKAAAhSUigCKAAAAAAiiKlSiiqAAAIgAgqBKogCKJQAAIsoAACoFKoAAAAAAAIIoKAAAAAAAADIAAAIKAAIoICoKCCKACoAAlACogoiiCgAAIUlIoAigAAAAAIoipUooqgAADIAIjSBKoyqKiiUAACFAAAKgVaAAAAAAAAggooAAAAAAAAMgSgAAAACKAgogqKIAAqAAAWKgCKlAACCiABYoEKigIoAigIKAAAAo0AAAiACAEtIAqAWAACiABGiSioKilUAAAAAAAJKgACgoAAAAAAAyBKAAAAAAAiggqKIAAqKgACUqAIqUAAIKIAFAEKigIoAgoIKAAAAo0AAIIIKIARayqKqAlIoAKIAJSs0KgqKVQAAAAAAAkAAAooAAAAAAAyAAAAAAAAAIoCAqAqKgASgAAAAAAI0gAzqCgIoAAikoAAAEolSiNAWgAiAIKgCCgAAACFIoAigqJSoIopaAAAAAAAEgAACoKCooIoAAADIAAAAAAAAIqKIqAqAqKgASgAAAAAACsqAsgoCKAAIpKAAABKEsoKiloAMiKIKyoIoAAAABAoAigqEqoIpS0AAAAAAAEgAACoKCoAKAAAAzKlAACFAAAAAIAqSgAAColACKACoAAigCKikoAAgCypSCiKCoiiCgEKlFCoAElCKigAIqoIAoKIKMigCKAKIotAAAAAAAAiAAAAKIAAooAAA52pQAAhQAAAACAKkoAAAqJQAigAqAAIoAAJQAAgCykqCiAqoiiCooQqUFiooQRQCKAAiqggCgoyqjIKAigCiKLQAAAAAAAIgAAAAAAANAAADKFCKAIoIoACCgIKCAKiiAKkqoAAAKgAAAAigSoKCCgAIoICgigCLKiiKALASoUqAAICgCUAAAqAAAWBSCilAAAAAAACIAAAAAAAAFoAAMoUIoAigigAIKioCiACooCAlKgAAAqAAAACKBKgoIoAAiggKCKAIsqKIoAsgUi2KgACAoAWAAAAAACUJagpRQAAAAAAAyAIoAAAAAAFoAAMgigSgigEoAAAiwqAqAqBKKICoACiAAigAAAIKIoAAAAAAAhQqAIoEKKyoIoAIUIKIKCwAAKgIWiAAKhRaAAAAAAACIAAJQAAAAACqAAMgigSgigEoIoAAQqAqAqBKKICoACiAAigAAAICooAAAAAAAJQqAIoJYorKgAigi2CCiCgsAAiqgIWiAAKhRaAAAAAAACICKAlAAAAIqKA0AAMUigiooAAEpKCKEpKQAAAAAAAAogSgAAACKIKAlAAAIKgUAAAqCKigIKACKigigAIoJQCKigBCiKCoAKWgAAAAAAAiAAAAAlAAIoACqADFIoIqKAIoIpKCKECkAAAAAAAAKILAAAAAiiCgJQAACCoFACKAqIKigIKACKigiooAiglAAigBCiCioAKWgAAAAAAAyAAAAAlAAIoAA0ADIgoAACKDKqIoCAogBUAAAAEqoKgBKSiKAAAIoiioAACoAgoiiCiKAAAigACKJUKAAAAACoAAAIWiQqKpaAAAAAAAggAAAAAAIoIKACqAMgAAACKCCiKAgKIAVAAAACUqCoAlEoigAAACKKgAAKgCCiKIKIoAAAAAABLCgAIoAACoAAABQzQKFoAAAAACAIAAAAAAAiggoAKoAyAAAIKgCoqKgoIKQKgqAAAAKghQAAAIoiiFAIoAAIoAAgCgAAIoIoIoioKigIqKCUAIoAoCFgi0gKCJQULQAAAAAIgAAAAAAigigIrNoAAqgyIoAIqCiAoAJQCKQKgqAACoAqAWAAAAigCFAIoAAIoAAgCgAAIoIoIoigIoAIoEoAAAoCJQhagKCJQVRQAAAAAIgAAAAAAiggKIqTQAANAyIqKAioKgoAACUAEAogAAACoAAAqCoAAAiiKAigAAAigCAKiooICooIoAAJQgoAAACKsAIsqWWoigKgFWgAAAAAMgAARQACUIloCAlqFAAApTIigAiooiaAigAlABAoIAAAAqAAAKgqAAAIoiiKigAAAigCAKiooICooIoAAJSAoigCKIqKQoIUllqAAqAq0AAAAAAyAIoEUAAlCJaAgJahQAAKUyIoAgoEFIqKAAiiACoqKihAAAKyqUCoAAAAAACKigAAAACKCKCKgoAAigABKlIKAAIqBQigigAACkKFoAAAAAAyAAAEoAJQASKKAgCooAKMqigICgQUiooACKIAKioqKEAAArKpQKgAAAAACKiooAAAAAigigioKAAIoAAsJSKAACKgUAiooACKCkKFoAAAAAAyAAAIoAJQAQCgICNIoAKIAIKgoAAgqKAAgogoiooAEAACKAAABKCKAAIoIoAIoAAigAigIVCooICoWoBKiiUiiKIoAAKioAKiWwCpS0AAAAAAiAAAIKAkqoKSgAAIBYoCUAAIKigigCCgAAgoigiooAEAAAAAAASgiiKAIoIoAIoAAigAigIVCooIKIWoBKiiUiiKIoAAKgACoSyoqpS0AAAAAAiAAAIKAkqoKigAAICwoCUAIqKCCiCgCCgBCiAoigBCiKgACggCBQigBCgIoAioKAAAioKAAlAIKACKIKAAAiggoJbAAIqwAAAKhS0AAAAAAiAAAAAJKUAgpKgCgAAAACKiiAogoAgoAQKgKIoAQoioAAoIAgUIoAQoCKAAgoAAioqCgAJQCCgiiKIKAAIqKCCglSgAirAAIoCoUtAAAAAAIgAAAADNFAIKSoAoAAAABCiAogqBUogFAQoCKCKiooSyiCKAAqEoACCgCAoigAiiChKACKigiggKgCgAAQqKi2AgKAgoigIKCwIKAAo0AAAAAAiAAAgqKgoCAAKgItIhaIqCgAQogKIKgVKIBYoQoAAioqKIUIAAAqEoACCgCAoigAiiChKACKigiggKgCgAAQqKhQICgIKIqogKBKCKAiiloAAAAACIAACCoqCgIAAqAJaiLNCKgoAAIKiUqKCUAAIoAAAAAIqUACFioUIAAAAAAACKigASkCyiKAhQAAiiUAIoAiiKIoCCiUAlIKEKogiooU0AAAAAAggAAiiKIoII0iKKRZKWAlqKJKKAACCoWKiopKAAIqKAIoigAIqUACFioUIAAAAAAAAIoAEpAsoigIUAAAEoAigCKIoigIKJQCUgKQqiCKiqlNAAAAAAIIAAIoiiCiAqAKkWUWAlqKJKKAIKICgAAAIKiiAAogKAEKAIogoCKgAACKAAAgqKAAAigAQKCKICgAAAiiKhSCgigCFIUiiKAIoACi0AAAAAAiACKgKIASqiNAIokqooIlqKiKKJYWCiAoAACCoKiiAqCiAoAQoAAgoIKgAACKAAAgqKAAAigAQKCKICgCKACKIqFIKAACFIUiiKACCgCi0AAAAAAiAAICiAJQCoqI0EoighNIqIooQAKiglIoCKhQioKIUgoCCgABCiCgECoKgiooACUAAgoACKAKgAgoAAIoCKigAIKRUCgCCgACKAAAJaA0AACCgAIIAAAhYoIlWCpKoIqUgAqSgIqLQCAqKBKigIqFCKgohSCgIKAAJQIKAQKgqAqAACUAAgoACKAKgAgoAAIoCKAACCktkCgCCgACKAACKloKoAAIKAAggAAioWKAktiiSqCKlIAKQCCiWgAIqFAIogqCiKAkoqKCKAAAAIoAioKAiiAAIoAIAoACKEoigJQCKAigihKCKBKACNIAAgqUIKAigCoigpaAAEoAAICAAAgqAogogqCWggAKgogACpYoioUAiiCoKIoCWCooIoAiiKAIoAioKAAgACKACAKAAihKIoCUAACKCKEoIoEoAI0gAAikogoCKAKiKCloAASgAAgIAACCoAoiiCoE0CCKrLSCiAIorNCoKiooiiKAIKCKgqCooAAIoAAigipNCKIKgCKAAigAigAAgoCFQoAEKAigAioKAIqKAigAACKEKAlAFLQAAgoACIAEoIAhSyUKCIqWiFgI0AhKrNJUWggKgqKiiKIoAgoIqCiKigAAigIoIoASgICoAigAIoAAAACCgIVCgAQoCKAIKgoAiooAAAACKEKAlCoUtAACCgAIgASggAUSUKCAUIWAjQCEqpKWRaCCiKAAigioqKIoCAqCosqCiKigACKJQBKCAAAiooCCgAigSoogKAIoACCoCooCCpaiAKgqAoAACKqCKACKCrQACJaAAiAAACKAIKigipSChKQCoiqzSiFgIqoKACCgioqKIoCAqChKgoigAAIoSgEoIAACKACKAAigQKCCgC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bRa/MiUtJScvi0ngS0Jcu8LLwEEy9Tk4I6nDJ2IiI422W2W3giOCPPtp1NdnwDKGHw7/ACTwM8EGkRyM+TuW2z0z+oeqcHJ4Dk8x2PQfAek+Jkhyc7bbbb0223jbbeNhttttt422222222222G2222222222222222221teArVu1aibw23kHbtf7ajoGrXJtsNttttsMNttsMNttttsNttttttttttttttttttttsNrwJr/bXDX+2v8Abdu1a/21ttttttthttttt5CC2XscEcHgZJ7EMMNvBbehCODqR4FmNattcNbbej1IYhziEINtsdDqezvjI5Z5eOS8fWGPfbeTjLLLOcss/iH8g9I/hHQ9J5ZhJHi+e+WWXzG2NjZfNjYwNljZY2NjY2NjY2NjY2NjY2NjY2NjY2NqFatQrf8Alq1atWrdq1atQ7du1btWrVq1Ct2rVu1bt27drhu3bhcN27cOLu3b47t27Vq3bt2/8t27du3bt27du3/lu3btWrdq1asbGxsYGxsbGxsbVq1atWrVq1I2uGcMvGT2ONhhjukng223qEEEEdzg4ONllmKt8+kNtsMQhSkIQYeN8e8nb99A8Bw8kO/cpLPzPiILOMssks5yznP5GeL/AHvvYt6HmHjOTyb0PWO76DwyWQbFNxd27dq1xONh1O8ZTjzZ/wAs8+bOWI4Mf5AscA2LHPmDZs2YFmxxDBsWbNizZsWOkBYsWLHQYssLLCwgLCAsLCyywsLCwgLCAssLCyREALCAsLCAsLCwscEWEBYsWIFjgCxY4AsWOObHHNmRxzZs2bNmzBgwINizZs2bMmQSYJMngg4ep1GGGOCOGSyTxhBBEcEcHUjjbZZZssssss9TYbYYYhSEIMPiO54D0v3hORl2WZPERzlkWcGZZ3z+Mdf31DqeA67/AAiPIeLfCzZEpkJl8XxfBOWkpaWkpaWlpj8wn+2LSUhIFj/ZFizZs2ZMmzZswbNmzZs2bNmDZs2bNmzZgwJNiLixYsWIubEHo82bFieIHDPnAADxsHKd/wDmBxzZs2bFmzZswbFixYgQLECTZs2bNls2YMGzBgf7Zs2LEGzIkyZEpYjlks8QwwwxzlkklnfIILODg4I4OhblsttjLbDbGWFlkllniPBllicDDDDEIMMMPmOT1jlnkZmZLPCWxEWWWWcGMyzvnuHB2P8AjDznY5ezyzwOQyHCtW/94at27dq1atW7dq3btf7atf7bt/7bt27du3/tu3btWrdu3DtcNWrVrk1a475BcNWo5GobVq1w1CtWtq1tttbW1tbW21tbbbW22G2G21htbW2223jW22+bW1tbW1ttbW2221tbW1bDw1C4a4atW7Vq1bt27du3b/23bt27cO1atW7fBeTonmGIMNvOWSWWWWQWQdSODocbLLLbfJk+JnkeQm3xxllnk222OU5LYYYYYgww7HB/FZnrkknc6kNsRFnGTGtST+AX7/IPQI8p6ZyX76b1eMssbGyyyxsbLGyyyyyCyyyxssssssssssssssssssssssgssssssssssssssgsssssssssssssssss4BZBZZZZZZwyyyyyyyyyyyyyyyyyCyyyyyyyyyyySyyyyyyyyyyyyyyyyyyyyzjPQIjrlnl2GGGHnLOMs8BER0222WW2OOfEkncthttt85DbPcYYYYYYYep4TzfvQ7s+gR1GGGHg4CQkzWZZ65/FPCe1nlLLOpB4DrvleHlLLLLLLLILLLLLOGWWWWQWWWWWQWWWWWWWWWWWWWWWWWWWWcMsssssssgssssssssgsssssssssssgssssss4yzkOTnOueDLOcs5yyyyyyyyyyyyyyyyyyyyyyyCyyyyyyyyyyyyyyzoR1CZ5zjLLLLOMs5IYbbfBvJERwMsvDbeci+0HxCSfFtttvXOr13xbDDDDDDDwfw1lnu+AiOwxCDGRxkkia1UjZ7pweZg6B3PAeU7HjzwHQ6npHTezPkPAcZ5c9o6Z/VPGdM4Omc5ZZZZZZZZZZZZZZJ0I7LwWcZZZZZZZZZZZZZyNtttttvJHBFtssxYfA21DGEz4d6D0LOT0SGGIYYYexyPs7LMW2Hq+AiGG2O2wxCDDzkxrWsyz1jwHBHB4M8p/ROxxnQ8B5GeDqekeyeoeH87nY85/EPMycERwcvULILLLLLLLLLLLLLLLLLLLLLILIIjhltl4OxwQ4jxbKSzjOrPY4I4T1SHgYYYfAevssxZmwww+fYbfAMMQpRIeMsnUmY1clnpHQ6HJ499g9k7f8A52PUO52ZmPEf9YfxUkmI4zhnoREEFllkFllkllllllllllllkFnQiZ5I7EcI2fMNkks7vhI9cjkYYeNt9rZZZi9CGPCcZ0IbbfCMQhSEGLLJE7mMUSeT96HqHjOhZyeL/wDfQPKeweD/AHuz7B6J6Z4zk5PSPAeM6npHjOmdWSyCONl4OCIIOAgjg7ZZ49tltj5YiSdDuQyc+5ZJJLJ7ZZZZZxlkHrBB1GGHoCDbbbbHhPDsssvD1GPJlncYfBsMcEhBh4ySa1rVEjZ4PyPCeb86EeA6HqZ5D3z0WZ6H8U9s/lHonvJZHCy8kQcEQRwch5lltttt4XzfSELLIIgssg4IjgzMz4QiMyILPTIgg77a222ww8hCEIMNsPQ6HOyyy2+Ah8Bwdc77Dwd9hilKQTnJEiaxrM8J5D/gDqeueJ6Mz5jxH8E8Z/xZ584WXoREcBEHBZwcPiWWW3qR8MfGdy7ycBZZZMyIIJZeXh8A2zEebOc4yOTjfAd9thhtiEGG06nDLLLL2fKPhzsREPgGIUpRhOAJJjWMazLPCdvzqR1OpyeQ6Hf8j+CR6z4cmZONht6bzsW29N43jbbbbbbbbeNttttttttttttttttttttttLbS222222222222222222222G222222222222222G22222222222222222G22222222G22222222222222223pvG22w+Fltt6kQEQRxlkeJ4WWWW3oWWREWWWcBZHGQdQy9Hh7ketnXbed75ZZxnOdRhhiEGG23hZZZeSOHuejngG23wbDkQpSDDHCScmsa16D0DwniP+SeGZJONttt5Ntt7gb4wA3wgG8m28Cbybb6AAA223qG2229BtvDbbeG8N4bbbbbbE222G222G2223htttttttvDYm8Nttt6Dbeg2G3oNt4bDbbbbDbbbbwW3qcEQRwQdDwrLLLLbwch0I5edthhtjhYhu3s9yOr5zwbb3CDtlni2GGIcCy2+B9I5OuWdi2PAWxClKQYeUkzXzzo8nuHP75iOx4ToeQ42PCeVkknwbbzvO28a8non/P7xttsW2228bbbbbbbbb3IggiCOCPHsssssvQ6kRFvxbxttvBFtts8HD5CPFvB1z0iPV22223sRw+c6HizqdN4I7DEKUpBjjJ6jwnsHg/89I9Ij0j0fvvkkkklnGWcZZxnTLLO2WcZznbOc7lnQ8OfzD+mdCCIIgsjg5O6yyzFtt8RFttttvQIOuWRDbsEk+EIJPjg98iPLvO222+i9T+GeAYhSlNw29HqeP8AeDk/pnQ/mZwlklllllllllllllllllllllllllllllllllllllllllllkFkHGWWWWc5Z0OuWdcs9LLP4We6cHAQQWQcB414GLb6xEdnghyGZ8JF9J/gER5Ntttttt9vY/hHQ42GFFKev/I909g9c6nfPPllnJncDOgyyyyyyzhlllllllllllllllllllllkFllllllllllllkFllllllllllllnGWWWWWWc5ZznGeHPJnQ/jHQggggiPIvAvrnJDb1XgiJSeuWcjhZ8B230iPBvG22222+oeI93PAQ9xhY8gjwn13PAeAPCeydj2D0ssssssssssssssgsssssssss4JZ1DOGWWWWcmcmWWWWWWWWWWWWWWWWWWWWQWWWWWWWWWWWWWWWWWWWQWWWWWWWWWWWWWWWcZZxlllllnTOAs4yyzrnGdc4znOmehlkEEdj0Is9MiHnbbeCLeAssss6EMLb7PfOu2+mRweDfGRZP9TPARydTk5PKeI6HU8p3ODxPk3xHQ8O+A4OweLOMss4yyyyyyyzjILLLLLLILLLLLLLLLLLLLLILLLOGWWWWWWcMsssss4ZZZZZZZZZBZZZZZZZZBZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZxnGWWWWWWcZzlnGWWWWc5ZzllkWcFnBBZBBBFkFnlEJOxzngOTwHYjggjjJnhbYj6mepZ0231CPBvG+M5J/pnXOpztsPT96Hh3g6ffO/wA6nm/OD0Dk6HkPQPJnxx8R1O+cZ0LLLOMssssssssssssssssssssssssssssssgsssssssss4ZZZBZZZZZZZZZJZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZBZZZZBZZZZZZZZZZBZBZZxllkFkEFlkHnZkn0DyHgI4GZZeogtnwbb65HJ6RwT6gQWdDk5P4JDbbb7B6Z6B4TwHc8Oe6ec7HP75M9LLOmcZZZxlnGWcZZZzlllkFlllkFlllnOWWWWWWWWWWWWWWWWWWQWWWWWWWWWWWWWWQWWWWWWWWWQWWWWWWWWWWWWWWWWWWWQWWWQQQQWRwRZ1O7MknOWWegeA77DbbbPU4O2y22+wRBPpkW2+cgsssiIkk8JwR0CyyzrnpnG9T+UcnU/gHGeM6nQ9PLP5mcnTPBnbPJnTOTvlllnGQcZZZZZZZxllllllllllllllkEFllllllk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DGDy3VcALbSF7YyrGTefMlwrEb7B7oyIidp2E+ZByEIRtvOLsGDvGRIJlM+Y4wZCEI32ntJHsjBgJPmTCMIX2krtA8Nku9JdiSxe2kkl7SS+KC/ybhGqFtr7CfDVJJLXXXXXXXXjFfFxcPDwcHBwcXFxcXFxcXFxcPFxcHBwcHBwcPDxcXFxcPDxcXBwcXFw8PDw8HBw8PBwcHBwcHBwcPDwcHEKuDg4ODg4BQP8/pvTem9N6b03pvTen9P6f0/p+Dg4OE1cXFpppprrrrrrrql9QMArhbcSB2ge4AAl4NNttttttg7bPbZtiYmJiYnvts29tnts29tn2nBjez2e2++/Jy8vLzc3Ly8vNzc3Nz85v5+fm5ufn5+c3C3m5ubm5uYXC/1A/wBHPz+o9R6j1HqPUeo9R6j1HPz8/Ny8vLy8m+++++++++7BMD9MBXCywnsJ90YAAsPhewR0be++22+++++27222225N+Tk35DMT5N999999m9m2228beDo+19G228eMH5y6AkL6SuE7CQO0D3BgGEsnwUbb7m22222222222299nttvttttttts229tgdttm2SC2222222222222222222222222222222233Aoj6EZXCdhPwwAOhPg8l3JJewklrpppx8emmuqSSQjrpppoIGArMNdNNUhDRLVJJJJJJJJJJJJJJJJJJJa6pa6666pJJJJJIgDvEiPoa4zM5L4QiBhJPhq3sJb7778m++7bbe2++4mLBZKYnKYkJ77Nie5L3Mttm22/aAS99t4m2237sCYEdwJBA+aMhAmcvgLAIViOHCfDl/EBJ7X2HoOxtL2gBFDF8EEFo1GswI94YDXOcO4YCR80AZZNfAEYUiGhEjKT8LhgBilhwBfHaPR9z6N9q9hAHASQOxLH7jBE9mAYa6r3AYSnBdwJHymBGM5fAGDKYTlAg2mc/C5IiJQBGIAhfEFYoP+eVcKvTmkw01EBXxcWmqXcl3AE4u5te2AKeE1awBItNhLfuHAYm2HcCvlAQhbM/BArgBKJys3WeF4BGxwE42METjJHsrrrrCEP8/pz/nEDMTlEYDLCNJwwAYTghMLUgYBqfYA9oBdElhJHZExuNxsJBfw65EWQfaPhpdEhgEIWWEge+BCEACYqdvhgCu1DAScXsgCIhoAxnLzi2UyRgLhhkCLHqS0CLDI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\" height=\"150\" width=\"150\"></image><g><g transform=\"rotate (45,4.166666666666667,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><defs></defs></svg></div>', '', 0, 0);
INSERT INTO `customadmin_organization` (`id`, `organization_name`, `website`, `address`, `start_date`, `end_date`, `no_of_candidates`, `logo`, `contact_person_email`, `contact_person_phone`, `password`, `contact_person_name`, `pin`, `sector_type`, `unique_code`, `city_id`, `country_id`, `state_id`, `certificate`, `logo1`, `show_second_logo`, `is_active`) VALUES
(4, 'google', 'http://wdkryfjvnjfvrf.com', 'nrfnrj rvjrvrjn', '2021-02-26', '', NULL, 'organization_logo/898403_apwSmva.jpg', 'google@gmail.com', '6447747477', 'root@123', 'google', '7474747477', 'government', NULL, 4, NULL, 7, '&lt;div class=&quot;certificate&quot; id=&quot;certificate&quot; style=&quot;border:red 6px groove;height: 580px;width:780px;&quot;&gt;\r\n\r\n                        &lt;svg width=&quot;780px&quot; height=&quot;580px&quot;&gt;&lt;defs&gt;&lt;/defs&gt;&lt;/svg&gt;&lt;/div&gt;', '', 0, 0),
(5, 'adobe', 'http://wdkrffvrrvyrcjnjdcf.com', 'djnjw edn fev c', '2021-02-26', '', NULL, 'organization_logo/898403_OhsxQqF.jpg', 'adobe@gmail.com', '6734674367', 'root@123', 'adobe', '9876546789', 'government', NULL, 4, NULL, 7, '&lt;div class=&quot;certificate&quot; id=&quot;certificate&quot; style=&quot;border:red 6px groove;height: 580px;width:780px;&quot;&gt;\r\n\r\n                        &lt;svg width=&quot;780px&quot; height=&quot;580px&quot;&gt;&lt;defs&gt;&lt;/defs&gt;&lt;/svg&gt;&lt;/div&gt;', '', 0, 0),
(6, 'dnjdcnj', 'http://fjnfvdsjdjjndjdcnvjnef.com', 'dcnjdnnjcdc', '2021-03-01', '', NULL, 'organization_logo/898403_jg7j1nV.jpg', 'dcjdcnj@gmail.com', '4786543567', 'root@123', 'dcnjdcnj', '8765466789', 'government', NULL, 4, NULL, 7, '&lt;div class=&quot;certificate&quot; id=&quot;certificate&quot; style=&quot;border:red 6px groove;height: 580px;width:780px;&quot;&gt;\r\n\r\n                        &lt;svg width=&quot;780px&quot; height=&quot;580px&quot;&gt;&lt;defs&gt;&lt;/defs&gt;&lt;/svg&gt;&lt;/div&gt;', '', 0, 1),
(7, 'Demo Organization', 'http://www.google121.com', 'Demo Address', '2021-03-01', '', NULL, 'organization_logo/download_2_l5TZBlz.jpg', 'adminorg1@gmail.com', '345435', 'root@123', 'Organization Admin', '324234', 'government', NULL, 4, NULL, 7, '<div class=\"certificate\" data-href=\"\" id=\"certificate\" style=\"height: 580px;width:780px;\">\r\n\r\n                               \r\n\r\n\r\n                            \r\n                        <svg width=\"780px\" height=\"580px\"><g transform=\"translate(0,0)\"><image xlink:href=\"data:image/webp;base64,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\" height=\"570\" width=\"770\" background=\"true\"></image><g><g transform=\"rotate (45,0,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(269,286.20001220703125)\"><text style=\"font-size: 28px; fill: rgb(14, 0, 255); font-weight: 400; font-family: Times New Roman;\" id=\"candidatename\" text-anchor=\"start\">dwcjdwndwcndjwcnw</text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(270,181.20001220703125)\"><text style=\"font-size: 25px; fill: rgb(255, 0, 0); font-weight: 400; font-family: sans-serif;\" text-anchor=\"start\">this is to certify that</text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><defs></defs></svg></div>', '', 0, 1);
INSERT INTO `customadmin_organization` (`id`, `organization_name`, `website`, `address`, `start_date`, `end_date`, `no_of_candidates`, `logo`, `contact_person_email`, `contact_person_phone`, `password`, `contact_person_name`, `pin`, `sector_type`, `unique_code`, `city_id`, `country_id`, `state_id`, `certificate`, `logo1`, `show_second_logo`, `is_active`) VALUES
(8, 'talento', 'http://talento.com', 'djndnjdc d cd', '2021-03-01', '', 2, 'organization_logo/talento-logo_uAzblnb.png', 'talento@gmail.com', '7446466464', 'root@123', 'talento', '1003933333', 'government', NULL, 4, NULL, 7, '<div class=\"certificate\" data-href=\"\" id=\"certificate\" style=\"height: 580px;width:780px;\">\r\n\r\n                               \r\n\r\n\r\n                            \r\n                        <svg width=\"780px\" height=\"580px\"><g transform=\"translate(0,0)\"><image xlink:href=\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEBLAEsAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wgARCAHLAooDASIAAhEBAxEB/8QAGgABAAMBAQEAAAAAAAAAAAAAAAECAwQGBf/EABoBAQEBAQEBAQAAAAAAAAAAAAABAgQDBQb/2gAMAwEAAhADEAAAAfopj8h9I6reueN2K43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43YON2Djdg43Zy4tdsdc3Ol6R7n53Z8b9Bx9Xb8vLy19qfjxZ9l8Mv3HxIy+5T5mup06cmu5v0fN6PWdTlanU5YOtyjqcsHW5R1OUdTlHU5JOpySdTkk6nKOpyDrco6nKOpywdbkk6nKOpyjqco6nKOpySdTkHW5JNcsY87vGOXlfovl82L918Nb9ufizZ9ifkcy/Uc0Zfd8d6jy2Lhrlr8npzpeke4+J934X6Djz0hzenVnx76mn0uP7nT5/Pn6LoxzdJ6ZCgAAAAAAAAAAAAAAAAAAAAAAAAAM+H6TF+fH0Wb8Hn+h83h9u35sxjVtbYR97yPsfHSc+uWvyenOl6R7r4f3PhfoOPaOP6vlrijqgn73zvo9viHvkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD5fyvt8nD7cNp+h464sufXN+/432XjYw1y1+R050vSPdfD+55/9Bx39B8D0dmg7vIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADzee2HyOn7/jfZeOOfXLX5HTnS9I918D7/wAD73I9Nx/Q6PMOnAAAAAAAAAAAAAAglSMtGNy6k1ZkjVS1SKAAAAAAAAAAAAAA85j6PzfzPf0HjfZeN89Ya5a/I6c6XpHt/h/f+F9/j+r9Pk6+vyD1gAAAAAAAAAAArFmdhWYyFiK2CIkSUrasXtRV2Y0GgAAAAAAAAAAAHP5z1fl+H1+x5T2Hj+X059ctfk9OdL0j3XwPv/E/Q8f2uzLXr8g3AAAAAAAAAABnETaMoiZFZgmYkmCqXy1zUJsmsiIiypErdWtETQUAAAAAAAAAA8n6zyvF6+g8d7vwfPvDXLX43VnS9I918f7Hx/0XF97XLXr8g0AAAAAAAAAIrELIhCCYJx1rLNqWJIsy1pfNlW2pGemWbpKdREwTCSLwqyJ0AAAAAAAAAAeX9R5fj9fUeD954Pn3hrlr8Xqyreke6+P9j4/6Li+9rlr1+QaAAAAAAAADOIWnKi0FNK0l1iJsAz0pObZE1npS5EwKWi0SidRMZreIvCLLK3ipqNgAAAAAAAAHl/UeX4/X1Hg/eeE598+uWvxerOl6R7r5H1/j/ouL72uWvX5BoAAAAAAABFLMoRMQmCazBnrFM24qEyRFpM5uKxYVmaklRE3glqBUJiLWrbQKAAAAAAAAeY9P5fj9fUeE934Pn3hrlr8Xqzpeke6+R9f4/wCi4vva5a9fkGgAAAAAAArETVlExWXSM7FiLAlrMXJpapJBIEBaFrM5ic2RZJC2ZwXvnaxpnNXGgAAAAAAADzHp/L8fr6jwnu/B8+8Nctfi9WdL0j3Xx/sfH/RcX3tctevyDQAAAAAABnpllYREoIppEtJsiJTRUTATEXKq2i1SpQLRFrKpiWq6IsakXgK2qaq20CgAAAAAAHl/UeX4/X1Hg/eeE598+uWvxerOl6R7r4/2Pj/ouL72uWvX5BoAAAAAAAx2pkiLRMRJEoEJlia2qIMprNqy0jnzbdHJfK9ovuRKtSWFZkIVMxKESISTattAoAAAAAAB5f1Hl+P19R4P3ng+feGuWvxerOl6R7r4/wBj4/6Li+9rlr1+QaAAAAAAAKXrEUsza02iMp0RRZVdc71WJiFLowr182LnEX8tXvvT3zElkzE6ViyKxeYynSCrWtTEXssidAoAAAAAAB5f1Hl+P19R4T3fg+feGuWvxerKt6R7r432fj/ouL7u2WvX5BoAAAAAAAx2yymQgmFbQRFolTEkQEwGdpvHN046S46pJQ1JRJNbVJJCVhEkJgtattAoAAAAAAB5f1Hl+P19R4P3ng+feGuWvxerOl6R7r4/2Pj/AKLi+9rlr1+QaAAAAAAAMtaZTWJiysEsmbM2EXoq0ReysTEqUESRMTFSWqJrCImZaWtnGk42rSazYqldBuAAAAAAAAPL+o8xx+vp/B+88Hz7w1y1+L1Z0vSPdfH+x8f9Fxfe1y16/INAAAAAAAAKJZZpnNiSxEiE0llMFq2WREzLC0WVmYlmLUsiymbeYnUEkRaCmiFsi+oFAAAAAAAAPL+o8vx+vqPB+88Jz759ctfi9WdL0j3XyPr/AB/0XF97XLXr8g0AAAAAAAAit8spmLRCAM5VkhMETAtCSs1sAQSCbMtJyzdVbakpioTWL2idAoAAAAAAAB5j0/l+P19R4P3nhOffPrlr8Xqzpeke6+P9j4/6Li+9rlr1+QaAAAAAAAAK2RnJlNQpMzLMJsrM1Wl6aZE10rel4gtWWkZ5ajUmsjO8xLeImxE3oNAAAAAAAAAHl/UeY4/X0/g/eeE598+uWvxerOl6R7r4/wBj4/6Li+9rlr1+QaAAAAAAAAAK2RmtGQVEkMtc5bWLIkMdc9M2UTqRntnLNqzYlIrIrdag0AAAAAAAAAAeX9R5jj9fT+E934Tn3z65a/F6s6XpHuvP+g+F+g4/v9PH2dnkG4AAAAAAAAAArZGczTKZgQvUiySAZ65XlkaiJRS0lQgk0sDQAAAAAAAAAAB5H13mOL19D4r1/kOX059ctfkdOdL0j2/xfu+f+9x/Z+lx9nb5B6QAAAAAAAAAAACIsikaUgqiYWJpNis1F6LEpnStgCgAAAAAAAAAAAMPO+p8pw+v2/J+y8by+mGuWvyenOl6R7r4H3/gfe49vQed9J65sOzzAAAAAAAAAAAAAAAhKAqJICgAAAAAAAAAAAAAAPh8XTz/ACen7vjvZeOy59ctfk9OdL0j3Xwvu/E/QceXpvOfXPovk79Xn3uTr3kNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADmxxe98f6GXwqS+b0fd8b7Lxxz65a/I6c6XpHuvO+i+R+g45xr0eG45ptL3/Z816Pu8bDp8wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPmfP34fm+95pbz1pz9NT7XjfZeOjn1y1+R050vSPdfC+v8P7/ACU2vnz7tqvudX0/L29ceqp5rT0npHyOn2x3Pm7WdjjnTrcg63IOtyDrcg63IOtyDrcg63IOtyDrcg63IOtyDrcg63IOtyDrcg63IOtyDrcg63IOtyDrcg63IOtw2jscER9CnD8nz16ePN5419n5FOnw3HJth56rvplHoPHem8xJhrlr8rpzpese3+F0b/d5Pm9PROLll1K5nSOSvazeJ2o5LdE7nL35NzScmpqyGrIashpOQ1ZDRmNJyGrIaTkNWQ0nIashqyGrIaxmNGY0ZjWMxrGY0nIaxmNYzGfN2vPXNn2TlxO1m8V+pqZc/aqmHUPnX7Zze3yPofOeVy1y1+Z0ZCAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmAAAABrlrp//8QALBAAAAQEBQUBAAMBAQEAAAAAAAECAwQRFDEQExU0QRIgITJAMzBQYCJCQ//aAAgBAQABBQL/ACJWwKGfUmkiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSKSJFJEikiRSRIpIkUkSDI0qBWCrQ3iEKKckcYsgUQcqkVIqRUipFQKgKipE3EmYVEmlBRjYz0jPSKhAz0jPSM9Iz0jPSKhAz0jPSM9IqEDPSM9IqECoQKhAz0jPSKhAqEDPSKhAz0ioQKhAqEDPSM9IqECoQKhAz0ioQKhAz0jPSM9IqEDPSM9IqECoQKhAqECoQFRSCNMXmBcSfQiKmKgVAqBUipFQKkVIOLX11SzTDrzGondgrBVmj6YCGPpfOeWZNPqQbZJNDT7BJQyk0ElzKR1KbbI0Q6XCKFUkEy66VMZKo1imWKVYpVimWKVYpVilWKVYpVilWKVYpVilWKVYpVilWKVYpVilWKVYpVimWKZYpVilWKZYpVilWKVYplilWKVYpVilWKVYpVimWKZYpVilWKVYpVilWKVYpVilWKZYpXCcpP+FsLQKd1wjhJF0N9S2kZbiEGs+iTUMhIStDpSabbIiUH1dbUCo1MRO7BWCrQ3mFJMnjJxLy0zUy4lTZ/8tsMSBQwOGmS4ZBm20hv+4UklppUdZw5TOGDzPSlojaCehKE9C0PdZuKSfVCFKHid2CsFWhdq41nutoS6b6DaEkOqJU3s82El/fuRJpdcKbbnSsI6nlrZIghCM2F20TuwVgq0LtXF5bpNIU8aldZ5hg1Zhw80O/38UclklSB1KUf/YW3mDrSb8Lt4ndgrBVoXauIJxxfS+TDXWDUaYlEMtsmm3Ev/wB/FIU42tl1ZrM4dDrEkGkkupJBvw23id2CsFWhdqslKdSpQZT0s/4ZzrSZEefC7eJ3YKwVaF2r91lIJ9f8M6k85O5hdvE7sFYKtC7V66+rMKcv8NEZlQj94XbxO7BWCrQu1euwhKk/fMTPDyJjyPImYn/QGhJqb/aF28TuwVgqzCiTB+5QS+pH3lgYtgZ4H/Qur6G0EfRBq6mIndgrBVoXaq8rh/y+qYmJAgV+OCwn4IcFhxcpYT+z/wCkN+MTuwVgq0LtVdRKh5ZH03HjCQmCtweHJ3w55wuCBi31qNQYIiZid2CsFWhdrFJI3G/z+gwWHJ4JtxhwfZzwWB4GOfpfSRmIndgrBVoXaxPu1+f0KsOeTx4Mc8mDB35BghyeJX+l64id2CsFWhdrE+7X5/QduwwrwEWHIP2If+cE+RzzzyC+p7CJ3YKwVaF2sT7tfn8txISLAp9nALweKvfFXhNu0zHEixI5/M9cRO7BWCrQu1ifdr8/kVjPA+4+w+zntLs55+V7CJ3YKwVaF2sT7tfn9UpgvHb5Hns8iR9pmEpBYTwtgXyvYRO7BWCrQu1ifdr8/jMGCtjYcgvGJYeMJYeB47DMSkDwt2EOfkeuIndgrBVoXaxPu1+fyELY+PgPu8dnHyvYRO7BWCrQu1ifdr8/iMTHkSEpApic+2+B/wA85DyC8iUh5E/leuIndgrBVoXaxPu1+fxH2eBIdI/6nPCXaV+cOOyWMzlIdPYXyvYRO7BWCrQu1ifdr8/kkJ9xd5jkgd+wgdu2ZYnYrfE9hE7sFYKtC7WJ92vz+IsJdnnEgruLyF+FieMsOTx84TxsDBfG9hE7sFYKtC7WJ92vz+Ii8dnns5xmLjpmJqQpRzNazMEiWE8SB93gecSt8T2ETuwVgq0LtYn3a/P47kYmJjqEzEzx5B49ZkOo1BJdQSo5Zhguzg7iYmY6jwJXiYL5XsIndgrBVoXaxPu1+fxEL4yExL+CQILV1KNI9DmRlLs4O/ZfG2BfG9hE7sFYKtC7WJ92vz+Ljt8YkD7Jg/IQUg5+h+QXgeRPErnj4xljyXxvXETuwVgq0LtYn3a/P4ix89xA++Xkhz2EDth57bAwVviewid2CsFWhdrE+7X5/FY/HdMh57+T8ngf8HVIF3H8j1xE7sFYKtC7WJ92vz+IwY8DnAk+flNOBA/neuIndgrBVoXaxPu1+fymCSJDz3EOOw8S/hkJSEiEwXyPYRO7BWCrQu1ifdr8/jMWBW7p9sv4bd18CHPyPXETuwVgq0LtYn3a/P4z7rYGcwXjsmJ9kxMu2wLz3cl8r2ETuwVgq0LtYn3a/P5D7TtcEUiHIP8Ag5xuJSBYzw5+V7CJ3YKwVaF2sT7tfn8h+RMHYczmZFjwLqxV7Yq8dlwZCwuWEwXzPYRO7BWCrQu1ifdr8/lPCQkCxMGFeAiw54P3If8AnkIMc84kQkJAi+d64id2CsFWhdrE+7X5/QfqD7bFbDlXt2l5HOHJX+l64id2CsFWhdrE+7X5/QdueecCKY455B4mOZBNgYOxjn6XsIndgrBVoXavyzGOrK+ksLYptwY4B3BDnkSxMgf1vSm31GiJ3YKwVaF2peFQ34/SZTHnCRYEP/ILtuQ4K1xLCX18wpSYid2CsFWYnRkfWUEpSm/slgdy7LC2FhxjL7HTUltJzTBmo2YndgrBVoXave0N+f3SwngUuyeEv6Bv9YXbxO7BWCrQu1eub5oWRkov6SX9E9EyiEftC7eJ3YKwVaF2r11HJRHMv8M8qcQn94XbxO7BWCrQu1c6c2cyR6f4Z9RJMpVELtondgrBVoXaqJKniUpCoVRdK31piDiEJCH21r/v3XUNFUtTeiVpN1wm0GrpUSel2F28TuwVgq0LtYkjUamOsuoiCXEkGSNCWV9UR/fxfVJxZLDRyazCUEMkEoUiMhdtE7sFYKtC7VMqltojciXMseoM+tU8oy/v31rN/pQhJn1m05N19pDiymIXbRO7BWCrQu1daznVKSpyREtDKzSfhxl3oJKiUQn/AHU/OC3yk5IycbUtXT1tuGnNJBVENt4ndgrBVmzNMA0lJrmJKN/rcaJGYUL05KFHMdKVk6SzUwpTZHEJIm4pKwb6CM4holVLAqWBUsCpYFSwKlgVLAqWBUsCpYFSwKlgVLAqWBUsCpYFSwKlgVLAqWBUsCpYFSwKlgVLAqWBUsCpYFSwKlgVLAqWBUsCpYFSwKlgVLAqWBUsCpYFSwKlgVLAqWBUsCpYFSwKlkG8gjciEpQiJSonHepPS5mLT0kZTcmbwhyJCWnHCS4laGDmbiy6hAHOHid2CsFWh9oyeWalGZLbW622h1snGFOBplbQyV5psKM6YxTCnMgRG6OhZEUM7LKdGU6Mp0ZToynRlOjKdGU6Mp0ZToynRlOjKdGU6Mp0ZToynRlOjKdGU6Mp0ZToynRlOjKdGU6Mp0ZToynRlOjKdGU6Mp0ZToynRlOjKdGU6Mp0ZToynRlOjKdGU6Mp0ZToynQbLpOoZcQ2pKkDKN0UwpjFN4WytwlodWlEL0A88ybYU2ozMOqNxmE/GJ3YKwOzMe02zqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZGpMjUmRqTI1JkakyNSZDqiW8Ct/kSt/kSt/8QAJxEAAQMDBAICAwEBAAAAAAAAAAECEhExUQMQMlAEIiFAEyNBUmH/2gAIAQMBAT8BJNySbkm3JJuSTckm5JtyTbkm3JNuSbckm5JNySbkk3JNuSbck25JtySbkk3JJuSTck25JtyTbkm3JJuSTck25JtyTbkk3JNuSTck25JtySbkRUW27UuRaQQg0g0iwowowowowowowowowowowowowowowowowowozJRhRhRhRhRhRhRhRhRhBqkGkGkEIpg0fhy7tup/aFB6uJL91FVCSja/0T420eS7suovxcqPWq9Ax3wVTbR5Luy6mp0iWNHku7LqPdX46RjqmjyXdl1HX6TTNHku7OSi36TSNC67s5KL0mlc8e67s5KL0mlc8e67s5KL0mlc8e67s5KL0mlc8e67s5KL0mlc8e67s5KL9Kn0tK54913ZyUX6KfT0rnj3XdnJRek0rnj3XdnJRek0rnj3XdnJRek0rnj3XdnJRek0rnj3XdnJRek0rnj3XdnJRek0rnj3Xdl1Fv0mkaHJd2XUdfpNM0eS7supqdI2xo8l3bdTUQipSnQUUiu2jyXdvwqn/NtROganxsimjyXdn9XddOtj8ZFSKlFKKUUopRSilFKKUUopRSilFKKUUopRSilFKKUUopRSikVIqIyp+MRIiV20ua7o1yV+D3we+D3wfswV1MHvgVNRf4Rfgi/BF+CL8EX4KPwRfgi/BF+CL8EX4IvwRfgi/BF+Cj8EX4IvwRfgi/BF+CL8EX4PfB74K6mD9mD3we+D2/yaTVRyqvV//8QANREAAQICCAQFAwMFAQAAAAAAAQACAxEEEBIUMDFRUhMhMjMFIEGB8CNAUCJCYVNxkaHx4f/aAAgBAgEBPwFXeLtKu8XaVd4u0q7xdpV3i7SrvF2lXeLtKu8XaVd4u0q7xdpV3i7SrvF2lXeLtKu8XaVd4u0q7xdpV3i7SrvF2lXeLtKu8XaVd4u0q7xdpV3i7SrvF2lXeLtKu8XaVd4u0q7xdpV3i7SrvF2lXeLtKu8XaVd4u0q7xdpV3i7SrvF2lXeLtKu8XaU6E9nUJJtUV5FkAyQixB6rjxPQ/P8AC48XX5/hXiL8/wCIRY5+f+Jroya6P6hWo2itRtFajaK1G0VqNorUbRWo2itRtFajaK1G0VqNorUbRWo2itRtFajaK1G0VqNorUbRWo2itRtFajaK1G0VqNoi6Oi+NNGPGbn8/wBK8Rfn/FxopMh8/wBLjxNVxHiZLlTjOC0ptUYcmKXKYyRcZKCyGVwWaIADkPvHQ2uzC4TVEsA/oTjPkpSnNU/ssTao/SyXzJNFsyarBPIKA2yPwEaGS4oMc4FEzVP7LE2qP0t+aKizmZ/hHciVT+wxNqpPQ35oqPDs8/sJqampqf2EeHYM9Sqf2GJtUfpaoPQJ408CeNS5zCp3YYm1UgfTaUzpH2QrFWWLTMgvEhKG0JtUftD2Tcsd1YqP2FLyC8U6Am1R+0PZNywjXl5R5c8Wl5BeKdATao/aHsm5YR8mVUqpeT+T5BhUvILxToCbVH7Q9k3LEniTqGFS8gvFOgJtUftD2TcsE1yFc8CWLS8gvFOgJtUftD2TcsE4E7OaDgJoA+uAMGl5BeKdATao/aHsm5YJqkVI1Ct0wOZQUjr5ZHEpeQXinQE2qP2h7JuWCcAD1QzKAlWfKMGl5BeKdATao/aHsm5YJrnh80DVnhUvILxToCbVH7Q9k3LDlhZeQYdLyC8U6Am1R+0PZNywjXNDAyxqXkF4p0BNqj9oeybli/3qKFQq9fsKXkF4p0BNqj9oeybljmsVEIVyxKXkF4p0BNqpHQ0KH0jHlWPLLFpnMALxAzhNKbVSOlqhCTBjSUvJOqWPS8wqd2GJtVJ6G/NFRiSTM/hIhJdzPqqf2GJtUbJnzRUYhriFxmIODsvwBiNHIlCK0z/hZzKp/YYm1RxMMHz0XKVrJEqjumCPwEZ83FfwnAKn9libVHPQFzXLIJlILORCvXKck2M0iZ5IRmH1XEbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVbbqrbdVxG6rjMnKaiUgNy5o0qXKSc8xTzRkRMLWapxnAYm1OiQnhv65SQ4XrEX0JStr6G9WKMf3KxRtyHB3ppo7f3LiUfcuJR9y4lH3LiUfcuJR9y4lH3LiUfcuJR9y4lH3LiUfcuJR9y4lH3LiUfcuJR9y4lH3LiUfcuJR9y4lH3LiUfcuJR9y4lH3LiUfcuJR9yN3zDkRAPIvXDo25BtHH70RAPMvX0c7a+n/UVNiMdCa1pmm/iWr//EAEcQAAECAgQHDQUJAAEDBQAAAAEAAgMREiExMxAgcXKRodETIjJAQVFhkpOio7HSMIGDsrMjQlBSYILB4fDCBFNiNENwc/H/2gAIAQEABj8C/SgLYcwekK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsK61hXWsItcJEYsI/+A8kTQFEGRIU5NlKcwuBrXA1rga1wNa4GtcDWuBrXA1rg606kBKaLywUBzGtDhUTYZWqyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyL2btisi9m7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YrInZu2KyJ2btisidm7YgAHl3NRl5o7k2bW2l1S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0KyJoVkTQrImhWRNCsiaFZE0KyJoVkTQrImhWRNCsiaFZE0KyJoVkTQrImhWRNCsiaFZE0KyJoVj9CsiaFZE0J7xYT/8T//EACoQAAIBAgUEAwADAQEBAAAAAAABESExQVFhcaEQgfDxQJGxwdHhYFAg/9oACAEBAAE/IXd/8jYHdjoh8VKU8L7NT5amt8tTU+WprfLU1Plqany1NT5amt8tTW+WprfLU1vlqany1Nf5amt8tTU+WprfLU1Plqany1Nf5amt8tTW+WpqfLU1Plqa3y1NT5amp8tTU+WpqfLU1vlqa3y1NT5amp8tTU+WpqfLU1Plqa3y1Nf5amp8tTW+WpqfLU1vlqany1Nb5amt8tTU+WpqfLU1Plqany1NT5amp8tTU+WpqfLU1Plqany1Nb5amp8tTW+WprfLU1vlqany1NT5amp8tTU+WprfLU1Plqany1NT5amt8tTW+WpqfLU1Plqany1NT5amt8tTW+WprfLUnAKGulgxZdG0BgruNKLNEEz3gkafkOg0k1RVFxuKZg2QyCQTCYVJrNknGXghs8LCE4a+/wDBoBBNWrSKjDora90NKyriv/Q2bDmzZs2bDmzZsObNhw4c2bDhzYc2HDhzZsKFDmw4c2bNhzZsOHDhw4wqM54q5syYpqQJsO/tIk9KvTJLzsNWKJMLnWsEwmEwkEhmWU5A7kIfX9oS6lW0zFbjVZJs5DpYHd7l0hBJwuHiJ6q0wHDRQrPcR1Rwp1ThP8+xQDONz7B1g0WktPDItJlmRisGozQkdKKOO7PyRVWhVes9diCRJmLlVlUUiBuJZIRwegZaFFq2uhiRaewK16bijVCZzsU81HUo22KZGnDiItgevL05enL15enL05enL05enL05enL05enL05enL05enL05enL05enL15evL05enL15enL05enL15ehL0JenL05enL05evL15enL05enL05enL05enL05evJtTUoiyNXbbDfAaLjG4jzchMltTlulraDkHtyhFX7hTkVi1Mug+cw3iJROaKh0qU9paW8WZgxKQ1qDTrX8EAkdRYTC2RV/QwlgqE0s0VUoEmyXRD1h/Yh/FNIJTaNHhsKeZ51britrEwRK6mhQ/HY5rpYHd7l0VJ1J0AibUTh1NUS4DMTh6MwHL/AKCJLLgqpEVQ8GGRWlKYqxpT+v5GWVcd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UxJGjcBTtqKjFFwptw1VMJwYqV12eBjwUV0PQsIJLKicfbZyHSwO73LpPOUhj4pulVNBAh5KXKKfVW5HiKqUfZQ9bJKPsk0yHVpRPsi415qr6ZCypZQ0/qxKKMpxZ6gTJfw5Ul+tSWUmcoX3n/HiNCR3YnpZ0tjf7KSMnY3FGq4P/wBDzzzzzzzzxzzzzzzzzzzzzzzzzzzzzzzzzxzxzzzxzzzzzzyMxUqEyqJeGYkCVUVPFhYqhA/I4YwpGsnwKlfKcNIJ/wCTpBu6Bah0K5hEm8Tsa6ruhjtq93h33EoboV/A/m9r90iraAYmRKVzwJcdzxbVXuTb7m23u3XmTkOlgxYkiScRGRf8V1/e973ve1b3ve9r3ve972te972ve97Wve9r3va173ve97Wva973vW173te9rWXr+tmNqlPSwO736wQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQR/wDFgd3v/wAjYP/aAAwDAQACAAMAAAAQgfNtdtNd9NMNd9NdN9dNN9NdNtNNNNNttddNNtNqmVY9HICCt4y2y2yyy666y+yy26yyyy6+6dfLE/GZlSV7FfK+9888888888888888888888888888MOUEYDGVo5d38888888888888888888888888888888gWJ0WVtX88888888888888888888888888888888888bRWV+v8888888888888887/wBN8PPPPPPPPPPPPPPPIVVlTX/PPPPPPPPPPPOsA/8APM1UP/Tzzzzzzzzzzzz2FJXzbzzzzzzzzzzyTe9G8Eb8NQN3bzzzzzzzzzzzu1ZX9Xzzzzzzzzzy7Ef9iIccuvl9OPTzzzzzzzzzz75LX9XzzzzzzzzyjH2hnk4qH779QRlfzzzzzzzzzz7pJW9Xzzzzzzzzykf80ZoYaZIqTJNHvbzzzzzzzzy65ZW9Xzzzzzzzz4f7bGqjYDJyWrfYS0Xzzzzzzzzy65ZX9Xzzzzzzzy+c9zMa7DgUh71yfW837zzzzzzzz7pJX9XzzzzzzzztsMMJxJgRE0TDIwutfzzzzzzzzz75JXtXzzzzzzzyiDGfkhQGs8DVRTt+Cdbzzzzzzzzq57X/AF88888888557FyCwwR06gYW+zbp888888888u+2V/V88888888/fDryONegvgEJ4zUPkc888888886+GV/V88888888sh+/xgU5SxiVGJ3FQc888888888+6WVvV888888888PLPudekCk601X5B3+888888888u6GV/V888888888+bLsbwbEE4vtfwLV888888888866WV/V8888888888+b1jAzjXP2lzbn888888888886q+Vtc88888888888+FndzjqNzIY9888888888888riWVPd8888888888888OVhxb1REe8888888888888R3eV/Z8888888888888888e8e8888888888888888IzSV+U4388888888888888888888888888888884zrRWV+y6U8888888888888888888888888888888ldqQWVgVg1403wyyyyyyyyyyyyyyyyyyyyyyy/55kW69vWRrxARQibhjDDDjDzjDjDjDDDTzzTTjTTSZSRBiyT28DPPPHPHPPPPPPPPPPPPPPPPPPPPPPPHPHPPPHPfe//EACoRAAIBAwIFAwUBAQAAAAAAAAABETFh8BCRITBRodFBcbEgQFCBwfHh/9oACAEDAQE/EEWm6LTdFhui03RabotN0WG6LDdFhuiw3RYbotN0Wm6LTdFpuiw3RYbosN0WG6LTdFpui03RabosN0WG6LDdFhui03RabosN0WG6LDdFpuiw3RabosN0WG6LTdHBGTGIS5tSN3oRvinn7MsZljIK53GjM+Nx+my4XC4XC4XC4XC4XC4XC4XC5oLhcLhcLhcLgurOcegnL03/AO50FRZ3Fl/pCpedxU2uOXOKkEhjEPVfD/SVD1Z7kU3GZ1EnLoyP1G2+L+8ojETOopEg3Oe/UTTShmP3GIhxKf6Olls8kUk3wz/LCJF+AQkTY1R0dP8Ac416kRV+3DLwZ/cYjB+x1Cj8JCHXM3vp2I77yTOCn2EEaR9jAjotOxHceSLePto5z8GtGxD8BjS3NnT01er58Jcjy4Yj5RU+etXouv2FQ7AYj5RU+UtYnV6P00ei4lOBPMqex2AxHyip8pfRX6JJ1n0XOqHYDEfKKnzIjmQPl1PY7AYj5RU+StU3rGtPpnpquVU9jsBiPlFT5K+lkaRK4DZwNr01XOqex2AxHyip8pcCUSuhI9JGToh8SV0j6JRKJXLqHYDEfKKnyVyG+EDo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\" height=\"570\" width=\"770\" background=\"true\"></image><g><g transform=\"rotate (45,0,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(142,487.20001220703125)\"><text style=\"font-size: 21px; fill: rgb(8, 7, 16); font-weight: 400; font-family: sans-serif;\" text-anchor=\"start\">CEO XYZ</text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(91,454.20001220703125)\"><text style=\"font-size: 28px; fill: rgb(24, 0, 255); font-weight: 400; font-family: sans-serif;\" text-anchor=\"start\">______________</text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(329,339.20001220703125)\"><text style=\"font-size: 28px; fill: rgb(24, 0, 255); font-weight: 400; font-family: Times New Roman;\" id=\"candidatename\" text-anchor=\"start\">Zubair khan</text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(267,273.20001220703125)\"><text style=\"font-size: 25px; fill: rgb(255, 12, 0); font-weight: 400; font-family: sans-serif;\" text-anchor=\"start\">this is to certify that </text><g><g transform=\"rotate (45,8.333333333333334,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><g transform=\"translate(112,47.19999694824219)\"><image xlink:href=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAABfCAYAAACtO4hlAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQ1IDc5LjE2MzQ5OSwgMjAxOC8wOC8xMy0xNjo0MDoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTkgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkY5NUFFNDk2NTc5NzExRTk5QjVCRTA4QzEyMUZERjBBIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkY5NUFFNDk3NTc5NzExRTk5QjVCRTA4QzEyMUZERjBBIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6Rjk1QUU0OTQ1Nzk3MTFFOTlCNUJFMDhDMTIxRkRGMEEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6Rjk1QUU0OTU1Nzk3MTFFOTlCNUJFMDhDMTIxRkRGMEEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz66wumkAAAt9ElEQVR42uxd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\" height=\"150\" width=\"150\"></image><g><g transform=\"rotate (45,4.166666666666667,3)\" style=\"stroke-width: 1.5px; stroke: black;\"></g></g></g><defs></defs></svg></div>', '', 0, 1);
INSERT INTO `customadmin_organization` (`id`, `organization_name`, `website`, `address`, `start_date`, `end_date`, `no_of_candidates`, `logo`, `contact_person_email`, `contact_person_phone`, `password`, `contact_person_name`, `pin`, `sector_type`, `unique_code`, `city_id`, `country_id`, `state_id`, `certificate`, `logo1`, `show_second_logo`, `is_active`) VALUES
(11, 'plus', 'http://wdkdnvjnef.com', 'vwdjjdwdwc hdwc dwc  d', '2021-03-05', '', NULL, 'organization_logo/talento-logo_82Sx1N8.png', 'plus@gmail.com', '7563643664', 'root@123', 'plus', 'dicdcjdjic', 'government', NULL, 4, NULL, 7, '&lt;div class=&quot;certificate&quot; data-href=&quot;&quot; id=&quot;certificate&quot; style=&quot;height: 580px;width:780px;&quot;&gt;\r\n\r\n                               \r\n\r\n\r\n                            \r\n                        &lt;svg width=&quot;780px&quot; height=&quot;580px&quot;&gt;&lt;defs&gt;&lt;/defs&gt;&lt;/svg&gt;&lt;/div&gt;', '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_organization_course`
--

CREATE TABLE `customadmin_organization_course` (
  `id` int NOT NULL,
  `organization_id` int NOT NULL,
  `coursesenduser_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_organization_course`
--

INSERT INTO `customadmin_organization_course` (`id`, `organization_id`, `coursesenduser_id`) VALUES
(3, 6, 97),
(2, 7, 97),
(5, 7, 105),
(6, 7, 110),
(4, 8, 110);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_organization_students`
--

CREATE TABLE `customadmin_organization_students` (
  `id` int NOT NULL,
  `organization_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_personinroom`
--

CREATE TABLE `customadmin_personinroom` (
  `id` int NOT NULL,
  `layer_id` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `chat_id` int NOT NULL,
  `user_id_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_question`
--

CREATE TABLE `customadmin_question` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `question_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `question_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `option_a` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `option_b` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `option_c` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `option_d` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `answer_option` varchar(1) COLLATE utf8mb4_general_ci NOT NULL,
  `answer_text` varchar(225) COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int NOT NULL,
  `question_language_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_question`
--

INSERT INTO `customadmin_question` (`id`, `start_date`, `end_date`, `question_name`, `question_type`, `option_a`, `option_b`, `option_c`, `option_d`, `answer_option`, `answer_text`, `author_id`, `question_language_id`) VALUES
(5, '2021-03-01 09:10:50.990008', NULL, 'what is 3+2 ?', '', '5', '4', '6', '0', 'a', '', 1, 1),
(6, '2021-03-01 09:13:05.867013', NULL, 'what is 6+5 ?', '', '11', '10', '-2', '-1', 'a', '', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_sessionactivity`
--

CREATE TABLE `customadmin_sessionactivity` (
  `id` int NOT NULL,
  `topic` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `duration` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `auto_attendence` tinyint(1) NOT NULL,
  `photo_attendence` tinyint(1) NOT NULL,
  `record_session` tinyint(1) NOT NULL,
  `enable_private_chat` tinyint(1) NOT NULL,
  `enable_group_chat` tinyint(1) NOT NULL,
  `raise_query` tinyint(1) NOT NULL,
  `download_record_session_video` tinyint(1) NOT NULL,
  `download_session_resource` tinyint(1) NOT NULL,
  `capture_photo_after_every` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `mute_participant_upon_entry` tinyint(1) NOT NULL,
  `record_session_visibility_to_students` tinyint(1) NOT NULL,
  `display_description` tinyint(1) NOT NULL,
  `session_room_id` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_sessionactivity`
--

INSERT INTO `customadmin_sessionactivity` (`id`, `topic`, `description`, `duration`, `auto_attendence`, `photo_attendence`, `record_session`, `enable_private_chat`, `enable_group_chat`, `raise_query`, `download_record_session_video`, `download_session_resource`, `capture_photo_after_every`, `start_date`, `mute_participant_upon_entry`, `record_session_visibility_to_students`, `display_description`, `session_room_id`, `author_id`, `course_id`, `teacher_id`, `organization_id`) VALUES
(3, 'dfvjnjfvnj', 'njdnjdv', '20', 0, 1, 0, 0, 0, 0, 0, 0, '5', '2021-03-01 11:55:00.000000', 0, 0, 0, 'dfvjnjfvnj2021-03-01 17:25:00+05:30teacher1@gmail.com<function now at 0x7f5561701940>', 54, 110, 14, 8),
(4, 'ddcjdcj', 'bhdbhdcbh', '20', 0, 1, 0, 0, 0, 0, 0, 0, '5', '2021-03-01 12:00:00.000000', 0, 0, 0, 'ddcjdcj2021-03-01 17:30:00+05:30teacher1@gmail.com<function now at 0x7f5561701940>', 54, 110, 14, 8),
(5, 'vdnfvnj', 'njdjdcj', '20', 0, 1, 0, 0, 0, 0, 0, 0, '5', '2021-03-26 10:11:00.000000', 0, 0, 0, 'vdnfvnj1616753460.0teacher1@gmail.com<function now at 0x7fcb9399d940>', NULL, 110, 14, NULL),
(6, 'vnjjvfjn', 'njdnjdnj', '20', 0, 1, 0, 0, 0, 0, 0, 0, '5', '2021-03-03 10:12:00.000000', 0, 0, 0, 'vnjjvfjn1614766320.0teacher1@gmail.com<function now at 0x7f09e2f63940>', NULL, 108, 14, 6),
(7, 'myname', 'minus', '20', 0, 1, 0, 0, 0, 0, 0, 0, '5', '2021-03-19 10:34:00.000000', 0, 0, 0, 'myname1616150040.0teacher1@gmail.com<function now at 0x7ff202c6d940>', 54, 110, 14, 8);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_spinactivity`
--

CREATE TABLE `customadmin_spinactivity` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `name` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `no_of_topic` int NOT NULL,
  `block_slice_after_open` tinyint(1) NOT NULL,
  `activity_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_spinactivity`
--

INSERT INTO `customadmin_spinactivity` (`id`, `start_date`, `end_date`, `name`, `no_of_topic`, `block_slice_after_open`, `activity_id`) VALUES
(1, '2021-02-25 07:07:58.286483', '2021-02-25 07:07:58.286400', 'dcncdn', 2, 0, 1),
(2, '2021-02-28 21:31:06.607275', '2021-02-28 21:31:06.607234', 'spin', 2, 0, 8),
(3, '2021-03-01 05:38:35.344419', '2021-03-01 05:38:35.344292', 'Spin Activity', 2, 0, 9),
(4, '2021-03-01 06:25:41.682465', '2021-03-01 06:25:41.682385', 'Spin Activity', 3, 0, 12),
(5, '2021-03-01 06:38:04.385423', '2021-03-01 06:38:04.385250', 'Demo Spin Activity ', 4, 0, 13),
(6, '2021-03-01 08:51:58.008629', '2021-03-01 08:51:58.008558', 'Demo Spin ', 2, 0, 17),
(7, '2021-03-01 08:53:53.479798', '2021-03-01 08:53:53.479739', 'Demo Spin Activity B', 3, 0, 18),
(8, '2021-03-01 09:18:49.797185', '2021-03-01 09:18:49.797153', 'Demo Spin A', 2, 0, 20),
(9, '2021-03-01 09:28:21.415488', '2021-03-01 09:28:21.415412', 'Demo Spin ', 2, 0, 23),
(10, '2021-03-01 10:28:04.320316', '2021-03-01 10:28:04.320251', 'Demo Spin ', 2, 0, 27),
(11, '2021-03-01 10:43:33.864163', '2021-03-01 10:43:33.864104', 'Spin Activity A', 3, 0, 28),
(12, '2021-03-01 11:05:14.101192', '2021-03-01 11:05:14.101135', 'Spin Activity A', 2, 0, 29),
(13, '2021-03-01 11:05:54.831353', '2021-03-01 11:05:54.831292', 'Spin Activity B', 2, 0, 30),
(14, '2021-03-01 11:06:43.626497', '2021-03-01 11:06:43.626439', 'Spin C', 3, 0, 31),
(15, '2021-03-01 11:22:52.446738', '2021-03-01 11:22:52.446649', 'Spin Activity', 2, 0, 32),
(16, '2021-03-01 11:23:26.140436', '2021-03-01 11:23:26.140388', 'Spin Activity B', 2, 0, 33),
(17, '2021-03-01 11:48:56.122855', '2021-03-01 11:48:56.122752', 'Spin Activity', 2, 0, 35),
(18, '2021-03-02 12:57:10.691659', '2021-03-02 12:57:10.691569', 'him', 2, 0, 37);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_spinactivityanswer`
--

CREATE TABLE `customadmin_spinactivityanswer` (
  `id` int NOT NULL,
  `answer_option` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `question_id` int NOT NULL,
  `spinactivity_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_spinactivityanswer`
--

INSERT INTO `customadmin_spinactivityanswer` (`id`, `answer_option`, `question_id`, `spinactivity_id`) VALUES
(12, 'a', 5, 6),
(13, 'a', 6, 6),
(14, 'a', 5, 9),
(15, 'a', 6, 9),
(16, 'a', 5, 11),
(17, 'a', 6, 11),
(18, 'a', 5, 12),
(19, 'b', 5, 12),
(20, 'b', 6, 12),
(21, 'c', 5, 12),
(22, 'c', 6, 12),
(23, 'd', 5, 12),
(24, 'd', 5, 13),
(25, 'c', 5, 13),
(26, 'a', 5, 13),
(27, 'a', 6, 12),
(28, 'a', 5, 15),
(29, 'a', 6, 14),
(30, 'a', 5, 14),
(31, 'd', 5, 14),
(32, 'd', 6, 14),
(33, 'a', 6, 15),
(34, 'a', 5, 16),
(35, 'd', 5, 17),
(36, 'a', 5, 17);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_spinactivityenroll`
--

CREATE TABLE `customadmin_spinactivityenroll` (
  `id` int NOT NULL,
  `enroll_date` datetime(6) NOT NULL,
  `candidate_id` int NOT NULL,
  `spinactivity_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_spinactivity_topic_details`
--

CREATE TABLE `customadmin_spinactivity_topic_details` (
  `id` int NOT NULL,
  `spinactivity_id` int NOT NULL,
  `topicdetails_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_spinactivity_topic_details`
--

INSERT INTO `customadmin_spinactivity_topic_details` (`id`, `spinactivity_id`, `topicdetails_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(5, 2, 3),
(6, 2, 4),
(7, 3, 5),
(8, 3, 6),
(9, 4, 7),
(10, 4, 8),
(11, 4, 9),
(12, 5, 10),
(13, 5, 11),
(14, 5, 12),
(15, 5, 13),
(16, 6, 14),
(17, 6, 15),
(18, 7, 16),
(19, 7, 17),
(20, 7, 18),
(45, 8, 19),
(46, 8, 20),
(47, 9, 21),
(48, 9, 22),
(49, 10, 23),
(50, 10, 24),
(51, 11, 25),
(52, 11, 26),
(53, 11, 27),
(54, 12, 28),
(55, 12, 29),
(56, 13, 30),
(57, 13, 31),
(58, 14, 32),
(59, 14, 33),
(60, 14, 34),
(61, 15, 35),
(62, 15, 36),
(63, 16, 37),
(64, 16, 38),
(65, 17, 39),
(66, 17, 40),
(67, 18, 41),
(68, 18, 42);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_state`
--

CREATE TABLE `customadmin_state` (
  `id` int NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL,
  `country_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_state`
--

INSERT INTO `customadmin_state` (`id`, `name`, `status`, `country_id`) VALUES
(7, 'dknndkc', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_subtopic`
--

CREATE TABLE `customadmin_subtopic` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `name` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `about` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `duration` bigint NOT NULL,
  `author_id` int NOT NULL,
  `topic_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_topic`
--

CREATE TABLE `customadmin_topic` (
  `id` int NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `about` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `topic_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `ordering` int UNSIGNED DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ;

--
-- Dumping data for table `customadmin_topic`
--

INSERT INTO `customadmin_topic` (`id`, `start_date`, `name`, `about`, `topic_type`, `author_id`, `course_id`, `ordering`, `end_date`) VALUES
(2, '2021-02-25 07:03:30.513235', 'dc kdc', '', 'subtopic', 1, NULL, NULL, NULL),
(4, '2021-02-25 09:17:46.225255', 'first', '', 'subtopic', 1, NULL, NULL, NULL),
(6, '2021-02-28 21:30:45.406884', 'first sub', '', 'subtopic', 37, NULL, NULL, NULL),
(7, '2021-02-28 21:43:05.588844', 'second sb', '', 'subtopic', 37, NULL, NULL, NULL),
(9, '2021-02-28 21:43:37.279456', 'first', '', 'subtopic', 37, NULL, NULL, NULL),
(11, '2021-03-01 05:38:11.136028', 'Sub topic', '', 'subtopic', 1, NULL, NULL, NULL),
(13, '2021-03-01 05:43:50.939544', 'Subtopic', '', 'subtopic', 1, NULL, NULL, NULL),
(14, '2021-03-01 06:11:02.951735', 'Demo Topic', '', 'topic', 1, 97, NULL, NULL),
(15, '2021-03-01 06:16:28.890945', 'Demo Sub Topic 1', '', 'subtopic', 1, NULL, NULL, NULL),
(16, '2021-03-01 06:26:17.325589', 'Demo Topic 1', '', 'topic', 1, 98, NULL, NULL),
(17, '2021-03-01 06:33:42.935294', 'Demo Sub Topic 2', '', 'subtopic', 1, NULL, NULL, NULL),
(18, '2021-03-01 06:26:17.325589', 'Demo Topic 2', '', 'topic', 1, 98, NULL, NULL),
(19, '2021-03-01 06:36:23.393350', 'Demo Sub topic 2.1', '', 'subtopic', 1, NULL, NULL, NULL),
(20, '2021-03-01 08:44:02.645149', 'Demo topic A', '', 'topic', 1, 99, NULL, NULL),
(21, '2021-03-01 08:51:00.337521', 'Sub Topic A', '', 'subtopic', 1, NULL, NULL, NULL),
(22, '2021-03-01 08:44:02.645149', 'Demo Topic B', '', 'topic', 1, 99, NULL, NULL),
(23, '2021-03-01 08:53:07.062398', 'Sub Topic B', '', 'subtopic', 1, NULL, NULL, NULL),
(25, '2021-03-01 09:05:05.226123', 'Sub Topic A', '', 'subtopic', 1, NULL, NULL, NULL),
(28, '2021-03-01 09:18:15.725350', 'Sub Topic A1', '', 'subtopic', 1, NULL, NULL, NULL),
(30, '2021-03-01 09:26:10.737735', 'Demo Subtopic A', '', 'subtopic', 1, NULL, NULL, NULL),
(31, '2021-03-01 09:27:32.054599', 'Demo Sub topic B', '', 'subtopic', 1, NULL, NULL, NULL),
(32, '2021-03-01 10:14:14.249235', 'Demo Topic', '', 'topic', 1, 103, NULL, NULL),
(33, '2021-03-01 10:14:14.263344', 'Demo Sub Topic 1', '', 'subtopic', 1, NULL, NULL, NULL),
(34, '2021-03-01 10:14:14.290065', 'Demo Sub Topic 2', '', 'subtopic', 1, NULL, NULL, NULL),
(35, '2021-03-01 10:24:08.876379', 'Demo Topic A', '', 'topic', 1, 104, NULL, NULL),
(36, '2021-03-01 10:24:42.301803', 'Demo Sub Topic A', '', 'subtopic', 1, NULL, NULL, NULL),
(37, '2021-03-01 10:27:33.778250', 'Demo Sub Topic B', '', 'subtopic', 1, NULL, NULL, NULL),
(38, '2021-03-01 10:24:08.876379', 'Topic B', '', 'topic', 1, 104, NULL, NULL),
(39, '2021-03-01 10:33:06.233072', 'Demo Topic A', '', 'topic', 1, 105, NULL, NULL),
(40, '2021-03-01 10:33:06.233072', 'Topic Demo B', '', 'topic', 1, 105, NULL, NULL),
(41, '2021-03-01 10:33:06.233072', 'Demo Topic C', '', 'topic', 1, 105, NULL, NULL),
(42, '2021-03-01 10:42:59.178137', 'Sub Topic C', '', 'subtopic', 1, NULL, NULL, NULL),
(43, '2021-03-01 11:00:53.031289', 'Topic A', '', 'topic', 1, 106, NULL, NULL),
(44, '2021-03-01 11:03:06.608831', 'Demo Sub Topic A', '', 'subtopic', 1, NULL, NULL, NULL),
(46, '2021-03-01 11:03:42.224419', 'Demo Sub Topic B', '', 'subtopic', 1, NULL, NULL, NULL),
(47, '2021-03-01 11:00:53.031289', 'Topic B', '', 'topic', 1, 106, NULL, NULL),
(48, '2021-03-01 11:06:19.943474', 'Sub Topic B', '', 'subtopic', 1, NULL, NULL, NULL),
(49, '2021-03-01 11:00:53.031289', 'Topic A', '', 'topic', 1, 107, NULL, NULL),
(50, '2021-03-01 11:22:32.354816', 'Sub Topic A', '', 'subtopic', 1, NULL, NULL, NULL),
(51, '2021-03-01 11:29:30.811405', 'first', '', 'topic', 1, 108, NULL, NULL),
(52, '2021-03-01 11:34:36.514266', 'first subtopic', '', 'subtopic', 1, NULL, NULL, NULL),
(54, '2021-03-01 11:48:40.127473', 'Topic A', '', 'subtopic', 1, NULL, NULL, NULL),
(55, '2021-03-02 12:56:24.179419', 'dcd', '', 'topic', 1, 110, NULL, NULL),
(56, '2021-03-02 12:56:52.661094', 'jhjhjhjh', '', 'subtopic', 1, NULL, NULL, NULL),
(57, '2021-03-02 12:56:52.661094', 'Hiii', '', 'subtopic', 1, NULL, NULL, NULL),
(58, '2021-03-02 12:56:52.661094', 'name', '', 'subtopic', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_topicdetails`
--

CREATE TABLE `customadmin_topicdetails` (
  `id` int NOT NULL,
  `topic_name` varchar(125) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_topicdetails`
--

INSERT INTO `customadmin_topicdetails` (`id`, `topic_name`) VALUES
(1, 'sd'),
(2, 'dcd'),
(3, 'dcjncdjncd'),
(4, 'dcdcdjc'),
(5, 'Test 1'),
(6, 'Test 2'),
(7, 'Topic Name 1'),
(8, 'Topic Name 2'),
(9, 'Topic Name 3'),
(10, 'Topic Name 1'),
(11, 'Topic Name 2'),
(12, 'Topic Name 3'),
(13, 'Topic Name 4'),
(14, 'Topic Name '),
(15, 'Topic Name 2'),
(16, 'Demo Topic 1'),
(17, 'Demo Topic 2'),
(18, 'Demo Topic 13'),
(19, 'Test 1'),
(20, 'Test 2'),
(21, 'Topic A'),
(22, 'Topic B'),
(23, 'Test 1'),
(24, 'Test 2'),
(25, 'Test 1'),
(26, 'Test 2'),
(27, 'Test 3'),
(28, 'Test 1'),
(29, 'Test 2'),
(30, 'Test 1'),
(31, 'Test 2'),
(32, 'Testing'),
(33, 'Test 2'),
(34, 'Test 3'),
(35, 'Test 1'),
(36, '123'),
(37, 'Test 1'),
(38, 'Test 2'),
(39, 'Test 1'),
(40, 'Test 2'),
(41, 'dcnjcd'),
(42, 'dckmdckm');

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_topicdetails_questions`
--

CREATE TABLE `customadmin_topicdetails_questions` (
  `id` int NOT NULL,
  `topicdetails_id` int NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_topicdetails_questions`
--

INSERT INTO `customadmin_topicdetails_questions` (`id`, `topicdetails_id`, `question_id`) VALUES
(30, 7, 5),
(34, 8, 6),
(35, 9, 5),
(39, 9, 6),
(40, 10, 5),
(41, 11, 6),
(42, 12, 5),
(43, 13, 6),
(44, 14, 5),
(45, 15, 6),
(46, 16, 5),
(47, 17, 6),
(48, 18, 5),
(49, 19, 5),
(50, 20, 6),
(51, 21, 6),
(52, 22, 5),
(53, 23, 5),
(54, 24, 5),
(55, 24, 6),
(56, 25, 5),
(57, 26, 5),
(58, 26, 6),
(59, 27, 6),
(60, 28, 5),
(61, 29, 5),
(62, 29, 6),
(63, 30, 5),
(64, 31, 5),
(65, 32, 6),
(66, 33, 5),
(67, 34, 5),
(68, 35, 5),
(69, 35, 6),
(70, 36, 5),
(71, 37, 5),
(72, 38, 5),
(73, 39, 5),
(74, 40, 5),
(89, 41, 5),
(90, 42, 6);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_topicrelation`
--

CREATE TABLE `customadmin_topicrelation` (
  `id` int NOT NULL,
  `topic_father_id` int DEFAULT NULL,
  `topic_id_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_topicrelation`
--

INSERT INTO `customadmin_topicrelation` (`id`, `topic_father_id`, `topic_id_id`) VALUES
(14, NULL, 14),
(15, 14, 15),
(16, NULL, 16),
(17, 14, 17),
(18, NULL, 18),
(19, 18, 19),
(20, NULL, 20),
(21, 20, 21),
(22, NULL, 22),
(23, 22, 23),
(32, NULL, 32),
(33, 32, 33),
(34, 32, 34),
(35, NULL, 35),
(36, 35, 36),
(37, 35, 37),
(38, NULL, 38),
(39, NULL, 39),
(40, NULL, 40),
(41, NULL, 41),
(42, 41, 42),
(43, NULL, 43),
(44, 43, 44),
(46, 43, 46),
(47, NULL, 47),
(48, 47, 48),
(49, NULL, 49),
(50, 49, 50),
(51, NULL, 51),
(52, 51, 52),
(55, NULL, 55),
(56, 55, 56);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_topicwiseanswerpaper`
--

CREATE TABLE `customadmin_topicwiseanswerpaper` (
  `id` int NOT NULL,
  `date_registered` datetime(6) NOT NULL,
  `is_completed` tinyint(1) NOT NULL,
  `is_open` tinyint(1) NOT NULL,
  `content_video_length` varchar(123) COLLATE utf8mb4_general_ci NOT NULL,
  `activity_id` int DEFAULT NULL,
  `content_video_id` int DEFAULT NULL,
  `course_id` int NOT NULL,
  `topic_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_topicwiseanswerpaper`
--

INSERT INTO `customadmin_topicwiseanswerpaper` (`id`, `date_registered`, `is_completed`, `is_open`, `content_video_length`, `activity_id`, `content_video_id`, `course_id`, `topic_id`, `user_id`) VALUES
(91, '2021-03-01 06:38:20.163086', 0, 1, '', NULL, NULL, 97, 14, 40),
(92, '2021-03-01 06:38:20.167419', 1, 1, '', 11, NULL, 97, 15, 40),
(93, '2021-03-01 06:39:21.804301', 0, 1, '', NULL, NULL, 97, 14, 40),
(94, '2021-03-01 06:44:40.816282', 1, 1, '', 12, NULL, 97, 15, 40),
(95, '2021-03-01 07:00:48.821445', 0, 1, '', NULL, NULL, 97, 14, 43),
(96, '2021-03-01 07:00:48.826754', 1, 1, '', 11, NULL, 97, 15, 43),
(97, '2021-03-01 07:01:27.168068', 0, 1, '', NULL, NULL, 97, 14, 43),
(98, '2021-03-01 07:01:31.235477', 1, 1, '', 12, NULL, 97, 15, 43),
(99, '2021-03-01 07:02:12.281135', 0, 1, '', NULL, NULL, 97, 14, 44),
(100, '2021-03-01 07:02:12.286976', 1, 1, '', 11, NULL, 97, 15, 44),
(101, '2021-03-01 07:03:33.945997', 0, 1, '', NULL, NULL, 97, 14, 44),
(102, '2021-03-01 07:03:37.677153', 1, 1, '', 12, NULL, 97, 15, 44),
(103, '2021-03-01 07:05:06.830064', 0, 1, '', NULL, NULL, 97, 14, 46),
(104, '2021-03-01 07:05:06.834108', 1, 1, '', 11, NULL, 97, 15, 46),
(105, '2021-03-01 07:12:27.426801', 0, 1, '', NULL, NULL, 97, 14, 47),
(106, '2021-03-01 07:12:27.432350', 1, 1, '', 11, NULL, 97, 15, 47),
(107, '2021-03-01 07:14:04.665315', 0, 1, '', NULL, NULL, 97, 14, 47),
(108, '2021-03-01 07:18:51.938333', 0, 1, '', NULL, NULL, 97, 14, 46),
(109, '2021-03-01 07:19:42.487136', 0, 1, '', NULL, NULL, 97, 14, 48),
(110, '2021-03-01 07:19:42.491817', 1, 1, '', 11, NULL, 97, 15, 48),
(111, '2021-03-01 07:19:58.418040', 0, 1, '', NULL, NULL, 98, 16, 46),
(112, '2021-03-01 07:19:58.426110', 0, 1, '', NULL, 8, 98, 16, 46),
(113, '2021-03-01 07:25:55.991730', 0, 1, '', NULL, NULL, 98, 18, 46),
(114, '2021-03-01 07:25:55.997434', 0, 1, '', NULL, NULL, 98, 19, 46),
(115, '2021-03-01 07:25:56.009529', 1, 1, '', 13, NULL, 98, 19, 46),
(116, '2021-03-01 07:29:06.797441', 0, 1, '', NULL, NULL, 98, 16, 49),
(117, '2021-03-01 07:29:06.805727', 0, 1, '', NULL, 8, 98, 16, 49),
(118, '2021-03-01 07:36:05.667922', 1, 1, '', 12, NULL, 97, 15, 47),
(119, '2021-03-01 07:36:50.708800', 0, 1, '', NULL, NULL, 97, 14, 50),
(120, '2021-03-01 07:36:50.713496', 1, 1, '', 11, NULL, 97, 15, 50),
(121, '2021-03-01 07:37:48.897945', 0, 1, '', NULL, NULL, 97, 14, 50),
(122, '2021-03-01 07:38:59.278915', 1, 1, '', 12, NULL, 97, 15, 50),
(123, '2021-03-01 07:40:05.122565', 0, 1, '', NULL, NULL, 97, 17, 50),
(124, '2021-03-01 07:40:05.140601', 0, 1, '', NULL, 7, 97, 17, 50),
(125, '2021-03-01 07:42:32.584358', 0, 1, '', NULL, NULL, 97, 14, 48),
(126, '2021-03-01 07:43:27.986353', 0, 1, '', NULL, NULL, 97, 14, 51),
(127, '2021-03-01 07:43:27.990466', 1, 1, '', 11, NULL, 97, 15, 51),
(128, '2021-03-01 07:45:44.995953', 0, 1, '', NULL, NULL, 97, 14, 51),
(129, '2021-03-01 08:30:58.341703', 0, 1, '', NULL, NULL, 97, 14, 52),
(130, '2021-03-01 08:30:58.346455', 1, 1, '', 11, NULL, 97, 15, 52),
(131, '2021-03-01 08:31:16.226412', 0, 1, '', NULL, NULL, 97, 14, 52),
(132, '2021-03-01 08:31:20.088557', 1, 1, '', 12, NULL, 97, 15, 52),
(133, '2021-03-01 08:38:05.795223', 0, 1, '', NULL, NULL, 97, 14, 53),
(134, '2021-03-01 08:38:05.799163', 1, 1, '', 11, NULL, 97, 15, 53),
(135, '2021-03-01 08:38:16.524763', 1, 1, '', 12, NULL, 97, 15, 53),
(136, '2021-03-01 08:38:18.782947', 0, 1, '', NULL, NULL, 97, 14, 53),
(137, '2021-03-01 08:38:53.248815', 0, 1, '', NULL, NULL, 98, 16, 53),
(138, '2021-03-01 08:38:53.255403', 0, 1, '', NULL, 8, 98, 16, 53),
(139, '2021-03-01 08:39:26.463836', 0, 1, '', NULL, NULL, 98, 18, 53),
(140, '2021-03-01 08:39:26.467571', 0, 1, '', NULL, NULL, 98, 19, 53),
(141, '2021-03-01 08:39:26.475435', 1, 1, '', 13, NULL, 98, 19, 53),
(142, '2021-03-01 08:54:33.128108', 0, 1, '', NULL, NULL, 99, 20, 46),
(143, '2021-03-01 08:54:33.131663', 1, 1, '', 17, NULL, 99, 21, 46),
(144, '2021-03-01 08:54:33.135042', 0, 1, '', NULL, 9, 99, 21, 46),
(145, '2021-03-01 08:54:42.954328', 0, 1, '', NULL, NULL, 99, 20, 46),
(146, '2021-03-01 08:54:58.973157', 0, 1, '', NULL, NULL, 99, 22, 46),
(147, '2021-03-01 08:54:58.978016', 0, 1, '', NULL, NULL, 99, 23, 46),
(148, '2021-03-01 08:56:00.467393', 0, 1, '', NULL, NULL, 99, 22, 46),
(149, '2021-03-01 08:56:00.483154', 0, 1, '', NULL, NULL, 99, 23, 46),
(150, '2021-03-01 09:00:24.245006', 0, 1, '', NULL, NULL, 99, 20, 1),
(151, '2021-03-01 09:00:24.248878', 1, 1, '', 17, NULL, 99, 21, 1),
(152, '2021-03-01 09:00:24.251840', 0, 1, '', NULL, 9, 99, 21, 1),
(153, '2021-03-01 09:00:34.216435', 0, 1, '', NULL, NULL, 99, 20, 1),
(154, '2021-03-01 09:00:57.420655', 0, 1, '', NULL, NULL, 99, 22, 1),
(155, '2021-03-01 09:00:57.437895', 0, 1, '', NULL, NULL, 99, 23, 1),
(156, '2021-03-01 09:02:35.173544', 0, 1, '', NULL, NULL, 98, 16, 13),
(157, '2021-03-01 09:02:35.179459', 0, 1, '', NULL, 8, 98, 16, 13),
(158, '2021-03-01 09:03:10.225999', 0, 1, '', NULL, NULL, 98, 18, 13),
(159, '2021-03-01 09:03:10.238332', 0, 1, '', NULL, NULL, 98, 19, 13),
(160, '2021-03-01 09:03:10.245536', 1, 1, '', 13, NULL, 98, 19, 13),
(161, '2021-03-01 09:03:20.457777', 0, 1, '', NULL, NULL, 99, 20, 13),
(162, '2021-03-01 09:03:20.461203', 1, 1, '', 17, NULL, 99, 21, 13),
(163, '2021-03-01 09:03:20.464000', 0, 1, '', NULL, 9, 99, 21, 13),
(164, '2021-03-01 09:03:35.630578', 0, 1, '', NULL, NULL, 99, 22, 13),
(165, '2021-03-01 09:03:35.643599', 0, 1, '', NULL, NULL, 99, 23, 13),
(166, '2021-03-01 09:03:37.709095', 0, 1, '', NULL, NULL, 99, 20, 13),
(175, '2021-03-01 09:29:12.788856', 0, 1, '', NULL, NULL, 99, 20, 53),
(176, '2021-03-01 09:29:12.793551', 1, 1, '', 17, NULL, 99, 21, 53),
(177, '2021-03-01 09:29:12.797918', 0, 1, '', NULL, 9, 99, 21, 53),
(178, '2021-03-01 09:29:50.334304', 0, 1, '', NULL, NULL, 99, 20, 53),
(181, '2021-03-01 09:47:29.704899', 0, 1, '', NULL, NULL, 99, 22, 53),
(182, '2021-03-01 09:47:29.713324', 0, 1, '', NULL, NULL, 99, 23, 53),
(187, '2021-03-01 09:49:34.805877', 0, 1, '', NULL, NULL, 99, 22, 53),
(188, '2021-03-01 09:49:34.815453', 0, 1, '', NULL, NULL, 99, 23, 53),
(189, '2021-03-01 09:55:43.322683', 0, 1, '', NULL, NULL, 99, 22, 53),
(190, '2021-03-01 09:55:43.390325', 0, 1, '', NULL, NULL, 99, 23, 53),
(191, '2021-03-01 09:55:51.017344', 0, 1, '', NULL, NULL, 99, 22, 53),
(192, '2021-03-01 09:55:51.025751', 0, 1, '', NULL, NULL, 99, 23, 53),
(193, '2021-03-01 09:59:05.856754', 0, 1, '', NULL, NULL, 99, 22, 53),
(194, '2021-03-01 09:59:05.923020', 0, 1, '', NULL, NULL, 99, 23, 53),
(195, '2021-03-01 09:59:05.935529', 0, 1, '', NULL, 10, 99, 23, 53),
(196, '2021-03-01 09:59:42.307340', 0, 1, '', 18, NULL, 99, 23, 53),
(200, '2021-03-01 10:21:59.068458', 0, 1, '', NULL, NULL, 99, 22, 46),
(201, '2021-03-01 10:21:59.083064', 0, 1, '', NULL, NULL, 99, 23, 46),
(202, '2021-03-01 10:21:59.088870', 0, 1, '', NULL, 10, 99, 23, 46),
(203, '2021-03-01 10:22:33.889820', 0, 1, '', 18, NULL, 99, 23, 46),
(204, '2021-03-01 10:28:54.404610', 0, 1, '', NULL, NULL, 104, 35, 46),
(205, '2021-03-01 10:28:54.414505', 0, 1, '', NULL, 12, 104, 35, 46),
(206, '2021-03-01 10:30:24.401809', 0, 1, '', NULL, NULL, 104, 36, 46),
(207, '2021-03-01 10:30:24.413968', 0, 1, '', NULL, 13, 104, 36, 46),
(208, '2021-03-01 10:30:32.805107', 0, 1, '', 26, NULL, 104, 36, 46),
(209, '2021-03-01 10:44:06.203378', 0, 1, '', NULL, NULL, 105, 39, 46),
(210, '2021-03-01 10:44:06.211663', 0, 1, '', NULL, 15, 105, 39, 46),
(211, '2021-03-01 10:44:18.048626', 0, 1, '', NULL, 16, 105, 39, 46),
(212, '2021-03-01 10:45:44.107916', 0, 1, '', NULL, NULL, 105, 39, 1),
(213, '2021-03-01 10:45:44.120081', 0, 1, '', NULL, 15, 105, 39, 1),
(214, '2021-03-01 10:45:59.088595', 0, 1, '', NULL, 16, 105, 39, 1),
(215, '2021-03-01 10:54:47.758978', 0, 1, '', NULL, NULL, 105, 40, 1),
(216, '2021-03-01 10:57:56.699703', 0, 1, '', NULL, 17, 105, 40, 1),
(217, '2021-03-01 10:58:46.893040', 0, 1, '', NULL, NULL, 105, 41, 1),
(218, '2021-03-01 10:58:46.900241', 0, 1, '', NULL, NULL, 105, 42, 1),
(219, '2021-03-01 10:58:46.914532', 0, 1, '', 28, NULL, 105, 42, 1),
(220, '2021-03-01 10:59:26.583186', 0, 1, '', NULL, 17, 105, 40, 46),
(221, '2021-03-01 10:59:42.136143', 0, 1, '', NULL, NULL, 105, 41, 46),
(222, '2021-03-01 10:59:42.150659', 0, 1, '', NULL, NULL, 105, 42, 46),
(223, '2021-03-01 10:59:42.166382', 0, 1, '', 28, NULL, 105, 42, 46),
(224, '2021-03-01 11:04:14.478310', 0, 1, '', NULL, NULL, 106, 43, 46),
(225, '2021-03-01 11:06:57.038995', 0, 1, '', NULL, NULL, 106, 43, 46),
(226, '2021-03-01 11:06:57.055252', 0, 1, '', 29, NULL, 106, 44, 46),
(227, '2021-03-01 11:07:35.663204', 0, 1, '', NULL, NULL, 106, 46, 46),
(228, '2021-03-01 11:07:35.676572', 0, 1, '', 30, NULL, 106, 46, 46),
(229, '2021-03-01 11:08:39.056929', 0, 1, '', NULL, NULL, 106, 43, 49),
(230, '2021-03-01 11:08:39.061570', 0, 1, '', 29, NULL, 106, 44, 49),
(231, '2021-03-01 11:09:59.110514', 0, 1, '', NULL, NULL, 106, 46, 49),
(232, '2021-03-01 11:09:59.153930', 0, 1, '', 30, NULL, 106, 46, 49),
(233, '2021-03-01 11:10:21.235058', 0, 1, '', NULL, NULL, 106, 43, 49),
(234, '2021-03-01 11:11:52.597965', 0, 1, '', NULL, NULL, 106, 47, 49),
(235, '2021-03-01 11:11:52.610475', 0, 1, '', NULL, NULL, 106, 48, 49),
(236, '2021-03-01 11:11:58.519609', 0, 1, '', NULL, NULL, 106, 47, 49),
(237, '2021-03-01 11:11:58.534877', 0, 1, '', NULL, NULL, 106, 48, 49),
(238, '2021-03-01 11:14:02.034226', 0, 1, '', NULL, NULL, 106, 47, 49),
(239, '2021-03-01 11:14:02.049866', 0, 1, '', NULL, NULL, 106, 48, 49),
(240, '2021-03-01 11:20:09.231740', 0, 1, '', NULL, NULL, 106, 43, 1),
(241, '2021-03-01 11:20:09.236219', 0, 1, '', 29, NULL, 106, 44, 1),
(242, '2021-03-01 11:20:32.315183', 0, 1, '', NULL, NULL, 106, 46, 1),
(243, '2021-03-01 11:20:32.389109', 0, 1, '', 30, NULL, 106, 46, 1),
(244, '2021-03-01 11:20:35.083650', 0, 1, '', NULL, NULL, 106, 43, 1),
(245, '2021-03-01 11:20:58.939180', 0, 1, '', NULL, NULL, 106, 47, 1),
(246, '2021-03-01 11:20:59.006640', 0, 1, '', NULL, NULL, 106, 48, 1),
(247, '2021-03-01 11:22:39.435663', 0, 1, '', NULL, NULL, 106, 47, 1),
(248, '2021-03-01 11:22:39.505308', 0, 1, '', NULL, NULL, 106, 48, 1),
(249, '2021-03-01 11:24:42.864052', 0, 1, '', NULL, NULL, 107, 49, 49),
(250, '2021-03-01 11:24:42.876303', 0, 1, '', NULL, 18, 107, 49, 49),
(251, '2021-03-01 11:24:56.292681', 0, 1, '', NULL, NULL, 106, 47, 1),
(252, '2021-03-01 11:24:56.301925', 0, 1, '', NULL, NULL, 106, 48, 1),
(253, '2021-03-01 11:26:36.922376', 0, 1, '', NULL, NULL, 107, 50, 49),
(254, '2021-03-01 11:26:36.993690', 0, 1, '', NULL, 19, 107, 50, 49),
(255, '2021-03-01 11:26:46.165138', 0, 1, '', NULL, 20, 107, 50, 49),
(256, '2021-03-01 11:27:18.302429', 0, 1, '', 32, NULL, 107, 50, 49),
(257, '2021-03-01 11:28:33.304825', 0, 1, '', NULL, NULL, 106, 47, 1),
(258, '2021-03-01 11:28:33.324454', 0, 1, '', NULL, NULL, 106, 48, 1),
(259, '2021-03-01 11:28:33.338517', 0, 1, '', 31, NULL, 106, 48, 1),
(260, '2021-03-01 11:29:11.358512', 0, 1, '', NULL, NULL, 106, 47, 49),
(261, '2021-03-01 11:29:11.368881', 0, 1, '', NULL, NULL, 106, 48, 49),
(262, '2021-03-01 11:29:11.375876', 0, 1, '', 31, NULL, 106, 48, 49),
(263, '2021-03-01 11:42:12.722318', 0, 1, '', NULL, NULL, 108, 51, 1),
(264, '2021-03-01 11:42:12.726687', 1, 1, '', 34, NULL, 108, 52, 1),
(265, '2021-03-01 11:42:12.730539', 0, 1, '', NULL, 21, 108, 52, 1),
(266, '2021-03-01 11:42:46.000323', 0, 1, '', NULL, NULL, 108, 51, 1),
(267, '2021-03-01 11:43:28.050651', 0, 1, '', NULL, NULL, 106, 47, 49),
(268, '2021-03-01 11:43:28.059250', 0, 1, '', NULL, NULL, 106, 48, 49),
(269, '2021-03-01 11:43:34.526152', 0, 1, '', NULL, NULL, 107, 49, 1),
(270, '2021-03-01 11:43:34.535675', 0, 1, '', NULL, 18, 107, 49, 1),
(271, '2021-03-01 11:43:42.349809', 0, 1, '', NULL, NULL, 107, 50, 1),
(272, '2021-03-01 11:43:42.422327', 0, 1, '', NULL, 19, 107, 50, 1),
(273, '2021-03-01 11:43:50.503001', 0, 1, '', NULL, 20, 107, 50, 1),
(274, '2021-03-01 11:44:22.878319', 0, 1, '', 32, NULL, 107, 50, 1),
(275, '2021-03-01 11:44:51.332173', 0, 1, '', 33, NULL, 107, 50, 1),
(276, '2021-03-01 11:45:34.212888', 0, 1, '', NULL, NULL, 106, 47, 49),
(277, '2021-03-01 11:45:34.230549', 0, 1, '', NULL, NULL, 106, 48, 49),
(278, '2021-03-01 11:46:00.753281', 0, 1, '', NULL, NULL, 98, 16, 1),
(279, '2021-03-01 11:46:00.761423', 0, 1, '', NULL, 8, 98, 16, 1),
(287, '2021-03-01 12:26:17.710697', 0, 1, '', 33, NULL, 107, 50, 49),
(294, '2021-03-02 08:49:52.270453', 0, 1, '', NULL, NULL, 104, 35, 1),
(295, '2021-03-02 08:49:52.277805', 0, 1, '', NULL, 12, 104, 35, 1),
(305, '2021-03-03 05:40:51.020297', 0, 1, '', NULL, NULL, 105, 39, 37),
(306, '2021-03-03 05:40:51.031102', 0, 1, '', NULL, 15, 105, 39, 37),
(307, '2021-03-03 05:41:19.668137', 0, 1, '', NULL, 16, 105, 39, 37),
(308, '2021-03-03 05:48:58.282101', 0, 1, '', NULL, NULL, 105, 39, 53),
(309, '2021-03-03 05:48:58.295623', 0, 1, '', NULL, 15, 105, 39, 53),
(310, '2021-03-03 05:49:04.620463', 0, 1, '', NULL, 16, 105, 39, 53),
(311, '2021-03-04 08:56:53.713843', 0, 1, '', NULL, NULL, 110, 55, 1),
(312, '2021-03-04 08:56:53.717066', 0, 1, '', 37, NULL, 110, 56, 1),
(313, '2021-03-04 09:36:00.269614', 0, 1, '', NULL, 23, 107, 50, 1),
(314, '2021-03-04 10:05:40.254342', 0, 1, '', NULL, NULL, 110, 55, 1),
(315, '2021-03-05 06:26:18.270417', 0, 1, '', NULL, NULL, 110, 55, 54),
(316, '2021-03-05 06:26:18.275298', 0, 1, '', 37, NULL, 110, 56, 54),
(317, '2021-03-05 06:27:26.044747', 0, 1, '', NULL, NULL, 110, 55, 54),
(318, '2021-03-05 06:35:09.443708', 0, 1, '', NULL, NULL, 110, 55, 45),
(319, '2021-03-05 06:35:09.448555', 0, 1, '', 37, NULL, 110, 56, 45),
(320, '2021-03-05 06:35:38.043538', 0, 1, '', NULL, NULL, 110, 55, 45),
(321, '2021-03-05 07:08:05.303526', 0, 1, '', NULL, NULL, 108, 51, 54),
(322, '2021-03-05 07:08:05.308202', 0, 1, '', 34, NULL, 108, 52, 54),
(323, '2021-03-05 07:08:05.312834', 0, 1, '', NULL, 21, 108, 52, 54),
(324, '2021-03-05 07:08:09.500338', 0, 1, '', NULL, NULL, 107, 49, 54),
(325, '2021-03-05 07:08:09.509613', 0, 1, '', NULL, 18, 107, 49, 54),
(326, '2021-03-05 07:08:13.608927', 0, 1, '', NULL, NULL, 105, 39, 54),
(327, '2021-03-05 07:08:13.619806', 0, 1, '', NULL, 15, 105, 39, 54),
(328, '2021-03-05 07:08:26.558287', 0, 1, '', NULL, 16, 105, 39, 54);

-- --------------------------------------------------------

--
-- Table structure for table `customadmin_usercategories`
--

CREATE TABLE `customadmin_usercategories` (
  `id` int NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `category_about` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `creator_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customadmin_usercategories`
--

INSERT INTO `customadmin_usercategories` (`id`, `name`, `created_at`, `updated_date`, `category_about`, `creator_id`) VALUES
(1, 'first', '2021-02-27 18:54:22.578203', '2021-02-27 18:54:22.578246', '', 1),
(2, 'second', '2021-02-27 19:03:36.812675', '2021-02-27 19:03:36.812746', '', 1),
(3, 'third', '2021-02-27 19:04:08.492215', '2021-02-27 19:04:08.492386', '', 1),
(4, 'fourth', '2021-02-27 19:05:08.955232', '2021-02-27 19:05:08.955321', '', 1),
(12, 'eckecm', '2021-02-27 19:21:23.015178', '2021-02-27 19:21:23.015216', '', 1),
(13, 'cdkdcmkd', '2021-02-27 19:21:27.935002', '2021-02-27 19:21:27.935042', '', 1),
(14, 'dckmdcmkd', '2021-02-27 19:21:32.330306', '2021-02-27 19:21:32.330395', '', 1),
(15, 'another c', '2021-02-28 09:17:23.072080', '2021-02-28 09:17:23.072107', '', 1),
(16, 'ddd', '2021-02-28 09:22:16.895835', '2021-02-28 09:22:16.895868', '', 1),
(17, 'dcdmc', '2021-02-28 09:35:00.789342', '2021-02-28 09:35:00.789367', '', 1),
(18, 'him', '2021-02-28 09:41:34.258486', '2021-02-28 09:41:34.258512', '', 1),
(19, 'him under', '2021-02-28 16:20:19.739479', '2021-02-28 16:20:19.739539', '', 1),
(24, 'retail', '2021-03-01 11:33:14.385683', '2021-03-01 11:33:14.385739', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `custompermission_perm`
--

CREATE TABLE `custompermission_perm` (
  `id` int NOT NULL,
  `type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `object_id` smallint DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `custompermission_perm`
--

INSERT INTO `custompermission_perm` (`id`, `type`, `codename`, `name`, `object_id`, `field_name`, `description`, `content_type_id`) VALUES
(97, 'generic', 'can_create_custompermission', '', NULL, NULL, 'for createting generic permission', NULL),
(98, 'generic', 'can_see_all_custompermission', '', NULL, NULL, 'permission to user if he/she can view all available custom permission (for superadmin)', NULL),
(99, 'generic', 'can_assign_custompermission', '', NULL, NULL, 'permission for assigning custom permission to user (company admin perm)', NULL),
(100, 'generic', 'can_create_group', '', NULL, NULL, 'Custom permission for creating group', NULL),
(101, 'generic', 'can_create_organization', '', NULL, NULL, 'Custom permission for creating organization (superadmin level access)', NULL),
(102, 'generic', 'can_add_user_of_organization', '', NULL, NULL, 'custom permission for adding user of organization ', NULL),
(103, 'generic', 'can_see_all_courses', '', NULL, NULL, 'custom permission for seeing all available courses (for superadmin )', NULL),
(104, 'generic', 'can_create_courses_for_organization', '', NULL, NULL, 'custom permission for creating courses of organization', NULL),
(105, 'generic', 'can_create_topic_for_organization', '', NULL, NULL, 'custom permission for creating topics inside courses  inside organization', NULL),
(106, 'generic', 'can_create_activity_for_topic', '', NULL, NULL, 'custom permission for adding activity inside courses or outside courses', NULL),
(107, 'generic', 'can_see_upcoming_session', '', NULL, NULL, 'custom permission for checking if any upcoming class room session is available', NULL),
(108, 'generic', 'can_schedulde_session', '', NULL, NULL, 'custom permission for scheduling virtual class room session (for com. Admin )', NULL),
(109, 'generic', 'can_see_completed_session', '', NULL, NULL, 'custom permission for seeing completed session ( for teacher) (for com. Admin)', NULL),
(110, 'generic', 'can_enroll_into_courses', '', NULL, NULL, 'custom permission for enrolling into courses (according to user org and course)(end user)', NULL),
(111, 'generic', 'can_see_own_permission', '', NULL, NULL, 'custom permission for viewing own permission (for org user only )', NULL),
(112, 'generic', 'can_see_organization_courses', '', NULL, NULL, 'custom permission for viewing only organization courses (apply only when user is reg. With org)', NULL),
(113, 'generic', 'can_assign_user_to_org', '', NULL, NULL, 'custom permission for assigning  user to organization (user which is reg by same org first)', NULL),
(114, 'generic', 'can_view_all_organization', '', NULL, NULL, 'custom permission for viewing all organization (superadmin level permission )', NULL),
(115, 'generic', 'can_enroll_into_any_course', '', NULL, NULL, 'custom permission to enroll in any course (superadmin level access)', NULL),
(116, 'generic', 'can_see_all_published_courses', '', NULL, NULL, 'custom permission to view all courses which are published (for end user ) (for company admin)', NULL),
(117, 'generic', 'can_see_published_courses_activity', '', NULL, NULL, 'custom permission for viewing all activity of published courses (for end user ) (for company admin)', NULL),
(118, 'generic', 'can_assign_user_to_course', '', NULL, NULL, 'revser way to enroll user into course by company (company admin perm)', NULL),
(119, 'generic', 'can_assign_activity_to_course', '', NULL, NULL, 'assign activity to course of org by org admin or course creator (company admin perm )', NULL),
(120, 'generic', 'can_assign_topic_to_course', '', NULL, NULL, 'assign topic to course of org by org admin or course creator ', NULL),
(121, 'generic', 'can_see_all_org_courses', '', NULL, NULL, 'for viewing all  courses of courses', NULL),
(122, 'generic', 'can_view_own_organization', '', NULL, NULL, 'for seeing organization (org user perm)', NULL),
(123, 'generic', 'can_view_course_category', '', NULL, NULL, 'for viewing category (org user perm )', NULL),
(124, 'generic', 'can_edit_organization', '', NULL, NULL, 'for editing organization', NULL),
(125, 'generic', 'can_delete_organization', '', NULL, NULL, 'for deleting organization', NULL),
(126, 'generic', 'can_create_category', '', NULL, NULL, 'can create category', NULL),
(127, 'generic', 'can_update_category', '', NULL, NULL, 'can update category', NULL),
(128, 'generic', 'can_delete_category', '', NULL, NULL, 'can delete category', NULL),
(129, 'generic', 'can_view_category', '', NULL, NULL, 'can view categiory', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `custompermission_perm_groups`
--

CREATE TABLE `custompermission_perm_groups` (
  `id` int NOT NULL,
  `perm_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `custompermission_perm_groups`
--

INSERT INTO `custompermission_perm_groups` (`id`, `perm_id`, `group_id`) VALUES
(80, 97, 6),
(87, 98, 6),
(79, 99, 6),
(82, 102, 6),
(78, 110, 6),
(77, 111, 6),
(76, 112, 6),
(75, 113, 6),
(73, 117, 6),
(72, 118, 6),
(71, 119, 6),
(70, 120, 6),
(74, 121, 6),
(81, 122, 6),
(84, 126, 6),
(85, 127, 6),
(83, 129, 6);

-- --------------------------------------------------------

--
-- Table structure for table `custompermission_perm_users`
--

CREATE TABLE `custompermission_perm_users` (
  `id` int NOT NULL,
  `perm_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `custompermission_perm_users`
--

INSERT INTO `custompermission_perm_users` (`id`, `perm_id`, `user_id`) VALUES
(178, 97, 58),
(196, 97, 59),
(214, 97, 60),
(185, 98, 58),
(203, 98, 59),
(221, 98, 60),
(177, 99, 58),
(195, 99, 59),
(213, 99, 60),
(180, 102, 58),
(198, 102, 59),
(216, 102, 60),
(176, 110, 58),
(194, 110, 59),
(212, 110, 60),
(175, 111, 58),
(193, 111, 59),
(211, 111, 60),
(174, 112, 58),
(192, 112, 59),
(210, 112, 60),
(173, 113, 58),
(191, 113, 59),
(209, 113, 60),
(171, 117, 58),
(189, 117, 59),
(207, 117, 60),
(170, 118, 58),
(188, 118, 59),
(206, 118, 60),
(169, 119, 58),
(187, 119, 59),
(205, 119, 60),
(168, 120, 58),
(186, 120, 59),
(204, 120, 60),
(172, 121, 58),
(190, 121, 59),
(208, 121, 60),
(179, 122, 58),
(197, 122, 59),
(215, 122, 60),
(182, 126, 58),
(200, 126, 59),
(218, 126, 60),
(183, 127, 58),
(201, 127, 59),
(219, 127, 60),
(181, 129, 58),
(199, 129, 59),
(217, 129, 60);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_general_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(45, 'accounts', 'user'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(64, 'chat', 'chatmessage'),
(66, 'chat', 'layer'),
(63, 'chat', 'room'),
(65, 'chat', 'room_user'),
(5, 'contenttypes', 'contenttype'),
(38, 'customadmin', 'activities'),
(9, 'customadmin', 'activityadding'),
(34, 'customadmin', 'activitytype'),
(10, 'customadmin', 'answer'),
(40, 'customadmin', 'assignmentactivity'),
(41, 'customadmin', 'assignmentanswer'),
(11, 'customadmin', 'categories'),
(12, 'customadmin', 'categorieshirerchy'),
(13, 'customadmin', 'chatactivity'),
(37, 'customadmin', 'city'),
(14, 'customadmin', 'classroom'),
(15, 'customadmin', 'contentvideo'),
(35, 'customadmin', 'country'),
(16, 'customadmin', 'courseenroll'),
(17, 'customadmin', 'courses'),
(18, 'customadmin', 'coursesenduser'),
(42, 'customadmin', 'dragdropactivity'),
(44, 'customadmin', 'dragdropactivityanswers'),
(43, 'customadmin', 'dragdropactivityelements'),
(19, 'customadmin', 'fileactivity'),
(20, 'customadmin', 'language'),
(21, 'customadmin', 'languagecourse'),
(22, 'customadmin', 'organization'),
(23, 'customadmin', 'personinroom'),
(24, 'customadmin', 'question'),
(33, 'customadmin', 'sessionactivity'),
(25, 'customadmin', 'spinactivity'),
(32, 'customadmin', 'spinactivityanswer'),
(31, 'customadmin', 'spinactivityenroll'),
(36, 'customadmin', 'state'),
(30, 'customadmin', 'subtopic'),
(26, 'customadmin', 'topic'),
(29, 'customadmin', 'topicdetails'),
(28, 'customadmin', 'topicrelation'),
(39, 'customadmin', 'topicwiseanswerpaper'),
(27, 'customadmin', 'usercategories'),
(8, 'custompermission', 'perm'),
(61, 'grades', 'graderange'),
(62, 'grades', 'gradingsystem'),
(46, 'organization', 'userinformation'),
(56, 'polls', 'choice'),
(57, 'polls', 'poll'),
(53, 'preassesment', 'answer'),
(54, 'preassesment', 'answerpaper'),
(47, 'preassesment', 'assesments'),
(52, 'preassesment', 'fileupload'),
(48, 'preassesment', 'question'),
(51, 'preassesment', 'questionoption'),
(50, 'preassesment', 'questionpaper'),
(49, 'preassesment', 'questionset'),
(55, 'preassesment', 'quiz'),
(6, 'sessions', 'session'),
(7, 'sites', 'site'),
(67, 'taggit', 'tag'),
(68, 'taggit', 'taggeditem'),
(58, 'userlms', 'discussion'),
(59, 'userlms', 'forumanswer'),
(60, 'userlms', 'notes');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int NOT NULL,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'accounts', '0001_initial', '2021-02-25 05:49:02.364270'),
(2, 'contenttypes', '0001_initial', '2021-02-25 05:49:02.409774'),
(3, 'auth', '0001_initial', '2021-02-25 05:49:02.541442'),
(4, 'admin', '0001_initial', '2021-02-25 05:49:02.823090'),
(5, 'admin', '0002_logentry_remove_auto_add', '2021-02-25 05:49:02.897465'),
(6, 'admin', '0003_logentry_add_action_flag_choices', '2021-02-25 05:49:02.954424'),
(7, 'contenttypes', '0002_remove_content_type_name', '2021-02-25 05:49:03.026534'),
(8, 'auth', '0002_alter_permission_name_max_length', '2021-02-25 05:49:03.072998'),
(9, 'auth', '0003_alter_user_email_max_length', '2021-02-25 05:49:03.100185'),
(10, 'auth', '0004_alter_user_username_opts', '2021-02-25 05:49:03.110907'),
(11, 'auth', '0005_alter_user_last_login_null', '2021-02-25 05:49:03.151029'),
(12, 'auth', '0006_require_contenttypes_0002', '2021-02-25 05:49:03.154886'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2021-02-25 05:49:03.164307'),
(14, 'auth', '0008_alter_user_username_max_length', '2021-02-25 05:49:03.214307'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2021-02-25 05:49:03.261549'),
(16, 'auth', '0010_alter_group_name_max_length', '2021-02-25 05:49:03.288572'),
(17, 'auth', '0011_update_proxy_permissions', '2021-02-25 05:49:03.299533'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2021-02-25 05:49:03.345695'),
(19, 'taggit', '0001_initial', '2021-02-25 05:49:03.408884'),
(20, 'taggit', '0002_auto_20150616_2121', '2021-02-25 05:49:03.503552'),
(21, 'taggit', '0003_taggeditem_add_unique_index', '2021-02-25 05:49:03.525126'),
(22, 'customadmin', '0001_initial', '2021-02-25 05:49:04.266446'),
(23, 'organization', '0001_initial', '2021-02-25 05:49:04.875993'),
(24, 'customadmin', '0002_auto_20201203_1754', '2021-02-25 05:49:08.197592'),
(25, 'customadmin', '0003_auto_20201204_1110', '2021-02-25 05:49:08.674383'),
(26, 'customadmin', '0004_usercategories_creator', '2021-02-25 05:49:08.748156'),
(27, 'customadmin', '0005_auto_20201204_1432', '2021-02-25 05:49:08.865053'),
(28, 'customadmin', '0006_auto_20201207_1559', '2021-02-25 05:49:09.224551'),
(29, 'customadmin', '0007_auto_20201207_1653', '2021-02-25 05:49:09.383077'),
(30, 'customadmin', '0008_auto_20201208_1635', '2021-02-25 05:49:09.637132'),
(31, 'customadmin', '0009_auto_20201208_1713', '2021-02-25 05:49:09.854918'),
(32, 'customadmin', '0010_auto_20201209_1203', '2021-02-25 05:49:10.170244'),
(33, 'customadmin', '0011_auto_20201209_1440', '2021-02-25 05:49:10.242468'),
(34, 'customadmin', '0012_auto_20201215_1259', '2021-02-25 05:49:10.438008'),
(35, 'customadmin', '0013_auto_20201215_1731', '2021-02-25 05:49:10.736799'),
(36, 'customadmin', '0014_auto_20201215_1838', '2021-02-25 05:49:11.087377'),
(37, 'customadmin', '0015_organization_certificate', '2021-02-25 05:49:11.206239'),
(38, 'customadmin', '0016_auto_20201221_1511', '2021-02-25 05:49:11.428126'),
(39, 'customadmin', '0017_auto_20210105_1106', '2021-02-25 05:49:11.812193'),
(40, 'customadmin', '0018_auto_20210105_1634', '2021-02-25 05:49:12.084913'),
(41, 'customadmin', '0019_courseenroll_activity', '2021-02-25 05:49:12.169271'),
(42, 'customadmin', '0020_auto_20210106_0059', '2021-02-25 05:49:12.200294'),
(43, 'customadmin', '0021_organization_course', '2021-02-25 05:49:12.258164'),
(44, 'customadmin', '0022_organization_students', '2021-02-25 05:49:12.391592'),
(45, 'customadmin', '0023_activities_content_id', '2021-02-25 05:49:12.532732'),
(46, 'customadmin', '0024_auto_20210112_1215', '2021-02-25 05:49:12.587008'),
(47, 'customadmin', '0025_auto_20210113_1430', '2021-02-25 05:49:12.638771'),
(48, 'customadmin', '0026_auto_20210113_1438', '2021-02-25 05:49:12.922803'),
(49, 'customadmin', '0027_auto_20210113_1447', '2021-02-25 05:49:13.119150'),
(50, 'customadmin', '0028_auto_20210113_1527', '2021-02-25 05:49:13.219498'),
(51, 'customadmin', '0029_auto_20210113_1545', '2021-02-25 05:49:13.350976'),
(52, 'customadmin', '0030_auto_20210113_1549', '2021-02-25 05:49:13.439074'),
(53, 'customadmin', '0031_auto_20210113_1600', '2021-02-25 05:49:14.057102'),
(54, 'customadmin', '0032_auto_20210113_1603', '2021-02-25 05:49:14.157841'),
(55, 'customadmin', '0033_auto_20210113_1616', '2021-02-25 05:49:14.952766'),
(56, 'customadmin', '0034_auto_20210114_1038', '2021-02-25 05:49:15.083459'),
(57, 'customadmin', '0035_auto_20210115_1238', '2021-02-25 05:49:15.177402'),
(58, 'customadmin', '0036_auto_20210119_1839', '2021-02-25 05:49:15.381272'),
(59, 'customadmin', '0037_auto_20210120_1019', '2021-02-25 05:49:15.424242'),
(60, 'customadmin', '0038_contentvideo_thumbnail', '2021-02-25 05:49:15.472721'),
(61, 'customadmin', '0039_auto_20210120_1542', '2021-02-25 05:49:15.571364'),
(62, 'customadmin', '0040_auto_20210121_1746', '2021-02-25 05:49:15.607953'),
(63, 'customadmin', '0041_auto_20210122_1311', '2021-02-25 05:49:15.685147'),
(64, 'customadmin', '0042_auto_20210122_1519', '2021-02-25 05:49:15.916932'),
(65, 'customadmin', '0043_auto_20210125_1446', '2021-02-25 05:49:16.075301'),
(66, 'customadmin', '0044_auto_20210125_1722', '2021-02-25 05:49:16.115891'),
(67, 'customadmin', '0045_auto_20210127_0020', '2021-02-25 05:49:16.224400'),
(68, 'customadmin', '0046_auto_20210131_1418', '2021-02-25 05:49:16.319631'),
(69, 'customadmin', '0049_auto_20210202_1022', '2021-02-25 05:49:16.467126'),
(70, 'customadmin', '0050_assignmentactivity_created_at', '2021-02-25 05:49:16.540217'),
(71, 'customadmin', '0051_coursesenduser_course_tag', '2021-02-25 05:49:16.587080'),
(72, 'customadmin', '0052_auto_20210203_1732', '2021-02-25 05:49:16.629587'),
(73, 'customadmin', '0053_auto_20210203_1746', '2021-02-25 05:49:16.723859'),
(74, 'customadmin', '0054_assignmentanswer_submission', '2021-02-25 05:49:16.921594'),
(75, 'customadmin', '0055_auto_20210203_1752', '2021-02-25 05:49:17.062587'),
(76, 'customadmin', '0056_auto_20210208_1101', '2021-02-25 05:49:17.184943'),
(77, 'customadmin', '0057_auto_20210208_1526', '2021-02-25 05:49:17.228329'),
(78, 'customadmin', '0058_auto_20210209_1234', '2021-02-25 05:49:17.274008'),
(79, 'customadmin', '0059_auto_20210212_1015', '2021-02-25 05:49:17.312779'),
(80, 'customadmin', '0060_auto_20210215_2249', '2021-02-25 05:49:17.528997'),
(81, 'customadmin', '0061_auto_20210215_2259', '2021-02-25 05:49:17.618481'),
(82, 'customadmin', '0062_auto_20210216_1447', '2021-02-25 05:49:18.003255'),
(83, 'customadmin', '0063_auto_20210218_0016', '2021-02-25 05:49:18.410878'),
(84, 'customadmin', '0064_auto_20210218_0018', '2021-02-25 05:49:18.652737'),
(85, 'customadmin', '0065_auto_20210218_1256', '2021-02-25 05:49:18.741001'),
(86, 'customadmin', '0066_remove_usercategories_thumbnail', '2021-02-25 05:49:18.801594'),
(87, 'customadmin', '0067_auto_20210218_1300', '2021-02-25 05:49:19.026058'),
(88, 'customadmin', '0068_auto_20210218_1811', '2021-02-25 05:49:19.370424'),
(89, 'customadmin', '0069_auto_20210219_1135', '2021-02-25 05:49:19.465525'),
(90, 'customadmin', '0070_organization_is_active', '2021-02-25 05:49:19.572926'),
(91, 'customadmin', '0071_auto_20210221_1049', '2021-02-25 05:49:19.610588'),
(92, 'customadmin', '0072_spinactivity_question_in_seq', '2021-02-25 05:49:19.669950'),
(93, 'customadmin', '0073_auto_20210223_1736', '2021-02-25 05:49:19.834155'),
(94, 'customadmin', '0074_remove_topic_end_date', '2021-02-25 05:49:19.910328'),
(95, 'customadmin', '0075_topic_end_date', '2021-02-25 05:49:19.978338'),
(96, 'customadmin', '0076_auto_20210223_1751', '2021-02-25 05:49:20.070551'),
(97, 'customadmin', '0078_auto_20210223_1815', '2021-02-25 05:49:20.109703'),
(98, 'customadmin', '0079_auto_20210225_1111', '2021-02-25 05:49:20.243847'),
(99, 'chat', '0001_initial', '2021-02-25 05:49:20.719064'),
(100, 'custompermission', '0001_initial', '2021-02-25 05:49:21.094831'),
(101, 'grades', '0001_initial', '2021-02-25 05:49:21.523521'),
(102, 'grades', 'default_grading_system', '2021-02-25 05:49:21.617839'),
(103, 'organization', '0002_auto_20210121_1543', '2021-02-25 05:49:21.943260'),
(104, 'organization', '0003_userinformation_image', '2021-02-25 05:49:22.007672'),
(105, 'organization', '0004_userinformation_houseno', '2021-02-25 05:49:22.073284'),
(106, 'organization', '0005_auto_20210121_1746', '2021-02-25 05:49:22.115684'),
(107, 'organization', '0006_auto_20210125_1237', '2021-02-25 05:49:22.156665'),
(108, 'organization', '0007_auto_20210125_1455', '2021-02-25 05:49:22.275557'),
(109, 'organization', '0008_auto_20210225_1111', '2021-02-25 05:49:22.519352'),
(110, 'polls', '0001_initial', '2021-02-25 05:49:22.598610'),
(111, 'preassesment', '0001_initial', '2021-02-25 05:49:23.657227'),
(112, 'preassesment', '0002_auto_20201221_2050', '2021-02-25 05:49:24.635982'),
(113, 'preassesment', '0003_remove_questionpaper_shuffle_testcases', '2021-02-25 05:49:24.720753'),
(114, 'preassesment', '0004_auto_20210112_0106', '2021-02-25 05:49:24.841844'),
(115, 'preassesment', '0005_auto_20210112_1115', '2021-02-25 05:49:25.118928'),
(116, 'preassesment', '0006_auto_20210118_1455', '2021-02-25 05:49:25.374658'),
(117, 'preassesment', '0007_remove_quiz_start_date_time', '2021-02-25 05:49:25.462793'),
(118, 'preassesment', '0008_auto_20210127_0118', '2021-02-25 05:49:25.613517'),
(119, 'preassesment', '0009_auto_20210127_0130', '2021-02-25 05:49:25.823873'),
(120, 'preassesment', '0010_auto_20210225_1111', '2021-02-25 05:49:26.115718'),
(121, 'sessions', '0001_initial', '2021-02-25 05:49:26.142516'),
(122, 'sites', '0001_initial', '2021-02-25 05:49:26.181009'),
(123, 'sites', '0002_alter_domain_unique', '2021-02-25 05:49:26.201974'),
(124, 'userlms', '0001_initial', '2021-02-25 05:49:26.652502'),
(125, 'userlms', '0002_delete_notes', '2021-02-25 05:49:26.852131'),
(126, 'userlms', '0003_notes', '2021-02-25 05:49:26.932678'),
(127, 'customadmin', '0080_auto_20210302_1522', '2021-03-02 09:53:00.937201'),
(128, 'customadmin', '0081_auto_20210302_1533', '2021-03-02 10:03:40.517017');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('03b9p9e8dnnfa2eunazqagwl2ueydi7j', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lI3ie:k7X8eiNxgOxl1q3ONmo0gQMWz4zS5cDpDs2KtPQWzaw', '2021-03-19 06:13:48.577157'),
('077o5lcnb5d1kiy4imw15bdwjoevzewl', '.eJxVjk0OwiAUhO_C2lChYGmX7j1D84BHoVUwLdVE492lSRc6y_n5Mm_Sw5p9vy4498GSjjBy-PU0mAnjFtgR4pCoSTHPQdOtQvd0oZdk8Xreu38AD4sva9dobJyQXNT8KFQrjVVoiqBVDKB4wjBm0FldN0pyzRl3DtGpE3KUpkDTPEAML8ghxUL0Od-7qnraycbHGNGVazfy-QKuDUa7:1lI6LR:bEUNB4L-bUXHIixm3LzpaXbd4ZsKs3MiAEDeWO_EuRk', '2021-03-19 09:02:01.241209'),
('80c1n1et9z22mb7364suv477h6gaz2pl', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lGUhM:_-1uhbo-WOMAptpRaTaHuzDpQwbYyXJvBwF877P_1bg', '2021-03-14 22:38:00.794515'),
('98e3xs6qbcy1bq3kkj9ckon77ccprig1', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lHRQa:Q7DyJYZ__mno1n5IDHIqpx5hEy81MvPhdlj7DB4udzU', '2021-03-17 13:20:36.987561'),
('aqr0iovtdz55xiqxjamvw3ybpmk4dras', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lGcep:Tc2s71czPF1s5rC6fR-mk_d2-EmNi_sSckQFoTfIHPY', '2021-03-15 07:07:55.393444'),
('bzo0rr2rfukvke6f5opac6s0pws80twv', '.eJxVjEEOgjAURO_StWk-tS2tS_ecgXz-tIKaklBYGe-uJCx0O--9eamet3Xst5qWfoK6qLNRp99xYHmkshPcudxmLXNZl2nQu6IPWnU3Iz2vh_t3MHIdv7UJwQIRhriN2TcEZ2LrESg5JwNEQo6GsvUSCEyUXeO9mIQ2Admq9wcDOzh0:1lFEUK:WuHvw54cW2AcBVN1jIj7sFOrf5ssHEAYPAWzE8l2OGU', '2021-03-11 11:07:20.680514'),
('djnksq0jm1ximjmlxhxqky95tp48v5uf', '.eJxVjEEOwiAQRe_C2pBSoBSX7j0DmRlmpGpoUtqV8e7apAvd_vfef6kE21rS1nhJU1Zn5a06_Y4I9OC6k3yHeps1zXVdJtS7og_a9HXO_Lwc7t9BgVa-NYTRgvVoPFoIxsloOzI5gosoHgFoiGKJse-N5MAsjkI0jmHoghdW7w8cTzj1:1lHLGE:DO0ClWO2wJaZUA7YpZuxCPaJxwFvd9m01hz85f67uNc', '2021-03-17 06:45:30.910384'),
('gvh1v8hzfdxpn3k8hlpudvl2u554vac1', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lGfXw:K79pyV-XSPAWnrsWemF5taCwXPycEKdyMhQVKYhqVQ4', '2021-03-15 10:13:00.138506'),
('h95hmrdcton4zcgw20zp5ch3qoot0904', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lHRJF:0Gx6oHyFSEIu6yDNHpqBklIkKxxTHJx2xpVuZVgBPu0', '2021-03-17 13:13:01.866345'),
('ixbaijamiqhxlh4vbsvupouqb1ahtxhv', '.eJxVjEEOwiAQAP_C2RAWlgoevfcNDbuAVA0kpT0Z_25qetDrzGReYgrbWqatp2Wao7gIi-L0CynwI9XdxHuotya51XWZSe6JPGyXY4vpeT3av0EJvXy_xiuMyA5cUpmz9RrOCTKS4YhIDsEDW80EKSvtBqu8BxyI2LLJ4v0B9BI3qA:1lGh5l:i07KvChwR_GYYWBWSGOS0y1CXB7t4PnKnKmWiH8ZGdw', '2021-03-15 11:52:01.408843'),
('mvsgkxk3f6c74h7it3h0ixnhwc9te1r2', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lGfeA:N3XTetXw7JgqzKLCYrwmYzSPpPgr3lJmraQveynEKHc', '2021-03-15 10:19:26.319274'),
('qfihtgodrbn7c897q3t2s2e5lm85ohak', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lHRV0:xaBmgY3tnZ_nHtPEsnGb4NRTY__qGzkqXHByS5pNRSE', '2021-03-17 13:25:10.869209'),
('qyh9sqz5pald56kkyy9q05vdn2hzikwa', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lH0la:69C6-CD8GSt_gxxtP5CwNvoOFNpP4Z5KNFnqElN6K4w', '2021-03-16 08:52:30.777007'),
('qzjmryxsabx6qaztii4lpvzyzyskvkod', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lH0nk:qOlTBitKuIVeT6XYznVuhsVxzJH7JoCUVV3KTs5VYiQ', '2021-03-16 08:54:44.968965'),
('sfo6i76jalegvnacpfegjmwpx4juoztl', '.eJxVjk0OwiAQhe_C2qBga9Gle8_QDMOMpSoYSmvUeHdp0oW-5fv58t6ihTF37ThQar0TB6HE6tezgBcKc-B6COcoMYacvJVzRS7pIE_R0fW4dP8AHQxdWXNjqeGq1tVWbyqzr9EZwiLYGwVQvAqVQmJnt42ptdVKMxOx2ZGmGgs0pjME_4LsYyjELuf7Yb1-uEtinlKangn70Dvk8vEmPl9ETEqb:1lFWPv:CH2hAF9GG9CvppqRZcQfgYt0Q7bc8yOKaEMBSVHxGkA', '2021-03-12 06:15:59.663442'),
('sr0nh0qm677mg43iex43hbkpws6t16kk', '.eJxVjEEOwiAQRe_C2pBSoBSX7j0DmRlmpGpoUtqV8e7apAvd_vfef6kE21rS1nhJU1Zn5a06_Y4I9OC6k3yHeps1zXVdJtS7og_a9HXO_Lwc7t9BgVa-NYTRgvVoPFoIxsloOzI5gosoHgFoiGKJse-N5MAsjkI0jmHoghdW7w8cTzj1:1lHKNK:-hBdQ2_o8VftloNtDM36dO4R68YQrF3sxCqg-jbTiJw', '2021-03-17 05:48:46.806397'),
('t5ddtaq8cm252yd88lm3bc4nnpg73qxb', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lHJeh:9NwKp-B-XzCY_dVKvWvP1FhK0GhLGjfQAYQOn74vArw', '2021-03-17 05:02:39.107043'),
('uwsrllfg0upx3litk5xen6mgap54lnck', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lHRZq:qodPuOwSeVnpGAy8HBPK8SuHeB_PyWLrEfWj9RXyW0s', '2021-03-17 13:30:10.351796'),
('vmjdubmdf633aep68f8r8jynr7c571iq', '.eJxVzMEOwiAQBNB_4WxI7QKlHr37DWSXXaRqaFLak_HfpUkPep15M28VcFtz2KosYWJ1UWZUp9-QMD6l7A0_sNxnHeeyLhPpneijrfo2s7yuh_07yFhzW6Nn8Cxn6wx5MmgdAEQaIQ4ijqRD68F3vRcTmU1CaSrZwfaNuuTU5wsbsTh9:1lGgPK:R3kQC38RUx0Q9CCKj1wWe3Gn-3n8NHpM_ZhNeJS3iYo', '2021-03-15 11:08:10.123615'),
('w44he5midnulo8ip9uncmnod9duuht9f', '.eJxVjMEOwiAQRP-FsyFCQahH7_0Gsiy7UjWQlPZk_Hdp0oPO8c2beYsA25rD1mgJcxJXocTpl0XAJ5W9SA8o9yqxlnWZo9wVebRNTjXR63a4fwcZWu5rdpEcG6vNoM_GjxaTJ-yB0SuAzgwqhcQpDs5bHbXSzETsL6TJovh8AfaFOMI:1lH2y0:Apc_I7dZDyBqTyqhPquRIbO2xLqwGKR3ejEcBdwpTtM', '2021-03-16 11:13:28.761560'),
('w9jany1chrngyi9pj3crta0b2gph7egy', '.eJxVjEEOwiAQAP_C2RAWlgoevfcNDbuAVA0kpT0Z_25qetDrzGReYgrbWqatp2Wao7gIi-L0CynwI9XdxHuotya51XWZSe6JPGyXY4vpeT3av0EJvXy_xiuMyA5cUpmz9RrOCTKS4YhIDsEDW80EKSvtBqu8BxyI2LLJ4v0B9BI3qA:1lI4bP:YEPBQAdmRbGYa0M8rDzoN83O7f825EHkn9fpyfmP3gs', '2021-03-19 07:10:23.932971'),
('xn4kmgb6fuhjki08l6a4y6jhomwz17er', '.eJxVjMsOwiAQRf-FtSG8BhiX7v0GAgNI1dCktCvjv2uTLnR7zzn3xULc1ha2UZYwZXZmINjpd0yRHqXvJN9jv82c5r4uU-K7wg86-HXO5Xk53L-DFkf71kJ5Z500oEQtmkBZnapH5aJWTmayCD5jImeykAQmVqrKEyCh0YiJvT_bhjdf:1lGd6j:BYWs5Ov-7TnkIPOnYqOXHBRK_HQMCiTX1ls9ZnTsE-A', '2021-03-15 07:36:45.454227'),
('ysdzuon7rtdpiswawwe75t9wc1jx5pq0', '.eJxVjMEOwiAQRP-FsyGlu0jr0bvfQNhdkKqBpLQn47_bJj3obTLvzbyVD-uS_dri7CdRF2WNOv2WFPgZy07kEcq9aq5lmSfSu6IP2vStSnxdD_fvIIeWt7WJEGjkNDB1o3PGIBIYEYuQgB3CmXoRRpd6x7G30tktD5JgJASD6vMFEB84Bg:1lGdD8:NdNnJIITEF1h-KWaTgZrub_apVG8xJ0pTA0hAGmPrgY', '2021-03-15 07:43:22.111126');

-- --------------------------------------------------------

--
-- Table structure for table `django_site`
--

CREATE TABLE `django_site` (
  `id` int NOT NULL,
  `domain` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

-- --------------------------------------------------------

--
-- Table structure for table `grades_graderange`
--

CREATE TABLE `grades_graderange` (
  `id` int NOT NULL,
  `lower_limit` double NOT NULL,
  `upper_limit` double NOT NULL,
  `grade` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(127) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `system_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades_graderange`
--

INSERT INTO `grades_graderange` (`id`, `lower_limit`, `upper_limit`, `grade`, `description`, `system_id`) VALUES
(1, 0, 40, 'F', 'Fail', 1),
(2, 40, 55, 'P', 'Pass', 1),
(3, 55, 60, 'C', 'Average', 1),
(4, 60, 75, 'B', 'Satisfactory', 1),
(5, 75, 90, 'A', 'Good', 1),
(6, 90, 101, 'A+', 'Excellent', 1);

-- --------------------------------------------------------

--
-- Table structure for table `grades_gradingsystem`
--

CREATE TABLE `grades_gradingsystem` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `creator_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades_gradingsystem`
--

INSERT INTO `grades_gradingsystem` (`id`, `name`, `description`, `creator_id`) VALUES
(1, 'default', 'About the grading system!', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `organization_userinformation`
--

CREATE TABLE `organization_userinformation` (
  `id` int NOT NULL,
  `end_user` tinyint(1) NOT NULL,
  `position` varchar(155) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `organization_id` int NOT NULL,
  `user_id` int NOT NULL,
  `address` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pincode` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `registration_date` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `houseno` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address1` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organization_userinformation`
--

INSERT INTO `organization_userinformation` (`id`, `end_user`, `position`, `email`, `phone`, `is_active`, `organization_id`, `user_id`, `address`, `first_name`, `last_name`, `pincode`, `registration_date`, `image`, `houseno`, `address1`) VALUES
(8, 0, 'admin', 'dcjdcnj@gmail.com', '4786543567', 1, 6, 42, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL),
(9, 0, 'admin', 'adminorg1@gmail.com', '345435', 1, 7, 45, NULL, 'admin', 'org', NULL, NULL, '', NULL, NULL),
(10, 0, 'student', 'studentone@gmail.com', '43563453', 1, 7, 46, 'Demo address', 'Demo Student', 'one', '345345', '2021-03-01 12:34:21.454614', 'user_profile/download_1.png', '23', 'None'),
(11, 0, 'student', 'studenttwo@gmail.com', '234234', 1, 7, 49, 'demo address', 'Demo Student', 'Two', '3234', '2021-03-01 12:58:45.612573', '', '324', NULL),
(12, 0, 'admin', 'talento@gmail.com', '7446466464', 1, 8, 54, 'talento', 'talento', 'talento', NULL, NULL, '', NULL, NULL),
(13, 0, 'student', 'talento1@gmail.com', '8765435678', 1, 8, 55, 'dknndvndnvd dj vj', 'talento', 'talento', '908765354', '2021-03-01 17:11:25.724986', '', 'dsjcbjdsbcdcj', 'None'),
(14, 0, 'teacher', 'teacher1@gmail.com', '9876754678', 1, 8, 56, 'ihbhgtg gvh', 'teacher1', 'teacher1', '6726672346', '2021-03-01 17:20:40.924593', '', 'uherureb', NULL),
(17, 0, 'admin', 'plus@gmail.com', '7563643664', 1, 11, 60, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `polls_choice`
--

CREATE TABLE `polls_choice` (
  `id` int NOT NULL,
  `choice_text` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `votes` int NOT NULL,
  `poll_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `polls_poll`
--

CREATE TABLE `polls_poll` (
  `id` int NOT NULL,
  `question` varchar(200) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_answer`
--

CREATE TABLE `preassesment_answer` (
  `id` int NOT NULL,
  `answer` longtext COLLATE utf8mb4_general_ci,
  `error` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `marks` double NOT NULL,
  `correct` tinyint(1) NOT NULL,
  `skipped` tinyint(1) NOT NULL,
  `comment` longtext COLLATE utf8mb4_general_ci,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_answer`
--

INSERT INTO `preassesment_answer` (`id`, `answer`, `error`, `marks`, `correct`, `skipped`, `comment`, `question_id`) VALUES
(1, NULL, '[]', 0, 0, 0, NULL, 2),
(2, 'dcnjcdj', '[]', 0, 0, 0, NULL, 1),
(3, 'njcdn', '[]', 0, 0, 0, NULL, 1),
(4, 'dcnjdcnj', '[]', 0, 0, 0, NULL, 2),
(5, 'dcnjcdj', '[]', 0, 0, 0, NULL, 1),
(6, 'dccdn', '[]', 0, 0, 0, NULL, 2),
(7, 'dcnjcdj', '[]', 0, 0, 0, NULL, 1),
(8, 'dccdn', '[]', 0, 0, 0, NULL, 2),
(9, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(10, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(11, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 3),
(12, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(13, 'Demo Answer 2', '[]', 0, 0, 0, NULL, 5),
(14, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(15, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(16, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(17, 'option1', '[]', 0, 0, 0, NULL, 6),
(18, 'option1', '[]', 0, 0, 0, NULL, 6),
(19, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(20, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(21, 'option1', '[]', 0, 0, 0, NULL, 6),
(22, 'Demo Answer 2', '[]', 0, 0, 0, NULL, 5),
(23, 'Demo', '[]', 0, 0, 0, NULL, 4),
(24, 'option1', '[]', 0, 0, 0, NULL, 6),
(25, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(26, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(27, 'option1', '[]', 0, 0, 0, NULL, 6),
(28, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(29, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(30, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 3),
(31, 'option2', '[]', 0, 0, 0, NULL, 6),
(32, 'demo5 option2', '[]', 0, 0, 0, NULL, 7),
(33, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 3),
(34, 'option2', '[]', 0, 0, 0, NULL, 6),
(35, 'demo5 option1', '[]', 0, 0, 0, NULL, 7),
(36, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(37, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(38, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(39, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(40, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(41, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 3),
(42, 'option1', '[]', 0, 0, 0, NULL, 6),
(43, 'demo5 option1', '[]', 0, 0, 0, NULL, 7),
(44, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(45, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5),
(46, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 4),
(47, 'Demo Answer 1', '[]', 0, 0, 0, NULL, 5);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_answerpaper`
--

CREATE TABLE `preassesment_answerpaper` (
  `id` int NOT NULL,
  `attempt_number` int NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `user_ip` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `comments` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `marks_obtained` double DEFAULT NULL,
  `percent` double DEFAULT NULL,
  `passed` tinyint(1) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `questions_order` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `extra_time` double NOT NULL,
  `is_special` tinyint(1) NOT NULL,
  `question_paper_id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_answerpaper`
--

INSERT INTO `preassesment_answerpaper` (`id`, `attempt_number`, `start_time`, `end_time`, `user_ip`, `comments`, `marks_obtained`, `percent`, `passed`, `status`, `questions_order`, `extra_time`, `is_special`, `question_paper_id`, `user_id`) VALUES
(1, 1, '2021-02-25 09:20:08.444383', '2021-02-25 09:33:11.817518', '192.168.1.117', '', 0, 0, 0, 'completed', '1,2', 0, 0, 1, 1),
(3, 1, '2021-02-26 12:47:43.720834', '2021-02-26 12:49:46.441024', '127.0.0.1', '', 0, 0, 0, 'inprogress', '1,2', 0, 0, 3, 1),
(4, 1, '2021-03-01 05:45:54.129971', '2021-03-01 05:46:01.169851', '192.168.1.117', '', 0, 0, 0, 'completed', '1,2', 0, 0, 4, 39),
(5, 1, '2021-03-01 05:48:15.868726', '2021-03-01 05:48:35.992934', '192.168.1.86', '', 0, 0, 0, 'completed', '1,2', 0, 0, 4, 33),
(6, 1, '2021-03-01 06:38:24.579908', '2021-03-01 06:44:26.394425', '192.168.1.117', '', 0, 0, 0, 'completed', '4,5,3', 0, 0, 5, 40),
(7, 1, '2021-03-01 07:00:54.148066', '2021-03-01 07:01:19.896171', '192.168.1.117', '', 0, 0, 0, 'completed', '4,5,3', 0, 0, 5, 43),
(8, 1, '2021-03-01 07:02:21.976004', '2021-03-01 07:03:25.515294', '192.168.1.117', '', 0, 0, 0, 'completed', '4,5,3', 0, 0, 5, 44),
(9, 1, '2021-03-01 07:05:27.015966', '2021-03-01 07:08:41.321074', '192.168.1.86', '', 0, 0, 0, 'inprogress', '4,5,3', 0, 0, 5, 46),
(10, 1, '2021-03-01 07:12:35.867177', '2021-03-01 07:12:53.164401', '192.168.1.117', '', 0, 0, 0, 'completed', '6,5,4', 0, 0, 5, 47),
(11, 1, '2021-03-01 07:20:47.953254', '2021-03-01 07:40:47.953254', '192.168.1.122', '', 0, 0, 0, 'inprogress', '6,5,4', 0, 0, 5, 48),
(12, 1, '2021-03-01 07:36:53.852966', '2021-03-01 07:37:22.894256', '192.168.1.117', '', 0, 0, 0, 'completed', '6,5,4', 0, 0, 5, 50),
(13, 1, '2021-03-01 07:43:31.538953', '2021-03-01 07:43:45.680272', '192.168.1.122', '', 0, 0, 0, 'completed', '6,5,4', 0, 0, 5, 51),
(14, 1, '2021-03-01 08:31:01.670615', '2021-03-01 08:31:13.763301', '192.168.1.117', '', 0, 0, 0, 'completed', '6,5,4', 0, 0, 5, 52),
(15, 1, '2021-03-01 08:38:09.120242', '2021-03-01 08:38:16.504232', '192.168.1.117', '', 0, 0, 0, 'completed', '6,5,4', 0, 0, 5, 53),
(16, 1, '2021-03-01 09:08:03.521506', '2021-03-01 09:08:21.000735', '192.168.1.86', '', 0, 0, 0, 'completed', '3,6,7', 0, 0, 8, 46),
(17, 1, '2021-03-01 09:17:50.323490', '2021-03-01 09:18:33.691518', '192.168.1.117', '', 0, 0, 0, 'completed', '3,6,7', 0, 0, 8, 53),
(18, 1, '2021-03-01 09:36:05.190053', '2021-03-01 09:37:17.365182', '192.168.1.86', '', 0, 0, 0, 'completed', '4,5', 0, 0, 10, 46),
(19, 1, '2021-03-01 09:47:45.367330', '2021-03-01 09:48:03.741772', '192.168.1.117', '', 0, 0, 0, 'completed', '4,5', 0, 0, 10, 53),
(20, 1, '2021-03-01 10:30:38.824736', '2021-03-01 10:31:04.263841', '192.168.1.86', '', 0, 0, 0, 'inprogress', '4,5', 0, 0, 11, 46),
(21, 1, '2021-03-01 11:42:51.497727', '2021-03-01 11:43:12.385959', '192.168.1.117', '', 0, 0, 0, 'completed', '3,6,7', 0, 0, 12, 1),
(22, 1, '2021-03-02 08:50:58.539553', '2021-03-02 08:52:17.911937', '192.168.1.86', '', 0, 0, 0, 'completed', '4,5', 0, 0, 10, 1),
(23, 1, '2021-03-02 08:53:18.255088', '2021-03-02 08:53:23.721644', '192.168.1.117', '', 0, 0, 0, 'completed', '4,5', 0, 0, 10, 57);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_answerpaper_answers`
--

CREATE TABLE `preassesment_answerpaper_answers` (
  `id` int NOT NULL,
  `answerpaper_id` int NOT NULL,
  `answer_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_answerpaper_answers`
--

INSERT INTO `preassesment_answerpaper_answers` (`id`, `answerpaper_id`, `answer_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 3, 3),
(4, 3, 4),
(6, 4, 5),
(7, 4, 6),
(8, 5, 7),
(9, 5, 8),
(10, 6, 9),
(11, 6, 10),
(28, 6, 11),
(31, 7, 12),
(32, 7, 13),
(33, 8, 14),
(34, 8, 15),
(35, 9, 16),
(36, 10, 17),
(37, 12, 18),
(38, 12, 19),
(39, 12, 20),
(40, 13, 21),
(41, 13, 22),
(42, 13, 23),
(43, 14, 24),
(44, 14, 25),
(45, 14, 26),
(46, 15, 27),
(47, 15, 28),
(48, 15, 29),
(49, 16, 30),
(50, 16, 31),
(51, 16, 32),
(52, 17, 33),
(53, 17, 34),
(54, 17, 35),
(55, 18, 36),
(56, 18, 37),
(57, 19, 38),
(58, 19, 39),
(59, 20, 40),
(60, 21, 41),
(61, 21, 42),
(62, 21, 43),
(63, 22, 44),
(64, 22, 45),
(65, 23, 46),
(66, 23, 47);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_answerpaper_questions`
--

CREATE TABLE `preassesment_answerpaper_questions` (
  `id` int NOT NULL,
  `answerpaper_id` int NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_answerpaper_questions`
--

INSERT INTO `preassesment_answerpaper_questions` (`id`, `answerpaper_id`, `question_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(5, 3, 1),
(6, 3, 2),
(7, 4, 1),
(8, 4, 2),
(9, 5, 1),
(10, 5, 2),
(11, 6, 3),
(12, 6, 4),
(13, 6, 5),
(14, 7, 3),
(15, 7, 4),
(16, 7, 5),
(17, 8, 3),
(18, 8, 4),
(19, 8, 5),
(20, 9, 3),
(21, 9, 4),
(22, 9, 5),
(23, 10, 4),
(24, 10, 5),
(25, 10, 6),
(26, 11, 4),
(27, 11, 5),
(28, 11, 6),
(29, 12, 4),
(30, 12, 5),
(31, 12, 6),
(32, 13, 4),
(33, 13, 5),
(34, 13, 6),
(35, 14, 4),
(36, 14, 5),
(37, 14, 6),
(38, 15, 4),
(39, 15, 5),
(40, 15, 6),
(41, 16, 3),
(42, 16, 6),
(43, 16, 7),
(44, 17, 3),
(45, 17, 6),
(46, 17, 7),
(47, 18, 4),
(48, 18, 5),
(49, 19, 4),
(50, 19, 5),
(51, 20, 4),
(52, 20, 5),
(53, 21, 3),
(54, 21, 6),
(55, 21, 7),
(56, 22, 4),
(57, 22, 5),
(58, 23, 4),
(59, 23, 5);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_answerpaper_questions_answered`
--

CREATE TABLE `preassesment_answerpaper_questions_answered` (
  `id` int NOT NULL,
  `answerpaper_id` int NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_answerpaper_questions_answered`
--

INSERT INTO `preassesment_answerpaper_questions_answered` (`id`, `answerpaper_id`, `question_id`) VALUES
(2, 1, 1),
(1, 1, 2),
(3, 3, 1),
(4, 3, 2),
(6, 4, 1),
(7, 4, 2),
(8, 5, 1),
(9, 5, 2),
(28, 6, 3),
(10, 6, 4),
(11, 6, 5),
(31, 7, 4),
(32, 7, 5),
(33, 8, 4),
(34, 8, 5),
(35, 9, 4),
(36, 10, 6),
(39, 12, 4),
(38, 12, 5),
(37, 12, 6),
(42, 13, 4),
(41, 13, 5),
(40, 13, 6),
(45, 14, 4),
(44, 14, 5),
(43, 14, 6),
(48, 15, 4),
(47, 15, 5),
(46, 15, 6),
(49, 16, 3),
(50, 16, 6),
(51, 16, 7),
(52, 17, 3),
(53, 17, 6),
(54, 17, 7),
(55, 18, 4),
(56, 18, 5),
(57, 19, 4),
(58, 19, 5),
(59, 20, 4),
(60, 21, 3),
(61, 21, 6),
(62, 21, 7),
(63, 22, 4),
(64, 22, 5),
(65, 23, 4),
(66, 23, 5);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_answerpaper_questions_unanswered`
--

CREATE TABLE `preassesment_answerpaper_questions_unanswered` (
  `id` int NOT NULL,
  `answerpaper_id` int NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_answerpaper_questions_unanswered`
--

INSERT INTO `preassesment_answerpaper_questions_unanswered` (`id`, `answerpaper_id`, `question_id`) VALUES
(14, 7, 3),
(17, 8, 3),
(20, 9, 3),
(22, 9, 5),
(23, 10, 4),
(24, 10, 5),
(26, 11, 4),
(27, 11, 5),
(28, 11, 6),
(52, 20, 5);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_assesments`
--

CREATE TABLE `preassesment_assesments` (
  `id` int NOT NULL,
  `name` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `about` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `start_date_time` datetime(6) DEFAULT NULL,
  `end_date_time` datetime(6) DEFAULT NULL,
  `duration` int NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pass_criteria` double NOT NULL,
  `attempts_allowed` int NOT NULL,
  `time_between_attempts` double NOT NULL,
  `is_trial` tinyint(1) NOT NULL,
  `instructions` longtext COLLATE utf8mb4_general_ci,
  `view_answerpaper` tinyint(1) NOT NULL,
  `allow_skip` tinyint(1) NOT NULL,
  `weightage` double NOT NULL,
  `is_exercise` tinyint(1) NOT NULL,
  `creator_id` int NOT NULL,
  `topics_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_fileupload`
--

CREATE TABLE `preassesment_fileupload` (
  `id` int NOT NULL,
  `file` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `extract` tinyint(1) NOT NULL,
  `hide` tinyint(1) NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_question`
--

CREATE TABLE `preassesment_question` (
  `id` int NOT NULL,
  `question_name` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `points` double NOT NULL,
  `topic` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(24) COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `min_time` int NOT NULL,
  `user_id` int NOT NULL,
  `solution` longtext COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_question`
--

INSERT INTO `preassesment_question` (`id`, `question_name`, `description`, `points`, `topic`, `type`, `active`, `min_time`, `user_id`, `solution`) VALUES
(1, 'nfvnjfnj', 'djnjdnj', 1, 'dnjd', 'mcq', 1, 0, 1, 'dcnjcdj'),
(2, 'dcjncdn', 'd', 1, 'dcn', 'mcq', 1, 0, 1, 'dccdn'),
(3, 'Demo Question 2', '', 2, NULL, 'mcq', 1, 0, 1, 'a'),
(4, 'Demo Question 1', '', 1, NULL, 'mcc', 1, 0, 1, 'a'),
(5, 'Demo Question 3', '', 3, NULL, 'mcc', 1, 0, 1, 'a'),
(6, 'Demo Question 4', '', 1, NULL, 'mcq', 1, 0, 1, 'demo option1'),
(7, 'demo question 5', '', 1, NULL, 'mcq', 1, 0, 1, 'option2');

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_questionoption`
--

CREATE TABLE `preassesment_questionoption` (
  `id` int NOT NULL,
  `option_a` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `option_b` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `option_c` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `option_d` varchar(125) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `option_e` varchar(125) COLLATE utf8mb4_general_ci NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_questionoption`
--

INSERT INTO `preassesment_questionoption` (`id`, `option_a`, `option_b`, `option_c`, `option_d`, `option_e`, `question_id`) VALUES
(1, 'dcnjcdj', 'njcdn', 'dcnjdc', 'dcnjndc', '', 1),
(2, 'dccdn', 'dcndcnj', 'dcnjdcnj', 'dcd', '', 2),
(4, 'Demo Answer 1', 'Demo Answer 2', 'Demo Answer 3', 'Demo Answer 4', '', 3),
(5, 'Demo Answer 1', 'Demo Answer 2', 'Demo Answer 3', 'Demo Answer 4', '', 4),
(6, 'Demo Answer 1', 'Demo Answer 2', 'Demo Answer 3', 'Demo Answer 4', '', 5),
(7, 'option1', 'option2', 'option3', 'option4', '', 6),
(8, 'demo5 option1', 'demo5 option2', 'demo5 option3', 'demo5 option4', '', 7);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_questionpaper`
--

CREATE TABLE `preassesment_questionpaper` (
  `id` int NOT NULL,
  `shuffle_questions` tinyint(1) NOT NULL,
  `total_marks` double NOT NULL,
  `fixed_question_order` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `quiz_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_questionpaper`
--

INSERT INTO `preassesment_questionpaper` (`id`, `shuffle_questions`, `total_marks`, `fixed_question_order`, `quiz_id`) VALUES
(1, 0, 2, '1,2', 1),
(3, 0, 2, '1,2', 3),
(4, 0, 2, '1,2', 4),
(5, 0, 5, '6,5,4', 5),
(8, 0, 4, '3,6,7', 8),
(9, 0, 4, '4,5,3', 9),
(10, 0, 4, '4,5', 10),
(11, 0, 4, '4,5', 11),
(12, 0, 4, '3,6,7', 12);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_questionpaper_fixed_questions`
--

CREATE TABLE `preassesment_questionpaper_fixed_questions` (
  `id` int NOT NULL,
  `questionpaper_id` int NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_questionpaper_fixed_questions`
--

INSERT INTO `preassesment_questionpaper_fixed_questions` (`id`, `questionpaper_id`, `question_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(7, 3, 1),
(8, 3, 2),
(9, 4, 1),
(10, 4, 2),
(19, 5, 4),
(20, 5, 5),
(18, 5, 6),
(21, 8, 3),
(22, 8, 6),
(23, 8, 7),
(24, 9, 4),
(25, 9, 5),
(28, 10, 4),
(29, 10, 5),
(30, 11, 4),
(31, 11, 5),
(32, 12, 3),
(33, 12, 6),
(34, 12, 7);

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_questionpaper_random_questions`
--

CREATE TABLE `preassesment_questionpaper_random_questions` (
  `id` int NOT NULL,
  `questionpaper_id` int NOT NULL,
  `questionset_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_questionset`
--

CREATE TABLE `preassesment_questionset` (
  `id` int NOT NULL,
  `marks` double NOT NULL,
  `num_questions` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_questionset_questions`
--

CREATE TABLE `preassesment_questionset_questions` (
  `id` int NOT NULL,
  `questionset_id` int NOT NULL,
  `question_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preassesment_quiz`
--

CREATE TABLE `preassesment_quiz` (
  `id` int NOT NULL,
  `duration` int NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `pass_criteria` double NOT NULL,
  `attempts_allowed` int NOT NULL,
  `time_between_attempts` double NOT NULL,
  `instructions` longtext COLLATE utf8mb4_general_ci,
  `allow_skip` tinyint(1) NOT NULL,
  `is_exercise` tinyint(1) NOT NULL,
  `creator_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `topic_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `preassesment_quiz`
--

INSERT INTO `preassesment_quiz` (`id`, `duration`, `active`, `description`, `pass_criteria`, `attempts_allowed`, `time_between_attempts`, `instructions`, `allow_skip`, `is_exercise`, `creator_id`, `course_id`, `topic_id`) VALUES
(1, 20, 1, 'dcjndcnjcd_quiz_check', 40, 2, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 4),
(3, 20, 1, 'vfjnvfnjvnf', 40, 2, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 2),
(4, 20, 1, 'Quiz', 40, 1, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 13),
(5, 20, 1, 'Quiz', 40, 1, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 15),
(8, 20, 1, 'Demo Quiz A', 40, 1, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 0, 0, 1, NULL, 25),
(9, 20, 1, 'Demo quiz', 40, 1, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 28),
(10, 20, 1, 'Quiz A', 40, 1, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 30),
(11, 20, 1, 'Demo Quiz', 40, 1, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 36),
(12, 20, 1, 'ygqhahba', 40, 1, 0, '</p><p>Please read instruction carefully</p>\r\n<ul>\r\n<li> <strong>You are not allowed to use any internet \r\ni.e. no google etc.</strong>\r\n</li>\r\n<li> Do not copy </strong>.\r\n</li></ul>\r\n<p>We hope you enjoy taking this exam !!!</p>', 1, 0, 1, NULL, 52);

-- --------------------------------------------------------

--
-- Table structure for table `taggit_tag`
--

CREATE TABLE `taggit_tag` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `taggit_tag`
--

INSERT INTO `taggit_tag` (`id`, `name`, `slug`) VALUES
(1, 'dede', 'dede'),
(2, 'test', 'test'),
(3, 'gheqj', 'gheqj'),
(4, 'sacnjajds', 'sacnjajds'),
(5, 'under', 'under'),
(6, 'him', 'him');

-- --------------------------------------------------------

--
-- Table structure for table `taggit_taggeditem`
--

CREATE TABLE `taggit_taggeditem` (
  `id` int NOT NULL,
  `object_id` int NOT NULL,
  `content_type_id` int NOT NULL,
  `tag_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `taggit_taggeditem`
--

INSERT INTO `taggit_taggeditem` (`id`, `object_id`, `content_type_id`, `tag_id`) VALUES
(4, 97, 18, 2),
(5, 98, 18, 2),
(6, 99, 18, 2),
(10, 104, 18, 2),
(11, 105, 18, 2),
(12, 106, 18, 2),
(13, 107, 18, 2),
(14, 108, 18, 3),
(15, 108, 18, 4),
(17, 110, 18, 5),
(18, 110, 18, 6);

-- --------------------------------------------------------

--
-- Table structure for table `userlms_discussion`
--

CREATE TABLE `userlms_discussion` (
  `id` int NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `discuss` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int NOT NULL,
  `course_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userlms_discussion`
--

INSERT INTO `userlms_discussion` (`id`, `created_date`, `discuss`, `author_id`, `course_id`) VALUES
(2, '2021-03-01 11:48:52.846175', 'himkjbvc ', 1, 108);

-- --------------------------------------------------------

--
-- Table structure for table `userlms_forumanswer`
--

CREATE TABLE `userlms_forumanswer` (
  `id` int NOT NULL,
  `answer` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int NOT NULL,
  `discussion_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userlms_notes`
--

CREATE TABLE `userlms_notes` (
  `id` int NOT NULL,
  `note` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `course_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_user`
--
ALTER TABLE `accounts_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `chat_chatmessage`
--
ALTER TABLE `chat_chatmessage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_chatmessage_course_id_4ebdd34b_fk_customadm` (`course_id`),
  ADD KEY `chat_chatmessage_userfrom_id_f6a7fe21_fk_auth_user_id` (`userfrom_id`),
  ADD KEY `chat_chatmessage_userto_id_d6f7e11f_fk_auth_user_id` (`userto_id`);

--
-- Indexes for table `chat_layer`
--
ALTER TABLE `chat_layer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `layer_name` (`layer_name`),
  ADD UNIQUE KEY `chat_layer_course_id_user_name_d2894db6_uniq` (`course_id`,`user_name`);

--
-- Indexes for table `chat_room`
--
ALTER TABLE `chat_room`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `room_id` (`room_id`),
  ADD KEY `chat_room_course_id_428d7139_fk_customadmin_coursesenduser_id` (`course_id`);

--
-- Indexes for table `chat_room_user`
--
ALTER TABLE `chat_room_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `channel_name` (`channel_name`),
  ADD UNIQUE KEY `chat_room_user_course_id_user_id_ccdc9830_uniq` (`course_id`,`user_id`),
  ADD KEY `chat_room_user_room_id_541666dd` (`room_id`);

--
-- Indexes for table `customadmin_activities`
--
ALTER TABLE `customadmin_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_activities_author_id_2a15aa3f_fk_auth_user_id` (`author_id`),
  ADD KEY `customadmin_activiti_course_id_44e14dc1_fk_customadm` (`course_id`),
  ADD KEY `customadmin_activiti_organization_id_3ec0695b_fk_customadm` (`organization_id`),
  ADD KEY `customadmin_activities_topic_id_e723c0c4_fk_customadmin_topic_id` (`topic_id`);

--
-- Indexes for table `customadmin_activityadding`
--
ALTER TABLE `customadmin_activityadding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_activity_course_id_id_d92cc1e9_fk_customadm` (`course_id_id`),
  ADD KEY `customadmin_activity_topic_id_id_a16d72eb_fk_customadm` (`topic_id_id`);

--
-- Indexes for table `customadmin_activitytype`
--
ALTER TABLE `customadmin_activitytype`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `customadmin_activitytype_author_id_20b0928c_fk_auth_user_id` (`author_id`);

--
-- Indexes for table `customadmin_answer`
--
ALTER TABLE `customadmin_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_answer_question_id_4ae2f93e_fk_customadm` (`question_id`);

--
-- Indexes for table `customadmin_assignmentactivity`
--
ALTER TABLE `customadmin_assignmentactivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_assignme_activity_id_aef7ba19_fk_customadm` (`activity_id`);

--
-- Indexes for table `customadmin_assignmentanswer`
--
ALTER TABLE `customadmin_assignmentanswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_assignme_activity_id_5c850fef_fk_customadm` (`activity_id`),
  ADD KEY `customadmin_assignmentanswer_user_id_3f0a4249_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `customadmin_categories`
--
ALTER TABLE `customadmin_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_categori_organization_id_39c17b5e_fk_customadm` (`organization_id`);

--
-- Indexes for table `customadmin_categorieshirerchy`
--
ALTER TABLE `customadmin_categorieshirerchy`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_id` (`category_id`),
  ADD KEY `customadmin_categori_category_father_id_9f119f1f_fk_customadm` (`category_father_id`);

--
-- Indexes for table `customadmin_chatactivity`
--
ALTER TABLE `customadmin_chatactivity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `room` (`room`),
  ADD KEY `customadmin_chatacti_activity_id_id_87f11f4a_fk_customadm` (`activity_id_id`);

--
-- Indexes for table `customadmin_city`
--
ALTER TABLE `customadmin_city`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `customadmin_city_state_id_9cfc6370_fk_customadmin_state_id` (`state_id`);

--
-- Indexes for table `customadmin_classroom`
--
ALTER TABLE `customadmin_classroom`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_classroo_sessionactivity_id_ed2fa621_fk_customadm` (`sessionactivity_id`),
  ADD KEY `customadmin_classroom_user_id_29854d03_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `customadmin_contentvideo`
--
ALTER TABLE `customadmin_contentvideo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_contentv_topic_id_f6843fa4_fk_customadm` (`topic_id`),
  ADD KEY `customadmin_contentv_course_id_7e53e168_fk_customadm` (`course_id`),
  ADD KEY `customadmin_contentv_organization_id_83823540_fk_customadm` (`organization_id`),
  ADD KEY `customadmin_contentv_language_id_a15e5c69_fk_customadm` (`language_id`);

--
-- Indexes for table `customadmin_country`
--
ALTER TABLE `customadmin_country`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `customadmin_courseenroll`
--
ALTER TABLE `customadmin_courseenroll`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `one time enroll for user` (`user_id`,`course_id`),
  ADD KEY `customadmin_courseen_course_id_fcaa150d_fk_customadm` (`course_id`),
  ADD KEY `customadmin_courseenroll_user_id_2c63378b` (`user_id`);

--
-- Indexes for table `customadmin_courses`
--
ALTER TABLE `customadmin_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_courses_author_id_30056b9d_fk_auth_user_id` (`author_id`),
  ADD KEY `customadmin_courses_courses_category_id_bf1f58cf_fk_customadm` (`courses_category_id`),
  ADD KEY `customadmin_courses_organization_id_c0922678_fk_customadm` (`organization_id`),
  ADD KEY `customadmin_courses_teacher_id_5fe35662_fk_organizat` (`teacher_id`);

--
-- Indexes for table `customadmin_coursesenduser`
--
ALTER TABLE `customadmin_coursesenduser`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_coursesenduser_author_id_c5d1dd8a_fk_auth_user_id` (`author_id`),
  ADD KEY `customadmin_coursesenduser_course_slug_02705373` (`course_slug`),
  ADD KEY `customadmin_coursese_category_id_edcaebcf_fk_customadm` (`category_id`);

--
-- Indexes for table `customadmin_coursesenduser_rejected`
--
ALTER TABLE `customadmin_coursesenduser_rejected`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_coursesendus_coursesenduser_id_user_i_6c4fb3b1_uniq` (`coursesenduser_id`,`user_id`),
  ADD KEY `customadmin_coursese_user_id_432d04e6_fk_auth_user` (`user_id`);

--
-- Indexes for table `customadmin_coursesenduser_requests`
--
ALTER TABLE `customadmin_coursesenduser_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_coursesendus_coursesenduser_id_user_i_d8a2191a_uniq` (`coursesenduser_id`,`user_id`),
  ADD KEY `customadmin_coursese_user_id_37e49ebb_fk_auth_user` (`user_id`);

--
-- Indexes for table `customadmin_coursesenduser_students`
--
ALTER TABLE `customadmin_coursesenduser_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_coursesendus_coursesenduser_id_user_i_f4226d7e_uniq` (`coursesenduser_id`,`user_id`),
  ADD KEY `customadmin_coursese_user_id_ef601796_fk_auth_user` (`user_id`);

--
-- Indexes for table `customadmin_courses_rejected`
--
ALTER TABLE `customadmin_courses_rejected`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_courses_rejected_courses_id_user_id_d39c70bd_uniq` (`courses_id`,`user_id`),
  ADD KEY `customadmin_courses_rejected_user_id_5100e393_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `customadmin_courses_requests`
--
ALTER TABLE `customadmin_courses_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_courses_requests_courses_id_user_id_fd596e60_uniq` (`courses_id`,`user_id`),
  ADD KEY `customadmin_courses_requests_user_id_bd45d0d3_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `customadmin_courses_students`
--
ALTER TABLE `customadmin_courses_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_courses_students_courses_id_user_id_e9012430_uniq` (`courses_id`,`user_id`),
  ADD KEY `customadmin_courses_students_user_id_3d2e8684_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `customadmin_dragdropactivity`
--
ALTER TABLE `customadmin_dragdropactivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_dragdrop_activity_id_54f8fca2_fk_customadm` (`activity_id`);

--
-- Indexes for table `customadmin_dragdropactivityanswers`
--
ALTER TABLE `customadmin_dragdropactivityanswers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_dragdrop_dd_activity_id_31834668_fk_customadm` (`dd_activity_id`);

--
-- Indexes for table `customadmin_dragdropactivityelements`
--
ALTER TABLE `customadmin_dragdropactivityelements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_dragdrop_dd_activity_id_77ca09c9_fk_customadm` (`dd_activity_id`);

--
-- Indexes for table `customadmin_fileactivity`
--
ALTER TABLE `customadmin_fileactivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_fileacti_activity_id_id_ce0c6abd_fk_customadm` (`activity_id_id`);

--
-- Indexes for table `customadmin_language`
--
ALTER TABLE `customadmin_language`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `language_code` (`language_code`);

--
-- Indexes for table `customadmin_languagecourse`
--
ALTER TABLE `customadmin_languagecourse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_language_course_id_a3c0833f_fk_customadm` (`course_id`),
  ADD KEY `customadmin_language_lang_id_e5058242_fk_customadm` (`lang_id`);

--
-- Indexes for table `customadmin_organization`
--
ALTER TABLE `customadmin_organization`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`organization_name`),
  ADD UNIQUE KEY `website` (`website`),
  ADD UNIQUE KEY `email` (`contact_person_email`),
  ADD UNIQUE KEY `phone` (`contact_person_phone`),
  ADD UNIQUE KEY `unique_code` (`unique_code`),
  ADD KEY `customadmin_organization_city_id_cdb4571b_fk_customadmin_city_id` (`city_id`),
  ADD KEY `customadmin_organiza_country_id_92af6697_fk_customadm` (`country_id`),
  ADD KEY `customadmin_organiza_state_id_13dbe259_fk_customadm` (`state_id`);

--
-- Indexes for table `customadmin_organization_course`
--
ALTER TABLE `customadmin_organization_course`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_organization_organization_id_coursese_c0aa4228_uniq` (`organization_id`,`coursesenduser_id`),
  ADD KEY `customadmin_organiza_coursesenduser_id_4c7378d7_fk_customadm` (`coursesenduser_id`);

--
-- Indexes for table `customadmin_organization_students`
--
ALTER TABLE `customadmin_organization_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_organization_organization_id_user_id_07b9b22c_uniq` (`organization_id`,`user_id`),
  ADD KEY `customadmin_organiza_user_id_86f9c0b5_fk_auth_user` (`user_id`);

--
-- Indexes for table `customadmin_personinroom`
--
ALTER TABLE `customadmin_personinroom`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_personin_chat_id_9175ae81_fk_customadm` (`chat_id`),
  ADD KEY `customadmin_personinroom_user_id_id_19d59f31_fk_auth_user_id` (`user_id_id`);

--
-- Indexes for table `customadmin_question`
--
ALTER TABLE `customadmin_question`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `question_name` (`question_name`),
  ADD KEY `customadmin_question_author_id_0b702895_fk_auth_user_id` (`author_id`),
  ADD KEY `customadmin_question_question_language_id_df522a0d_fk_customadm` (`question_language_id`);

--
-- Indexes for table `customadmin_sessionactivity`
--
ALTER TABLE `customadmin_sessionactivity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_room_id` (`session_room_id`),
  ADD KEY `customadmin_sessionactivity_author_id_75383d6a_fk_auth_user_id` (`author_id`),
  ADD KEY `customadmin_sessiona_course_id_4bac360c_fk_customadm` (`course_id`),
  ADD KEY `customadmin_sessiona_organization_id_1e3312eb_fk_customadm` (`organization_id`),
  ADD KEY `customadmin_sessiona_teacher_id_e02f19d8_fk_organizat` (`teacher_id`);

--
-- Indexes for table `customadmin_spinactivity`
--
ALTER TABLE `customadmin_spinactivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_spinacti_activity_id_90126c61_fk_customadm` (`activity_id`);

--
-- Indexes for table `customadmin_spinactivityanswer`
--
ALTER TABLE `customadmin_spinactivityanswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_spinacti_question_id_ea9b1f17_fk_customadm` (`question_id`),
  ADD KEY `customadmin_spinacti_spinactivity_id_ffa0f953_fk_customadm` (`spinactivity_id`);

--
-- Indexes for table `customadmin_spinactivityenroll`
--
ALTER TABLE `customadmin_spinactivityenroll`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_spinactivity_candidate_id_spinactivit_3441dea1_uniq` (`candidate_id`,`spinactivity_id`),
  ADD KEY `customadmin_spinacti_spinactivity_id_d9cd1644_fk_customadm` (`spinactivity_id`);

--
-- Indexes for table `customadmin_spinactivity_topic_details`
--
ALTER TABLE `customadmin_spinactivity_topic_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_spinactivity_spinactivity_id_topicdet_9175d3b6_uniq` (`spinactivity_id`,`topicdetails_id`),
  ADD KEY `customadmin_spinacti_topicdetails_id_b57084ed_fk_customadm` (`topicdetails_id`);

--
-- Indexes for table `customadmin_state`
--
ALTER TABLE `customadmin_state`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `customadmin_state_country_id_3f63677a_fk_customadmin_country_id` (`country_id`);

--
-- Indexes for table `customadmin_subtopic`
--
ALTER TABLE `customadmin_subtopic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customadmin_subtopic_author_id_dd5882b2_fk_auth_user_id` (`author_id`),
  ADD KEY `customadmin_subtopic_topic_id_6bf766ad_fk_customadmin_topic_id` (`topic_id`);

--
-- Indexes for table `customadmin_topic`
--
ALTER TABLE `customadmin_topic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_topic_name_course_id_e27a5dfd_uniq` (`name`,`course_id`),
  ADD KEY `customadmin_topic_author_id_c4d80f92_fk_auth_user_id` (`author_id`),
  ADD KEY `customadmin_topic_course_id_a8d1b7d1_fk_customadm` (`course_id`);

--
-- Indexes for table `customadmin_topicdetails`
--
ALTER TABLE `customadmin_topicdetails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customadmin_topicdetails_questions`
--
ALTER TABLE `customadmin_topicdetails_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_topicdetails_topicdetails_id_question_5ade6f33_uniq` (`topicdetails_id`,`question_id`),
  ADD KEY `customadmin_topicdet_question_id_3b08a534_fk_customadm` (`question_id`);

--
-- Indexes for table `customadmin_topicrelation`
--
ALTER TABLE `customadmin_topicrelation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `topic_id_id` (`topic_id_id`),
  ADD KEY `customadmin_topicrel_topic_father_id_ae4f38c3_fk_customadm` (`topic_father_id`);

--
-- Indexes for table `customadmin_topicwiseanswerpaper`
--
ALTER TABLE `customadmin_topicwiseanswerpaper`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_topicwiseans_user_id_activity_id_1d9ffda9_uniq` (`user_id`,`activity_id`),
  ADD UNIQUE KEY `customadmin_topicwiseans_user_id_content_video_id_7116ae26_uniq` (`user_id`,`content_video_id`),
  ADD KEY `customadmin_topicwis_activity_id_f56c08f3_fk_customadm` (`activity_id`),
  ADD KEY `customadmin_topicwis_content_video_id_66e154ff_fk_customadm` (`content_video_id`),
  ADD KEY `customadmin_topicwis_course_id_38fc2841_fk_customadm` (`course_id`),
  ADD KEY `customadmin_topicwiseanswerpaper_topic_id_47cd618d` (`topic_id`);

--
-- Indexes for table `customadmin_usercategories`
--
ALTER TABLE `customadmin_usercategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customadmin_usercategories_name_9a8ea52b_uniq` (`name`),
  ADD KEY `customadmin_usercategories_creator_id_8696eda6_fk_auth_user_id` (`creator_id`);

--
-- Indexes for table `custompermission_perm`
--
ALTER TABLE `custompermission_perm`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codename` (`codename`),
  ADD KEY `custompermission_per_content_type_id_063fe74d_fk_django_co` (`content_type_id`);

--
-- Indexes for table `custompermission_perm_groups`
--
ALTER TABLE `custompermission_perm_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `custompermission_perm_groups_perm_id_group_id_28027297_uniq` (`perm_id`,`group_id`),
  ADD KEY `custompermission_perm_groups_group_id_7c62e56d_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `custompermission_perm_users`
--
ALTER TABLE `custompermission_perm_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `custompermission_perm_users_perm_id_user_id_fb0e1213_uniq` (`perm_id`,`user_id`),
  ADD KEY `custompermission_perm_users_user_id_47189282_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `django_site`
--
ALTER TABLE `django_site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`);

--
-- Indexes for table `grades_graderange`
--
ALTER TABLE `grades_graderange`
  ADD PRIMARY KEY (`id`),
  ADD KEY `grades_graderange_system_id_775318a7_fk_grades_gradingsystem_id` (`system_id`);

--
-- Indexes for table `grades_gradingsystem`
--
ALTER TABLE `grades_gradingsystem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `grades_gradingsystem_creator_id_b4de4f90_fk_auth_user_id` (`creator_id`);

--
-- Indexes for table `organization_userinformation`
--
ALTER TABLE `organization_userinformation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `organization_userinformation_email_8db38f50_uniq` (`email`),
  ADD UNIQUE KEY `organization_userinformation_phone_baf94a59_uniq` (`phone`),
  ADD KEY `organization_userinf_organization_id_6879d9d6_fk_customadm` (`organization_id`);

--
-- Indexes for table `polls_choice`
--
ALTER TABLE `polls_choice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `polls_choice_poll_id_3a553f1a_fk_polls_poll_id` (`poll_id`);

--
-- Indexes for table `polls_poll`
--
ALTER TABLE `polls_poll`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `preassesment_answer`
--
ALTER TABLE `preassesment_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preassesment_answer_question_id_f141ba3c_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_answerpaper`
--
ALTER TABLE `preassesment_answerpaper`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_answerpaper_user_id_question_paper_i_06563a99_uniq` (`user_id`,`question_paper_id`,`attempt_number`),
  ADD KEY `preassesment_answerp_question_paper_id_11b79cab_fk_preassesm` (`question_paper_id`);

--
-- Indexes for table `preassesment_answerpaper_answers`
--
ALTER TABLE `preassesment_answerpaper_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_answerpaper_answerpaper_id_answer_id_edd8a3a8_uniq` (`answerpaper_id`,`answer_id`),
  ADD KEY `preassesment_answerp_answer_id_740c8082_fk_preassesm` (`answer_id`);

--
-- Indexes for table `preassesment_answerpaper_questions`
--
ALTER TABLE `preassesment_answerpaper_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_answerpaper_answerpaper_id_question__03a7f54b_uniq` (`answerpaper_id`,`question_id`),
  ADD KEY `preassesment_answerp_question_id_699cbf5e_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_answerpaper_questions_answered`
--
ALTER TABLE `preassesment_answerpaper_questions_answered`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_answerpaper_answerpaper_id_question__a0b427cf_uniq` (`answerpaper_id`,`question_id`),
  ADD KEY `preassesment_answerp_question_id_b288b96d_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_answerpaper_questions_unanswered`
--
ALTER TABLE `preassesment_answerpaper_questions_unanswered`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_answerpaper_answerpaper_id_question__79068f59_uniq` (`answerpaper_id`,`question_id`),
  ADD KEY `preassesment_answerp_question_id_6f3504cd_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_assesments`
--
ALTER TABLE `preassesment_assesments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preassesment_assesments_creator_id_5cdc9ca7_fk_auth_user_id` (`creator_id`),
  ADD KEY `preassesment_assesme_topics_id_8b36b664_fk_customadm` (`topics_id`);

--
-- Indexes for table `preassesment_fileupload`
--
ALTER TABLE `preassesment_fileupload`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preassesment_fileupl_question_id_6fc1236c_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_question`
--
ALTER TABLE `preassesment_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preassesment_question_user_id_0bcb0c2a_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `preassesment_questionoption`
--
ALTER TABLE `preassesment_questionoption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preassesment_questio_question_id_f9e680f8_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_questionpaper`
--
ALTER TABLE `preassesment_questionpaper`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preassesment_questio_quiz_id_c8252bde_fk_preassesm` (`quiz_id`);

--
-- Indexes for table `preassesment_questionpaper_fixed_questions`
--
ALTER TABLE `preassesment_questionpaper_fixed_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_questionpap_questionpaper_id_questio_e0317390_uniq` (`questionpaper_id`,`question_id`),
  ADD KEY `preassesment_questio_question_id_867267cd_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_questionpaper_random_questions`
--
ALTER TABLE `preassesment_questionpaper_random_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_questionpap_questionpaper_id_questio_be17e9ce_uniq` (`questionpaper_id`,`questionset_id`),
  ADD KEY `preassesment_questio_questionset_id_5febf713_fk_preassesm` (`questionset_id`);

--
-- Indexes for table `preassesment_questionset`
--
ALTER TABLE `preassesment_questionset`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `preassesment_questionset_questions`
--
ALTER TABLE `preassesment_questionset_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `preassesment_questionset_questionset_id_question__3e60e4f1_uniq` (`questionset_id`,`question_id`),
  ADD KEY `preassesment_questio_question_id_e6659835_fk_preassesm` (`question_id`);

--
-- Indexes for table `preassesment_quiz`
--
ALTER TABLE `preassesment_quiz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preassesment_quiz_creator_id_1d1a0fab_fk_auth_user_id` (`creator_id`),
  ADD KEY `preassesment_quiz_course_id_7e742666_fk_customadm` (`course_id`),
  ADD KEY `preassesment_quiz_topic_id_483e3164_fk_customadmin_topic_id` (`topic_id`);

--
-- Indexes for table `taggit_tag`
--
ALTER TABLE `taggit_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `taggit_taggeditem_content_type_id_object_id_tag_id_4bb97a8e_uniq` (`content_type_id`,`object_id`,`tag_id`),
  ADD KEY `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` (`tag_id`),
  ADD KEY `taggit_taggeditem_object_id_e2d7d1df` (`object_id`),
  ADD KEY `taggit_taggeditem_content_type_id_object_id_196cc965_idx` (`content_type_id`,`object_id`);

--
-- Indexes for table `userlms_discussion`
--
ALTER TABLE `userlms_discussion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userlms_discussion_author_id_1343c752_fk_auth_user_id` (`author_id`),
  ADD KEY `userlms_discussion_course_id_af504ee2_fk_customadm` (`course_id`);

--
-- Indexes for table `userlms_forumanswer`
--
ALTER TABLE `userlms_forumanswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userlms_forumanswer_author_id_a0f33035_fk_auth_user_id` (`author_id`),
  ADD KEY `userlms_forumanswer_discussion_id_644692ee_fk_userlms_d` (`discussion_id`);

--
-- Indexes for table `userlms_notes`
--
ALTER TABLE `userlms_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userlms_notes_author_id_b0ba17ca_fk_auth_user_id` (`author_id`),
  ADD KEY `userlms_notes_course_id_74b4f769_fk_customadm` (`course_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_user`
--
ALTER TABLE `accounts_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=273;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_chatmessage`
--
ALTER TABLE `chat_chatmessage`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `chat_layer`
--
ALTER TABLE `chat_layer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `chat_room`
--
ALTER TABLE `chat_room`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `chat_room_user`
--
ALTER TABLE `chat_room_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customadmin_activities`
--
ALTER TABLE `customadmin_activities`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `customadmin_activityadding`
--
ALTER TABLE `customadmin_activityadding`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_activitytype`
--
ALTER TABLE `customadmin_activitytype`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customadmin_answer`
--
ALTER TABLE `customadmin_answer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_assignmentactivity`
--
ALTER TABLE `customadmin_assignmentactivity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customadmin_assignmentanswer`
--
ALTER TABLE `customadmin_assignmentanswer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customadmin_categories`
--
ALTER TABLE `customadmin_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_categorieshirerchy`
--
ALTER TABLE `customadmin_categorieshirerchy`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_chatactivity`
--
ALTER TABLE `customadmin_chatactivity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_city`
--
ALTER TABLE `customadmin_city`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customadmin_classroom`
--
ALTER TABLE `customadmin_classroom`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_contentvideo`
--
ALTER TABLE `customadmin_contentvideo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `customadmin_country`
--
ALTER TABLE `customadmin_country`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customadmin_courseenroll`
--
ALTER TABLE `customadmin_courseenroll`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `customadmin_courses`
--
ALTER TABLE `customadmin_courses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_coursesenduser`
--
ALTER TABLE `customadmin_coursesenduser`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `customadmin_coursesenduser_rejected`
--
ALTER TABLE `customadmin_coursesenduser_rejected`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_coursesenduser_requests`
--
ALTER TABLE `customadmin_coursesenduser_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_coursesenduser_students`
--
ALTER TABLE `customadmin_coursesenduser_students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_courses_rejected`
--
ALTER TABLE `customadmin_courses_rejected`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_courses_requests`
--
ALTER TABLE `customadmin_courses_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_courses_students`
--
ALTER TABLE `customadmin_courses_students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_dragdropactivity`
--
ALTER TABLE `customadmin_dragdropactivity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customadmin_dragdropactivityanswers`
--
ALTER TABLE `customadmin_dragdropactivityanswers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_dragdropactivityelements`
--
ALTER TABLE `customadmin_dragdropactivityelements`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_fileactivity`
--
ALTER TABLE `customadmin_fileactivity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_language`
--
ALTER TABLE `customadmin_language`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customadmin_languagecourse`
--
ALTER TABLE `customadmin_languagecourse`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_organization`
--
ALTER TABLE `customadmin_organization`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customadmin_organization_course`
--
ALTER TABLE `customadmin_organization_course`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customadmin_organization_students`
--
ALTER TABLE `customadmin_organization_students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_personinroom`
--
ALTER TABLE `customadmin_personinroom`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_question`
--
ALTER TABLE `customadmin_question`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customadmin_sessionactivity`
--
ALTER TABLE `customadmin_sessionactivity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customadmin_spinactivity`
--
ALTER TABLE `customadmin_spinactivity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `customadmin_spinactivityanswer`
--
ALTER TABLE `customadmin_spinactivityanswer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `customadmin_spinactivityenroll`
--
ALTER TABLE `customadmin_spinactivityenroll`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_spinactivity_topic_details`
--
ALTER TABLE `customadmin_spinactivity_topic_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `customadmin_state`
--
ALTER TABLE `customadmin_state`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customadmin_subtopic`
--
ALTER TABLE `customadmin_subtopic`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_topic`
--
ALTER TABLE `customadmin_topic`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customadmin_topicdetails`
--
ALTER TABLE `customadmin_topicdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `customadmin_topicdetails_questions`
--
ALTER TABLE `customadmin_topicdetails_questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `customadmin_topicrelation`
--
ALTER TABLE `customadmin_topicrelation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `customadmin_topicwiseanswerpaper`
--
ALTER TABLE `customadmin_topicwiseanswerpaper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329;

--
-- AUTO_INCREMENT for table `customadmin_usercategories`
--
ALTER TABLE `customadmin_usercategories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `custompermission_perm`
--
ALTER TABLE `custompermission_perm`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `custompermission_perm_groups`
--
ALTER TABLE `custompermission_perm_groups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `custompermission_perm_users`
--
ALTER TABLE `custompermission_perm_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `django_site`
--
ALTER TABLE `django_site`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `grades_graderange`
--
ALTER TABLE `grades_graderange`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `grades_gradingsystem`
--
ALTER TABLE `grades_gradingsystem`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `organization_userinformation`
--
ALTER TABLE `organization_userinformation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `polls_choice`
--
ALTER TABLE `polls_choice`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `polls_poll`
--
ALTER TABLE `polls_poll`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preassesment_answer`
--
ALTER TABLE `preassesment_answer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `preassesment_answerpaper`
--
ALTER TABLE `preassesment_answerpaper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `preassesment_answerpaper_answers`
--
ALTER TABLE `preassesment_answerpaper_answers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `preassesment_answerpaper_questions`
--
ALTER TABLE `preassesment_answerpaper_questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `preassesment_answerpaper_questions_answered`
--
ALTER TABLE `preassesment_answerpaper_questions_answered`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `preassesment_answerpaper_questions_unanswered`
--
ALTER TABLE `preassesment_answerpaper_questions_unanswered`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `preassesment_assesments`
--
ALTER TABLE `preassesment_assesments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preassesment_fileupload`
--
ALTER TABLE `preassesment_fileupload`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preassesment_question`
--
ALTER TABLE `preassesment_question`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `preassesment_questionoption`
--
ALTER TABLE `preassesment_questionoption`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `preassesment_questionpaper`
--
ALTER TABLE `preassesment_questionpaper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `preassesment_questionpaper_fixed_questions`
--
ALTER TABLE `preassesment_questionpaper_fixed_questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `preassesment_questionpaper_random_questions`
--
ALTER TABLE `preassesment_questionpaper_random_questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preassesment_questionset`
--
ALTER TABLE `preassesment_questionset`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preassesment_questionset_questions`
--
ALTER TABLE `preassesment_questionset_questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preassesment_quiz`
--
ALTER TABLE `preassesment_quiz`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `taggit_tag`
--
ALTER TABLE `taggit_tag`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `userlms_discussion`
--
ALTER TABLE `userlms_discussion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `userlms_forumanswer`
--
ALTER TABLE `userlms_forumanswer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userlms_notes`
--
ALTER TABLE `userlms_notes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `chat_chatmessage`
--
ALTER TABLE `chat_chatmessage`
  ADD CONSTRAINT `chat_chatmessage_course_id_4ebdd34b_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `chat_chatmessage_userfrom_id_f6a7fe21_fk_auth_user_id` FOREIGN KEY (`userfrom_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `chat_chatmessage_userto_id_d6f7e11f_fk_auth_user_id` FOREIGN KEY (`userto_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `chat_layer`
--
ALTER TABLE `chat_layer`
  ADD CONSTRAINT `chat_layer_course_id_458adb5f_fk_customadmin_coursesenduser_id` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`);

--
-- Constraints for table `chat_room`
--
ALTER TABLE `chat_room`
  ADD CONSTRAINT `chat_room_course_id_428d7139_fk_customadmin_coursesenduser_id` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`);

--
-- Constraints for table `chat_room_user`
--
ALTER TABLE `chat_room_user`
  ADD CONSTRAINT `chat_room_user_course_id_a7fdf47b_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`);

--
-- Constraints for table `customadmin_activities`
--
ALTER TABLE `customadmin_activities`
  ADD CONSTRAINT `customadmin_activiti_course_id_44e14dc1_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_activiti_organization_id_3ec0695b_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`),
  ADD CONSTRAINT `customadmin_activities_author_id_2a15aa3f_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `customadmin_activities_topic_id_e723c0c4_fk_customadmin_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `customadmin_topic` (`id`);

--
-- Constraints for table `customadmin_activityadding`
--
ALTER TABLE `customadmin_activityadding`
  ADD CONSTRAINT `customadmin_activity_course_id_id_d92cc1e9_fk_customadm` FOREIGN KEY (`course_id_id`) REFERENCES `customadmin_courses` (`id`),
  ADD CONSTRAINT `customadmin_activity_topic_id_id_a16d72eb_fk_customadm` FOREIGN KEY (`topic_id_id`) REFERENCES `customadmin_topic` (`id`);

--
-- Constraints for table `customadmin_activitytype`
--
ALTER TABLE `customadmin_activitytype`
  ADD CONSTRAINT `customadmin_activitytype_author_id_20b0928c_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_answer`
--
ALTER TABLE `customadmin_answer`
  ADD CONSTRAINT `customadmin_answer_question_id_4ae2f93e_fk_customadm` FOREIGN KEY (`question_id`) REFERENCES `customadmin_question` (`id`);

--
-- Constraints for table `customadmin_assignmentactivity`
--
ALTER TABLE `customadmin_assignmentactivity`
  ADD CONSTRAINT `customadmin_assignme_activity_id_aef7ba19_fk_customadm` FOREIGN KEY (`activity_id`) REFERENCES `customadmin_activities` (`id`);

--
-- Constraints for table `customadmin_assignmentanswer`
--
ALTER TABLE `customadmin_assignmentanswer`
  ADD CONSTRAINT `customadmin_assignme_activity_id_5c850fef_fk_customadm` FOREIGN KEY (`activity_id`) REFERENCES `customadmin_assignmentactivity` (`id`),
  ADD CONSTRAINT `customadmin_assignmentanswer_user_id_3f0a4249_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_categories`
--
ALTER TABLE `customadmin_categories`
  ADD CONSTRAINT `customadmin_categori_organization_id_39c17b5e_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`);

--
-- Constraints for table `customadmin_categorieshirerchy`
--
ALTER TABLE `customadmin_categorieshirerchy`
  ADD CONSTRAINT `customadmin_categori_category_father_id_9f119f1f_fk_customadm` FOREIGN KEY (`category_father_id`) REFERENCES `customadmin_categories` (`id`),
  ADD CONSTRAINT `customadmin_categori_category_id_95dbe04b_fk_customadm` FOREIGN KEY (`category_id`) REFERENCES `customadmin_categories` (`id`);

--
-- Constraints for table `customadmin_chatactivity`
--
ALTER TABLE `customadmin_chatactivity`
  ADD CONSTRAINT `customadmin_chatacti_activity_id_id_87f11f4a_fk_customadm` FOREIGN KEY (`activity_id_id`) REFERENCES `customadmin_activities` (`id`);

--
-- Constraints for table `customadmin_city`
--
ALTER TABLE `customadmin_city`
  ADD CONSTRAINT `customadmin_city_state_id_9cfc6370_fk_customadmin_state_id` FOREIGN KEY (`state_id`) REFERENCES `customadmin_state` (`id`);

--
-- Constraints for table `customadmin_classroom`
--
ALTER TABLE `customadmin_classroom`
  ADD CONSTRAINT `customadmin_classroo_sessionactivity_id_ed2fa621_fk_customadm` FOREIGN KEY (`sessionactivity_id`) REFERENCES `customadmin_sessionactivity` (`id`),
  ADD CONSTRAINT `customadmin_classroom_user_id_29854d03_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_contentvideo`
--
ALTER TABLE `customadmin_contentvideo`
  ADD CONSTRAINT `customadmin_contentv_course_id_7e53e168_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_contentv_language_id_a15e5c69_fk_customadm` FOREIGN KEY (`language_id`) REFERENCES `customadmin_language` (`id`),
  ADD CONSTRAINT `customadmin_contentv_organization_id_83823540_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`),
  ADD CONSTRAINT `customadmin_contentv_topic_id_f6843fa4_fk_customadm` FOREIGN KEY (`topic_id`) REFERENCES `customadmin_topic` (`id`);

--
-- Constraints for table `customadmin_courseenroll`
--
ALTER TABLE `customadmin_courseenroll`
  ADD CONSTRAINT `customadmin_courseen_course_id_fcaa150d_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_courseenroll_user_id_2c63378b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_courses`
--
ALTER TABLE `customadmin_courses`
  ADD CONSTRAINT `customadmin_courses_author_id_30056b9d_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `customadmin_courses_courses_category_id_bf1f58cf_fk_customadm` FOREIGN KEY (`courses_category_id`) REFERENCES `customadmin_categories` (`id`),
  ADD CONSTRAINT `customadmin_courses_organization_id_c0922678_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`),
  ADD CONSTRAINT `customadmin_courses_teacher_id_5fe35662_fk_organizat` FOREIGN KEY (`teacher_id`) REFERENCES `organization_userinformation` (`id`);

--
-- Constraints for table `customadmin_coursesenduser`
--
ALTER TABLE `customadmin_coursesenduser`
  ADD CONSTRAINT `customadmin_coursese_category_id_edcaebcf_fk_customadm` FOREIGN KEY (`category_id`) REFERENCES `customadmin_usercategories` (`id`),
  ADD CONSTRAINT `customadmin_coursesenduser_author_id_c5d1dd8a_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_coursesenduser_rejected`
--
ALTER TABLE `customadmin_coursesenduser_rejected`
  ADD CONSTRAINT `customadmin_coursese_coursesenduser_id_01ed56d7_fk_customadm` FOREIGN KEY (`coursesenduser_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_coursese_user_id_432d04e6_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_coursesenduser_requests`
--
ALTER TABLE `customadmin_coursesenduser_requests`
  ADD CONSTRAINT `customadmin_coursese_coursesenduser_id_597a691f_fk_customadm` FOREIGN KEY (`coursesenduser_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_coursese_user_id_37e49ebb_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_coursesenduser_students`
--
ALTER TABLE `customadmin_coursesenduser_students`
  ADD CONSTRAINT `customadmin_coursese_coursesenduser_id_a2a62211_fk_customadm` FOREIGN KEY (`coursesenduser_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_coursese_user_id_ef601796_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_courses_rejected`
--
ALTER TABLE `customadmin_courses_rejected`
  ADD CONSTRAINT `customadmin_courses__courses_id_4920285e_fk_customadm` FOREIGN KEY (`courses_id`) REFERENCES `customadmin_courses` (`id`),
  ADD CONSTRAINT `customadmin_courses_rejected_user_id_5100e393_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_courses_requests`
--
ALTER TABLE `customadmin_courses_requests`
  ADD CONSTRAINT `customadmin_courses__courses_id_e676c00b_fk_customadm` FOREIGN KEY (`courses_id`) REFERENCES `customadmin_courses` (`id`),
  ADD CONSTRAINT `customadmin_courses_requests_user_id_bd45d0d3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_courses_students`
--
ALTER TABLE `customadmin_courses_students`
  ADD CONSTRAINT `customadmin_courses__courses_id_6ee60b34_fk_customadm` FOREIGN KEY (`courses_id`) REFERENCES `customadmin_courses` (`id`),
  ADD CONSTRAINT `customadmin_courses_students_user_id_3d2e8684_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_dragdropactivity`
--
ALTER TABLE `customadmin_dragdropactivity`
  ADD CONSTRAINT `customadmin_dragdrop_activity_id_54f8fca2_fk_customadm` FOREIGN KEY (`activity_id`) REFERENCES `customadmin_activities` (`id`);

--
-- Constraints for table `customadmin_dragdropactivityanswers`
--
ALTER TABLE `customadmin_dragdropactivityanswers`
  ADD CONSTRAINT `customadmin_dragdrop_dd_activity_id_31834668_fk_customadm` FOREIGN KEY (`dd_activity_id`) REFERENCES `customadmin_dragdropactivity` (`id`);

--
-- Constraints for table `customadmin_dragdropactivityelements`
--
ALTER TABLE `customadmin_dragdropactivityelements`
  ADD CONSTRAINT `customadmin_dragdrop_dd_activity_id_77ca09c9_fk_customadm` FOREIGN KEY (`dd_activity_id`) REFERENCES `customadmin_dragdropactivity` (`id`);

--
-- Constraints for table `customadmin_fileactivity`
--
ALTER TABLE `customadmin_fileactivity`
  ADD CONSTRAINT `customadmin_fileacti_activity_id_id_ce0c6abd_fk_customadm` FOREIGN KEY (`activity_id_id`) REFERENCES `customadmin_activities` (`id`);

--
-- Constraints for table `customadmin_languagecourse`
--
ALTER TABLE `customadmin_languagecourse`
  ADD CONSTRAINT `customadmin_language_course_id_a3c0833f_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_courses` (`id`),
  ADD CONSTRAINT `customadmin_language_lang_id_e5058242_fk_customadm` FOREIGN KEY (`lang_id`) REFERENCES `customadmin_language` (`id`);

--
-- Constraints for table `customadmin_organization`
--
ALTER TABLE `customadmin_organization`
  ADD CONSTRAINT `customadmin_organiza_country_id_92af6697_fk_customadm` FOREIGN KEY (`country_id`) REFERENCES `customadmin_country` (`id`),
  ADD CONSTRAINT `customadmin_organiza_state_id_13dbe259_fk_customadm` FOREIGN KEY (`state_id`) REFERENCES `customadmin_state` (`id`),
  ADD CONSTRAINT `customadmin_organization_city_id_cdb4571b_fk_customadmin_city_id` FOREIGN KEY (`city_id`) REFERENCES `customadmin_city` (`id`);

--
-- Constraints for table `customadmin_organization_course`
--
ALTER TABLE `customadmin_organization_course`
  ADD CONSTRAINT `customadmin_organiza_coursesenduser_id_4c7378d7_fk_customadm` FOREIGN KEY (`coursesenduser_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_organiza_organization_id_c9a041e4_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`);

--
-- Constraints for table `customadmin_organization_students`
--
ALTER TABLE `customadmin_organization_students`
  ADD CONSTRAINT `customadmin_organiza_organization_id_116c9c76_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`),
  ADD CONSTRAINT `customadmin_organiza_user_id_86f9c0b5_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_personinroom`
--
ALTER TABLE `customadmin_personinroom`
  ADD CONSTRAINT `customadmin_personin_chat_id_9175ae81_fk_customadm` FOREIGN KEY (`chat_id`) REFERENCES `customadmin_chatactivity` (`id`),
  ADD CONSTRAINT `customadmin_personinroom_user_id_id_19d59f31_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_question`
--
ALTER TABLE `customadmin_question`
  ADD CONSTRAINT `customadmin_question_author_id_0b702895_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `customadmin_question_question_language_id_df522a0d_fk_customadm` FOREIGN KEY (`question_language_id`) REFERENCES `customadmin_language` (`id`);

--
-- Constraints for table `customadmin_sessionactivity`
--
ALTER TABLE `customadmin_sessionactivity`
  ADD CONSTRAINT `customadmin_sessiona_course_id_4bac360c_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_sessiona_organization_id_1e3312eb_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`),
  ADD CONSTRAINT `customadmin_sessiona_teacher_id_e02f19d8_fk_organizat` FOREIGN KEY (`teacher_id`) REFERENCES `organization_userinformation` (`id`),
  ADD CONSTRAINT `customadmin_sessionactivity_author_id_75383d6a_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_spinactivity`
--
ALTER TABLE `customadmin_spinactivity`
  ADD CONSTRAINT `customadmin_spinacti_activity_id_90126c61_fk_customadm` FOREIGN KEY (`activity_id`) REFERENCES `customadmin_activities` (`id`);

--
-- Constraints for table `customadmin_spinactivityanswer`
--
ALTER TABLE `customadmin_spinactivityanswer`
  ADD CONSTRAINT `customadmin_spinacti_question_id_ea9b1f17_fk_customadm` FOREIGN KEY (`question_id`) REFERENCES `customadmin_question` (`id`),
  ADD CONSTRAINT `customadmin_spinacti_spinactivity_id_ffa0f953_fk_customadm` FOREIGN KEY (`spinactivity_id`) REFERENCES `customadmin_spinactivity` (`id`);

--
-- Constraints for table `customadmin_spinactivityenroll`
--
ALTER TABLE `customadmin_spinactivityenroll`
  ADD CONSTRAINT `customadmin_spinacti_candidate_id_eab8c4ea_fk_auth_user` FOREIGN KEY (`candidate_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `customadmin_spinacti_spinactivity_id_d9cd1644_fk_customadm` FOREIGN KEY (`spinactivity_id`) REFERENCES `customadmin_spinactivity` (`id`);

--
-- Constraints for table `customadmin_spinactivity_topic_details`
--
ALTER TABLE `customadmin_spinactivity_topic_details`
  ADD CONSTRAINT `customadmin_spinacti_spinactivity_id_ab9f6648_fk_customadm` FOREIGN KEY (`spinactivity_id`) REFERENCES `customadmin_spinactivity` (`id`),
  ADD CONSTRAINT `customadmin_spinacti_topicdetails_id_b57084ed_fk_customadm` FOREIGN KEY (`topicdetails_id`) REFERENCES `customadmin_topicdetails` (`id`);

--
-- Constraints for table `customadmin_state`
--
ALTER TABLE `customadmin_state`
  ADD CONSTRAINT `customadmin_state_country_id_3f63677a_fk_customadmin_country_id` FOREIGN KEY (`country_id`) REFERENCES `customadmin_country` (`id`);

--
-- Constraints for table `customadmin_subtopic`
--
ALTER TABLE `customadmin_subtopic`
  ADD CONSTRAINT `customadmin_subtopic_author_id_dd5882b2_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `customadmin_subtopic_topic_id_6bf766ad_fk_customadmin_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `customadmin_topic` (`id`);

--
-- Constraints for table `customadmin_topic`
--
ALTER TABLE `customadmin_topic`
  ADD CONSTRAINT `customadmin_topic_author_id_c4d80f92_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `customadmin_topic_course_id_a8d1b7d1_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`);

--
-- Constraints for table `customadmin_topicdetails_questions`
--
ALTER TABLE `customadmin_topicdetails_questions`
  ADD CONSTRAINT `customadmin_topicdet_question_id_3b08a534_fk_customadm` FOREIGN KEY (`question_id`) REFERENCES `customadmin_question` (`id`),
  ADD CONSTRAINT `customadmin_topicdet_topicdetails_id_00aa0aad_fk_customadm` FOREIGN KEY (`topicdetails_id`) REFERENCES `customadmin_topicdetails` (`id`);

--
-- Constraints for table `customadmin_topicrelation`
--
ALTER TABLE `customadmin_topicrelation`
  ADD CONSTRAINT `customadmin_topicrel_topic_father_id_ae4f38c3_fk_customadm` FOREIGN KEY (`topic_father_id`) REFERENCES `customadmin_topic` (`id`),
  ADD CONSTRAINT `customadmin_topicrel_topic_id_id_0633f3f5_fk_customadm` FOREIGN KEY (`topic_id_id`) REFERENCES `customadmin_topic` (`id`);

--
-- Constraints for table `customadmin_topicwiseanswerpaper`
--
ALTER TABLE `customadmin_topicwiseanswerpaper`
  ADD CONSTRAINT `customadmin_topicwis_activity_id_f56c08f3_fk_customadm` FOREIGN KEY (`activity_id`) REFERENCES `customadmin_activities` (`id`),
  ADD CONSTRAINT `customadmin_topicwis_content_video_id_66e154ff_fk_customadm` FOREIGN KEY (`content_video_id`) REFERENCES `customadmin_contentvideo` (`id`),
  ADD CONSTRAINT `customadmin_topicwis_course_id_38fc2841_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `customadmin_topicwis_topic_id_47cd618d_fk_customadm` FOREIGN KEY (`topic_id`) REFERENCES `customadmin_topic` (`id`),
  ADD CONSTRAINT `customadmin_topicwis_user_id_4ecafeb1_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `customadmin_usercategories`
--
ALTER TABLE `customadmin_usercategories`
  ADD CONSTRAINT `customadmin_usercategories_creator_id_8696eda6_fk_auth_user_id` FOREIGN KEY (`creator_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `custompermission_perm`
--
ALTER TABLE `custompermission_perm`
  ADD CONSTRAINT `custompermission_per_content_type_id_063fe74d_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `custompermission_perm_groups`
--
ALTER TABLE `custompermission_perm_groups`
  ADD CONSTRAINT `custompermission_per_perm_id_06fa9239_fk_customper` FOREIGN KEY (`perm_id`) REFERENCES `custompermission_perm` (`id`),
  ADD CONSTRAINT `custompermission_perm_groups_group_id_7c62e56d_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `custompermission_perm_users`
--
ALTER TABLE `custompermission_perm_users`
  ADD CONSTRAINT `custompermission_per_perm_id_7cdc1b47_fk_customper` FOREIGN KEY (`perm_id`) REFERENCES `custompermission_perm` (`id`),
  ADD CONSTRAINT `custompermission_perm_users_user_id_47189282_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `grades_graderange`
--
ALTER TABLE `grades_graderange`
  ADD CONSTRAINT `grades_graderange_system_id_775318a7_fk_grades_gradingsystem_id` FOREIGN KEY (`system_id`) REFERENCES `grades_gradingsystem` (`id`);

--
-- Constraints for table `grades_gradingsystem`
--
ALTER TABLE `grades_gradingsystem`
  ADD CONSTRAINT `grades_gradingsystem_creator_id_b4de4f90_fk_auth_user_id` FOREIGN KEY (`creator_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `organization_userinformation`
--
ALTER TABLE `organization_userinformation`
  ADD CONSTRAINT `organization_userinf_organization_id_6879d9d6_fk_customadm` FOREIGN KEY (`organization_id`) REFERENCES `customadmin_organization` (`id`),
  ADD CONSTRAINT `organization_userinformation_user_id_0fb87740_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `polls_choice`
--
ALTER TABLE `polls_choice`
  ADD CONSTRAINT `polls_choice_poll_id_3a553f1a_fk_polls_poll_id` FOREIGN KEY (`poll_id`) REFERENCES `polls_poll` (`id`);

--
-- Constraints for table `preassesment_answer`
--
ALTER TABLE `preassesment_answer`
  ADD CONSTRAINT `preassesment_answer_question_id_f141ba3c_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`);

--
-- Constraints for table `preassesment_answerpaper`
--
ALTER TABLE `preassesment_answerpaper`
  ADD CONSTRAINT `preassesment_answerp_question_paper_id_11b79cab_fk_preassesm` FOREIGN KEY (`question_paper_id`) REFERENCES `preassesment_questionpaper` (`id`),
  ADD CONSTRAINT `preassesment_answerpaper_user_id_f7a2bcb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `preassesment_answerpaper_answers`
--
ALTER TABLE `preassesment_answerpaper_answers`
  ADD CONSTRAINT `preassesment_answerp_answer_id_740c8082_fk_preassesm` FOREIGN KEY (`answer_id`) REFERENCES `preassesment_answer` (`id`),
  ADD CONSTRAINT `preassesment_answerp_answerpaper_id_331b1c9e_fk_preassesm` FOREIGN KEY (`answerpaper_id`) REFERENCES `preassesment_answerpaper` (`id`);

--
-- Constraints for table `preassesment_answerpaper_questions`
--
ALTER TABLE `preassesment_answerpaper_questions`
  ADD CONSTRAINT `preassesment_answerp_answerpaper_id_6a6c7f85_fk_preassesm` FOREIGN KEY (`answerpaper_id`) REFERENCES `preassesment_answerpaper` (`id`),
  ADD CONSTRAINT `preassesment_answerp_question_id_699cbf5e_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`);

--
-- Constraints for table `preassesment_answerpaper_questions_answered`
--
ALTER TABLE `preassesment_answerpaper_questions_answered`
  ADD CONSTRAINT `preassesment_answerp_answerpaper_id_5b4d116f_fk_preassesm` FOREIGN KEY (`answerpaper_id`) REFERENCES `preassesment_answerpaper` (`id`),
  ADD CONSTRAINT `preassesment_answerp_question_id_b288b96d_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`);

--
-- Constraints for table `preassesment_answerpaper_questions_unanswered`
--
ALTER TABLE `preassesment_answerpaper_questions_unanswered`
  ADD CONSTRAINT `preassesment_answerp_answerpaper_id_6f997335_fk_preassesm` FOREIGN KEY (`answerpaper_id`) REFERENCES `preassesment_answerpaper` (`id`),
  ADD CONSTRAINT `preassesment_answerp_question_id_6f3504cd_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`);

--
-- Constraints for table `preassesment_assesments`
--
ALTER TABLE `preassesment_assesments`
  ADD CONSTRAINT `preassesment_assesme_topics_id_8b36b664_fk_customadm` FOREIGN KEY (`topics_id`) REFERENCES `customadmin_topic` (`id`),
  ADD CONSTRAINT `preassesment_assesments_creator_id_5cdc9ca7_fk_auth_user_id` FOREIGN KEY (`creator_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `preassesment_fileupload`
--
ALTER TABLE `preassesment_fileupload`
  ADD CONSTRAINT `preassesment_fileupl_question_id_6fc1236c_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`);

--
-- Constraints for table `preassesment_question`
--
ALTER TABLE `preassesment_question`
  ADD CONSTRAINT `preassesment_question_user_id_0bcb0c2a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `preassesment_questionoption`
--
ALTER TABLE `preassesment_questionoption`
  ADD CONSTRAINT `preassesment_questio_question_id_f9e680f8_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`);

--
-- Constraints for table `preassesment_questionpaper`
--
ALTER TABLE `preassesment_questionpaper`
  ADD CONSTRAINT `preassesment_questio_quiz_id_c8252bde_fk_preassesm` FOREIGN KEY (`quiz_id`) REFERENCES `preassesment_quiz` (`id`);

--
-- Constraints for table `preassesment_questionpaper_fixed_questions`
--
ALTER TABLE `preassesment_questionpaper_fixed_questions`
  ADD CONSTRAINT `preassesment_questio_question_id_867267cd_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`),
  ADD CONSTRAINT `preassesment_questio_questionpaper_id_5618366f_fk_preassesm` FOREIGN KEY (`questionpaper_id`) REFERENCES `preassesment_questionpaper` (`id`);

--
-- Constraints for table `preassesment_questionpaper_random_questions`
--
ALTER TABLE `preassesment_questionpaper_random_questions`
  ADD CONSTRAINT `preassesment_questio_questionpaper_id_825cbef7_fk_preassesm` FOREIGN KEY (`questionpaper_id`) REFERENCES `preassesment_questionpaper` (`id`),
  ADD CONSTRAINT `preassesment_questio_questionset_id_5febf713_fk_preassesm` FOREIGN KEY (`questionset_id`) REFERENCES `preassesment_questionset` (`id`);

--
-- Constraints for table `preassesment_questionset_questions`
--
ALTER TABLE `preassesment_questionset_questions`
  ADD CONSTRAINT `preassesment_questio_question_id_e6659835_fk_preassesm` FOREIGN KEY (`question_id`) REFERENCES `preassesment_question` (`id`),
  ADD CONSTRAINT `preassesment_questio_questionset_id_40966a59_fk_preassesm` FOREIGN KEY (`questionset_id`) REFERENCES `preassesment_questionset` (`id`);

--
-- Constraints for table `preassesment_quiz`
--
ALTER TABLE `preassesment_quiz`
  ADD CONSTRAINT `preassesment_quiz_course_id_7e742666_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`),
  ADD CONSTRAINT `preassesment_quiz_creator_id_1d1a0fab_fk_auth_user_id` FOREIGN KEY (`creator_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `preassesment_quiz_topic_id_483e3164_fk_customadmin_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `customadmin_topic` (`id`);

--
-- Constraints for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  ADD CONSTRAINT `taggit_taggeditem_content_type_id_9957a03c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `taggit_tag` (`id`);

--
-- Constraints for table `userlms_discussion`
--
ALTER TABLE `userlms_discussion`
  ADD CONSTRAINT `userlms_discussion_author_id_1343c752_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `userlms_discussion_course_id_af504ee2_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`);

--
-- Constraints for table `userlms_forumanswer`
--
ALTER TABLE `userlms_forumanswer`
  ADD CONSTRAINT `userlms_forumanswer_author_id_a0f33035_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `userlms_forumanswer_discussion_id_644692ee_fk_userlms_d` FOREIGN KEY (`discussion_id`) REFERENCES `userlms_discussion` (`id`);

--
-- Constraints for table `userlms_notes`
--
ALTER TABLE `userlms_notes`
  ADD CONSTRAINT `userlms_notes_author_id_b0ba17ca_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `userlms_notes_course_id_74b4f769_fk_customadm` FOREIGN KEY (`course_id`) REFERENCES `customadmin_coursesenduser` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
