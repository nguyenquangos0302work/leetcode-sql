DROP SCHEMA IF EXISTS leetcode CASCADE;
CREATE SCHEMA leetcode;
SET search_path TO leetcode, public;

-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

-- Insert data into Students table
INSERT INTO Students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(13, 'John'),
(6, 'Alex');

-- Create Subjects table
CREATE TABLE Subjects (
    subject_name VARCHAR(100) PRIMARY KEY
);

-- Insert data into Subjects table
INSERT INTO Subjects (subject_name) VALUES
('Math'),
('Physics'),
('Programming');

-- Create Examinations table
CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_name) REFERENCES Subjects(subject_name)
);

-- Insert data into Examinations table
INSERT INTO Examinations (student_id, subject_name) VALUES
(1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Math'),
(2, 'Programming'),
(13, 'Math'),
(13, 'Physics'),
(6, 'Programming'),
(1, 'Math'),
(2, 'Physics');

WITH term_table AS (
	SELECT s.student_id, s.student_name, sb.subject_name, COUNT(sb.subject_name) AS attended_exams
	FROM Students AS s
	CROSS JOIN Subjects AS sb
	LEFT JOIN Examinations e ON s.student_id = e.student_id AND sb.subject_name = e.subject_name
	WHERE e.student_id IS NOT NULL
	GROUP BY s.student_id, s.student_name, sb.subject_name
	ORDER BY s.student_id ASC, sb.subject_name ASC
)
SELECT s.student_id, s.student_name, sb.subject_name, 
	(CASE WHEN tt.attended_exams IS NULL THEN 0
	ELSE tt.attended_exams
	END) AS attended_exams
FROM Students AS s
CROSS JOIN Subjects AS sb
LEFT JOIN term_table AS tt ON s.student_id = tt.student_id AND sb.subject_name = tt.subject_name;

SELECT s.student_id, s.student_name, sb.subject_name, COUNT(e.student_id) AS attended_exams
FROM Students AS s
CROSS JOIN Subjects AS sb
LEFT JOIN Examinations e ON s.student_id = e.student_id AND sb.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sb.subject_name
ORDER BY s.student_id ASC, sb.subject_name ASC;














