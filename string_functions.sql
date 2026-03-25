-- ============================================================
-- Assignment 1: String Functions & DDL Basics
-- Topics: SUBSTRING, LTRIM, RTRIM, CHARINDEX, CONCAT,
--         REPLACE, ROW_NUMBER, CONVERT, ALTER TABLE
-- ============================================================
 
-- SUBSTRING: Extract first 4 characters from 'Rawalpindi'
-- Result: 'Rawa'
SELECT SUBSTRING('Rawalpindi', 1, 4) AS Result;
 
-- LTRIM: Remove leading (left side) spaces from string
-- Result: 'SQL Server'
SELECT LTRIM('   SQL Server') AS Result;
 
-- CHARINDEX: Find position of character 'Q' in 'SQL Server'
-- Result: 2 (1-based index)
SELECT CHARINDEX('Q', 'SQL Server') AS Position;
 
-- ============================================================
-- Create Student table and insert a record
-- ============================================================
CREATE TABLE Student (
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);
 
INSERT INTO Student VALUES
('Aiman', 'Malik');
 
-- CONCAT: Join FirstName and LastName with a space
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Student;
 
-- Alternative way to concatenate using + operator
SELECT FirstName + ' ' + LastName AS FullName
FROM Student;
 
-- ============================================================
-- Create Students table WITHOUT Primary Key first,
-- then add Primary Key using ALTER TABLE
-- ============================================================
CREATE TABLE Students (
    ID INT NOT NULL,
    Name VARCHAR(50)
);
 
-- ALTER TABLE: Add Primary Key constraint after table creation
ALTER TABLE Students
ADD CONSTRAINT PK_Students
PRIMARY KEY (ID);
 
-- Insert a record into Students
INSERT INTO Students VALUES (1, 'Aiman');
 
-- View all records
SELECT * FROM Students;
 
-- REPLACE: Replace 'Java' with 'SQL' in the given string
-- Result: 'I like SQL'
SELECT REPLACE('I like Java', 'Java', 'SQL') AS Result;
 
-- RTRIM: Remove trailing (right side) spaces from string
-- Result: 'SQL Server'
SELECT RTRIM('SQL Server   ') AS Result;
 
-- ROW_NUMBER: Assign row numbers to students ordered by FirstName descending
-- OVER clause defines the ordering for the window function
SELECT
    FirstName,
    ROW_NUMBER() OVER (ORDER BY FirstName DESC) AS RowNum
FROM Student;
 
-- CONVERT: Display current date in DD/MM/YYYY format
-- Format code 103 = British/French date format
SELECT CONVERT(VARCHAR, GETDATE(), 103) AS FormattedDate;