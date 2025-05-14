-- Section 2: Inserting Data

-- Insert a single row into the cats table
-- This inserts the name 'Blue Steele' and age 5 into the 'cats' table
INSERT INTO cats (name, age)
VALUES ('Blue Steele', 5);

-- Update the breed of a specific cat where the cat_id is 8
UPDATE cats
SET breed = 'Doms'
WHERE cat_id = 8;

-- --- --- Multi Inserts ---
-- Insert multiple rows into the cats table at once
-- This inserts 3 different cats with their names and ages
INSERT INTO cats (name, age)
VALUES 
    ('Meatball', 5), 
    ('Turkey', 1), 
    ('Potato Face', 15);

-- --- --- Exercise ---
-- Create a new table for people with their first name, last name, and age
CREATE TABLE people (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT
);

-- Insert multiple rows into the 'people' table
-- This inserts 5 rows for the Belcher family members with their ages
INSERT INTO people (first_name, last_name, age)
VALUES
    ('Tina', 'Belcher', 13),
    ('Bob', 'Belcher', 42),
    ('Linda', 'Belcher', 47),
    ('Phillip', 'Belcher', 32),
    ('Calvin', 'Belcher', 27);

-- --- --- Working with NULL ---
-- Insert a row into the 'cats' table with no data (NULL values for all fields)
-- This example shows how to insert a row with no data (NULL values)
INSERT INTO cats () VALUES ();

-- Create a new table 'cats2' with NOT NULL constraints for both name and age
CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Insert a row where the 'name' column is given but 'age' column is omitted
-- The 'age' will be NULL by default if not specified
INSERT INTO cats2 (name) VALUES ('Bilbo');

-- --- --- Set DEFAULT Values ---
-- Create a table 'cats3' with default values for name and age
-- If no value is provided for these columns, the default values will be used
CREATE TABLE cats3 (
    name VARCHAR(100) DEFAULT 'unnamed',
    age INT DEFAULT 99
);

-- Insert a row with the default values for both columns (name = 'unnamed', age = 99)
INSERT INTO cats3 (name, age)
VALUES ();

-- Insert a row with explicitly NULL values (ignoring default values)
INSERT INTO cats3 (name, age)
VALUES (NULL, NULL);

-- Create a new table 'cats4' where the columns 'name' and 'age' are NOT NULL
-- The columns have default values of 'unnamed' and 99, respectively
CREATE TABLE cats4 (
    name VARCHAR(100) NOT NULL DEFAULT 'unnamed',
    age INT NOT NULL DEFAULT 99
);

-- Insert a row with default values (since no values are specified for the 'name' and 'age' columns)
INSERT INTO cats4 ()
VALUES ();

-- --- --- Introducing PRIMARY KEY ---
-- Create a table 'unique_cats' with a PRIMARY KEY and AUTO_INCREMENT for the 'cat_id'
CREATE TABLE unique_cats (
    cat_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- --- --- CREATE TABLE / INSERT TABLE Exercise ---
-- Create a table 'employees' with an AUTO_INCREMENT primary key, and various fields
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    age INT NOT NULL,
    current_status VARCHAR(20) NOT NULL DEFAULT 'employed'
);
