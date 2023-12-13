create database library;
show databases;
use library;
create table Branch(
Branch_no  varchar(20) PRIMARY KEY,
 Manager_Id varchar(20),
 Branch_address varchar(50),
 Contact_no int
 );
create table Employee(
Emp_Id varchar(20) PRIMARY KEY,
 Emp_name varchar(50),
 Position varchar(30),
 Salary float,
 Branch_no varchar(20),
 FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
create table Customer(
Customer_Id varchar(20) PRIMARY KEY,
 Customer_name varchar(50),
 Customer_address varchar(80),
 Reg_date date
 );
create table Books(
 ISBN varchar(20) PRIMARY KEY,
 Book_title varchar(80),
 Category varchar(50),
 Rental_Price decimal(10,2),
 Status varchar(3) check(status in ('yes','no')),
 Author varchar(60),
 Publisher varchar(60)
 );
create table IssueStatus(
Issue_Id varchar(20) PRIMARY KEY,
 Issued_cust  varchar(20),
 Issued_book_name varchar(80),
 Issue_date date,
 Isbn_book varchar(20),
 FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
 FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
 );
 create table ReturnStatus(
 Return_Id varchar(20) PRIMARY KEY,
 Return_cust varchar(60),
 Return_book_name varchar(80),
 Return_date date,
 Isbn_book2 varchar(20),
 FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    ('B001', 'M001', '123 Main Street', 5551234),
    ('B002', 'M002', '456 Oak Avenue', 5555678),
    ('B003', 'M003', '789 Elm Street', 5559876),
    ('B004', 'M001', '567 Pine Avenue', 5554321),
	('B005', 'M002', '890 Maple Lane', 5555432);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
    ('E001', 'John Doe', 'Librarian', 50000, 'B001'),
    ('E002', 'Jane Smith', 'Assistant Librarian', 40000, 'B001'),
    ('E003', 'Alice Williams', 'Clerk', 30000, 'B002'),
    ('E004', 'Emily Davis', 'IT Specialist', 55000,'B002'),
	('E005', 'Sara Johnson', 'Librarian', 42000, 'B003'),
	('E006', 'Robert White', 'Maintenance Staff', 32000, 'B004'),
	('E007', 'Mark Johnson', 'Library Assistant', 35000, 'B005');
    
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
    ('C001', 'Alice Johnson', '456 Elm Street, Cityville', '2023-01-15'),
    ('C002', 'Bob Smith', '789 Oak Avenue, Townsville', '2023-02-20'),
    ('C003', 'Charlie Brown', '123 Maple Lane, Villageton', '2023-03-10'),
	('C004', 'David Wilson', '567 Birch Street, Hamletville', '2023-04-05'),
    ('C005', 'Eva Davis', '890 Cedar Lane, Suburbia', '2023-05-12'),
    ('C006', 'Frank White', '303 Maple Drive, Township', '2022-10-08'),
    ('C007', 'Grace Taylor', '404 Birch Lane, Districttown', '2020-11-15'),
    ('C008', 'Henry Wilson', '505 Walnut Road, Municipality', '2021-12-22');

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
	('ISBN001', 'The Great Gatsby', 'Fiction', 10.99, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
    ('ISBN002', 'Introduction to Python', 'Programming', 8.99, 'yes', 'John Doe', 'Tech Publications'),
    ('ISBN003', 'Data Science for Beginners', 'Data Science', 12.99, 'no', 'Jane Smith', 'Data Insights'),
	('ISBN004', 'To Kill a Mockingbird', 'Novel', 11.99, 'yes', 'Harper Lee', 'J.B. Lippincott'),
    ('ISBN005', 'The Catcher in the Rye', 'Novel', 10.49, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
    ('ISBN006','Pride and Prejudice', 'Classic', 10.99, 'yes', 'Jane Austen', 'Thomas Egerton'),
    ('ISBN007', 'Sapiens: A Brief History of Humankind', 'History', 15.99, 'yes', 'Yuval Noah Harari', 'Harper'),
	('ISBN008', 'The Diary of a Young Girl', 'Autobiography', 9.99, 'yes', 'Anne Frank', 'Doubleday');
    
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
    ('I001', 'C001', 'The Great Gatsby', '2023-04-01', 'ISBN001'),
    ('I002', 'C002', 'Introduction to Python', '2023-05-15', 'ISBN002'),
    ('I003', 'C003', 'To Kill a Mockingbird', '2023-06-10', 'ISBN004'),
	('I004', 'C004', 'Data Science for Beginners', '2023-07-05', 'ISBN003'),
    ('I005', 'C005', 'The Diary of a Young Girl', '2023-08-12', 'ISBN008');
    
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
    ('R001', 'C001', 'The Great Gatsby', '2023-07-15', 'ISBN001'),
    ('R002', 'C002', 'Introduction to Python', '2023-08-20', 'ISBN002'),
	('R003', 'C003', 'To Kill a Mockingbird', '2023-09-05', 'ISBN004'),
    ('R004', 'C004', 'Data Science for Beginners', '2023-10-12', 'ISBN003'),
    ('R005', 'C005', 'The Diary of a Young Girl', '2023-11-18', 'ISBN008');
    
    drop table Branch;
    drop table Employee;
	drop table Customer;
	drop table IssueStatus;
    drop table Books;
    drop table ReturnStatus;
    
-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary
FROM Employee 
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books
SELECT IssueStatus.Issued_book_name, Customer.Customer_name
FROM IssueStatus 
LEFT JOIN Customer on IssueStatus.Issued_cust = Customer.Customer_Id;

-- 4. Display the total count of books in each category
SELECT Category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary>50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
  AND Customer_Id NOT IN (
    SELECT DISTINCT Issued_cust
    FROM IssueStatus
    WHERE Issue_date IS NOT NULL
);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, count(*) AS Employee_count
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT Customer_name 
FROM Customer
LEFT JOIN  IssueStatus on Customer.Customer_Id = IssueStatus.Issued_cust
WHERE IssueStatus.Issue_date between '2023-05-31' AND '2023-07-01';

-- 9. Retrieve book_title from book table containing history.
SELECT Book_title 
FROM Books
WHERE lower(Book_title) LIKE '%history%';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, count(*) AS Employee_count
FROM Employee
GROUP BY Branch_no
HAVING Employee_count > 1;
-- i used > 1 here because my table doesnt have branches with more than 5 employees, maximum count of employees in a branch is 2