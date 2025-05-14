-- Section 5: String Functions

-- --- --- USE & DROP TABLE ---
-- Select the 'book_shop' database
USE book_shop;

-- Drop the 'books' table if it exists (useful for resetting before importing data)
DROP TABLE books;

-- Import data from an external SQL file
source C:/Program Files/MySQL/book_data.sql;

-- --- --- CONCAT ---
-- Concatenate first and last names of authors with a space between them
SELECT CONCAT(author_fname, ' ', author_lname) AS author FROM books;

-- Concatenate first and last names with a space separator (CONCAT_WS stands for Concatenate With Separator)
SELECT CONCAT_WS(' ', author_fname, author_lname) AS author FROM books;

-- Concatenate title, first name, and last name of author with a space separator
SELECT CONCAT_WS(' ', title, author_fname, author_lname) AS author FROM books;

-- --- --- SUBSTRING ---
-- Extract part of a string starting from position 1 and taking the first 5 characters
SELECT SUBSTR('Hello World', 1, 5);

-- Extract substring starting from position 7 to the end
SELECT SUBSTR('Hello World', 7);

-- Extract substring starting from position 5 to the end
SELECT SUBSTR('Hello World', 5);

-- Extract substring from the end of the string
SELECT SUBSTR('Hello World', -1);

-- Extract one character from the end of the string
SELECT SUBSTR('Hello World', -2, 1);

-- Extract the first 15 characters of the book title
SELECT SUBSTR(title, 1, 15) FROM books;

-- Extract the first letter of the author's last name
SELECT SUBSTR(author_lname, 1, 1) AS initial, author_lname FROM books;

-- --- --- Combining String Functions ---
-- Create a short title by extracting the first 10 characters and adding '...'
SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS short_title FROM books;

-- Create initials by combining first letters from first and last names of authors
SELECT CONCAT(SUBSTR(author_fname, 1, 1), '.', SUBSTR(author_lname, 1, 1), '.') AS initials FROM books;

-- --- --- REPLACE ---
-- Replace all spaces with 'and' in a string
SELECT REPLACE('cheese bread coffee milk', ' ', ' and ');

-- Replace spaces with slashes in book titles
SELECT REPLACE(title, ' ', '/') FROM books;

-- Replace 'e ' with '3' in book titles
SELECT REPLACE(title, 'e ', '3') FROM books;

-- --- --- REVERSE ---
-- Reverse the string 'Hello world'
SELECT REVERSE('Hello world');

-- Reverse the author's first name
SELECT REVERSE(author_fname) FROM books;

-- Create a palindrome by concatenating 'Александър' with its reversed version
SELECT CONCAT('Александър', REVERSE('Александър')) AS palindrom;

-- Concatenate author's first name with its reversed version
SELECT CONCAT(author_fname, REVERSE(author_fname)) FROM books;

-- --- --- CHAR_LENGTH ---
-- Find the character length of the book title
SELECT CHAR_LENGTH(title) AS length, title FROM books;

-- --- --- UPPER LOWER ---
-- Convert a string to uppercase
SELECT UPPER('Hello world');

-- Convert a string to lowercase
SELECT LOWER('Hello world');

-- Convert book titles to uppercase
SELECT UPPER(title) FROM books;

-- Concatenate the phrase with an uppercase version of the book title
SELECT CONCAT('MY FAVORITE BOOK IS ', UPPER(title)) FROM books;

-- Concatenate the phrase with a lowercase version of the book title
SELECT CONCAT('MY FAVORITE BOOK IS ', LOWER(title)) FROM books;

-- --- --- Other String Functions ---
-- Insert a string at the beginning of the book title
SELECT INSERT(title, 1, 0, ' Inserting from the begining') FROM books;

-- Extract the leftmost 3 characters from a string
SELECT LEFT('omghahalol!', 3);

-- Extract the rightmost 4 characters from a string
SELECT RIGHT('omghahalol!', 4);

-- Repeat a string 4 times
SELECT REPEAT('ha', 4);

-- Trim spaces from both sides of a string
SELECT TRIM('  pickle  ');

-- --- --- Exercise ---
-- Reverse and convert to uppercase a string
SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?'));

-- Replace spaces with '-' in the sentence 'I like dogs'
SELECT REPLACE(CONCAT('I', ' ', 'like', ' ', 'dogs'), ' ', '-');

-- Replace spaces with '->' in book titles
SELECT REPLACE(title, ' ', '->') AS title FROM books;

-- Show last name forwards and backwards
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

-- Concatenate uppercase first and last name of authors
SELECT CONCAT(UPPER(author_fname), ' ', UPPER(author_lname)) AS 'full name in caps' FROM books;

-- Create a book blurb with title and release year
SELECT CONCAT(title, ' was released in ', released_year) AS blurb FROM books;

-- Show character count for each book title
SELECT title, CHAR_LENGTH(title) AS 'character count' FROM books;

-- Create a short title, author information, and quantity in stock
SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title',
       CONCAT(author_lname, ',', author_fname) AS author,
       CONCAT(stock_quantity, ' in stock') AS quantity
FROM books;
