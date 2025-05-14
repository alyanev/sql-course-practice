-- Section 10: Constraints & ALTER TABLE

-- --- --- UNIQUE CONSTRAINT --- ---
-- Create a table contacts with a unique phone number
CREATE TABLE contacts (
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

-- Insert a contact
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');

-- This insert would result in an error due to the UNIQUE constraint
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');

-- --- --- CHECK CONSTRAINT --- ---
-- Create a table for users where age must be positive
CREATE TABLE users (
    username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);

-- Create a table for palindromes, where the word must be the same forwards and backwards
CREATE TABLE palindromes (
    word VARCHAR(100) CHECK(REVERSE(word) = word)
);

-- --- --- NAMED CONSTRAINT --- ---
-- Create a users table with a named check constraint on the age column
CREATE TABLE users2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);

-- Create a palindromes table with a named check constraint on the word column
CREATE TABLE palindromes2 (
    word VARCHAR(100),
    CONSTRAINT word_is_palindrome CHECK(REVERSE(word) = word)
);

-- --- --- Multiple COLUMN CONSTRAINT --- ---
-- Create a companies table with a unique constraint on a combination of name and address
CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);

-- Create a houses table with a check constraint that sale price must be greater than or equal to purchase price
CREATE TABLE houses (
    purchase_price INT NOT NULL,
    sale_price INT NOT NULL,
    CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price)
);

-- --- --- ALTER TABLE ADD COLUMNS --- ---
-- Add a phone column to the companies table
ALTER TABLE companies 
ADD COLUMN phone VARCHAR(15);

-- Add an employee_count column to the companies table, with a default value of 1
ALTER TABLE companies
ADD COLUMN employee_count INT NOT NULL DEFAULT 1;

-- --- --- ALTER TABLE DROP COLUMNS --- ---
-- Drop the phone column from the companies table
ALTER TABLE companies DROP COLUMN phone;

-- --- --- ALTER TABLE RENAME --- ---
-- Rename the companies table to suppliers
RENAME TABLE companies TO suppliers;

-- Rename the suppliers table back to companies
ALTER TABLE suppliers RENAME TO companies;

-- Rename the name column to company_name in the companies table
ALTER TABLE companies
RENAME COLUMN name TO company_name;

-- --- --- ALTER TABLE Modifying Columns --- ---
-- Modify the company_name column to have a default value of 'unknown'
ALTER TABLE companies
MODIFY company_name VARCHAR(100) DEFAULT 'unknown';

-- Change the column 'business' to 'biz_name' in the suppliers table
ALTER TABLE suppliers
CHANGE business biz_name VARCHAR(50);

-- --- --- ALTER TABLE Constraints --- ---
-- Add a check constraint for purchase price in the houses table
ALTER TABLE houses 
ADD CONSTRAINT positive_pprice CHECK (purchase_price >= 0);

-- Drop the check constraint for positive purchase price from the houses table
ALTER TABLE houses DROP CONSTRAINT positive_pprice;

-- --- --- SHOW CREATE TABLE --- ---
-- Display the CREATE TABLE statement for the houses table
SHOW CREATE TABLE houses;
