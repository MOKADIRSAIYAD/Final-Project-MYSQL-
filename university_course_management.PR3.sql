-- =====================================================================
-- Final Project : University Course Management System
-- Database      : MySQL 8.0 (MySQL Workbench)
-- Run           : Open in Workbench -> Ctrl+A -> Execute (lightning icon)
-- =====================================================================

DROP DATABASE IF EXISTS UniversityDB;
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- =====================================================================
-- 1. TABLE CREATION
-- =====================================================================

CREATE TABLE Departments (
    DepartmentID   INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    StudentID      INT PRIMARY KEY,
    FirstName      VARCHAR(50)  NOT NULL,
    LastName       VARCHAR(50)  NOT NULL,
    Email          VARCHAR(100) UNIQUE,
    BirthDate      DATE,
    EnrollmentDate DATE
);

CREATE TABLE Courses (
    CourseID     INT PRIMARY KEY,
    CourseName   VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits      INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Assumption: Salary column added (needed for Query 8)
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName    VARCHAR(50)  NOT NULL,
    LastName     VARCHAR(50)  NOT NULL,
    Email        VARCHAR(100) UNIQUE,
    DepartmentID INT,
    Salary       DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
    EnrollmentID   INT PRIMARY KEY AUTO_INCREMENT,
    StudentID      INT,
    CourseID       INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID)  REFERENCES Courses(CourseID)
);

-- =====================================================================
-- 2. SAMPLE DATA
-- (first 2 rows of each table are from the project document,
--  extra rows added so every query returns meaningful output)
-- =====================================================================

INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Students VALUES
(1,  'John',   'Doe',    'john.doe@email.com',     '2000-01-15', '2022-08-01'),
(2,  'Jane',   'Smith',  'jane.smith@email.com',   '1999-05-25', '2021-08-01'),
(3,  'Rahul',  'Sharma', 'rahul.sharma@email.com', '2001-03-10', '2023-07-15'),
(4,  'Priya',  'Patel',  'priya.patel@email.com',  '2002-11-20', '2024-08-05'),
(5,  'Amit',   'Verma',  'amit.verma@email.com',   '2000-07-07', '2020-08-10'),
(6,  'Neha',   'Gupta',  'neha.gupta@email.com',   '2001-09-09', '2019-08-12'),
(7,  'Karan',  'Mehta',  'karan.mehta@email.com',  '2003-02-14', '2025-07-20'),
(8,  'Sneha',  'Joshi',  'sneha.joshi@email.com',  '2002-06-30', '2023-08-01'),
(9,  'Vikram', 'Singh',  'vikram.singh@email.com', '1998-12-12', '2018-08-01'),
(10, 'Anjali', 'Rao',    'anjali.rao@email.com',   '2001-01-01', '2022-08-15'),
(11, 'Rohan',  'Das',    'rohan.das@email.com',    '2003-05-05', '2024-08-20'),
(12, 'Meera',  'Nair',   'meera.nair@email.com',   '2002-08-18', '2025-08-01'),
(13, 'Arjun',  'Kapoor', 'arjun.kapoor@email.com', '2004-04-04', '2026-08-01');

INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures',     2, 4),
(103, 'Algorithms',          1, 4),
(104, 'Calculus',            2, 4),
(105, 'Linear Algebra',      2, 3),
(106, 'Discrete Math',       2, 3),
(107, 'Statistics',          2, 3),
(108, 'Probability',         2, 3);

INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 85000.00),
(2, 'Bob',   'Lee',     'bob.lee@univ.com',       2, 78000.00),
(3, 'Carol', 'White',   'carol.white@univ.com',   1, 92000.00),
(4, 'David', 'Brown',   'david.brown@univ.com',   1, 70000.00);

-- Enrollments (EnrollmentDate = student's joining date)
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
-- Introduction to SQL (101): 12 students total
(2,  101, '2021-08-01'),
(3,  101, '2023-07-15'),
(4,  101, '2024-08-05'),
(5,  101, '2020-08-10'),
(6,  101, '2019-08-12'),
(7,  101, '2025-07-20'),
(8,  101, '2023-08-01'),
(9,  101, '2018-08-01'),
(10, 101, '2022-08-15'),
(11, 101, '2024-08-20'),
(12, 101, '2025-08-01'),
-- Data Structures (102): 6 students total
(1,  102, '2022-08-01'),
(3,  102, '2023-07-15'),
(4,  102, '2024-08-05'),
(5,  102, '2020-08-10'),
(6,  102, '2019-08-12'),
-- Other courses
(7,  103, '2025-07-20'),
(8,  103, '2023-08-01'),
(9,  103, '2018-08-01'),
(10, 104, '2022-08-15'),
(11, 104, '2024-08-20'),
(12, 105, '2025-08-01');

-- =====================================================================
-- 3. QUERIES
-- =====================================================================

-- ---------------------------------------------------------------------
-- Q1. CRUD operations on all tables
-- (temporary rows with ID 99/999 are created, updated, read, deleted
--  so the main data stays unchanged)
-- ---------------------------------------------------------------------

-- ---- Departments ----
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES (99, 'Physics');           -- CREATE
SELECT * FROM Departments WHERE DepartmentID = 99;                                       -- READ
UPDATE Departments SET DepartmentName = 'Applied Physics' WHERE DepartmentID = 99;       -- UPDATE
SELECT * FROM Departments WHERE DepartmentID = 99;

-- ---- Students ----
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES (99, 'Test', 'Student', 'test.student@email.com', '2002-02-02', '2024-08-01');    -- CREATE
SELECT * FROM Students WHERE StudentID = 99;                                             -- READ
UPDATE Students SET LastName = 'Updated' WHERE StudentID = 99;                           -- UPDATE
SELECT * FROM Students WHERE StudentID = 99;

-- ---- Courses ----
INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits)
VALUES (999, 'Quantum Basics', 99, 3);                                                   -- CREATE
SELECT * FROM Courses WHERE CourseID = 999;                                              -- READ
UPDATE Courses SET Credits = 4 WHERE CourseID = 999;                                     -- UPDATE
SELECT * FROM Courses WHERE CourseID = 999;

-- ---- Instructors ----
INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID, Salary)
VALUES (99, 'Test', 'Instructor', 'test.instructor@univ.com', 99, 60000);                -- CREATE
SELECT * FROM Instructors WHERE InstructorID = 99;                                       -- READ
UPDATE Instructors SET Salary = 65000 WHERE InstructorID = 99;                           -- UPDATE
SELECT * FROM Instructors WHERE InstructorID = 99;

-- ---- Enrollments ----
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES (999, 99, 999, '2024-08-01');                                                     -- CREATE
SELECT * FROM Enrollments WHERE EnrollmentID = 999;                                      -- READ
UPDATE Enrollments SET EnrollmentDate = '2024-09-01' WHERE EnrollmentID = 999;           -- UPDATE
SELECT * FROM Enrollments WHERE EnrollmentID = 999;

-- ---- DELETE (child tables first because of foreign keys) ----
DELETE FROM Enrollments WHERE EnrollmentID = 999;
DELETE FROM Instructors WHERE InstructorID = 99;
DELETE FROM Courses     WHERE CourseID = 999;
DELETE FROM Students    WHERE StudentID = 99;
DELETE FROM Departments WHERE DepartmentID = 99;

-- ---------------------------------------------------------------------
-- Q2. Students who enrolled after 2022
-- ---------------------------------------------------------------------
SELECT StudentID, FirstName, LastName, EnrollmentDate
FROM Students
WHERE YEAR(EnrollmentDate) > 2022;

-- ---------------------------------------------------------------------
-- Q3. Courses offered by Mathematics department (limit 5)
-- ---------------------------------------------------------------------
SELECT c.CourseID, c.CourseName, c.Credits
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;

-- ---------------------------------------------------------------------
-- Q4. Number of students in each course, only courses with more than 5
-- ---------------------------------------------------------------------
SELECT c.CourseID, c.CourseName, COUNT(e.StudentID) AS TotalStudents
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 5;

-- ---------------------------------------------------------------------
-- Q5. Students enrolled in BOTH Introduction to SQL and Data Structures
-- ---------------------------------------------------------------------
SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c     ON e.CourseID  = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;

-- ---------------------------------------------------------------------
-- Q6. Students enrolled in EITHER Introduction to SQL OR Data Structures
-- ---------------------------------------------------------------------
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c     ON e.CourseID  = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');

-- ---------------------------------------------------------------------
-- Q7. Average number of credits for all courses
-- ---------------------------------------------------------------------
SELECT ROUND(AVG(Credits), 2) AS AvgCredits
FROM Courses;

-- ---------------------------------------------------------------------
-- Q8. Maximum salary of instructors in Computer Science department
-- ---------------------------------------------------------------------
SELECT MAX(i.Salary) AS MaxSalary
FROM Instructors i
JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

-- ---------------------------------------------------------------------
-- Q9. Number of students enrolled in each department
-- ---------------------------------------------------------------------
SELECT d.DepartmentID, d.DepartmentName,
       COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Courses c     ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments e ON c.CourseID     = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName;

-- ---------------------------------------------------------------------
-- Q10. INNER JOIN: students and their corresponding courses
-- ---------------------------------------------------------------------
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c     ON e.CourseID  = c.CourseID
ORDER BY s.StudentID;

-- ---------------------------------------------------------------------
-- Q11. LEFT JOIN: all students and their courses, if any
-- (Arjun Kapoor has no enrollment -> CourseName = NULL)
-- ---------------------------------------------------------------------
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c     ON e.CourseID  = c.CourseID
ORDER BY s.StudentID;

-- ---------------------------------------------------------------------
-- Q12. Subquery: students enrolled in courses having more than 10 students
-- ---------------------------------------------------------------------
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 10
);

-- ---------------------------------------------------------------------
-- Q13. Extract the year from EnrollmentDate of students
-- ---------------------------------------------------------------------
SELECT StudentID, FirstName, LastName, EnrollmentDate,
       YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;

-- ---------------------------------------------------------------------
-- Q14. Concatenate the instructor's first and last name
-- ---------------------------------------------------------------------
SELECT InstructorID,
       CONCAT(FirstName, ' ', LastName) AS InstructorFullName
FROM Instructors;

-- ---------------------------------------------------------------------
-- Q15. Running total of students enrolled in courses (window function)
-- ---------------------------------------------------------------------
SELECT CourseID,
       COUNT(StudentID) AS StudentsInCourse,
       SUM(COUNT(StudentID)) OVER (ORDER BY CourseID) AS RunningTotal
FROM Enrollments
GROUP BY CourseID
ORDER BY CourseID;

-- ---------------------------------------------------------------------
-- Q16. Label students 'Senior' / 'Junior' (CASE expression)
-- Senior = enrollment date is MORE than 4 years before current date
-- ---------------------------------------------------------------------
SELECT StudentID, FirstName, LastName, EnrollmentDate,
       CASE
           WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR) THEN 'Senior'
           ELSE 'Junior'
       END AS StudentLevel
FROM Students;

-- ======================== END OF SCRIPT ==============================
