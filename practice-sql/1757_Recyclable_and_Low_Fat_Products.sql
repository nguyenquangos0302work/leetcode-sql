-- 1757. Recyclable and Low Fat Products (https://leetcode.com/problems/recyclable-and-low-fat-products/description/?envType=study-plan-v2&envId=top-sql-50)

DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

-- 1757. Recyclable and Low Fat Products

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    low_fats VARCHAR(1) CHECK (low_fats IN ('Y', 'N')),
    recyclable VARCHAR(1) CHECK (recyclable IN ('Y', 'N'))
);

INSERT INTO Products (low_fats, recyclable)
VALUES
('Y', 'N'),
('Y', 'Y'),
('N', 'Y'),
('Y', 'Y'),
('N', 'N');

SELECT p.product_id
FROM Products AS p
WHERE p.low_fats = 'Y' AND p.recyclable = 'Y';