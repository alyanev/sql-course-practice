-- Section 16: Database Triggers

-- --- --- CREATE DATABASE & USE ---
-- Create a new database for trigger demo
CREATE DATABASE trigger_demo;

-- Switch to the 'trigger_demo' database
USE trigger_demo;

-- --- --- CREATE TABLE ---
-- Create a simple 'users' table for demo purposes
CREATE TABLE users (
    username VARCHAR(100),
    age INT
);

-- --- --- USE EXISTING DATABASE ---
-- Switch back to the Instagram clone database
USE ig_clone;

-- Create 'unfollows' table to track unfollow events
CREATE TABLE unfollows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followee_id) REFERENCES users(id),
    PRIMARY KEY (follower_id, followee_id)
);

-- --- --- TRIGGER UTILITIES ---
-- Show all existing triggers
SHOW TRIGGERS;

-- Drop a trigger by name
DROP TRIGGER trigger_name;
