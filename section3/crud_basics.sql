-- Section 3: CRUD Basics

-- --- --- SELECT ---
-- Retrieve all columns from the 'cats' table
SELECT * FROM cats;

-- Retrieve only the 'age' column from the 'cats' table
SELECT age FROM cats;

-- Retrieve 'name' and 'breed' columns from the 'cats' table
SELECT name, breed FROM cats;

-- --- --- WHERE clause ---
-- Retrieve all rows where the 'age' is 4
SELECT * FROM cats WHERE age = 4;

-- Retrieve the 'name' of cats where the 'age' is 4
SELECT name FROM cats WHERE age = 4;

-- Retrieve all rows where the 'name' is exactly 'EgG'
SELECT * FROM cats WHERE name = 'EgG';

-- --- --- Exercise ---
-- Retrieve 'name' and 'breed' columns from 'cats' table
SELECT name, breed FROM cats;

-- Retrieve 'name' and 'age' of cats where breed contains 'tab'
SELECT name, age FROM cats WHERE breed LIKE '%tab%';

-- Retrieve 'name' and 'age' of cats where breed is exactly 'tabby'
SELECT name, age FROM cats WHERE breed = 'tabby';

-- Retrieve 'cat_id' and 'age' where 'cat_id' is equal to 'age'
SELECT cat_id, age FROM cats WHERE cat_id = age;

-- --- --- Aliases ---
-- Retrieve 'cat_id' as 'id' and 'name' as 'KittyName' using aliases
SELECT cat_id AS id, name AS KittyName FROM cats;

-- --- --- UPDATE ---
-- Update the 'last_name' of all employees to 'Yanev'
UPDATE employees SET last_name = 'Yanev';

-- Update the 'current_status' to 'laid_off' and 'last_name' to 'Yanef' for all employees
UPDATE employees SET current_status = 'laid_off', last_name = 'Yanef';

-- Update cats' breed from 'Tabby' to 'Shorthair' where breed is 'Tabby'
UPDATE cats SET breed = 'Shorthair' WHERE breed = 'Tabby';

-- Update the age and breed of the cat named 'Misty' to 14 and 'Cocker', respectively
UPDATE cats SET age = 14, breed = 'Cocker' WHERE name = 'Misty';

-- --- --- Try SELECT before UPDATE ---
-- (Try to SELECT data before performing an UPDATE operation for comparison)

-- --- --- Exercise ---
-- Update the name of the cat from 'Jackson' to 'Jack'
UPDATE cats SET name = 'Jack' WHERE name = 'Jackson';

-- Update the breed of the cat named 'Ringo' to 'British Shorthair'
UPDATE cats SET breed = 'British Shorthair' WHERE name = 'Ringo';

-- Update the age of all cats where the breed contains 'Maine' to 14
UPDATE cats SET age = 14 WHERE breed LIKE '%Maine%';

-- Verify the update by selecting all cats where breed contains 'Maine'
SELECT * FROM cats WHERE breed LIKE '%Maine%';

-- --- --- DELETE ---
-- Delete the cat where the name is 'Egg'
DELETE FROM cats WHERE name = 'Egg';

-- Delete all rows from the 'cats' table (clearing the entire table)
DELETE FROM cats;

-- --- --- Exercise ---
-- Retrieve all rows from the 'cats' table before deletion
SELECT * FROM cats;

-- Delete all cats where the 'age' is 4
DELETE FROM cats WHERE age = 4;

-- Delete cats where the 'cat_id' is equal to 'age'
DELETE FROM cats WHERE cat_id = age;

-- Delete all rows from the 'cats' table (clearing the entire table)
DELETE FROM cats;
