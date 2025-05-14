-- Section 4: CRUD Challenges

-- Create a table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Insert multiple rows
INSERT INTO products (product_name, price)
VALUES
('Laptop', 1200.99),
('Smartphone', 699.99),
('Headphones', 150.50);

-- Select data with WHERE clause
SELECT * FROM products
WHERE price > 500;

-- Update product price
UPDATE products
SET price = 799.99
WHERE product_name = 'Smartphone';

-- Delete a product
DELETE FROM products
WHERE product_name = 'Headphones';
