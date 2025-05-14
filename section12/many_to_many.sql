-- Section 12: Many to Many Relationships

-- Create the database and use it
CREATE DATABASE tv_db;
USE tv_db;

-- Create reviewers table
CREATE TABLE reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Create series table
CREATE TABLE series (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100)
);

-- Create reviews table to establish many-to-many relationship between reviewers and series
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2, 1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
);

-- Insert data into the series table
INSERT INTO series (title, released_year, genre) VALUES
('Archer', 2009, 'Animation'),
('Arrested Development', 2003, 'Comedy'),
("Bob's Burgers", 2011, 'Animation'),
('Bojack Horseman', 2014, 'Animation'),
("Breaking Bad", 2008, 'Drama'),
('Curb Your Enthusiasm', 2000, 'Comedy'),
("Fargo", 2014, 'Drama'),
('Freaks and Geeks', 1999, 'Comedy'),
('General Hospital', 1963, 'Drama'),
('Halt and Catch Fire', 2014, 'Drama'),
('Malcolm In The Middle', 2000, 'Comedy'),
('Pushing Daisies', 2007, 'Comedy'),
('Seinfeld', 1989, 'Comedy'),
('Stranger Things', 2016, 'Drama');

-- Insert data into reviewers table
INSERT INTO reviewers (first_name, last_name) VALUES
('Thomas', 'Stoneman'),
('Wyatt', 'Skaggs'),
('Kimbra', 'Masters'),
('Domingo', 'Cortes'),
('Colt', 'Steele'),
('Pinkie', 'Petit'),
('Marlon', 'Crafford');

-- Insert data into reviews table to associate reviewers with series and ratings
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
(1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
(2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
(3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
(4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
(5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
(6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
(7,2,9.1),(7,5,9.7),
(8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
(9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
(10,5,9.9),
(13,3,8.0),(13,4,7.2),
(14,2,8.5),(14,3,8.9),(14,4,8.9);

-- ======================== CHALLENGES ========================

-- Select the series title and its rating
SELECT title, rating
FROM series
JOIN reviews ON series.id = reviews.series_id
ORDER BY title;

-- Select the series title and average rating, rounded to 1 decimal place
SELECT title, ROUND(AVG(rating), 1) AS avg_rating
FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating;

-- Select reviewer's first and last name along with the rating
SELECT first_name, last_name, rating
FROM reviewers
JOIN reviews ON reviewers.id = reviews.reviewer_id;

-- Select the unreviewed series (those without ratings)
SELECT title AS unreviewed_series
FROM series
LEFT JOIN reviews ON series.id = reviews.series_id
WHERE reviews.rating IS NULL;

-- Select the genre and the average rating of series in each genre
SELECT genre, ROUND(AVG(rating), 1) AS avg_rating
FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY genre;

-- ===================== USING CASE ============================

-- Select the reviewer stats and their status (ACTIVE/INACTIVE based on their reviews)
SELECT first_name, last_name, COUNT(rating) AS count, IFNULL(MIN(rating), 0) AS min, IFNULL(MAX(rating), 0) AS max, IFNULL(ROUND(AVG(rating), 1), 0) AS avg,
    CASE
        WHEN AVG(rating) > 0 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS status
FROM reviewers
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;

-- ===================== USING IF ==============================

-- Select reviewer stats and use IF to assign 'ACTIVE' or 'INACTIVE' based on reviews count
SELECT 
    first_name,
    last_name,
    COUNT(rating) AS count,
    IFNULL(MIN(rating), 0) AS min,
    IFNULL(MAX(rating), 0) AS max,
    ROUND(IFNULL(AVG(rating), 0), 2) AS average,
    IF(COUNT(rating) > 0,
        'ACTIVE',
        'INACTIVE') AS status
FROM
    reviewers
    LEFT JOIN
    reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name , last_name;

-- Join series, reviews, and reviewers to show reviewer name with series title and their rating
SELECT title, rating, CONCAT(first_name, ' ', last_name) AS reviewer
FROM series
JOIN reviews ON reviews.series_id = series.id
JOIN reviewers ON reviews.reviewer_id = reviewers.id
ORDER BY title;

-- ===================== Same Challenges ======================

-- Select the series title and rating, ordered by rating descending
SELECT title, rating FROM series
JOIN reviews ON series.id = reviews.series_id
ORDER BY rating DESC;

-- Select the series title and average rating, rounded to 1 decimal place, ordered by avg_rating
SELECT title, ROUND(AVG(rating), 1) AS avg_rating
FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating;

-- Select reviewer's first name, last name, and rating (rounded to 1 decimal)
SELECT first_name, last_name, ROUND(rating, 1) AS rating
FROM reviewers
JOIN reviews ON reviewers.id = reviews.reviewer_id;

-- Select unreviewed series (series with no ratings in the reviews table)
SELECT title AS unreviewed_series FROM series
LEFT JOIN reviews ON series.id = reviews.series_id
WHERE rating IS NULL;

-- Same query to select unreviewed series using RIGHT JOIN
SELECT title AS unreviewed_series
FROM reviews
RIGHT JOIN series ON series.id = reviews.series_id
WHERE rating IS NULL;

-- Select the genre and the average rating of series by genre
SELECT genre, ROUND(AVG(rating), 2) AS avg_rating
FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY genre;

-- ===================== with CASE ============================

-- Select reviewer stats (count, min, max, avg) with user status based on review count using CASE
SELECT reviewers.first_name, last_name, COUNT(rating) AS count, IFNULL(MIN(rating), 0) AS min, IFNULL(MAX(rating), 0) AS max, IFNULL(AVG(rating), 0) AS avg,
    CASE 
        WHEN COUNT(rating) >= 10 THEN 'POWERUSER'
        WHEN COUNT(rating) > 0 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS status
FROM reviewers 
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;

-- ===================== IF statement instead of CASE =====================

-- Select reviewer stats using IF statement instead of CASE to assign 'ACTIVE' or 'INACTIVE'
SELECT reviewers.first_name, last_name, COUNT(rating) AS count, IFNULL(MIN(rating), 0) AS min, IFNULL(MAX(rating), 0) AS max, IFNULL(AVG(rating), 0) AS avg,
    IF (COUNT(rating) > 0, 'ACTIVE', 'INACTIVE') AS status
FROM reviewers 
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;

-- ===================== Final Challenge =====================

-- Select series title, rating, and reviewer (with concatenated first and last name) ordered by series title
SELECT title, rating, CONCAT(first_name, ' ', last_name) AS reviewer
FROM series
JOIN reviews ON
