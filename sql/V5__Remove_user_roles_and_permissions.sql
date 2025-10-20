-- Remove roles and permissions system
-- Migration: V5
-- Description: Undoes V3 by removing the RBAC system and role column from users

-- Drop junction table first (has foreign key constraints)
DROP TABLE IF EXISTS role_permissions;

-- Drop permissions table
DROP TABLE IF EXISTS permissions;

-- Drop roles table
DROP TABLE IF EXISTS roles;

-- Remove the role column from users table
-- This reverses the ALTER TABLE from V3
ALTER TABLE users DROP COLUMN role;

-- Note: This migration demonstrates how to "undo" a previous migration
-- by creating a new forward migration that reverses the changes.
-- This is the recommended approach in Flyway OSS Edition.
