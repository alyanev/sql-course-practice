-- Section 9: Comparison & Logical Operators

-- --- --- Basic Comparison Operators --- ---
-- Select books where the released year is not 2017
SELECT * FROM books WHERE released_year != 2017;

-- Select books where the title does not contain the letter 'e'
SELECT * FROM books WHERE title NOT LIKE '%e%';

-- Select books released after 2005
SELECT * FROM books WHERE released_year > 2005;

-- Select books with more than 500 pages
SELECT * FROM books WHERE pages > 500;

-- Select books with fewer than 200 pages
SELECT * FROM books WHERE pages < 200;

-- Select books released before 2000
SELECT * FROM books WHERE released_year < 2000;

-- Select books released in or before 1985
SELECT * FROM books WHERE released_year <= 1985;

-- --- --- Logical AND --- ---
-- Select books where the author's first name starts with 'Dave' and last name contains 'Egg'
SELECT title FROM books WHERE author_fname LIKE '&Dave%' AND author_lname LIKE '%Egg%';

-- Select books by 'Eggers' released after 2010
SELECT title, author_lname, released_year FROM books
WHERE released_year > 2010 AND author_lname = 'Eggers';

-- Select books by 'Eggers' released after 2010 and that contain 'novel' in the title
SELECT title, author_lname, released_year FROM books
WHERE released_year > 2010 AND author_lname = 'Eggers' AND title LIKE '%novel%';

-- --- --- Logical OR --- ---
-- Select books with a title length greater than 30 characters and more than 500 pages
SELECT title, pages FROM books 
WHERE CHAR_LENGTH(title) > 30 AND pages > 500;

-- Select books by 'Eggers' released after 2010
SELECT title, author_lname FROM books
WHERE author_lname = 'Eggers' AND released_year > 2010;

-- Select books by 'Eggers' or books released after 2010
SELECT title, author_lname, released_year FROM books
WHERE author_lname = 'Eggers' OR released_year > 2010;

-- Select books with fewer than 200 pages or titles containing 'stories'
SELECT title, pages FROM books
WHERE pages < 200 OR title LIKE '%stories%';

-- --- --- BETWEEN --- ---
-- Select books released between 2004 and 2015 (inclusive)
SELECT title, released_year FROM books
WHERE released_year <= 2015 AND released_year >= 2004;

-- Select books released between 2004 and 2014 (inclusive) using BETWEEN
SELECT title, released_year FROM books
WHERE released_year BETWEEN 2004 AND 2014;

-- --- --- Comparing Dates --- ---
-- Select people born before 2005
SELECT * FROM people WHERE YEAR(birthdate) < 2005;

-- Select people whose birthtime is between 12:00:00 and 16:00:00
SELECT * FROM people WHERE birthtime BETWEEN CAST('12:00:00' AS TIME) AND CAST('16:00:00' AS TIME);

-- Select people whose birthtime is between 12:00:00 and 16:00:00 using HOUR function
SELECT * FROM people WHERE HOUR(birthtime) BETWEEN 12 AND 16;

-- --- --- The IN Operator --- ---
-- Select books by specific authors (Carver, Lahiri, Smith)
SELECT title, author_lname FROM books
WHERE author_lname = 'Carver' OR author_lname = 'Lahiri' OR author_lname = 'Smith';

-- Select books by authors Carver, Lahiri, or Smith using IN
SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

-- Select books not by authors Carver, Lahiri, or Smith using NOT IN
SELECT title, author_lname FROM books
WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');

-- Select books released after 2000 with odd years using modulus operator
SELECT title, released_year FROM books
WHERE released_year >= 2000 AND released_year % 2 = 1;

-- Select books by authors Carver or Lahiri
SELECT title, author_lname FROM books 
WHERE author_lname IN ('Carver', 'Lahiri');

-- --- --- CASE Statements --- ---
-- Add a genre column based on the release year of the book
SELECT title, released_year,
    CASE
        WHEN released_year >= 2000 THEN 'modern lit'
        ELSE '20th century lit'
    END AS genre
FROM books;

-- Add a stock rating based on stock quantity
SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
        WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
        WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
        WHEN stock_quantity BETWEEN 101 AND 140 THEN '****'
        ELSE '*****'
    END AS stock
FROM books;

-- Another version of stock rating based on stock quantity ranges
SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity <= 40 THEN '*'
        WHEN stock_quantity <= 70 THEN '**'
        WHEN stock_quantity <= 100 THEN '***'
        WHEN stock_quantity <= 140 THEN '****'
        ELSE '*****'
    END AS stock
FROM books;

-- --- --- IS NULL --- ---
-- Select books where the released year is NULL
SELECT * FROM books WHERE released_year IS NULL;

-- Delete books where the released year is NULL
DELETE FROM books WHERE released_year IS NULL;

-- --- --- EXERCISE --- ---
-- Select books released before 1980
SELECT * FROM books WHERE released_year < 1980;

-- Select books by authors 'Eggers' or 'Chabon'
SELECT * FROM books WHERE author_lname = 'Eggers' OR author_lname = 'Chabon';

-- Select books by 'Lahiri' released after 2000
SELECT * FROM books WHERE author_lname = 'Lahiri' AND released_year > 2000;

-- Select books with page count between 100 and 200
SELECT * FROM books WHERE pages BETWEEN 100 AND 200;

-- Select books where author's last name starts with 'C' or 'S'
SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

-- Select books where the first letter of author's last name is 'C' or 'S'
SELECT * FROM books WHERE SUBSTR(author_lname, 1, 1) IN ('C', 'S');
SELECT * FROM books WHERE LEFT(author_lname, 1) IN ('C', 'S');

-- Categorize books by type (Short Stories, Memoir, or Novel)
SELECT title, author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title LIKE '%Just Kids' OR title LIKE '%A Heartbreaking%' THEN 'Memoir'
        ELSE 'Novel'
    END AS TYPE
FROM books;

-- --- --- Bonus --- ---
-- Count the number of books for each author and format as "X books" or "1 book"
SELECT author_fname, author_lname,
    CASE 
        WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
        ELSE CONCAT(COUNT(*), ' book')
    END AS COUNT
FROM books
GROUP BY author_fname, author_lname;

-- Count the number of books for each author where author's last name is not NULL
SELECT author_fname, author_lname,
    CASE 
        WHEN COUNT(*) = 1 THEN '1 book'
        ELSE CONCAT(COUNT(*), ' books')
    END AS count
FROM books
WHERE author_lname IS NOT NULL
GROUP BY author_fname, author_lname;

-- Get number of books and average pages by release year
SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages'
FROM books
GROUP BY released_year
ORDER BY released_year;
