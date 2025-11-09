-- ========================= Mock Data for Cloudy Backend =========================
-- This file contains sample data for testing and development purposes
-- All enum values match the TypeScript enums in the project

-- Clear existing data (in reverse order of foreign key dependencies)
DELETE FROM comments;
DELETE FROM email_attachments;
DELETE FROM email_logs;
DELETE FROM shares;
DELETE FROM media_tags;
DELETE FROM tags;
DELETE FROM album_media;
DELETE FROM albums;
DELETE FROM media;
DELETE FROM users;

-- Reset auto-increment counters
ALTER TABLE users AUTO_INCREMENT = 1;
ALTER TABLE media AUTO_INCREMENT = 1;
ALTER TABLE albums AUTO_INCREMENT = 1;
ALTER TABLE tags AUTO_INCREMENT = 1;
ALTER TABLE shares AUTO_INCREMENT = 1;
ALTER TABLE email_logs AUTO_INCREMENT = 1;
ALTER TABLE comments AUTO_INCREMENT = 1;

-- ========================= Users =========================
-- Password for all users: "password123" (hashed with bcrypt)
-- Status values: ACTIVE, PENDING, DELETED, DISABLED
-- Role values: USER, ADMIN

INSERT INTO users (email, password, first_name, last_name, phone_number, bio, avatar_path, status, role, is_deleted, codeId, codeExpired, createdAt, updatedAt) VALUES
('john.doe@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'John', 'Doe', '+1234567890', 'Photography enthusiast and nature lover', '/avatars/john-doe.jpg', 'ACTIVE', 'USER', 0, NULL, NULL, NOW(), NOW()),
('jane.smith@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Jane', 'Smith', '+1234567891', 'Travel blogger and food photographer', '/avatars/jane-smith.jpg', 'ACTIVE', 'USER', 0, NULL, NULL, NOW(), NOW()),
('admin@cloudy.com', '$2b$10$6bRYGJV5JRnqwx0rQ2Rbbe97OSIA5.poEJLUOLoGO4Zw3HMdZa1Zm', 'Admin', 'User', '+1234567892', 'System administrator', '/avatars/admin.jpg', 'ACTIVE', 'ADMIN', 0, NULL, NULL, NOW(), NOW()),
('bob.wilson@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Bob', 'Wilson', '+1234567893', 'Amateur photographer', NULL, 'PENDING', 'USER', 0, 'abc123-pending-user', DATE_ADD(NOW(), INTERVAL 30 MINUTE), NOW(), NOW()),
('alice.brown@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Alice', 'Brown', '+1234567894', 'Video content creator', '/avatars/alice-brown.jpg', 'ACTIVE', 'USER', 0, NULL, NULL, NOW(), NOW()),
('mike.disabled@example.com', '$2b$10$rZ5fGE3pF4xYvCwQqGqW7eKqGqW7eKqGqW7eKqGqW7eKqGqW7eKqG', 'Mike', 'Disabled', '+1234567895', 'Disabled account for testing', NULL, 'DISABLED', 'USER', 0, NULL, NULL, NOW(), NOW());

-- ========================= Media =========================
-- Type values: IMAGE, VIDEO
-- Visibility values: PRIVATE, PUBLIC
-- Processing status values: PENDING, PROCESSING, DONE, ERROR

INSERT INTO media (owner_id, type, mime_type, filename, size, duration_ms, visibility, processing_status, caption, is_deleted, createdAt, updatedAt) VALUES
-- John's media
(1, 'IMAGE', 'image/jpeg', 'sunset-beach.jpg', 2048576, NULL, 'PUBLIC', 'DONE', 'Beautiful sunset at the beach', 0, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY)),
(1, 'IMAGE', 'image/png', 'mountain-view.png', 3145728, NULL, 'PUBLIC', 'DONE', 'Mountain hiking adventure', 0, DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY)),
(1, 'VIDEO', 'video/mp4', 'nature-walk.mp4', 52428800, 45000, 'PUBLIC', 'DONE', 'Nature walk in the forest', 0, DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),
(1, 'IMAGE', 'image/jpeg', 'private-photo.jpg', 1048576, NULL, 'PRIVATE', 'DONE', 'Personal photo', 0, DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY)),

-- Jane's media
(2, 'IMAGE', 'image/jpeg', 'paris-eiffel.jpg', 2621440, NULL, 'PUBLIC', 'DONE', 'Eiffel Tower in Paris', 0, DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 6 DAY)),
(2, 'IMAGE', 'image/jpeg', 'italian-pasta.jpg', 1572864, NULL, 'PUBLIC', 'DONE', 'Delicious Italian pasta', 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 'VIDEO', 'video/mp4', 'tokyo-street.mp4', 104857600, 120000, 'PUBLIC', 'DONE', 'Walking through Tokyo streets', 0, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY)),
(2, 'IMAGE', 'image/jpeg', 'processing-image.jpg', 2097152, NULL, 'PRIVATE', 'PROCESSING', 'Currently being processed', 0, DATE_SUB(NOW(), INTERVAL 1 HOUR), DATE_SUB(NOW(), INTERVAL 1 HOUR)),

-- Alice's media
(5, 'VIDEO', 'video/mp4', 'pending-upload.mp4', 157286400, 180000, 'PRIVATE', 'PENDING', 'Video pending processing', 0, DATE_SUB(NOW(), INTERVAL 30 MINUTE), DATE_SUB(NOW(), INTERVAL 30 MINUTE)),
(5, 'IMAGE', 'image/jpeg', 'failed-upload.jpg', 5242880, NULL, 'PRIVATE', 'ERROR', 'Failed to process this image', 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5, 'VIDEO', 'video/mp4', 'tutorial-video.mp4', 209715200, 300000, 'PUBLIC', 'DONE', 'Photography tutorial', 0, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY));

-- ========================= Albums =========================
INSERT INTO albums (owner_id, name, description, cover_media_id, visibility, is_deleted, createdAt, updatedAt) VALUES
(1, 'Summer Vacation 2024', 'Photos and videos from my summer vacation', 1, 'PUBLIC', 0, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),
(1, 'Nature Photography', 'Collection of nature photographs', 2, 'PUBLIC', 0, DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY)),
(2, 'Travel Memories', 'My travel adventures around the world', 5, 'PUBLIC', 0, DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY)),
(2, 'Food Gallery', 'Delicious food from different cuisines', 6, 'PUBLIC', 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 'Video Tutorials', 'Educational content', 11, 'PUBLIC', 0, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
(1, 'Private Memories', 'Personal collection', 4, 'PRIVATE', 0, DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY));

-- ========================= Album Media Relations =========================
INSERT INTO album_media (album_id, media_id, added_by, createdAt, updatedAt, is_deleted) VALUES
(1, 1, 1, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), 0),
(1, 3, 1, DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY), 0),
(2, 2, 1, DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY), 0),
(2, 1, 1, DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY), 0),
(3, 5, 2, DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 6 DAY), 0),
(3, 7, 2, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), 0),
(4, 6, 2, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), 0),
(5, 11, 5, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), 0),
(6, 4, 1, DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY), 0);

-- ========================= Tags =========================
INSERT INTO tags (name, is_deleted, createdAt, updatedAt) VALUES
('sunset', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('beach', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('mountain', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('nature', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('travel', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('food', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('paris', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('tokyo', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('tutorial', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('photography', 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY));

-- ========================= Media Tags =========================
INSERT INTO media_tags (media_id, tag_id, createdAt, updatedAt, is_deleted) VALUES
(1, 1, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), 0),
(1, 2, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), 0),
(1, 4, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), 0),
(2, 3, DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY), 0),
(2, 4, DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY), 0),
(3, 4, DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY), 0),
(5, 5, DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 6 DAY), 0),
(5, 7, DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 6 DAY), 0),
(6, 6, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), 0),
(7, 5, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), 0),
(7, 8, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), 0),
(11, 9, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), 0),
(11, 10, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), 0);

-- ========================= Shares =========================
-- Permission values: VIEW, EDIT
-- resource_type values: MEDIA, ALBUM

INSERT INTO shares (resource_type, resource_id, owner_id, permission, token, password_hash, receiver_id, expires_at, is_deleted, createdAt, updatedAt) VALUES
-- Public share links (no receiver, no password)
('MEDIA', 1, 1, 'VIEW', 'abc123def456ghi789jkl012mno345pqr678stu901vwx234yz567abc890def123', NULL, NULL, DATE_ADD(NOW(), INTERVAL 30 DAY), 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
('ALBUM', 1, 1, 'VIEW', 'def456ghi789jkl012mno345pqr678stu901vwx234yz567abc890def123ghi456', NULL, NULL, DATE_ADD(NOW(), INTERVAL 60 DAY), 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),

-- Password protected share
('MEDIA', 5, 2, 'VIEW', 'ghi789jkl012mno345pqr678stu901vwx234yz567abc890def123ghi456jkl789', '$2b$10$somehashedpasswordhere12345678901234567890123456789012', NULL, DATE_ADD(NOW(), INTERVAL 7 DAY), 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),

-- Share with specific receiver
('ALBUM', 3, 2, 'VIEW', 'jkl012mno345pqr678stu901vwx234yz567abc890def123ghi456jkl789mno012', NULL, 1, DATE_ADD(NOW(), INTERVAL 90 DAY), 0, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),

-- Edit permission share
('MEDIA', 11, 5, 'EDIT', 'mno345pqr678stu901vwx234yz567abc890def123ghi456jkl789mno012pqr345', NULL, 2, NULL, 0, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY)),

-- Expired share
('MEDIA', 2, 1, 'VIEW', 'pqr678stu901vwx234yz567abc890def123ghi456jkl789mno012pqr345stu678', NULL, NULL, DATE_SUB(NOW(), INTERVAL 5 DAY), 0, DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY));

-- ========================= Email Logs =========================
-- Status values: QUEUED, SENT, FAILED

INSERT INTO email_logs (sender_id, to_email, subject, body, status, error_message, is_deleted, createdAt, updatedAt) VALUES
(1, 'john.doe@example.com', 'Activate your account', 'Welcome to Cloudy! Please activate your account using the code: abc123', 'SENT', NULL, 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
(2, 'jane.smith@example.com', 'Activate your account', 'Welcome to Cloudy! Please activate your account using the code: def456', 'SENT', NULL, 0, DATE_SUB(NOW(), INTERVAL 18 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY)),
(1, 'friend@example.com', 'Check out my photos!', 'Hey! I wanted to share some photos with you.', 'SENT', NULL, 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 'colleague@example.com', 'Travel photos', 'Here are the photos from our trip!', 'QUEUED', NULL, 0, DATE_SUB(NOW(), INTERVAL 1 HOUR), DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(5, 'student@example.com', 'Tutorial video', 'Here is the tutorial video you requested.', 'SENT', NULL, 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),
(1, 'invalid@invalid', 'Test email', 'This email will fail', 'FAILED', 'Invalid email address', 0, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY));

-- ========================= Email Attachments =========================
INSERT INTO email_attachments (email_id, media_id, is_deleted, createdAt, updatedAt) VALUES
(3, 1, 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(3, 2, 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 5, 0, DATE_SUB(NOW(), INTERVAL 1 HOUR), DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(4, 6, 0, DATE_SUB(NOW(), INTERVAL 1 HOUR), DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(5, 11, 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY));

-- ========================= Comments =========================
INSERT INTO comments (media_id, author_id, content, is_deleted, createdAt, updatedAt) VALUES
(1, 2, 'Beautiful sunset! Amazing colors!', 0, DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY)),
(1, 5, 'Where was this taken? Stunning view!', 0, DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),
(1, 1, 'Thanks! This was at Santa Monica Beach', 0, DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),
(5, 1, 'Paris is always beautiful! Great shot!', 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 5, 'I want to visit Paris someday', 0, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
(6, 1, 'That pasta looks delicious!', 0, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY)),
(7, 1, 'Love the atmosphere of Tokyo streets', 0, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
(11, 2, 'Very helpful tutorial! Thanks for sharing', 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),
(11, 1, 'Great explanation of the techniques', 0, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY));

-- ========================= Summary =========================
-- Total records inserted:
-- Users: 6
-- Media: 11
-- Albums: 6
-- Album Media: 9
-- Tags: 10
-- Media Tags: 13
-- Shares: 6
-- Email Logs: 6
-- Email Attachments: 5
-- Comments: 9
