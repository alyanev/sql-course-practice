-- Section 7: Aggregate Functions

-- --- --- COUNT --- ---
-- Count total number of books in the database
SELECT COUNT(*) FROM books;

-- Count the number of non-null author first names in the database
SELECT COUNT(author_fname) FROM books;

-- Count distinct author first names in the database
SELECT COUNT(DISTINCT author_fname) FROM books;

-- Count distinct release years in the database
SELECT COUNT(DISTINCT released_year) FROM books;

-- Count the number of books where the title contains 'the'
SELECT COUNT(title) FROM books WHERE title LIKE '%the%';

-- --- --- GROUP BY ---
-- Group books by author last name and count how many books each author has written
SELECT author_lname, COUNT(*) AS books_written
FROM books
GROUP BY author_lname
ORDER BY books_written DESC;

-- Group books by both author first and last names and count books for each combination
SELECT author_fname, author_lname, COUNT(*) AS books_written
FROM books
GROUP BY author_fname, author_lname
ORDER BY books_written DESC;

-- Group by release year and count the number of books released each year
SELECT released_year, COUNT(*) AS released_books
FROM books
GROUP BY released_year
ORDER BY released_books DESC;

-- Group by title and author last name to show how many times a book appears in the table
SELECT author_lname, title FROM books GROUP BY title, author_lname;

-- Group by author last name only
SELECT author_lname FROM books GROUP BY author_lname;

-- --- --- MIN MAX --- ---
-- Find the earliest release year of any book
SELECT MIN(released_year) FROM books;

-- Find the maximum number of pages in any book
SELECT MAX(pages) FROM books;

-- Find the lexicographically first and last author last names
SELECT MIN(author_lname), MAX(author_lname) FROM books;

-- --- --- SUBQUERIES ---
-- Find the title and pages of the longest book
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

-- Find the title of the book with the most pages using a subquery
SELECT title, pages
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

-- Insert a new book for testing purposes
INSERT INTO books (title, pages) VALUES ('test', 634);

-- Find the title of the book released the earliest using a subquery
SELECT title, released_year
FROM books
WHERE released_year = (SELECT MIN(released_year) FROM books);

-- --- --- GROUP BY multiple columns ---
-- Group by both author first and last names to count how many books each author has written
SELECT author_fname, author_lname, COUNT(*) AS books_written
FROM books
GROUP BY author_fname, author_lname
ORDER BY books_written DESC;

-- --- --- MIN MAX WITH GROUP BY ---
-- Group by author and find the earliest and latest book release year, along with the longest book and book count
SELECT author_fname, author_lname, 
       MIN(released_year) AS earliest_book, 
       MAX(released_year) AS latest_book, 
       COUNT(*) AS books_written, 
       MAX(pages) AS longest_book
FROM books
GROUP BY author_fname, author_lname;

-- Find the longest page count for each author
SELECT author_fname, author_lname, MAX(pages)
FROM books
GROUP BY author_fname, author_lname;

-- --- --- SUM --- ---
-- Sum of pages for each author
SELECT author_fname, author_lname, SUM(pages)
FROM books
GROUP BY author_fname, author_lname;

-- --- --- AVG --- --- 
-- Calculate the average release year of all books
SELECT AVG(released_year) FROM books;

-- Calculate the average stock quantity for books released in the same year
SELECT released_year, AVG(stock_quantity)
FROM books
GROUP BY released_year
ORDER BY released_year;

-- --- --- Exercise ---
-- Find the total number of books in the database
SELECT COUNT(*) AS 'number of books' FROM books;

-- Find how many books were released in each year
SELECT released_year, COUNT(*) AS released_books
FROM books
GROUP BY released_year
ORDER BY released_books;

-- Find the total number of books in stock
SELECT SUM(stock_quantity)
FROM books;

-- Find the average release year for each author
SELECT author_fname, author_lname, AVG(released_year)
FROM books
GROUP BY author_fname, author_lname;

-- Find the full name of the author who wrote the longest book
SELECT CONCAT(author_fname, ' ', author_lname) AS author
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

-- Find the full name of the author who wrote the longest book (alternative method)
SELECT CONCAT(author_fname, ' ', author_lname) AS full_name, pages 
FROM books 
WHERE pages = (SELECT MAX(pages) FROM books);

-- Get the number of books released each year and the average number of pages for those books
SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' 
FROM books 
GROUP BY released_year 
ORDER BY released_year;

-- Count how many books were released each year and calculate the average number of pages for those books
SELECT released_year AS year, COUNT(*), AVG(pages) AS 'avg pages'
FROM books
GROUP BY released_year
ORDER BY released_year;
