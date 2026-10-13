-- Week 1 Assignment: School Management Database
-- Database: school_management
-- Run this script in MySQL Workbench or with the MySQL command-line client.

CREATE DATABASE IF NOT EXISTS school_management;
USE school_management;

-- Table 1: Students
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE
);

-- Table 2: Teachers
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Table 3: Courses
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT,
    CONSTRAINT fk_courses_teacher
        FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Table 4: Enrollments (links students and courses)
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT uq_student_course UNIQUE (student_id, course_id)
);

-- Sample teacher records
INSERT INTO teachers (first_name, last_name, email) VALUES
('Grace', 'Wanjiku', 'grace.wanjiku@example.com'),
('Peter', 'Otieno', 'peter.otieno@example.com');

-- Sample student records
INSERT INTO students (first_name, last_name, email, date_of_birth) VALUES
('Amina', 'Kamau', 'amina.kamau@example.com', '2005-04-12'),
('Brian', 'Mwangi', 'brian.mwangi@example.com', '2004-11-23'),
('Faith', 'Njeri', 'faith.njeri@example.com', '2006-02-08');

-- Sample course records
INSERT INTO courses (course_name, teacher_id) VALUES
('Mathematics', 1),
('Computer Studies', 2),
('English Language', 1);

-- Sample enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2026-01-12'),
(1, 2, '2026-01-12'),
(2, 1, '2026-01-13'),
(3, 3, '2026-01-14');

-- Verification commands
SHOW DATABASES;
SHOW TABLES;

-- View all students
SELECT * FROM students;

-- View courses and their teachers
SELECT
    c.course_name,
    CONCAT(t.first_name, ' ', t.last_name) AS teacher_name
FROM courses AS c
LEFT JOIN teachers AS t ON c.teacher_id = t.teacher_id;

-- View student enrollments with course names
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.enrollment_date
FROM enrollments AS e
JOIN students AS s ON e.student_id = s.student_id
JOIN courses AS c ON e.course_id = c.course_id
ORDER BY student_name, c.course_name;
