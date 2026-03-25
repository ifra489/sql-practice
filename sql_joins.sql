-- ============================================================
-- LAB 2: SQL JOINs
-- Database: joins
-- Topics: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN,
--         UNION, MAX, Subquery, SUM, MONTH()
-- ============================================================
 
-- Create and select the database
CREATE DATABASE joins;
USE joins;
 
-- ============================================================
-- Create Persons table (Parent table)
-- P_Id is the Primary Key
-- ============================================================
CREATE TABLE Persons (
    P_Id INT PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50)
);
 
-- ============================================================
-- Create Orders table (Child table)
-- Per_id is a Foreign Key referencing Persons(P_Id)
-- ============================================================
CREATE TABLE Orders (
    O_Id INT PRIMARY KEY,
    OrderDate DATE,
    OrderPrice INT,
    Per_id INT,
    FOREIGN KEY (Per_id) REFERENCES Persons(P_Id)
);
 
-- Insert 3 persons
INSERT INTO Persons VALUES
(1, 'Hansen',    'Ola',  'Timoteivn 10', 'Sandnes'),
(2, 'Svendson',  'Tove', 'Borgvn 23',   'Sandnes'),
(3, 'Pettersen', 'Kari', 'Storgt 20',   'Stavanger');
 
-- Insert 5 orders (Person 2 has no orders — useful for LEFT JOIN demo)
INSERT INTO Orders VALUES
(1, '2008-11-12', 1000, 3),
(2, '2008-10-23', 1600, 3),
(3, '2008-09-02',  700, 1),
(4, '2008-09-03',  300, 1),
(5, '2008-08-30', 2000, 1);
 
-- View all persons
SELECT * FROM Persons;
 
-- ============================================================
-- INNER JOIN: Returns only matching rows from both tables
-- (Person 2 'Svendson' will NOT appear — has no orders)
-- ============================================================
SELECT Persons.P_Id, FirstName, LastName, City,
       Orders.O_Id, OrderDate, OrderPrice
FROM Persons
INNER JOIN Orders
ON Persons.P_Id = Orders.Per_id;
 
-- ============================================================
-- LEFT JOIN: Returns all rows from LEFT table (Persons)
-- even if there is no match in Orders
-- (Person 2 'Svendson' WILL appear with NULL order values)
-- ============================================================
SELECT Persons.P_Id, FirstName, LastName, City,
       Orders.O_Id, OrderDate, OrderPrice
FROM Persons
LEFT JOIN Orders
ON Persons.P_Id = Orders.Per_id;
 
-- ============================================================
-- RIGHT JOIN: Returns all rows from RIGHT table (Orders)
-- even if there is no match in Persons
-- ============================================================
SELECT Persons.P_Id, FirstName, LastName, City,
       Orders.O_Id, OrderDate, OrderPrice
FROM Persons
RIGHT JOIN Orders
ON Persons.P_Id = Orders.Per_id;
 
-- ============================================================
-- FULL OUTER JOIN: Returns all rows from both tables
-- NULL where there is no match on either side
-- ============================================================
SELECT Persons.P_Id, FirstName, LastName, City,
       Orders.O_Id, OrderDate, OrderPrice
FROM Persons
FULL OUTER JOIN Orders
ON Persons.P_Id = Orders.Per_id;
 
-- ============================================================
-- UNION of LEFT + RIGHT JOIN: Alternative to FULL OUTER JOIN
-- Combines all records from both sides (duplicates removed)
-- ============================================================
SELECT Persons.P_Id, FirstName, LastName, City,
       Orders.O_Id, OrderDate, OrderPrice
FROM Persons
LEFT JOIN Orders ON Persons.P_Id = Orders.Per_id
UNION
SELECT Persons.P_Id, FirstName, LastName, City,
       Orders.O_Id, OrderDate, OrderPrice
FROM Persons
RIGHT JOIN Orders ON Persons.P_Id = Orders.Per_id;
 
-- ============================================================
-- MAX: Find the highest order price
-- ============================================================
SELECT MAX(OrderPrice) AS MaxPrice
FROM Orders;
 
-- ============================================================
-- Subquery: Find the person who placed the most expensive order
-- Uses MAX() inside a WHERE clause (correlated subquery)
-- ============================================================
SELECT P.*
FROM Persons P
JOIN Orders O ON P.P_Id = O.Per_id
WHERE O.OrderPrice = (
    SELECT MAX(OrderPrice) FROM Orders
);
 
-- ============================================================
-- Find persons who have orders with price greater than 1000
-- DISTINCT removes duplicate person rows
-- ============================================================
SELECT DISTINCT P.*
FROM Persons P
JOIN Orders O ON P.P_Id = O.Per_id
WHERE O.OrderPrice > 1000;
 
-- ============================================================
-- Find persons who placed orders in September (Month = 9)
-- MONTH() extracts month number from a date
-- ============================================================
SELECT DISTINCT P.*
FROM Persons P
JOIN Orders O ON P.P_Id = O.Per_id
WHERE MONTH(O.OrderDate) = 9;
 
-- ============================================================
-- SUM: Total order price for a specific person ('Pettersen')
-- ============================================================
SELECT SUM(O.OrderPrice) AS TotalPrice
FROM Persons P
JOIN Orders O ON P.P_Id = O.Per_id
WHERE P.LastName = 'Pettersen';