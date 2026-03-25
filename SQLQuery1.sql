-- ================================================
-- WorksOn Database: Create & Insert
-- ================================================

CREATE DATABASE  workson_db;
USE workson_db;

-- ================================================
-- 1. DEPT TABLE (pehle banao, emp depend karta hai)
-- ================================================
CREATE TABLE dept (
    dno     INT PRIMARY KEY,
    dname   VARCHAR(50) NOT NULL,
    mgreno  INT  -- Manager (FK to emp, baad mein add karein)
);

-- ================================================
-- 2. EMP TABLE
-- ================================================
CREATE TABLE emp (
    eno     INT PRIMARY KEY,
    ename   VARCHAR(50) NOT NULL,
    bdate   DATE,
    title   VARCHAR(30),
    salary  DECIMAL(10,2),
    dno     INT,
    FOREIGN KEY (dno) REFERENCES dept(dno)
);

-- ================================================
-- 3. Ab dept mein mgreno FK add karo
-- ================================================
ALTER TABLE dept
    ADD CONSTRAINT fk_mgr
    FOREIGN KEY (mgreno) REFERENCES emp(eno);

-- ================================================
-- 4. PROJ TABLE
-- ================================================
CREATE TABLE proj (
    pno     INT PRIMARY KEY,
    pname   VARCHAR(50) NOT NULL,
    budget  DECIMAL(12,2),
    dno     INT,
    FOREIGN KEY (dno) REFERENCES dept(dno)
);

-- ================================================
-- 5. WORKSON TABLE (composite PK)
-- ================================================
CREATE TABLE workson (
    eno     INT,
    pno     INT,
    resp    VARCHAR(30),
    hours   DECIMAL(5,1),
    PRIMARY KEY (eno, pno),
    FOREIGN KEY (eno) REFERENCES emp(eno),
    FOREIGN KEY (pno) REFERENCES proj(pno)
);

-- ================================================
-- DATA INSERT
-- ================================================

-- Dept insert (mgreno baad mein update karein)
INSERT INTO dept (dno, dname, mgreno) VALUES
(10, 'Engineering',   NULL),
(20, 'Marketing',     NULL),
(30, 'Finance',       NULL);

-- Emp insert
INSERT INTO emp (eno, ename, bdate, title, salary, dno) VALUES
(101, 'Ali Hassan',    '1985-03-12', 'Manager',    85000, 10),
(102, 'Sara Khan',     '1990-07-25', 'Engineer',   60000, 10),
(103, 'Usman Raza',    '1988-11-05', 'Analyst',    55000, 20),
(104, 'Ayesha Noor',   '1992-02-18', 'Designer',   52000, 20),
(105, 'Bilal Ahmed',   '1987-09-30', 'Accountant', 58000, 30),
(106, 'Hina Malik',    '1995-06-14', 'Manager',    80000, 30);

-- Dept manager update
UPDATE dept SET mgreno = 101 WHERE dno = 10;
UPDATE dept SET mgreno = 103 WHERE dno = 20;
UPDATE dept SET mgreno = 106 WHERE dno = 30;

-- Proj insert
INSERT INTO proj (pno, pname, budget, dno) VALUES
(1, 'Website Redesign',  500000, 10),
(2, 'Ad Campaign',       300000, 20),
(3, 'Annual Audit',      150000, 30),
(4, 'Mobile App',        750000, 10);

-- Workson insert
INSERT INTO workson (eno, pno, resp, hours) VALUES
(101, 1, 'Lead',       40.0),
(102, 1, 'Developer',  80.0),
(102, 4, 'Developer',  60.0),
(103, 2, 'Analyst',    50.0),
(104, 2, 'Designer',   45.0),
(105, 3, 'Auditor',    70.0),
(106, 3, 'Lead',       35.0),
(101, 4, 'Lead',       30.0);

-- ================================================
-- VERIFY (check)
-- ================================================
SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM proj;
SELECT * FROM workson;


-- Q1: Project number and name where budget > $100,000
-- Note: Do not include comma or dollar sign in query
SELECT pno, pname
FROM proj
WHERE budget > 100000;
 
-- Q2: All workson records where hours < 10 AND responsibility = 'Manager'
SELECT *
FROM workson
WHERE hours < 10 AND resp = 'Manager';
 
-- Q3: Employee number and name where title is 'EE' or 'SA' AND salary > $35,000
-- Note: Parentheses are required around OR condition
SELECT eno, ename
FROM emp
WHERE (title = 'EE' OR title = 'SA') AND salary > 35000;
 
-- Q4: Employee names in department 'D1' ordered by decreasing salary
-- Note: Can sort on a field (salary) not included in SELECT
SELECT ename
FROM emp
WHERE dno = 'D1'
ORDER BY salary DESC;
 
-- Q5: All department fields ordered by ascending department name
SELECT *
FROM dept
ORDER BY dname ASC;
 
-- Q6: Employee name, department name, and title
-- JOIN between emp and dept using matching dno
SELECT ename, dname, title
FROM emp, dept
WHERE emp.dno = dept.dno;
 
-- Q7: Project name, hours worked, and project number where hours > 10
-- JOIN between workson and proj using matching pno
SELECT pname, hours, proj.pno
FROM workson, proj
WHERE hours > 10 AND proj.pno = workson.pno;
 
-- Q8: Project name, department name, and budget where budget < $50,000
-- JOIN between proj and dept using matching dno
SELECT pname, dname, budget
FROM proj, dept
WHERE budget < 50000 AND proj.dno = dept.dno;
 
-- Q9: Employee numbers and salaries in 'Consulting' department
-- ordered by descending salary
-- JOIN between emp and dept to filter by department name
SELECT eno, salary
FROM emp, dept
WHERE dname = 'Consulting' AND emp.dno = dept.dno
ORDER BY salary DESC;
 
-- Q10: Employee name, project name, title, and hours for all workson records
-- 3-table JOIN: emp + proj + workson
SELECT ename, pname, title, hours
FROM emp, proj, workson
WHERE emp.eno = workson.eno AND proj.pno = workson.pno;