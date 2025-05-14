-- Section 11: One-To-Many & Joins Relationship

-- --- --- Relationships Basics --- ---
-- --- --- One to Many Relationship --- ---
-- 1. What we want to store?
-- 2. How do we store (represent) it?

-- --- --- Working with FOREIGN KEY --- ---
-- Create customers table with a primary key 'id'
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

-- Create orders table with a foreign key 'customer_id' referencing 'customers(id)'
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Insert customers
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

-- Insert orders with customer references
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

-- --- --- Cross Joins --- ---
-- Query to find all customers with last name 'George'
SELECT id FROM customers WHERE last_name = 'George';

-- Query to find all orders for the customer with id = 1
SELECT * FROM orders WHERE customer_id = 1;

-- Using subquery to fetch orders for customer with last name 'George'
SELECT * FROM orders 
WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George');

-- Perform a cross join (not recommended in most real-world cases)
SELECT * FROM customers, orders;

-- --- --- INNER JOINS --- ---
-- Our first inner join: Join customers with their orders
SELECT * FROM customers
JOIN orders ON orders.customer_id = customers.id;

-- Select first name, last name, order date, and amount using inner join
SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders ON orders.customer_id = customers.id;

-- Query showing inner join condition (should show no result as condition is incorrect)
SELECT * FROM customers
JOIN orders ON customers.id = orders.customer_id
WHERE customers.id = orders.id;

-- --- --- INNER JOINS with GROUP BY --- ---
-- Grouping by customer name and summing their orders' amounts
SELECT first_name, last_name, SUM(amount) AS total 
FROM customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY customers.first_name, customers.last_name
ORDER BY total;

-- --- --- LEFT JOIN --- ---
-- LEFT JOIN returns all customers, even if they have no orders
SELECT first_name, last_name, order_date, amount FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id;

-- LEFT JOIN with reversed order of tables (still returns all customers)
SELECT order_date, amount, first_name, last_name FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

-- --- LEFT JOIN with GROUP BY --- ---
-- Use LEFT JOIN and GROUP BY to calculate total order amounts for each customer
SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS total
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name, last_name;

-- --- RIGHT JOIN with GROUP BY --- ---
-- Using RIGHT JOIN to calculate total order amounts (showing customers who have orders)
SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS total
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name, last_name;

-- --- --- On Delete Cascade --- ---
-- Create customers table with 'id' as primary key
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

-- Create orders table with a foreign key that references customers with ON DELETE CASCADE
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Insert customers with sample data
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

-- Insert orders associated with customers
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

-- --- --- Exercise --- ---
-- Create a students table
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100)
);

-- Create a papers table where each paper is associated with a student (on delete cascade)
CREATE TABLE papers (
    title VARCHAR(255) NOT NULL,
    grade TINYINT,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Insert sample student data
INSERT INTO students (first_name) 
VALUES ('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

-- Insert papers with corresponding student IDs
INSERT INTO papers (student_id, title, grade) 
VALUES 
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

-- Select first name, title, and grade from students and papers, sorted by grade
SELECT first_name, title, grade
FROM students
JOIN papers ON students.id = papers.student_id
ORDER BY grade DESC;

-- Select first name, title, and grade, but replace NULLs with 'MISSING' for titles and 0 for grades
SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0)
FROM students
LEFT JOIN papers ON students.id = papers.student_id
ORDER BY grade DESC;

-- Calculate the average grade for each student, replacing NULLs with 0
SELECT first_name, IFNULL(AVG(grade), 0) AS average
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC;

-- Add a passing status based on average grade (>= 70 for passing)
SELECT first_name, IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN AVG(grade) >= 70 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC;
