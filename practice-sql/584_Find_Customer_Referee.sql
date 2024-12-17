DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

CREATE TABLE Customer (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    referee_id INT
);

INSERT INTO Customer (id, name, referee_id)
VALUES
(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2);

SELECT c.name
FROM Customer c
WHERE c.referee_id != 2 OR c.referee_id IS NULL;
