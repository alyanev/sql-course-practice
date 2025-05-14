-- Section 3: CRUD Basics

-- Create a table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

-- Insert data
INSERT INTO users (first_name, last_name, email)
VALUES ('John', 'Doe', 'john.doe@example.com');

-- Read data
SELECT * FROM users;

-- Update data
UPDATE users
SET first_name = 'Jane'
WHERE id = 1;

-- Delete data
DELETE FROM users
WHERE id = 1;
