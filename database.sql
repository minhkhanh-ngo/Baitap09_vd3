USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'BAITAP09_WEB')
BEGIN
    ALTER DATABASE BAITAP09_WEB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BAITAP09_WEB;
END
GO

CREATE DATABASE BAITAP09_WEB;
GO

USE BAITAP09_WEB;
GO

CREATE TABLE roles (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);
GO

CREATE TABLE users (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name NVARCHAR(500),
    enabled BIT NOT NULL DEFAULT 0,
    role_id BIGINT NOT NULL,

    CONSTRAINT FK_users_roles
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
);
GO

CREATE INDEX idx_users_username
ON users(username);
GO

CREATE INDEX idx_users_email
ON users(email);
GO

CREATE TABLE otp_tokens (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(150) NOT NULL,
    otp_hash VARCHAR(100) NOT NULL,
    type VARCHAR(30) NOT NULL,
    expires_at DATETIME2 NOT NULL,
    attempts INT NOT NULL DEFAULT 0,
    used BIT NOT NULL DEFAULT 0,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO

CREATE INDEX idx_otp_email_type
ON otp_tokens(email, type);
GO

CREATE TABLE products (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(500) NOT NULL,
    description NVARCHAR(500),
    price DECIMAL(18,2) NOT NULL,
    image_url VARCHAR(1000),
    user_id BIGINT NOT NULL,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_products_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);
GO

CREATE INDEX idx_products_name
ON products(name);
GO


INSERT INTO roles (name)
VALUES
('USER'),
('ADMIN');
GO


INSERT INTO users
(username, email, password, full_name, enabled, role_id)
VALUES
(
    'admin',
    'admin@gmail.com',
    '$2a$10$1WnI1u6jE5F7y8t1g3wH2.vS5s9k3xK7bZ5qL1nZ8tW4vY2xK2lW6',
    N'Quản Trị Viên',
    1,
    2
),
(
    'khanh',
    'khanh@gmail.com',
    '$2a$10$1WnI1u6jE5F7y8t1g3wH2.vS5s9k3xK7bZ5qL1nZ8tW4vY2xK2lW6',
    N'Ngô Minh Khánh',
    1,
    1
),
(
    'nguyen',
    'nguyen@gmail.com',
    '$2a$10$1WnI1u6jE5F7y8t1g3wH2.vS5s9k3xK7bZ5qL1nZ8tW4vY2xK2lW6',
    N'Nguyễn Văn An',
    1,
    1
);
GO


INSERT INTO products
(name, description, price, image_url, user_id, created_at)
VALUES
(
    N'Laptop Gaming ASUS',
    N'Core i7, RAM 16GB, RTX 4060',
    25000000.00,
    'https://res.cloudinary.com/demo/image/upload/sample.jpg',
    2,
    '2026-09-20 09:00:00'
),
(
    N'Bàn phím cơ Logitech',
    N'Switch Brown, LED RGB',
    1800000.00,
    'https://res.cloudinary.com/demo/image/upload/sample.jpg',
    2,
    '2026-09-21 10:30:00'
),
(
    N'Chuột Logitech G102',
    N'Chuột gaming có dây',
    450000.00,
    'https://res.cloudinary.com/demo/image/upload/sample.jpg',
    2,
    '2026-09-22 14:00:00'
),
(
    N'Màn hình Samsung 24 inch',
    N'Màn hình Full HD 75Hz',
    3290000.00,
    'https://res.cloudinary.com/demo/image/upload/sample.jpg',
    3,
    '2026-09-23 08:30:00'
);
GO


INSERT INTO otp_tokens
(email, otp_hash, type, expires_at, attempts, used, created_at)
VALUES
(
    'khanh@gmail.com',
    '$2a$10$1WnI1u6jE5F7y8t1g3wH2.vS5s9k3xK7bZ5qL1nZ8tW4vY2xK2lW6',
    'REGISTER',
    '2026-09-30 23:59:00',
    0,
    0,
    '2026-09-29 20:00:00'
),
(
    'admin@gmail.com',
    '$2a$10$1WnI1u6jE5F7y8t1g3wH2.vS5s9k3xK7bZ5qL1nZ8tW4vY2xK2lW6',
    'FORGOT_PASSWORD',
    '2026-09-30 23:59:00',
    0,
    0,
    '2026-09-29 21:00:00'
);
GO


SELECT * FROM roles;
SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM otp_tokens;
GO