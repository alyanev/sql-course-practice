-- Section 8: Revisiting Data Types

-- --- --- Dates & Times --- ---
-- Create a table for storing people's birthdates, birthtimes, and datetime
CREATE TABLE people (
    name VARCHAR(100),
    birthdate DATE, 
    birthtime TIME,
    birthdt DATETIME
);

-- Insert data into the people table
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES 
    ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00'),
    ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10'),
    ('Elton', '2020-08-15', '23:59:00', '2020-08-15 23:59:00'),
    ('Hazel', CURDATE(), CURTIME(), NOW());

-- Select different parts of the birthdt column
SELECT 
    birthdt,
    MONTHNAME(birthdt), -- Full month name
    DAYNAME(birthdt),   -- Full day name
    HOUR(birthdt),      -- Hour
    MINUTE(birthdt),    -- Minute
    SECOND(birthdt)     -- Second
FROM people;

-- --- --- CURDATE & CURTIME & NOW() / CURRENT_TIMESTAMP --- ---
-- Show current time, date, and timestamp
SELECT CURTIME(); -- Current time
SELECT CURDATE(); -- Current date
SELECT NOW();     -- Current timestamp

-- Insert a new person with current date and time
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

-- --- --- Date Functions --- ---
-- Extract day, week day, day of the year, month name, and day name from birthdate
SELECT birthdate, 
       DAY(birthdate), 
       DAYOFWEEK(birthdate), 
       DAYOFYEAR(birthdate), 
       MONTHNAME(birthdate), 
       DAYNAME(birthdate) 
FROM people;

-- --- --- Time Functions --- ---
-- Extract hour and minute from birthtime
SELECT name, birthtime, 
       HOUR(birthtime), 
       MINUTE(birthtime) 
FROM people;

-- Extract specific parts of the datetime column (birthdt)
SELECT 
    birthdt,
    MONTH(birthdt), 
    DAY(birthdt), 
    HOUR(birthdt), 
    MINUTE(birthdt)
FROM people;

-- --- --- DATE_FORMAT --- ---
-- Format the birthdate and birthdt column using various formats
SELECT birthdate, DATE_FORMAT(birthdt, '%a %b %c %p %W %D') FROM people;
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;

-- --- --- Date Math --- ---
-- (No example provided here, but you can do things like adding/subtracting dates using INTERVAL)
-- Example: Add 1 day to current date
SELECT CURDATE() + INTERVAL 1 DAY;

-- --- --- TIMESTAMP --- ---
-- Create table for captions with created_at and updated_at timestamps
CREATE TABLE captions (
    text VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert a caption into the captions table
INSERT INTO captions (text)
VALUES ('some test text here');

-- Create another table for captions with similar timestamp behavior
CREATE TABLE captions2 (
    text VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert a caption into the second captions table
INSERT INTO captions2 (text)
VALUES ('i love life!');

-- --- --- Exercise --- ---
-- Create an inventory table
CREATE TABLE inventory (
    item_name VARCHAR(255) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    quantity INT NOT NULL
);

-- Show current time and date in various formats
SELECT CURTIME();
SELECT CURDATE();
SELECT DAYOFWEEK(CURDATE());  -- Get the day of the week
SELECT DAYNAME(CURDATE());    -- Get the full name of the current day
SELECT CURRENT_TIMESTAMP();   -- Show current timestamp

-- Format current timestamp as mm/dd/yyyy
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');

-- Format current timestamp as "Month Day at Hour:Minute"
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i') AS 'Current DateTime';

-- Create a tweets table with timestamp for tweet creation
CREATE TABLE tweets (
    content VARCHAR(255) NOT NULL,
    username VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert a tweet into the tweets table
INSERT INTO tweets (content, username) VALUES ('this is my first tweet', 'coltscat');

-- Select all tweets
SELECT * FROM tweets;

-- Insert another tweet
INSERT INTO tweets (content, username) VALUES ('this is my second tweet', 'coltscat');
SELECT * FROM tweets;
