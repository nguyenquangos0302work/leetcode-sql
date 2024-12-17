DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
  personId INT PRIMARY KEY,
  lastName VARCHAR(50),
	firstName VARCHAR(50)
);

DROP TABLE IF EXISTS Address;
CREATE TABLE Address (
	addressId INT PRIMARY KEY,
	personId INT,
	city VARCHAR(100),
	state VARCHAR(100),
	FOREIGN KEY (personId) REFERENCES Person(personId)
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    salary INT
);

-- Insert data into Person table
INSERT INTO Person (personId, lastName, firstName)
VALUES 
(1, 'Wang', 'Allen'),
(2, 'Alice', 'Bob');

-- 175. Combine Two Tables (https://leetcode.com/problems/combine-two-tables/description/)
SELECT p.firstname, 
	p.lastname, 
	a. city, 
	a.state
FROM Person AS p
LEFT JOIN Address AS a ON p.personId = a.personId;

