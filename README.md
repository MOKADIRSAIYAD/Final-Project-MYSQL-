# 🎓 University Course Management System (SQL Final Project)

**Red & White Skill Education – Final Project (SQL)**

A complete MySQL database for a University Course Management System covering CRUD operations, joins, subqueries, aggregation, string & date functions, window functions and the `CASE` expression.

---

## 📁 Repository Structure

```
├── university_course_management.sql   # Tables + sample data + all 16 queries
└── README.md                          # Project documentation
```

## 🛠️ Tech Stack

- MySQL 8.0 (window functions require 8.0+)
- MySQL Workbench

## ▶️ How to Run

1. Open **MySQL Workbench** and connect to your local server.
2. Open `university_course_management.sql` (File → Open SQL Script).
3. Press **Ctrl + A**, then click the ⚡ **Execute** button.
4. The script creates the `UniversityDB` database, tables, sample data and runs every query. Results appear in the result tabs.

---

## 🗂️ Database Schema

| Table | Columns |
|---|---|
| **Departments** | DepartmentID (PK), DepartmentName |
| **Students** | StudentID (PK), FirstName, LastName, Email, BirthDate, EnrollmentDate |
| **Courses** | CourseID (PK), CourseName, DepartmentID (FK), Credits |
| **Instructors** | InstructorID (PK), FirstName, LastName, Email, DepartmentID (FK), Salary |
| **Enrollments** | EnrollmentID (PK, auto increment), StudentID (FK), CourseID (FK), EnrollmentDate |

**Relationships**

- Department 1 → N Courses
- Department 1 → N Instructors
- Students N ↔ N Courses (through Enrollments)

---

## 📋 Queries Implemented

| # | Task | Concept |
|---|---|---|
| 1 | CRUD operations on all tables | INSERT / SELECT / UPDATE / DELETE |
| 2 | Students enrolled after 2022 | WHERE + YEAR() |
| 3 | Mathematics department courses (limit 5) | JOIN + LIMIT |
| 4 | Students per course, only courses with more than 5 | GROUP BY + HAVING |
| 5 | Students enrolled in both *Introduction to SQL* and *Data Structures* | HAVING COUNT(DISTINCT) |
| 6 | Students enrolled in either of the two courses | IN / OR logic |
| 7 | Average credits of all courses | AVG |
| 8 | Max salary of Computer Science instructors | MAX + JOIN |
| 9 | Students enrolled in each department | COUNT DISTINCT + multi-join |
| 10 | Students and their courses | INNER JOIN |
| 11 | All students with courses, if any | LEFT JOIN |
| 12 | Students in courses having more than 10 students | Subquery |
| 13 | Year from EnrollmentDate | YEAR() |
| 14 | Instructor full name | CONCAT() |
| 15 | Running total of students enrolled in courses | Window function `SUM() OVER` |
| 16 | Label students Senior / Junior | CASE + DATE_SUB |

---

## 📝 Assumptions

1. The **Instructors** table has no `Salary` column in the project document, but Query 8 needs it, so a `Salary` column was added.
2. Extra sample records (13 students, 8 courses, 4 instructors, 23 enrollments) were added beyond the document's samples so that queries with conditions like "more than 5" and "more than 10" return meaningful results.
3. "Enrolled after 2022" is interpreted as `YEAR(EnrollmentDate) > 2022` (i.e. 2023 onwards).
4. **Senior / Junior**: a student is labelled *Senior* if the enrollment date is more than 4 years before the current date (`CURDATE()`), otherwise *Junior*. Output changes over time since it depends on the current date.
5. The CRUD section uses temporary records (IDs 99 / 999) that are deleted at the end, so the main data stays unchanged.
6. "Number of students in each department" counts distinct students enrolled in that department's courses.
7. Enrollment records use the student's joining date as `EnrollmentDate`.

---

## 👤 Author

**Your Name**
MOHAMMADKADIR SAIYAD

---

> *Original work. No code copied from classmates or other sources.*
