/*
 Navicat Premium Data Transfer

 Source Server         : local_mysql
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : cloudy

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 26/12/2025 15:56:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for album_media
-- ----------------------------
DROP TABLE IF EXISTS `album_media`;
CREATE TABLE `album_media`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `album_id` int NULL DEFAULT NULL,
  `media_id` int NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_media
-- ----------------------------
INSERT INTO `album_media` VALUES (10, 1, 1, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `album_media` VALUES (11, 1, 3, 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `album_media` VALUES (12, 2, 2, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `album_media` VALUES (13, 1, 1, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `album_media` VALUES (14, 3, 5, 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `album_media` VALUES (15, 3, 7, 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `album_media` VALUES (16, 4, 6, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `album_media` VALUES (17, 5, 11, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `album_media` VALUES (18, 6, 4, 0, '2025-11-23 16:53:30', '2025-11-23 16:53:30');

-- ----------------------------
-- Table structure for albums
-- ----------------------------
DROP TABLE IF EXISTS `albums`;
CREATE TABLE `albums`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `cover_media_id` int NULL DEFAULT NULL,
  `visibility` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of albums
-- ----------------------------
INSERT INTO `albums` VALUES (1, 1, 'Summer Vacation 2024', 'Photos and videos from my summer vacation', 1, 'PUBLIC', 0, '2025-11-20 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `albums` VALUES (2, 3, 'Nature Photography', 'wow', 2, 'PUBLIC', 0, '2025-11-15 16:53:30', '2025-12-26 15:34:32');
INSERT INTO `albums` VALUES (3, 2, 'Travel Memories', 'My travel adventures around the world', 5, 'PUBLIC', 0, '2025-11-24 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `albums` VALUES (4, 2, 'Food Gallery', 'Delicious food from different cuisines', 6, 'PUBLIC', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `albums` VALUES (5, 5, 'Video Tutorials', 'Educational content', 11, 'PUBLIC', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `albums` VALUES (6, 1, 'Private Memories', 'Personal collection', 4, 'PRIVATE', 0, '2025-11-23 16:53:30', '2025-11-23 16:53:30');
INSERT INTO `albums` VALUES (7, 3, 'khanhkhanh', 'Photos and videos from my summer vacation', NULL, 'PUBLIC', 1, '2025-11-30 17:45:15', '2025-11-30 17:47:02');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `media_id` int NULL DEFAULT NULL,
  `author_id` int NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, 1, 2, 'Beautiful sunset! Amazing colors!', 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `comments` VALUES (2, 1, 5, 'Where was this taken? Stunning view!', 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `comments` VALUES (3, 1, 1, 'Thanks! This was at Santa Monica Beach', 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `comments` VALUES (4, 5, 1, 'Paris is always beautiful! Great shot!', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `comments` VALUES (5, 5, 5, 'I want to visit Paris someday', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `comments` VALUES (6, 6, 1, 'That pasta looks delicious!', 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `comments` VALUES (7, 7, 1, 'Love the atmosphere of Tokyo streets', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `comments` VALUES (8, 11, 2, 'Very helpful tutorial! Thanks for sharing', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `comments` VALUES (9, 11, 1, 'Great explanation of the techniques', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');

-- ----------------------------
-- Table structure for email_attachments
-- ----------------------------
DROP TABLE IF EXISTS `email_attachments`;
CREATE TABLE `email_attachments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_id` int NULL DEFAULT NULL,
  `media_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of email_attachments
-- ----------------------------
INSERT INTO `email_attachments` VALUES (1, 3, '1', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `email_attachments` VALUES (2, 3, '2', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `email_attachments` VALUES (3, 4, '5', 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `email_attachments` VALUES (4, 4, '6', 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `email_attachments` VALUES (5, 5, '11', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');

-- ----------------------------
-- Table structure for email_logs
-- ----------------------------
DROP TABLE IF EXISTS `email_logs`;
CREATE TABLE `email_logs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NULL DEFAULT NULL,
  `to_email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `body` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `error_message` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of email_logs
-- ----------------------------
INSERT INTO `email_logs` VALUES (1, 1, 'john.doe@example.com', 'Activate your account', 'Welcome to Cloudy! Please activate your account using the code: abc123', 'SENT', NULL, 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `email_logs` VALUES (2, 2, 'jane.smith@example.com', 'Activate your account', 'Welcome to Cloudy! Please activate your account using the code: def456', 'SENT', NULL, 0, '2025-11-12 16:53:30', '2025-11-12 16:53:30');
INSERT INTO `email_logs` VALUES (3, 1, 'friend@example.com', 'Check out my photos!', 'Hey! I wanted to share some photos with you.', 'SENT', NULL, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `email_logs` VALUES (4, 2, 'colleague@example.com', 'Travel photos', 'Here are the photos from our trip!', 'QUEUED', NULL, 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `email_logs` VALUES (5, 5, 'student@example.com', 'Tutorial video', 'Here is the tutorial video you requested.', 'SENT', NULL, 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `email_logs` VALUES (6, 1, 'invalid@invalid', 'Test email', 'This email will fail', 'FAILED', 'Invalid email address', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');

-- ----------------------------
-- Table structure for media
-- ----------------------------
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `size` int NULL DEFAULT NULL,
  `duration_ms` int NULL DEFAULT NULL,
  `visibility` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `processing_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `caption` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of media
-- ----------------------------
INSERT INTO `media` VALUES (1, 3, 'IMAGE', 'image/png', 'sunset-beach.jpg', 2048576, NULL, 'PUBLIC', 'DONE', '3/a.png', 'Beautiful sunset at the beach', 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media` VALUES (2, 3, 'IMAGE', 'image/jpeg', 'mountain-view.png', 3145728, NULL, 'PUBLIC', 'DONE', '3/2/b.jpg', 'khanh', 0, '2025-11-21 16:53:30', '2025-12-26 15:33:24');
INSERT INTO `media` VALUES (3, 1, 'VIDEO', 'video/mp4', 'nature-walk.mp4', 52428800, 45000, 'PUBLIC', 'DONE', '/uploads/1/nature-walk.mp4', 'Nature walk in the forest', 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `media` VALUES (4, 1, 'IMAGE', 'image/jpeg', 'private-photo.jpg', 1048576, NULL, 'PRIVATE', 'DONE', '/uploads/1/private-photo.jpg', 'Personal photo', 0, '2025-11-23 16:53:30', '2025-11-23 16:53:30');
INSERT INTO `media` VALUES (5, 2, 'IMAGE', 'image/jpeg', 'paris-eiffel.jpg', 2621440, NULL, 'PUBLIC', 'DONE', '/uploads/2/paris-eiffel.jpg', 'Eiffel Tower in Paris', 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `media` VALUES (6, 2, 'IMAGE', 'image/jpeg', 'italian-pasta.jpg', 1572864, NULL, 'PUBLIC', 'DONE', '/uploads/2/italian-pasta.jpg', 'Delicious Italian pasta', 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `media` VALUES (7, 2, 'VIDEO', 'video/mp4', 'tokyo-street.mp4', 104857600, 120000, 'PUBLIC', 'DONE', '/uploads/2/tokyo-street.mp4', 'Walking through Tokyo streets', 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `media` VALUES (8, 2, 'IMAGE', 'image/jpeg', 'processing-image.jpg', 2097152, NULL, 'PRIVATE', 'PROCESSING', '/uploads/2/processing-image.jpg', 'Currently being processed', 0, '2025-11-30 15:53:30', '2025-11-30 15:53:30');
INSERT INTO `media` VALUES (9, 1, 'VIDEO', 'video/mp4', 'pending-upload.mp4', 157286400, 180000, 'PRIVATE', 'PENDING', '/uploads/5/pending-upload.mp4', 'Video pending processing', 0, '2025-11-30 16:23:30', '2025-11-30 16:23:30');
INSERT INTO `media` VALUES (10, 1, 'IMAGE', 'image/jpeg', 'failed-upload.jpg', 5242880, NULL, 'PRIVATE', 'ERROR', '/uploads/5/failed-upload.jpg', 'Failed to process this image', 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `media` VALUES (11, 5, 'VIDEO', 'video/mp4', 'tutorial-video.mp4', 209715200, 300000, 'PUBLIC', 'DONE', '/uploads/5/tutorial-video.mp4', 'Photography tutorial', 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `media` VALUES (12, 3, 'IMAGE', 'image/jpeg', 'test.jpg', 999999999, NULL, 'PUBLIC', 'DONE', '3/a.png', 'Beautiful sunset at the beach', 0, '2025-11-30 17:38:01', '2025-12-19 21:20:24');
INSERT INTO `media` VALUES (13, 3, 'IMAGE', 'image/jpeg', 'hihi.jpg', 0, NULL, 'PUBLIC', NULL, '3/33-1766154643384-070a8ff4-9a15-49e3-a329-ed9ef598f476.jpg', 'hehe', 0, '2025-12-19 21:30:44', '2025-12-26 15:32:41');

-- ----------------------------
-- Table structure for media_tags
-- ----------------------------
DROP TABLE IF EXISTS `media_tags`;
CREATE TABLE `media_tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `media_id` int NULL DEFAULT NULL,
  `tag_id` int NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of media_tags
-- ----------------------------
INSERT INTO `media_tags` VALUES (14, 1, 1, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media_tags` VALUES (15, 1, 2, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media_tags` VALUES (16, 1, 4, 0, '2025-11-20 16:53:30', '2025-11-20 16:53:30');
INSERT INTO `media_tags` VALUES (17, 2, 3, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `media_tags` VALUES (18, 2, 4, 0, '2025-11-21 16:53:30', '2025-11-21 16:53:30');
INSERT INTO `media_tags` VALUES (19, 3, 4, 0, '2025-11-22 16:53:30', '2025-11-22 16:53:30');
INSERT INTO `media_tags` VALUES (20, 5, 5, 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `media_tags` VALUES (21, 5, 7, 0, '2025-11-24 16:53:30', '2025-11-24 16:53:30');
INSERT INTO `media_tags` VALUES (22, 6, 6, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `media_tags` VALUES (23, 7, 5, 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `media_tags` VALUES (24, 7, 8, 0, '2025-11-26 16:53:30', '2025-11-26 16:53:30');
INSERT INTO `media_tags` VALUES (25, 11, 9, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `media_tags` VALUES (26, 11, 10, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `run_on` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (35, '/20251107140255-create-table-users', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (36, '/20251107141117-create-table-tags', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (37, '/20251107141215-create-table-shares', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (38, '/20251107141528-create-table-media', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (39, '/20251107142354-create-table-media-tags', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (40, '/20251107142546-create-table-email-logs', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (41, '/20251107142716-create-table-email-attachments', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (42, '/20251107142835-create-table-comments', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (43, '/20251107143007-create-table-albums', '2025-11-30 23:21:46');
INSERT INTO `migrations` VALUES (44, '/20251107143121-create-table-album-media', '2025-11-30 23:21:46');

-- ----------------------------
-- Table structure for shares
-- ----------------------------
DROP TABLE IF EXISTS `shares`;
CREATE TABLE `shares`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `resource_id` int NULL DEFAULT NULL,
  `owner_id` int NULL DEFAULT NULL,
  `permission` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `receiver_id` int NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shares
-- ----------------------------
INSERT INTO `shares` VALUES (1, 'MEDIA', 1, 1, 'VIEW', 3, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `shares` VALUES (2, 'ALBUM', 1, 1, 'VIEW', 2, 0, '2025-11-25 16:53:30', '2025-11-25 16:53:30');
INSERT INTO `shares` VALUES (3, 'MEDIA', 5, 2, 'VIEW', 1, 0, '2025-11-28 16:53:30', '2025-11-28 16:53:30');
INSERT INTO `shares` VALUES (4, 'ALBUM', 3, 2, 'VIEW', 1, 0, '2025-11-27 16:53:30', '2025-11-27 16:53:30');
INSERT INTO `shares` VALUES (5, 'MEDIA', 11, 5, 'DOWNLOAD', 1, 0, '2025-11-29 16:53:30', '2025-11-29 16:53:30');
INSERT INTO `shares` VALUES (6, 'MEDIA', 2, 1, 'VIEW', 5, 0, '2025-11-15 16:53:30', '2025-11-15 16:53:30');
INSERT INTO `shares` VALUES (7, 'MEDIA', 1, 3, 'VIEW', 4, 0, '2025-12-01 03:20:57', '2025-12-01 03:20:57');
INSERT INTO `shares` VALUES (8, 'MEDIA', 13, 3, 'VIEW', 4, 0, '2025-12-19 21:37:20', '2025-12-19 21:37:20');

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (1, 'sunset', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (2, 'beach', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (3, 'mountain', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (4, 'nature', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (5, 'travel', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (6, 'food', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (7, 'paris', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (8, 'tokyo', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (9, 'tutorial', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');
INSERT INTO `tags` VALUES (10, 'photography', 0, '2025-11-10 16:53:30', '2025-11-10 16:53:30');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `bio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `avatar_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `codeId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `codeExpired` timestamp NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'John', 'Doe', 'john.doe@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Photography enthusiast and nature lover', '/avatars/john-doe.jpg', '+1234567890', 'ACTIVE', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Travel blogger and food photographer', '/avatars/jane-smith.jpg', '+1234567891', 'ACTIVE', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` VALUES (3, 'Admin', 'User', 'admin@cloudy.com', '$2b$10$6bRYGJV5JRnqwx0rQ2Rbbe97OSIA5.poEJLUOLoGO4Zw3HMdZa1Zm', 'System administrator', '/avatars/admin.jpg', '+1234567892', 'ACTIVE', 'ADMIN', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` VALUES (4, 'Bob', 'Wilson', 'test@example.com', '$2b$10$6bRYGJV5JRnqwx0rQ2Rbbe97OSIA5.poEJLUOLoGO4Zw3HMdZa1Zm', 'Amateur photographer', NULL, '+1234567893', 'ACTIVE', 'USER', 'abc123-pending-user', '2025-11-30 17:23:30', 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` VALUES (5, 'Alice', 'Brown', 'alice.brown@example.com', '$2b$10$6bRYGJV5JRnqwx0rQ2Rbbe97OSIA5.poEJLUOLoGO4Zw3HMdZa1Zm', 'Video content creator', '/avatars/alice-brown.jpg', '+1234567894', 'ACTIVE', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');
INSERT INTO `users` VALUES (6, 'Mike', 'Disabled', 'mike.disabled@example.com', '$2b$10$6bRYGJV5JRnqwx0rQ2Rbbe97OSIA5.poEJLUOLoGO4Zw3HMdZa1Zm', 'Disabled account for testing', NULL, '+1234567895', 'DISABLED', 'USER', NULL, NULL, 0, '2025-11-30 16:53:30', '2025-11-30 16:53:30');

SET FOREIGN_KEY_CHECKS = 1;
