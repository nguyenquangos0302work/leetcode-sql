-- 177. Nth Highest Salary (https://leetcode.com/problems/nth-highest-salary/description/)

DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

CREATE TABLE Employee (
  id INT PRIMARY KEY,
  salary INT
);

INSERT INTO Employee (id, salary)
VALUES 
(1, 5000),
(2, 2000),
(3, 4000),
(4, 7000),
(5, 8000),
(6, 9000)
;

CREATE OR REPLACE FUNCTION nthHighestSalary(n int)
RETURNS TABLE (
	salary int
)
AS
$$
BEGIN
	RETURN QUERY
		SELECT (
			CASE WHEN n > 0 THEN (
				SELECT DISTINCT e.salary
				FROM Employee e
				ORDER BY e.salary DESC
				OFFSET (n - 1) ROWS
				FETCH FIRST 1 ROW ONLY
			)
			ELSE NULL
			END
		)
		;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nthHighestSalaryWithWindowFunction(n int)
RETURNS TABLE (
	salary int
)
AS
$$
BEGIN

	RETURN QUERY
	SELECT rank_salary.salary
	FROM (SELECT distinct_salary.salary,
							RANK() OVER (ORDER BY distinct_salary.salary DESC) as rank
				FROM (SELECT DISTINCT e.salary
							FROM Employee e) AS distinct_salary) AS rank_salary
	WHERE rank_salary.rank = n;

END;
$$ LANGUAGE plpgsql;

SELECT (SELECT nthHighestSalary(-1));
