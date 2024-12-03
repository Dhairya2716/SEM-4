CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

create PROCEDURE PR_Department_INSERT
	@DepartmentID int,
	@DepartmentName varchar(100)
AS
BEGIN
	insert into Department
	(DepartmentID,DepartmentName)
	VALUES
	(@DepartmentID,@DepartmentName)
END

EXEC PR_Department_INSERT 1 ,'Admin'
EXEC PR_Department_INSERT 2 ,'IT'
EXEC PR_Department_INSERT 3 ,'HR'
EXEC PR_Department_INSERT 4 ,'Account'

select * from Department

CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

create PROCEDURE PR_Designation_INSERT
	@DesignationID int,
	@DesignationName varchar(100)
AS
BEGIN
	insert into Designation
	(DesignationID,DesignationName)
	VALUES
	(@DesignationID,@DesignationName)
END

EXEC PR_Designation_INSERT 11 ,'Jobber'
EXEC PR_Designation_INSERT 12 ,'Welder'
EXEC PR_Designation_INSERT 13 ,'Clerk'
EXEC PR_Designation_INSERT 14 ,'Manager'
EXEC PR_Designation_INSERT 15 ,'CEO'

select * from Designation

CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

Alter PROCEDURE PR_Person_INSERT
	@FirstName varchar(100),
	@LastName varchar(100),
	@Salary Decimal(8,2),
	@JoiningDate Datetime,
	@DepartmentID int,
	@DesignationID int
AS
BEGIN
	insert into Person
	(FirstName,LastName,Salary,JoiningDate,DepartmentID,DesignationID)
	VALUES
	(@FirstName,@LastName,@Salary,@JoiningDate,@DepartmentID,@DesignationID)
END

EXEC PR_Person_INSERT 'Rahul' , 'Anshu', 56000.0 , '1990-01-01' , 1 , 12
EXEC PR_Person_INSERT 'Hardik' , 'Hinsu', 18000.0 , '1990-09-25' , 2 , 11
EXEC PR_Person_INSERT 'Bhavin' , 'Kamani', 25000.0 , '1991-05-14' , NULL , 11
EXEC PR_Person_INSERT 'Bhoomi' , 'Patel', 39000.0 , '2014-02-20' , 1 , 13
EXEC PR_Person_INSERT 'Rohit' , 'Rajgor', 17000.0 , '1990-07-23' , 2 , 15
EXEC PR_Person_INSERT 'Priya' , 'Mehta', 25000.0 , '1990-10-18' , 2 , NULL
EXEC PR_Person_INSERT 'Neha' , 'Trivedi', 18000.0 , '2014-02-20' , 3 , 15

select * from Person

CREATE PROCEDURE PR_Department_DELETE
	@DepartmentID int
AS
BEGIN
	 DELETE FROM Department
     WHERE  DepartmentID = @DepartmentID
END