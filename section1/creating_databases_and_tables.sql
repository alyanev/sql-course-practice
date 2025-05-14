-- Section 1: Creating Databases & Tables

-- Create a new table
CREATE TABLE pet_shop (
    username VARCHAR(15),
    content VARCHAR(140),
    favorites INT
);

-- Show columns of a table
SHOW COLUMNS FROM pet_shop;

-- Create another table
CREATE TABLE pastries (
    name VARCHAR(50),
    quantity INT
);

-- Describe table structure
DESC pastries;

-- Drop the table
DROP TABLE pastries;
