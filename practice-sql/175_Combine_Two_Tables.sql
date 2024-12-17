DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

-- 175. Combine Two Tables (https://leetcode.com/problems/combine-two-tables/description/)

CREATE TABLE Person (
  personId INT PRIMARY KEY,
  lastName VARCHAR(50),
	firstName VARCHAR(50)
);

CREATE TABLE Address (
	addressId INT PRIMARY KEY,
	personId INT,
	city VARCHAR(100),
	state VARCHAR(100),
	FOREIGN KEY (personId) REFERENCES Person(personId)
);

-- Insert data into Person table
INSERT INTO Person (personId, lastName, firstName)
VALUES 
(1, 'Wang', 'Allen'),
(2, 'Alice', 'Bob');

SELECT p.firstname, 
	p.lastname, 
	a. city, 
	a.state
FROM Person AS p
LEFT JOIN Address AS a ON p.personId = a.personId;

