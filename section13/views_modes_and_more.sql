============================ SECTION 13 Views, Modes & More! ============================

--- --- Basic Views ---

-- Select data from tables using JOIN:
SELECT title, released_year, genre, rating, first_name, last_name
FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

-- Create a view that contains the same information:
CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name
FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

--- --- Update Views ---

-- Display the content of the view:
SELECT * FROM full_reviews;

-- Create a new view with series ordered by release year:
CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

-- Replace the view to show series ordered by release year in descending order:
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;

-- Alter the view to order by release year in ascending order again:
ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

-- Drop the view:
DROP VIEW ordered_series;

--- --- GROUP BY & HAVING ---

-- Use GROUP BY to group results and calculate average ratings:
SELECT title, AVG(rating) FROM full_reviews GROUP BY title;

-- Add HAVING to filter results with more than one review:
SELECT title, AVG(rating), COUNT(rating) AS review_count
FROM full_reviews
GROUP BY title HAVING COUNT(rating) > 1;

--- --- GROUP BY with ROLLUP ---

-- Generate summary statistics using ROLLUP:
SELECT title, AVG(rating)
FROM full_reviews
GROUP BY title WITH ROLLUP;

-- Count the number of reviews with ROLLUP:
SELECT title, COUNT(rating)
FROM full_reviews
GROUP BY title WITH ROLLUP;

-- Perform grouping by multiple columns and add ROLLUP:
SELECT first_name, released_year, genre, AVG(rating)
FROM full_reviews
GROUP BY released_year, genre, first_name WITH ROLLUP;

--- --- SQL Modes ---

-- Show the current global SQL mode:
SELECT @@GLOBAL.sql_mode;

-- Show the current session's SQL mode:
SELECT @@SESSION.sql_mode;

-- Set the session's SQL mode:
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Modify the session's SQL mode with additional settings:
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
