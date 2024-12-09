CREATE DATABASE library;
USE library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES 
(1, 101, '123 Main St, City A', '9876543210'),
(2, 102, '456 Elm St, City B', '8765432109'),
(3, 103, '789 Pine St, City C', '7654321098');
select * from branch;

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(101, 'Alice Johnson', 'Manager', 75000, 1),
(102, 'Bob Smith', 'Manager', 72000, 2),
(103, 'Clara Lee', 'Manager', 71000, 3),
(104, 'David Brown', 'Librarian', 50000, 1),
(105, 'Eve Davis', 'Assistant Librarian', 40000, 2),
(106, 'Frank Harris', 'Assistant Librarian', 38000, 3);
select * from employee;

CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
('9781111111111', 'Introduction to Python', 'Programming', 30.00, 'yes', 'John Doe', 'TechBooks'),
('9782222222222', 'History of Civilizations', 'History', 25.00, 'no', 'Jane Austen', 'WorldBooks'),
('9783333333333', 'Advanced SQL Queries', 'Programming', 35.00, 'yes', 'Alan Turing', 'CodeBooks'),
('9784444444444', 'Modern Art: An Overview', 'Art', 40.00, 'yes', 'Leonardo Vinci', 'ArtPress'),
('9785555555555', 'Physics for Beginners', 'Science', 20.00, 'no', 'Marie Curie', 'SciencePub');
select * from books;

select * from 
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(201, 'Chris Evans', '12 Oak St, City A', '2021-12-15'),
(202, 'Diana Prince', '34 Maple St, City B', '2020-05-10'),
(203, 'Bruce Wayne', '56 Willow St, City C', '2022-07-20'),
(204, 'Clark Kent', '78 Cedar St, City A', '2023-03-01'),
(205, 'Natasha Romanoff', '90 Birch St, City B', '2021-11-30');
select * from customer;

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(301, 201, 'Introduction to Python', '2023-06-15', '9781111111111'),
(302, 202, 'Advanced SQL Queries', '2023-06-20', '9783333333333'),
(303, 204, 'Modern Art: An Overview', '2023-06-10', '9784444444444');

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(401, 201, 'Introduction to Python', '2023-06-25', '9781111111111'),
(402, 202, 'Advanced SQL Queries', '2023-06-28', '9783333333333');
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';

SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

SELECT Books.Book_title, Customer.Customer_name 
FROM Books 
JOIN IssueStatus ON Books.ISBN = IssueStatus.Isbn_book 
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
  AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;
SELECT Customer.Customer_name 
FROM Customer 
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust 
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;

SELECT Emp_name, Branch_address 
FROM Employee 
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

SELECT DISTINCT Customer.Customer_name 
FROM Customer 
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust 
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN 
WHERE Books.Rental_Price > 25;
