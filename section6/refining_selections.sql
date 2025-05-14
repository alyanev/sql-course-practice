-- Section 6: Refining Selections

-- --- --- INSERT INTO --- 
-- Inserting multiple books into the 'books' table
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES 
    ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
    ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
    ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

-- --- --- DISTINCT ---
-- Select distinct author last names (removes duplicates)
SELECT DISTINCT author_lname FROM books;

-- Select distinct release years from the books
SELECT DISTINCT released_year FROM books;

-- Select distinct full author names
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books;

-- Select distinct first and last author names
SELECT DISTINCT author_fname, author_lname FROM books;

-- --- --- ORDER BY ---
-- Select all books ordered by author last name (ascending)
SELECT * FROM books ORDER BY author_lname;

-- Select all books ordered by author last name (descending)
SELECT * FROM books ORDER BY author_lname DESC;

-- Select all books ordered by released year (ascending)
SELECT * FROM books ORDER BY released_year;

-- Select specific columns, ordered by the third column (pages)
SELECT title, author_fname, author_lname, pages FROM books ORDER BY 3;

-- Select books ordered by author last name and then first name
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY author_lname, author_fname;

-- --- --- LIMIT ---
-- Select first 3 book titles
SELECT title FROM books LIMIT 3;

-- Select the first book title
SELECT title FROM books LIMIT 1;

-- Select first 10 book titles
SELECT title FROM books LIMIT 10;

-- Select all details of the first book
SELECT * FROM books LIMIT 1;

-- Select the top 5 books ordered by released year (descending)
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 5;

-- Select the most recent book
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 1;

-- Select top 14 books ordered by released year (descending)
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 14;

-- Select first 5 books starting from position 0
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 0,5;

-- Select first 3 books starting from position 0
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 0,3;

-- Select 3 books starting from position 1
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 1,3;

-- Select a specific book (21st) by its released year in descending order
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 21,1;

-- --- --- LIKE ---
-- Select books where author's first name contains 'da'
SELECT title, author_fname, author_lname, pages FROM books WHERE author_fname LIKE '%da%';

-- Select books where title contains a colon ':'
SELECT title, author_fname, author_lname, pages FROM books WHERE title LIKE '%:%';

-- Select books where author's first name has exactly 4 characters
SELECT * FROM books WHERE author_fname LIKE '____';

-- Select books where author's first name ends with 'n' (exactly 2 characters before 'n')
SELECT * FROM books WHERE author_fname LIKE '__n';

-- Select books where author's first name has 'a' as the second character
SELECT * FROM books WHERE author_fname LIKE '_a_';

-- Select books where the title contains a literal '%' character (escaped)
SELECT * FROM books WHERE title LIKE '%\%%';

-- --- --- Exercise ---
-- Select books where the title contains 'stories'
SELECT title FROM books WHERE title LIKE '%stories%';

-- Select the book with the most pages
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

-- Create a summary with the title and release year, ordered by released year, limited to the top 3
SELECT CONCAT(title, ' -
