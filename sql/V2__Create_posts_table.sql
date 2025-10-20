-- Create posts table
-- Migration: V2
-- Description: Table for storing blog posts with foreign key to users

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    published_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Add indexes for better query performance
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_status ON posts(status);
CREATE INDEX idx_posts_published_at ON posts(published_at);

-- Insert sample posts
INSERT INTO posts (user_id, title, content, status, published_at) VALUES
    (1, 'My First Post', 'This is the content of my first blog post.', 'published', NOW()),
    (1, 'Learning Flyway', 'Flyway makes database migrations easy!', 'draft', NULL),
    (2, 'Hello World', 'Welcome to my blog!', 'published', NOW());
