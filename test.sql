CREATE DATABASE if NOT EXISTS test;

USE test;

CREATE TABLE if NOT EXISTS table1 (
    name VARCHAR(10),
    id INT
);

CREATE TABLE if NOT EXISTS table2 (
    name VARCHAR(10),
    salary DECIMAL(10, 2)
);

DELETE FROM table1;
DELETE FROM table2;

INSERT INTO table1 (name, id) VALUES
('A', 1),
('B', 2),
('C', 3);

INSERT INTO table2 (name, salary) VALUES
('B', 200),
('C', 300),
('D', 400);

SELECT * FROM table1;
SELECT * FROM table2;

SELECT name, salary
    FROM table1 NATURAL JOIN table2
    WHERE salary = (SELECT MAX(salary) FROM table1 NATURAL JOIN table2);