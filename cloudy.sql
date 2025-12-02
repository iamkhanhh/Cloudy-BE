/*
 Navicat Premium Dump SQL

 Source Server         : java and a45081
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:33069
 Source Schema         : cloudy

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 02/12/2025 21:54:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for album_media
-- ----------------------------
DROP TABLE IF EXISTS `album_media`;
CREATE TABLE `album_media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `album_id` int DEFAULT NULL,
  `media_id` int DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of album_media
-- ----------------------------
BEGIN;
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (10, 1, 1, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (11, 1, 3, 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (12, 2, 2, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (13, 1, 1, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (14, 3, 5, 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (15, 3, 7, 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (16, 4, 6, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (17, 5, 11, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `album_media` (`id`, `album_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (18, 6, 4, 0, '2025-11-23 16:53:30', '2025-11-23 16:53:30');
COMMIT;

-- ----------------------------
-- Table structure for albums
-- ----------------------------
DROP TABLE IF EXISTS `albums`;
CREATE TABLE `albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cover_media_id` int DEFAULT NULL,
  `visibility` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of albums
-- ----------------------------
BEGIN;
INSERT INTO `albums` (`id`, `owner_id`, `name`, `description`, `cover_media_id`, `visibility`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 1, 'Summer Vacation 2024', 'Photos and videos from my summer vacation', 1, 'PUBLIC', 0, '2025-11-20 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `albums` (`id`, `owner_id`, `name`, `description`, `cover_media_id`, `visibility`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 3, 'Nature Photography', 'Collection of nature photographs', 2, 'PUBLIC', 0, '2025-11-15 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `albums` (`id`, `owner_id`, `name`, `description`, `cover_media_id`, `visibility`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 2, 'Travel Memories', 'My travel adventures around the world', 5, 'PUBLIC', 0, '2025-11-24 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `albums` (`id`, `owner_id`, `name`, `description`, `cover_media_id`, `visibility`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 2, 'Food Gallery', 'Delicious food from different cuisines', 6, 'PUBLIC', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `albums` (`id`, `owner_id`, `name`, `description`, `cover_media_id`, `visibility`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 5, 'Video Tutorials', 'Educational content', 11, 'PUBLIC', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `albums` (`id`, `owner_id`, `name`, `description`, `cover_media_id`, `visibility`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (6, 1, 'Private Memories', 'Personal collection', 4, 'PRIVATE', 0, '2025-11-23 16:53:30', '2025-11-23 16:53:30');
INSERT INTO `albums` (`id`, `owner_id`, `name`, `description`, `cover_media_id`, `visibility`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (7, 3, 'khanhkhanh', 'Photos and videos from my summer vacation', NULL, 'PUBLIC', 1, '2025-11-30 17:45:15', '2025-11-30 17:47:02');
COMMIT;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `media_id` int DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of comments
-- ----------------------------
BEGIN;
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 1, 2, 'Beautiful sunset! Amazing colors!', 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 1, 5, 'Where was this taken? Stunning view!', 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 1, 1, 'Thanks! This was at Santa Monica Beach', 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 5, 1, 'Paris is always beautiful! Great shot!', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 5, 5, 'I want to visit Paris someday', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (6, 6, 1, 'That pasta looks delicious!', 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (7, 7, 1, 'Love the atmosphere of Tokyo streets', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (8, 11, 2, 'Very helpful tutorial! Thanks for sharing', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `comments` (`id`, `media_id`, `author_id`, `content`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (9, 11, 1, 'Great explanation of the techniques', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
COMMIT;

-- ----------------------------
-- Table structure for email_attachments
-- ----------------------------
DROP TABLE IF EXISTS `email_attachments`;
CREATE TABLE `email_attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_id` int DEFAULT NULL,
  `media_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of email_attachments
-- ----------------------------
BEGIN;
INSERT INTO `email_attachments` (`id`, `email_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 3, '1', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `email_attachments` (`id`, `email_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 3, '2', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `email_attachments` (`id`, `email_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 4, '5', 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `email_attachments` (`id`, `email_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 4, '6', 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `email_attachments` (`id`, `email_id`, `media_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 5, '11', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
COMMIT;

-- ----------------------------
-- Table structure for email_logs
-- ----------------------------
DROP TABLE IF EXISTS `email_logs`;
CREATE TABLE `email_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int DEFAULT NULL,
  `to_email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb3_unicode_ci,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `error_message` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of email_logs
-- ----------------------------
BEGIN;
INSERT INTO `email_logs` (`id`, `sender_id`, `to_email`, `subject`, `body`, `status`, `error_message`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 1, 'john.doe@example.com', 'Activate your account', 'Welcome to Cloudy! Please activate your account using the code: abc123', 'SENT', NULL, 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `email_logs` (`id`, `sender_id`, `to_email`, `subject`, `body`, `status`, `error_message`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 2, 'jane.smith@example.com', 'Activate your account', 'Welcome to Cloudy! Please activate your account using the code: def456', 'SENT', NULL, 0, '2025-11-12 16:53:30', '2025-11-12 16:53:30');
INSERT INTO `email_logs` (`id`, `sender_id`, `to_email`, `subject`, `body`, `status`, `error_message`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 1, 'friend@example.com', 'Check out my photos!', 'Hey! I wanted to share some photos with you.', 'SENT', NULL, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `email_logs` (`id`, `sender_id`, `to_email`, `subject`, `body`, `status`, `error_message`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 2, 'colleague@example.com', 'Travel photos', 'Here are the photos from our trip!', 'QUEUED', NULL, 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `email_logs` (`id`, `sender_id`, `to_email`, `subject`, `body`, `status`, `error_message`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 5, 'student@example.com', 'Tutorial video', 'Here is the tutorial video you requested.', 'SENT', NULL, 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `email_logs` (`id`, `sender_id`, `to_email`, `subject`, `body`, `status`, `error_message`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (6, 1, 'invalid@invalid', 'Test email', 'This email will fail', 'FAILED', 'Invalid email address', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
COMMIT;

-- ----------------------------
-- Table structure for media
-- ----------------------------
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mime_type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `size` int DEFAULT NULL,
  `duration_ms` int DEFAULT NULL,
  `visibility` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `processing_status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `caption` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of media
-- ----------------------------
BEGIN;
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 3, 'IMAGE', 'image/png', 'sunset-beach.jpg', 2048576, NULL, 'PUBLIC', 'DONE', '3/a.png', 'Beautiful sunset at the beach', 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 3, 'IMAGE', 'image/jpeg', 'mountain-view.png', 3145728, NULL, 'PUBLIC', 'DONE', '3/2/b.jpg', 'khanh', 0, '2025-11-21 16:53:30', '2025-11-30 17:36:41');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 1, 'VIDEO', 'video/mp4', 'nature-walk.mp4', 52428800, 45000, 'PUBLIC', 'DONE', '/uploads/1/nature-walk.mp4', 'Nature walk in the forest', 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 1, 'IMAGE', 'image/jpeg', 'private-photo.jpg', 1048576, NULL, 'PRIVATE', 'DONE', '/uploads/1/private-photo.jpg', 'Personal photo', 0, '2025-11-23 16:53:30', '2025-11-23 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 2, 'IMAGE', 'image/jpeg', 'paris-eiffel.jpg', 2621440, NULL, 'PUBLIC', 'DONE', '/uploads/2/paris-eiffel.jpg', 'Eiffel Tower in Paris', 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (6, 2, 'IMAGE', 'image/jpeg', 'italian-pasta.jpg', 1572864, NULL, 'PUBLIC', 'DONE', '/uploads/2/italian-pasta.jpg', 'Delicious Italian pasta', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (7, 2, 'VIDEO', 'video/mp4', 'tokyo-street.mp4', 104857600, 120000, 'PUBLIC', 'DONE', '/uploads/2/tokyo-street.mp4', 'Walking through Tokyo streets', 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (8, 2, 'IMAGE', 'image/jpeg', 'processing-image.jpg', 2097152, NULL, 'PRIVATE', 'PROCESSING', '/uploads/2/processing-image.jpg', 'Currently being processed', 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (9, 1, 'VIDEO', 'video/mp4', 'pending-upload.mp4', 157286400, 180000, 'PRIVATE', 'PENDING', '/uploads/5/pending-upload.mp4', 'Video pending processing', 0, '2025-11-30 16:23:30', '2025-11-30 16:23:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (10, 1, 'IMAGE', 'image/jpeg', 'failed-upload.jpg', 5242880, NULL, 'PRIVATE', 'ERROR', '/uploads/5/failed-upload.jpg', 'Failed to process this image', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (11, 5, 'VIDEO', 'video/mp4', 'tutorial-video.mp4', 209715200, 300000, 'PUBLIC', 'DONE', '/uploads/5/tutorial-video.mp4', 'Photography tutorial', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `media` (`id`, `owner_id`, `type`, `mime_type`, `filename`, `size`, `duration_ms`, `visibility`, `processing_status`, `file_path`, `caption`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (12, 3, 'IMAGE', 'image/jpeg', 'sunset-beach.jpg', 2048576, 45000, 'PUBLIC', NULL, '1/sunset-beach.jpg', 'Beautiful sunset at the beach', 0, '2025-11-30 17:38:01', '2025-11-30 17:38:01');
COMMIT;

-- ----------------------------
-- Table structure for media_tags
-- ----------------------------
DROP TABLE IF EXISTS `media_tags`;
CREATE TABLE `media_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `media_id` int DEFAULT NULL,
  `tag_id` int DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of media_tags
-- ----------------------------
BEGIN;
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (14, 1, 1, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (15, 1, 2, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (16, 1, 4, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (17, 2, 3, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (18, 2, 4, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (19, 3, 4, 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (20, 5, 5, 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (21, 5, 7, 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (22, 6, 6, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (23, 7, 5, 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (24, 7, 8, 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (25, 11, 9, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `media_tags` (`id`, `media_id`, `tag_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (26, 11, 10, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `run_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (35, '/20251107140255-create-table-users', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (36, '/20251107141117-create-table-tags', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (37, '/20251107141215-create-table-shares', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (38, '/20251107141528-create-table-media', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (39, '/20251107142354-create-table-media-tags', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (40, '/20251107142546-create-table-email-logs', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (41, '/20251107142716-create-table-email-attachments', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (42, '/20251107142835-create-table-comments', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (43, '/20251107143007-create-table-albums', '2025-11-30 23:21:46');
INSERT INTO `migrations` (`id`, `name`, `run_on`) VALUES (44, '/20251107143121-create-table-album-media', '2025-11-30 23:21:46');
COMMIT;

-- ----------------------------
-- Table structure for shares
-- ----------------------------
DROP TABLE IF EXISTS `shares`;
CREATE TABLE `shares` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `permission` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `receiver_id` int DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of shares
-- ----------------------------
BEGIN;
INSERT INTO `shares` (`id`, `resource_type`, `resource_id`, `owner_id`, `permission`, `receiver_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 'MEDIA', 1, 1, 'VIEW', 3, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `shares` (`id`, `resource_type`, `resource_id`, `owner_id`, `permission`, `receiver_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 'ALBUM', 1, 1, 'VIEW', 2, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `shares` (`id`, `resource_type`, `resource_id`, `owner_id`, `permission`, `receiver_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 'MEDIA', 5, 2, 'VIEW', 1, 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `shares` (`id`, `resource_type`, `resource_id`, `owner_id`, `permission`, `receiver_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 'ALBUM', 3, 2, 'VIEW', 1, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `shares` (`id`, `resource_type`, `resource_id`, `owner_id`, `permission`, `receiver_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 'MEDIA', 11, 5, 'DOWNLOAD', 1, 0, '2025-11-29 16:53:30', '2025-11-29 16:53:30');
INSERT INTO `shares` (`id`, `resource_type`, `resource_id`, `owner_id`, `permission`, `receiver_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (6, 'MEDIA', 2, 1, 'VIEW', 5, 0, '2025-11-15 16:53:30', '2025-11-15 16:53:30');
INSERT INTO `shares` (`id`, `resource_type`, `resource_id`, `owner_id`, `permission`, `receiver_id`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (7, 'MEDIA', 1, 3, 'VIEW', 4, 0, '2025-12-01 03:20:57', '2025-12-01 03:20:57');
COMMIT;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of tags
-- ----------------------------
BEGIN;
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 'sunset', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 'beach', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 'mountain', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 'nature', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 'travel', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (6, 'food', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (7, 'paris', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (8, 'tokyo', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (9, 'tutorial', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` (`id`, `name`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (10, 'photography', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `bio` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `avatar_path` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `codeId` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `codeExpired` timestamp NULL DEFAULT NULL,
  `is_deleted` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `bio`, `avatar_path`, `phone_number`, `status`, `role`, `codeId`, `codeExpired`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (1, 'John', 'Doe', 'john.doe@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Photography enthusiast and nature lover', '/avatars/john-doe.jpg', '+1234567890', 'ACTIVE', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `bio`, `avatar_path`, `phone_number`, `status`, `role`, `codeId`, `codeExpired`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Travel blogger and food photographer', '/avatars/jane-smith.jpg', '+1234567891', 'ACTIVE', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `bio`, `avatar_path`, `phone_number`, `status`, `role`, `codeId`, `codeExpired`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (3, 'Admin', 'User', 'admin@cloudy.com', '$2b$10$6bRYGJV5JRnqwx0rQ2Rbbe97OSIA5.poEJLUOLoGO4Zw3HMdZa1Zm', 'System administrator', '/avatars/admin.jpg', '+1234567892', 'ACTIVE', 'ADMIN', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `bio`, `avatar_path`, `phone_number`, `status`, `role`, `codeId`, `codeExpired`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (4, 'Bob', 'Wilson', 'bob.wilson@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Amateur photographer', NULL, '+1234567893', 'PENDING', 'USER', 'abc123-pending-user', '2025-11-30 17:23:30', 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `bio`, `avatar_path`, `phone_number`, `status`, `role`, `codeId`, `codeExpired`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (5, 'Alice', 'Brown', 'alice.brown@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Video content creator', '/avatars/alice-brown.jpg', '+1234567894', 'ACTIVE', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `bio`, `avatar_path`, `phone_number`, `status`, `role`, `codeId`, `codeExpired`, `is_deleted`, `createdAt`, `updatedAt`) VALUES (6, 'Mike', 'Disabled', 'mike.disabled@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Disabled account for testing', NULL, '+1234567895', 'DISABLED', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
