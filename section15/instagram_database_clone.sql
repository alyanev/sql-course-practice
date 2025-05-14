-- Section 15: Instagram Database Clone

-- --- --- CREATE DATABASE & USE ---
-- Create a new database for the Instagram clone
CREATE DATABASE ig_clone;

-- Switch to the 'ig_clone' database
USE ig_clone;

-- --- --- CREATE TABLE ---
-- Create 'users' table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create 'photos' table
CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create 'comments' table
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id)
);

-- Create 'likes' table
CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

-- Create 'follows' table
CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followee_id) REFERENCES users(id),
    PRIMARY KEY (follower_id, followee_id)
);

-- Create 'tags' table
CREATE TABLE tags (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create 'photo_tags' table
CREATE TABLE photo_tags (
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id),
    PRIMARY KEY (photo_id, tag_id)
);

-- --- --- SELECT CHALLENGES ---
-- Find the 5 oldest users
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- What day of the week do most users register on?
SELECT COUNT(*) AS reg_count, DAYNAME(created_at) AS day 
FROM users
GROUP BY day
ORDER BY reg_count DESC
LIMIT 1;

-- Find users who have never posted a photo
SELECT username, IFNULL(image_url, 0) AS posted
FROM users
LEFT JOIN photos ON photos.user_id = users.id
WHERE image_url IS NULL
ORDER BY username;

-- Count how many users have never posted a photo
SELECT COUNT(*) AS user_num, IFNULL(image_url, 0) AS posted
FROM users
LEFT JOIN photos ON photos.user_id = users.id
WHERE image_url IS NULL
GROUP BY image_url;

-- Who got the most likes on a single photo
SELECT username, photos.id, COUNT(*) AS likes
FROM photos
JOIN likes ON photos.id = likes.photo_id
JOIN users ON users.id = photos.user_id
GROUP BY username, photos.id
ORDER BY likes DESC
LIMIT 1;

-- Course version
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes ON likes.photo_id = photos.id
INNER JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- How many times does the average user post
SELECT (SELECT Count(*) FROM photos) / (SELECT Count(*) FROM users) AS avg; 

SELECT AVG(posts) AS avg_posts 
FROM (
    SELECT COUNT(photos.id) AS posts 
    FROM users 
    LEFT JOIN photos ON photos.user_id = users.id
    GROUP BY users.id
) AS user_posts;

-- Top 5 most commonly used hashtags
SELECT tags.tag_name, 
       Count(*) AS total 
FROM photo_tags 
JOIN tags ON photo_tags.tag_id = tags.id 
GROUP BY tags.id 
ORDER BY total DESC 
LIMIT 5;

-- Find users who have liked every single photo on the site
SELECT username, COUNT(*) AS likes
FROM users
JOIN likes ON likes.user_id = users.id
GROUP BY username
HAVING likes = (SELECT COUNT(*) FROM photos);