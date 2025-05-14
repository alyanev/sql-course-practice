-- Section 2: Inserting Data

-- Insert a single record
INSERT INTO cats (name, age)
VALUES ('Blue Steele', 5);

-- Update data in the table
UPDATE cats
SET breed = 'Doms'
WHERE cat_id = 8;

-- Multi-row insert
INSERT INTO cats (name, age) 
VALUES 
  ('Meatball', 5), 
  ('Turkey', 1), 
  ('Potato Face', 15);
