-- Add roles and permissions system
-- Migration: V3
-- Description: Extends the schema with role-based access control

-- Add role column to users table
ALTER TABLE users 
ADD COLUMN role ENUM('admin', 'editor', 'viewer') DEFAULT 'viewer' AFTER email;

-- Create roles table for more flexible role management
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create permissions table
CREATE TABLE permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create role_permissions junction table
CREATE TABLE role_permissions (
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
);

-- Insert default roles
INSERT INTO roles (name, description) VALUES
    ('admin', 'Full system access'),
    ('editor', 'Can create and edit content'),
    ('viewer', 'Read-only access');

-- Insert default permissions
INSERT INTO permissions (name, description) VALUES
    ('create_post', 'Can create new posts'),
    ('edit_post', 'Can edit posts'),
    ('delete_post', 'Can delete posts'),
    ('view_post', 'Can view posts'),
    ('manage_users', 'Can manage user accounts');

-- Assign permissions to roles
INSERT INTO role_permissions (role_id, permission_id) VALUES
    -- Admin gets all permissions
    (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
    -- Editor gets create, edit, and view
    (2, 1), (2, 2), (2, 4),
    -- Viewer gets only view
    (3, 4);

-- Update existing users with appropriate roles
UPDATE users SET role = 'admin' WHERE username = 'johndoe';
UPDATE users SET role = 'editor' WHERE username = 'janedoe';
