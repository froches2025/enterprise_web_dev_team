-- =============================================
-- Project: Transaction Tracking System
-- File: database_setup.sql
-- Author: Annabel Kemasuode
-- =============================================

DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb;
USE mydb;

-- =========================
-- STEP 2: TABLES (DDL)
-- =========================

CREATE TABLE users (
    UserID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each user',
    Name VARCHAR(100) NOT NULL COMMENT 'Full name of the user',
    PhoneNumber VARCHAR(20) NOT NULL UNIQUE COMMENT 'Contact phone number, must be unique'
);

CREATE TABLE transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each transaction',
    UserID INT NOT NULL COMMENT 'FK to the user who made the transaction',
    Amount DECIMAL(10,2) NOT NULL COMMENT 'Transaction amount, must be greater than 0',
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'When the transaction occurred',
    -- STEP 3: FOREIGN KEY
    CONSTRAINT fk_transaction_user
        FOREIGN KEY (UserID) REFERENCES users(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    -- STEP 4: CHECK CONSTRAINT
    CONSTRAINT chk_amount_valid CHECK (Amount > 0)
);

CREATE TABLE transaction_categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each category',
    CategoryName VARCHAR(100) NOT NULL UNIQUE COMMENT 'Name of the transaction category'
);

CREATE TABLE transaction_category_mapping (
    TransactionID INT NOT NULL COMMENT 'FK to transactions table',
    CategoryID INT NOT NULL COMMENT 'FK to transaction_categories table',
    PRIMARY KEY (TransactionID, CategoryID),
    CONSTRAINT fk_mapping_transaction
        FOREIGN KEY (TransactionID) REFERENCES transactions(TransactionID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_mapping_category
        FOREIGN KEY (CategoryID) REFERENCES transaction_categories(CategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE system_logs (
    LogID INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each log entry',
    UserID INT COMMENT 'FK to the user associated with this log entry (nullable)',
    LogMessage VARCHAR(255) NOT NULL COMMENT 'Description of the logged event',
    LogDate DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'When the log entry was created',
    CONSTRAINT fk_log_user
        FOREIGN KEY (UserID) REFERENCES users(UserID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- =========================
-- STEP 5: INDEXES
-- =========================

CREATE INDEX idx_transactions_user_id ON transactions(UserID);
CREATE INDEX idx_transactions_date ON transactions(TransactionDate);
CREATE INDEX idx_mapping_category_id ON transaction_category_mapping(CategoryID);
CREATE INDEX idx_logs_user_id ON system_logs(UserID);
CREATE INDEX idx_logs_date ON system_logs(LogDate);

-- =========================
-- STEP 6: SAMPLE DATA (DML)
-- =========================

INSERT INTO users (Name, PhoneNumber) VALUES
('Alice Mensah', '0781234501'),
('Brian Okafor', '0781234502'),
('Chidi Nwosu', '0781234503'),
('Diana Osei', '0781234504'),
('Efe Johnson', '0781234505');

INSERT INTO transactions (UserID, Amount) VALUES
(1, 150.00),
(2, 45.50),
(3, 320.75),
(4, 89.99),
(5, 12.25);

INSERT INTO transaction_categories (CategoryName) VALUES
('Groceries'),
('Utilities'),
('Entertainment'),
('Transport'),
('Rent');

INSERT INTO transaction_category_mapping (TransactionID, CategoryID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO system_logs (UserID, LogMessage) VALUES
(1, 'User logged in'),
(2, 'Transaction created'),
(3, 'Password changed'),
(4, 'User logged out'),
(5, 'Transaction updated');
