

-- ============================================================
-- LAB 1: DDL & DML Basics
-- Database: Student
-- Topics: CREATE, INSERT, UPDATE, DELETE, SELECT, DISTINCT, ORDER BY
-- ============================================================
 
-- Create a new database named Student
CREATE DATABASE Student;
 
-- Switch to the Student database
USE Student;
 
-- Create Students table with relevant columns
-- Reg_No is the Primary Key (unique identifier for each student)
CREATE TABLE Students (
   Name VARCHAR(50),
   Reg_No INT Primary Key,
   Courses VARCHAR(50),
   Course_Code INT,
   Offered_By VARCHAR(50)
);
 
-- View table (empty at this point)
SELECT * FROM Students;
 
-- Insert 10 student records
-- Note: Ikram (09) and Hassan (10) have NULL values for some fields
INSERT INTO Students (Name, Reg_No, Courses, Course_Code, Offered_By) VALUES
('Ali',     01, 'DIP',  1001, 'Mr. A'),
('Basit',   02, 'DBMS', 1002, 'Mr. X'),
('Akram',   03, 'OS',   1003, 'Mr. Y'),
('Asad',    04, 'DBMS', 1002, 'Mr. X'),
('Zeeshan', 05, 'DIP',  1001, 'Mr. A'),
('Muneer',  06, 'OS',   1003, 'Mr. Y'),
('Shafqat', 07, 'NM',   1004, 'Mr. H'),
('Ahsan',   08, 'OS',   1003, 'Mr. Y'),
('Ikram',   09, 'DIP',  NULL, NULL),
('Hassan',  10, NULL,   NULL, NULL);
 
-- View all inserted records
SELECT * FROM Students;
 
-- Update Ikram's (Reg_No=9) missing course info
UPDATE Students
SET Courses = 'DIP', Course_Code = 1001, Offered_By = 'Mr. A'
WHERE Reg_No = 9;
 
-- Update Hassan's (Reg_No=10) course to DSP (new course)
UPDATE Students
SET Courses = 'DSP', Course_Code = 1005, Offered_By = 'Mr. Z'
WHERE Reg_No = 10;
 
-- View records after update
SELECT * FROM Students;
 
-- Delete students with Reg_No 03 and 09
DELETE FROM Students
WHERE Reg_No IN (03, 09);
 
-- View records after first delete
SELECT * FROM Students;
 
-- Delete students with Reg_No 01, 05, and 08
DELETE FROM Students
WHERE Reg_No IN (01, 05, 08);
 
-- View records after second delete
SELECT * FROM Students;
 
-- Show unique/distinct course combinations (removes duplicate rows)
SELECT DISTINCT Courses, Course_Code, Offered_By
FROM Students;
 
-- Show all students sorted by Name in descending (Z to A) order
SELECT *
FROM Students
ORDER BY Name DESC;
 
-- Show distinct courses sorted by course name in descending order
SELECT DISTINCT Courses, Course_Code, Offered_By
FROM Students
ORDER BY Courses DESC;

