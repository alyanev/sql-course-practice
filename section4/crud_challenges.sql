-- Section 4: CRUD Challenges

-- --- --- CREATE DATABASE & USE ---
-- Create a new database called 'shirts_db'
CREATE DATABASE shirts_db;

-- Switch to the 'shirts_db' database
USE shirts_db;

-- --- --- CREATE TABLE ---
-- Create a 'shirts' table with columns: 'shirt_id', 'article', 'color', 'shirt_size', 'last_worn'
CREATE TABLE shirts (
    shirt_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each shirt
    article VARCHAR(50) NOT NULL,            -- The article of clothing (e.g., t-shirt, polo shirt)
    color VARCHAR(50) NOT NULL,              -- Color of the shirt
    shirt_size VARCHAR(20) NOT NULL,         -- Size of the shirt (e.g., S, M, L)
    last_worn INT NOT NULL                  -- A value indicating when the shirt was last worn (integer value)
);

-- --- --- INSERT INTO ---
-- Insert data into the 'shirts' table
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES
    ('t-shirt', 'white', 'S', 10),
    ('t-shirt', 'green', 'S', 200),
    ('polo shirt', 'black', 'M', 10),
    ('tank top', 'blue', 'S', 50),
    ('t-shirt', 'pink', 'S', 0),
    ('polo shirt', 'red', 'M', 5),
    ('tank top', 'white', 'S', 200),
    ('tank top', 'blue', 'M', 15);

-- Insert additional data into the 'shirts' table
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES
    ('polo shirt', 'purple', 'M', 50);

-- --- --- SELECT ---
-- Retrieve the 'article' and 'color' columns from the 'shirts' table
SELECT article, color FROM shirts;

-- Retrieve all columns for shirts where the 'shirt_size' is 'M'
SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size = 'M';

-- Retrieve all data from the 'shirts' table
SELECT * FROM shirts;

-- --- --- UPDATE ---
-- Update the 'shirt_size' to 'L' for all rows where the 'article' is 'polo shirt'
UPDATE shirts
SET shirt_size = 'L'
WHERE article = 'polo shirt';

-- Set 'last_worn' to 0 for all shirts that were last worn 15 times
UPDATE shirts
SET last_worn = 0
WHERE last_worn = 15;

-- Change 'shirt_size' to 'XS' and 'color' to 'off white' for shirts with 'color' = 'white'
UPDATE shirts
SET shirt_size = 'XS', color = 'off white'
WHERE color = 'white';

-- --- --- DELETE ---
-- Delete shirts where 'last_worn' equals 200
DELETE FROM shirts
WHERE last_worn = 200;

-- Delete shirts where the 'article' is 'tank top'
DELETE FROM shirts
WHERE article = 'tank top';

-- Delete all rows from the 'shirts' table (clear the entire table)
DELETE FROM shirts;

-- Drop the 'shirts' table from the database
DROP TABLE shirts;
