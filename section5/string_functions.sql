-- Section 5: String Functions

-- Create a table for testing string functions
CREATE TABLE people (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Insert sample data
INSERT INTO people (name)
VALUES ('John Doe'),
       ('Jane Smith'),
       ('Michael Johnson');

-- String functions
-- UPPER case
SELECT UPPER(name) AS upper_name FROM people;

-- LOWER case
SELECT LOWER(name) AS lower_name FROM people;

-- CONCAT (concatenate strings)
SELECT CONCAT(name, ' - ', id) AS full_info FROM people;

-- LENGTH (get string length)
SELECT name, LENGTH(name) AS name_length FROM people;

-- SUBSTRING (extract part of a string)
SELECT SUBSTRING(name, 1, 4) AS name_substring FROM people;
