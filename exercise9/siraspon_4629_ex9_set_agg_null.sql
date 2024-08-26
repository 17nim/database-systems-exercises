-- Create tables
create database if not exists university_db;
use university_db;

CREATE TABLE if not exists students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    major VARCHAR(50),
    gpa DECIMAL(3,2)
);

CREATE TABLE if not exists courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(50),
    department VARCHAR(50),
    credits INT
);

CREATE TABLE if not exists enrollments (
    student_id INT,
    course_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id, semester, year),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample data
delete from enrollments;
delete from courses;
delete from students;


INSERT INTO students (student_id, name, major, gpa) VALUES
(1, 'Alice', 'Computer Science', 3.8),
(2, 'Bob', 'Physics', 3.5),
(3, 'Charlie', 'Mathematics', 3.9),
(4, 'David', 'Computer Science', 3.2),
(5, 'Eve', 'Physics', 3.7),
(6, 'Frank', 'Mathematics', NULL);


INSERT INTO courses (course_id, course_name, department, credits) VALUES
('CS101', 'Introduction to Programming', 'Computer Science', 3),
('CS201', 'Data Structures', 'Computer Science', 4),
('PHYS101', 'Mechanics', 'Physics', 4),
('MATH201', 'Calculus', 'Mathematics', 4),
('MATH202', 'Linear Algebra', 'Mathematics', 3);


INSERT INTO enrollments (student_id, course_id, semester, year, grade) VALUES
(1, 'CS101', 'Fall', 2023, 'A'),
(1, 'CS201', 'Spring', 2024, 'B'),
(2, 'PHYS101', 'Fall', 2023, 'A'),
(2, 'MATH201', 'Spring', 2024, 'B'),
(3, 'MATH201', 'Fall', 2023, 'A'),
(3, 'MATH202', 'Spring', 2024, 'A'),
(4, 'CS101', 'Fall', 2023, 'B'),
(5, 'PHYS101', 'Fall', 2023, 'A'),
(5, 'MATH201', 'Spring', 2024, NULL),
(6, 'MATH202', 'Spring', 2024, NULL);

-- Exercises begin here :D
(SELECT name FROM students WHERE major = 'Computer Science')
    UNION
    (SELECT name FROM students WHERE major = 'Physics');

(SELECT student_id FROM enrollments WHERE course_id = 'CS101')
    INTERSECT
    (SELECT student_id FROM enrollments WHERE course_id = 'CS201');

SELECT name FROM students
    WHERE gpa IS NULL;

SELECT name, course_name FROM students
    INNER JOIN enrollments ON enrollments.student_id = students.student_id
    INNER JOIN courses ON courses.course_id = enrollments.course_id
    WHERE grade IS NULL;

SELECT major, AVG(gpa) AS avg_gpa FROM students GROUP BY major;

SELECT course_name, COUNT(*) AS num_students FROM courses
    INNER JOIN enrollments ON courses.course_id = enrollments.course_id
    GROUP BY course_name;

SELECT name, gpa FROM students
    WHERE gpa = (SELECT max(gpa) FROM students);

SELECT major, COUNT(*) AS num_student FROM students
    GROUP BY major;
