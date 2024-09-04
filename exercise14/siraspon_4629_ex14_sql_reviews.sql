CREATE DATABASE if NOT EXISTS exercise14_db;

USE exercise14_db;

CREATE TABLE if NOT EXISTS students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    major VARCHAR(50),
    gpa DECIMAL(3,2)
);

CREATE TABLE if NOT EXISTS courses (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    credits INT
);

CREATE TABLE if NOT EXISTS enrollments (
    student_id INT,
    course_id VARCHAR(10),
    grade CHAR(1),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

DELETE FROM enrollments;
DELETE FROM courses;
DELETE FROM students;

-- Insert sample data into students table
INSERT INTO students (student_id, name, major, gpa) VALUES
(1, 'Alice Johnson', 'Computer Science', 3.8),
(2, 'Bob Smith', 'Mathematics', 3.6),
(3, 'Charlie Brown', 'Computer Science', 3.2),
(4, 'Diana Prince', 'Physics', 3.9),
(5, 'Eva Green', 'Mathematics', 3.5),
(6, 'Frank Castle', 'Computer Science', 3.7);

-- Insert sample data into courses table
INSERT INTO courses (course_id, title, credits) VALUES
('CS101', 'Introduction to Programming', 3),
('CS102', 'Data Structures', 4),
('MATH201', 'Calculus I', 4),
('PHYS101', 'Physics I', 4);

-- Insert sample data into enrollments table
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 'CS101', 'A'),
(1, 'CS102', 'B'),
(1, 'MATH201', 'A'),
(2, 'CS101', 'B'),
(2, 'MATH201', 'A'),
(3, 'CS101', 'B'),
(3, 'PHYS101', 'C'),
(4, 'CS101', 'A'),
(4, 'CS102', 'A'),
(4, 'MATH201', 'A'),
(4, 'PHYS101', 'A'),
(5, 'MATH201', 'B'),
(6, 'CS101', 'A'),
(6, 'CS102', 'A');

SELECT name, gpa FROM students 
    WHERE gpa > 3.50
    ORDER BY gpa DESC;

SELECT major, AVG(gpa) AS avg_gpa
    FROM students
    GROUP BY major
    HAVING COUNT(student_id) > 1;

(SELECT students.name
    FROM students NATURAL JOIN enrollments
    WHERE course_id = 'CS101')
    EXCEPT
    (SELECT students.name
    FROM students NATURAL JOIN enrollments
    WHERE course_id = 'CS102');

SELECT name, COUNT(course_id) AS num_courses
    FROM students NATURAL JOIN enrollments
    GROUP BY student_id
    ORDER BY student_id;
