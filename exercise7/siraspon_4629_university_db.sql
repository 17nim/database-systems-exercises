create database if not exists university_db_4629;

use university_db_4629;

CREATE TABLE if not exists students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    email VARCHAR(40),
    date_of_birth DATE
);

CREATE TABLE if not exists courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(40),
    department VARCHAR(20),
    credits INT
);

CREATE TABLE if not exists enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester VARCHAR(6),
    year YEAR,
    grade VARCHAR(2),

    FOREIGN KEY (student_id)
        REFERENCES students (student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses (course_id)
);

CREATE TABLE if not exists professors (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    department VARCHAR(20),
    hire_date DATE
);

INSERT INTO students (student_id, first_name, last_name, email) VALUES
    (1, 'Manee', 'Jaidee', 'john.doe@university.edu'),
    (2, 'Siraspon', 'Saengnak', 'siraspon.s@kkumail.com'),
    (3, 'Yotin', 'Nuntasan', 'yotin.n@kkumail.com');

INSERT INTO courses VALUES
    (101, 'Intro to Programming', 'Computer Engineering', 3),
    (102, 'Database Systems', 'Computer Engineering', 4),
    (103, 'Data Structures', 'Computer Engineering', 4),
    (201, 'Linear Algebra', 'Mathematics', 3);  

INSERT INTO professors (professor_id, first_name, last_name, department) VALUES
    (1, 'Kanda', 'Saikaew', 'Computer Engineering'),
    (2, 'Elizabeth', 'Davis', 'Computer Science'),
    (3, 'Richard', 'Miller', 'Mathematics');

INSERT INTO enrollments VALUES
    (1, 1, 101, 'Fall', 2023, 'A'),
    (2, 1, 102, 'Spring', 2024, NULL),
    (3, 1, 103, 'Spring', 2024, NULL),
    (4, 2, 101, 'Fall', 2023, 'B'),
    (5, 2, 102, 'Spring', 2024, NULL),
    (6, 2, 103, 'Spring', 2024, NULL),
    (7, 3, 101, 'Fall', 2023, 'A'),
    (8, 3, 201, 'Spring', 2024, NULL);  

SELECT first_name, last_name, course_name, department
    FROM students NATURAL JOIN enrollments NATURAL JOIN courses;

SELECT DISTINCT course_name, department, semester, year
    FROM courses NATURAL JOIN enrollments
    WHERE department = 'Computer Engineering';

SELECT first_name, last_name, course_name, department
    FROM students NATURAL JOIN enrollments NATURAL JOIN courses
    WHERE course_name LIKE '%Programming%';

SELECT first_name, last_name, course_name, department
    FROM professors NATURAL JOIN courses
    WHERE course_name LIKE '%Systems%';

SELECT DISTINCT students.first_name, students.last_name, professors.first_name, professors.last_name
    FROM (enrollments NATURAL JOIN (courses NATURAL JOIN professors)) INNER JOIN students
    WHERE enrollments.student_id = students.student_id
    AND students.last_name LIKE 'S%'
    AND professors.last_name LIKE 'S%';