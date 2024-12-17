-- 176. Second Highest Salary (https://leetcode.com/problems/second-highest-salary/description/)

DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

CREATE TABLE Employee (
  id INT PRIMARY KEY,
  salary INT
);

INSERT INTO Employee (id, salary)
VALUES 
(1, 5000);

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee e
WHERE e.id NOT IN (SELECT e.id
									FROM Employee e
									WHERE e.salary = (SELECT MAX(e.salary)
																		FROM Employee e));

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee e
WHERE e.salary < (SELECT MAX(e.salary)
									FROM Employee e);
								
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee e
WHERE e.salary <> (SELECT MAX(e.salary)
									FROM Employee e);
									
SELECT (SELECT DISTINCT salary
FROM Employee e
ORDER BY salary DESC
LIMIT 1 OFFSET 1) AS SecondHighestSalary;

SELECT (SELECT rank_salary.salary
FROM (SELECT distinct_salary.salary,
						RANK() OVER (ORDER BY distinct_salary.salary DESC)
			FROM (SELECT DISTINCT salary
						FROM Employee e) AS distinct_salary) AS rank_salary
WHERE rank_salary.rank = 2);

-- 
CREATE OR REPLACE FUNCTION nthHighestSalary(n int)
RETURNS TABLE (
	salary int
)
AS
$$
BEGIN

		

END;
$$ LANGUAGE plpgsql;
