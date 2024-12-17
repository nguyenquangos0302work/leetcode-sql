DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

CREATE TABLE Weather (
    id INT PRIMARY KEY,
    recordDate DATE,
    temperature INT
);

INSERT INTO Weather (id, recordDate, temperature)
VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);

SELECT w2.id AS Id
FROM Weather AS w1
INNER JOIN Weather AS w2 ON w2.recordDate = date_add(w1.recordDate, '1 DAY')
WHERE w1.temperature < w2.temperature;

SELECT w.id AS Id
FROM (SELECT w1.id, 
					w1.recordDate, 
					w1.temperature, 
					LAG(w1.temperature) OVER (ORDER BY w1.recordDate) AS lag_temperature,
					LAG(w1.recordDate) OVER (ORDER BY w1.recordDate) AS lag_day
			FROM Weather AS w1) AS w
WHERE w.lag_temperature IS NOT NULL 
		AND w.lag_temperature < w.temperature 
		AND w.lag_day IS NOT NULL
		AND (w.recordDate - w.lag_day) = 1;