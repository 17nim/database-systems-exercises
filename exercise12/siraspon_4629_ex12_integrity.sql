CREATE DATABASE if NOT EXISTS integrity_db;

USE integrity_db;

-- Problem #1
CREATE TABLE if NOT EXISTS accounts (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL CHECK (balance >= 0),
    account_type VARCHAR(8),
    CONSTRAINT valid_account_type CHECK (account_type IN ('Checking', 'Savings', 'Credit'))
);

CREATE TABLE if NOT EXISTS transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(8),
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    transaction_date DATETIME NOT NULL,
    CONSTRAINT valid_transaction_type CHECK (transaction_type IN ('Deposit', 'Withdraw', 'Transfer')),
    CONSTRAINT max_amount CHECK (amount <= 10000),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON UPDATE CASCADE
);

DELETE FROM transactions;
DELETE FROM accounts;

INSERT INTO accounts VALUES
(1001, 'John Doe', 10000.00, 'Savings'),
(1002, 'Jane Smith', 5000.00, 'Checking'),
(1003, 'Bob Johnson', 7500.00, 'Savings');

START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1001;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 1002;

INSERT INTO transactions VALUES
(1, 1001, 'Withdraw', 2000, now()),
(2, 1002, 'Deposit', 2000, now());

COMMIT;

SELECT * FROM accounts;
SELECT * FROM transactions;