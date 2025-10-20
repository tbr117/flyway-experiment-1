-- Create users table
-- Migration: V1
-- Description: Initial table for storing user information

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Add index for faster email lookups
CREATE INDEX idx_users_email ON users(email);

-- Insert some sample data
INSERT INTO users (username, email, first_name, last_name) VALUES
    ('johndoe', 'john.doe@example.com', 'John', 'Doe'),
    ('janedoe', 'jane.doe@example.com', 'Jane', 'Doe');
