CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employee (EmpID, Name, Salary) VALUES
(1, 'Ali', 55000),
(2, 'Sara', 60000),
(3, 'Ahmed', 55000);

SELECT * FROM Employee;


CREATE TABLE EmployeeDetails (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO EmployeeDetails (EmpID, Name, Salary) VALUES
(1, 'Ali', NULL),
(4, 'David', NULL);

SELECT * FROM EmployeeDetails;


UPDATE ed
SET ed.Salary = e.Salary
FROM EmployeeDetails ed
INNER JOIN Employee e 
ON ed.EmpID = e.EmpID;

INSERT INTO EmployeeDetails (EmpID, Name, Salary)
SELECT e.EmpID, e.Name, e.Salary
FROM Employee e
WHERE e.EmpID NOT IN (
    SELECT EmpID FROM EmployeeDetails
);

SELECT * FROM EmployeeDetails;

--Question 2---

CREATE TABLE Product (
    ProductID INT,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Product VALUES
(1, 'Laptop', 75000),
(2, 'Mobile', 45000),
(3, 'Tablet', 30000);

SELECT * FROM Product;

SELECT *
INTO Product_Backup
FROM Product;

SELECT * FROM Product_Backup;


CREATE TABLE Employes (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2),
    BonusSalary DECIMAL(10,2)
);

INSERT INTO Employes (EmpID, Name, Salary, BonusSalary) VALUES
(1, 'Ali', 50000, NULL),
(2, 'Sara', 60000, NULL),
(3, 'David', 55000, NULL);

SELECT * FROM Employee;

UPDATE Employes
SET BonusSalary = Salary;
SELECT * FROM Employes;