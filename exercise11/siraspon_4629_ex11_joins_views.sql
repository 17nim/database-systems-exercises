create database if not exists joins_views_db;

use joins_views_db;

-- Create tables
CREATE TABLE if not exists departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    building VARCHAR(50)
);

CREATE TABLE if not exists instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE if not exists courses (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_id INT,
    credits INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE if not exists sections (
    section_id INT PRIMARY KEY,
    course_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    room_number VARCHAR(10),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE if not exists teaches (
    instructor_id INT,
    section_id INT,
    PRIMARY KEY (instructor_id, section_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id),
    FOREIGN KEY (section_id) REFERENCES sections(section_id)
);

delete from teaches;
delete from instructors;
delete from sections;
delete from courses;
delete from departments;


-- Insert sample data
INSERT INTO departments VALUES
(1, 'Computer Science', 'Taylor'),
(2, 'Physics', 'Watson'),
(3, 'Mathematics', 'Taylor'),
(4, 'Biology', 'Watson');

INSERT INTO instructors VALUES
(101, 'John Doe', 1, 75000.00),
(102, 'Jane Smith', 2, 80000.00),
(103, 'Bob Johnson', 1, 72000.00),
(104, 'Alice Brown', 3, 78000.00),
(105, 'Charlie Davis', 4, 76000.00);

INSERT INTO courses VALUES
('CS101', 'Introduction to Programming', 1, 3),
('PHY201', 'Classical Mechanics', 2, 4),
('MATH301', 'Linear Algebra', 3, 3),
('BIO101', 'General Biology', 4, 4),
('CS201', 'Data Structures', 1, 3);

INSERT INTO sections VALUES
(1, 'CS101', 'Fall', 2023, 'Taylor', '3A'),
(2, 'PHY201', 'Fall', 2023, 'Watson', '2B'),
(3, 'MATH301', 'Spring', 2024, 'Taylor', '1C'),
(4, 'BIO101', 'Fall', 2023, 'Watson', '4D'),
(5, 'CS201', 'Spring', 2024, 'Taylor', '3B');

INSERT INTO teaches VALUES
(101, 1),
(102, 2),
(103, 5),
(104, 3),
(105, 4);

-- Exercises begin here :D
SELECT name, dept_name
    FROM instructors NATURAL JOIN departments;

SELECT title, name, room_number
    FROM courses INNER JOIN sections NATURAL JOIN instructors NATURAL JOIN teaches
    ON courses.course_id = sections.course_id
    AND sections.building = 'Taylor';

CREATE OR REPLACE VIEW dept_total_salary(dept_name, total_salary) AS
    SELECT dept_name, sum(salary)
    FROM departments NATURAL JOIN instructors
    GROUP BY dept_name;

SELECT * FROM dept_total_salary
    WHERE total_salary = (SELECT MAX(total_salary) FROM dept_total_salary);

CREATE OR REPLACE VIEW course_fall_2023 AS
    SELECT course_id, title, room_number
    FROM courses NATURAL JOIN sections
    WHERE building = 'Watson';

SELECT * FROM course_fall_2023;

CREATE OR REPLACE VIEW instructors_course_loads AS
    SELECT instructor_id, name, COUNT(course_id) AS 'course_count', salary
    FROM instructors NATURAL JOIN teaches NATURAL JOIN sections
    GROUP BY instructor_id;

SELECT * FROM instructors_course_loads;

CREATE TABLE if NOT EXISTS avg_credit_per_dept AS
    SELECT dept_name, AVG(credits) AS avg_credits
    FROM courses NATURAL JOIN departments
    GROUP BY dept_name;

SELECT * FROM avg_credit_per_dept 
    WHERE avg_credits > (SELECT AVG(avg_credits) FROM avg_credit_per_dept);

CREATE OR REPLACE VIEW avg_salary_taylor AS
    SELECT building, AVG(salary) AS 'avg_salary'
    FROM instructors NATURAL JOIN teaches NATURAL JOIN sections
    GROUP BY building;

SELECT avg_salary FROM avg_salary_taylor
    WHERE building = 'Taylor';