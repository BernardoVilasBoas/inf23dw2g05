-- Criação do esquema e uso do mesmo
CREATE DATABASE IF NOT EXISTS api_ecommerce;
SHOW DATABASES;
USE api_ecommerce;

-- Criação da tabela de usuários
START TRANSACTION;
CREATE TABLE IF NOT EXISTS Users (
    ID INT PRIMARY KEY AUTO_INCREMENT, -- Renomeado de UserID para ID
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Pass VARCHAR(64) NOT NULL,
    Age INT,
    Rol VARCHAR(10),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CreatedAt DATE,
    UpdatedAt DATE
);

-- Criação da tabela de categorias de produtos
CREATE TABLE IF NOT EXISTS ProductCategories (
    ID INT PRIMARY KEY AUTO_INCREMENT, -- Renomeado de CategoryID para ID
    CategoryName VARCHAR(50) NOT NULL
);

-- Criação da tabela de produtos
CREATE TABLE IF NOT EXISTS Products (
    ID INT PRIMARY KEY AUTO_INCREMENT, -- Renomeado de ProductID para ID
    Name_products VARCHAR(100),
    Description_products TEXT,
    Image_products VARCHAR(255),
    Price DECIMAL(10, 2),
    PriceUnit VARCHAR(10),
    CategoryID INT,
    CreatedAt DATE,
    UpdatedAt DATE,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategories(ID) -- Atualizado para referenciar ID
);

-- Criação da tabela de carrinho de compras
CREATE TABLE IF NOT EXISTS Cart (
    ID INT PRIMARY KEY AUTO_INCREMENT, -- Renomeado de CartID para ID
    UserID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (UserID) REFERENCES Users(ID), -- Atualizado para referenciar ID
    FOREIGN KEY (ProductID) REFERENCES Products(ID) -- Atualizado para referenciar ID
);
COMMIT;

-- Inserção de dados
START TRANSACTION;

-- Inserção de dados na tabela Users
INSERT IGNORE INTO Users (UserName, Email, Pass, Age, Rol, FirstName, LastName, CreatedAt, UpdatedAt)
VALUES
    ('john.doe', 'john.doe@example.com', 'hashed_password_1', 33, 'user', 'John', 'Doe', '2023-05-12', '2024-05-12'),
    ('jane.smith', 'jane.smith@example.com', 'hashed_password_2', 29, 'admin', 'Jane', 'Smith', '2023-05-12', '2024-05-12'),
    ('robert.johnson', 'robert.johnson@example.com', 'hashed_password_3', 40, 'user', 'Robert', 'Johnson', '2023-05-12', '2024-05-12');

-- Inserção de dados na tabela ProductCategories
INSERT IGNORE INTO ProductCategories (CategoryName)
VALUES
    ('Electronics'),
    ('Clothing'),
    ('Books');

-- Inserção de dados na tabela Products
INSERT IGNORE INTO Products (Name_products, Description_products, Image_products, Price, PriceUnit, CategoryID, CreatedAt, UpdatedAt)
VALUES
    ('Microsoft Sculpt Ergonomic Wireless Keyboard', 'Designed for comfort and functionality, offers protection for your joints.', 'https://example.com/sculpt_keyboard.jpg', 80.95, 'USD', 1, '2023-05-12', '2023-05-12'),
    ('Logitech MK345 Wireless Keyboard and Mouse Set', 'Generous palm rest and spill-resistant design makes it comfortable to use.', 'https://example.com/mk345_keyboard.jpg', 39.99, 'USD', 1, '2023-05-12', '2023-05-12');

-- Inserção de dados na tabela Cart
INSERT IGNORE INTO Cart (UserID, ProductID, Quantity)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 1, 3);

COMMIT;

GRANT ALL PRIVILEGES ON api_ecommerce.* TO 'API'@'%' IDENTIFIED BY 'API' with grant option;
FLUSH PRIVILEGES;