DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

CREATE TYPE activity_type AS ENUM ('start', 'end');

CREATE TABLE Activity (
    machine_id INT,
    process_id INT,
    activity_type activity_type,
    timestamp FLOAT,
    PRIMARY KEY (machine_id, process_id, activity_type)
);

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES
    (0, 1, 'start', 18.891),
    (1, 0, 'end', 81.874),
    (0, 0, 'start', 37.019),
    (0, 1, 'end', 38.098),
    (1, 0, 'start', 25.135),
    (1, 1, 'start', 23.355),
    (0, 0, 'end', 40.222),
    (1, 1, 'end', 90.302);

   
   
SELECT activty_start_end.machine_id, ROUND(AVG(activty_start_end.during_time::numeric),3) AS processing_time
FROM (
SELECT a.machine_id, a.process_id, (b.timestamp - a.timestamp) AS during_time
FROM Activity a
INNER JOIN Activity b ON a.machine_id = b.machine_id AND a.process_id = b.process_id
AND a.activity_type != b.activity_type AND a.activity_type = 'start') AS activty_start_end
GROUP BY activty_start_end.machine_id;


SELECT activity.machine_id, ROUND(AVG(activity.during_time::numeric),3) AS processing_time
FROM (
SELECT a.machine_id, 
			a.process_id, 
			a.timestamp - LAG(a.timestamp) OVER (PARTITION BY a.machine_id, a.process_id ORDER BY a.machine_id) AS during_time
FROM (SELECT act.*
			FROM Activity act
			ORDER BY act.machine_id ASC, act.process_id ASC) AS a) AS activity
WHERE activity.during_time IS NOT NULL
GROUP BY activity.machine_id;

SELECT a.machine_id,
			ROUND((SUM(CASE
				WHEN a.activity_type = 'start' THEN a.timestamp * -1
				ELSE a.timestamp
			END) / (SELECT COUNT(DISTINCT process_id) FROM activity))::numeric, 3) as processing_time
FROM Activity a
GROUP BY a.machine_id
ORDER BY a.machine_id;
