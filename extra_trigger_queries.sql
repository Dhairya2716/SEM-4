CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
);

CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);

--1) Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails 
--table to display the message 
--"Employee record inserted", "Employee record updated", "Employee record deleted"

create or alter trigger tr_fire_insert
on EmployeeDetails
after insert
as
begin
	print('Employee record inserted')
end

create trigger tr_fire_update
on EmployeeDetails
after update
as
begin
	print('Employee record updated')
end

create trigger tr_fire_delete
on EmployeeDetails
after delete
as
begin
	print('Employee record deleted')
end


insert into EMPLOYEEDETAILS values(1,'Dhairya','1216','CE',1000,'2023-7-5')
update EMPLOYEEDETAILS set EmployeeName = 'kb' where EmployeeID = 1
delete from EMPLOYEEDETAILS where EmployeeID = 1

drop trigger tr_fire_insert
drop trigger tr_fire_update
drop trigger tr_fire_delete


--2) Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails 
--table to log all operations into the EmployeeLog table.

create trigger tr_fire_insert_queries_in_employeelog
on EmployeeDetails
after insert
as
begin
	declare @Id int,@Name varchar(100)
	select @ID=EmployeeID from inserted
	select @Name=EmployeeName from inserted

	insert into EmployeeLogs values (@Id,@Name,'inserted',GETDATE())
end

create trigger tr_fire_update_queries_in_employeelog
on EmployeeDetails
after update
as
begin
	declare @Id int,@Name varchar(100)
	select @ID=EmployeeID from inserted
	select @Name=EmployeeName from inserted

	insert into EmployeeLogs values (@Id,@Name,'updated',GETDATE())
end

create trigger tr_fire_delete_queries_in_employeelog
on EmployeeDetails
after delete
as
begin
	declare @Id int,@Name varchar(100)
	select @ID=EmployeeID from deleted
	select @Name=EmployeeName from deleted

	insert into EmployeeLogs values (@Id,@Name,'deleted',GETDATE())
end

insert into EMPLOYEEDETAILS values(1,'Dhairya','1216','CE',1000,'2023-7-5')
update EMPLOYEEDETAILS set EmployeeName = 'kb' where EmployeeID = 1
delete from EMPLOYEEDETAILS where EmployeeID = 1

select * from EMPLOYEEDETAILS
select * from EmployeeLogs

drop trigger tr_fire_insert_queries_in_employeelog
drop trigger tr_fire_update_queries_in_employeelog
drop trigger tr_fire_delete_queries_in_employeelog

--3) Create a trigger that fires AFTER INSERT to automatically calculate 
--the joining bonus (10% of the salary) for new employees and 
--update a bonus column in the EmployeeDetails table.

create trigger tr_joiningbonus_after_insert
on EmployeeDetails
after insert
as
begin
	declare @Bonus decimal(8,2)=0,@Salary decimal(8,2),@EMPID int
	select @EMPID=EmployeeID,@Salary=Salary from inserted
	set @Bonus=@Salary+@Salary*0.1

	update EMPLOYEEDETAILS
	set Salary=@Bonus
	where EmployeeID=@EMPID

end

--4) Create a trigger to ensure that the JoiningDate is automatically 
--set to the current date if it is NULL during an INSERT operation.

create trigger tr_joiningdate_after_insert
on EmployeeDetails
after insert
as
begin
	declare @Jdate datetime,@EID int
	select @Jdate=JoiningDate,@EID=EmployeeID from inserted

	if(@Jdate is null)
	begin
		update EMPLOYEEDETAILS
		set @Jdate=GETDATE()
		where EmployeeID=@EID
	end
end

--5) Create a trigger that ensure that ContactNo is valid during insert and update 
--(Like ContactNo length is 10)

create trigger tr_validate_phoneno_after_insert
on EmployeeDetails
after insert
as
begin
	declare @phoneno int,  @EID int
	select @phoneno = ContactNo, @EID=EmployeeID from inserted

	if(@phoneno != 10)
	begin
		update EMPLOYEEDETAILS
		set @phoneno=GETDATE()
		where EmployeeID=@EID
	end
end

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);

insert into Movies values(101,'AVENGER ENDGAME',2019,'3',10.0,150)

select * from Movies

--1. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed on the Movies table into MoviesLog.
CREATE OR ALTER TRIGGER TR_InsteadOfMoviesOperations
ON Movies
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Action VARCHAR(100), @MovieID INT, @MovieTitle VARCHAR(255);
    
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Action = 'Inserted';
        SELECT @MovieID = MovieID, @MovieTitle = MovieTitle FROM inserted;
    END
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        IF @Action = 'Inserted'
        BEGIN
            SET @Action = 'Updated';
        END
        ELSE
        BEGIN
            SET @Action = 'Deleted';
            SELECT @MovieID = MovieID, @MovieTitle = MovieTitle FROM deleted;
        END
    END

    INSERT INTO MoviesLog (MovieID, MovieTitle, ActionPerformed, ActionDate)
    VALUES (@MovieID, @MovieTitle, @Action, GETDATE());

    -- Perform actual operation after logging (if needed)
    IF @Action = 'Inserted'
    BEGIN
        INSERT INTO Movies (MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration)
        SELECT MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration FROM inserted;
    END
    ELSE IF @Action = 'Updated'
    BEGIN
        UPDATE Movies
        SET MovieTitle = inserted.MovieTitle,
            ReleaseYear = inserted.ReleaseYear,
            Genre = inserted.Genre,
            Rating = inserted.Rating,
            Duration = inserted.Duration
        FROM inserted WHERE Movies.MovieID = inserted.MovieID;
    END
    --ELSE IF @Action = 'Deleted'
    --BEGIN
    --    DELETE FROM Movies WHERE MovieID = deleted.MovieID;
    --END
END;

drop trigger TR_InsteadOfMoviesOperations

--2. Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .
CREATE OR ALTER TRIGGER TR_ValidateMovieRating
ON Movies
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Rating <= 5.5)
    BEGIN
        PRINT 'Movie Rating must be greater than 5.5.';
    END
    ELSE
    BEGIN
        INSERT INTO Movies (MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration)
        SELECT MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration FROM inserted;
    END
END;

drop trigger TR_ValidateMovieRating

--3. Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.
CREATE OR ALTER TRIGGER TR_PreventDuplicateMovieTitle
ON Movies
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE MovieTitle IN (SELECT MovieTitle FROM Movies))
    BEGIN
        PRINT 'Movie title already exists in the Movies table.';
        INSERT INTO MoviesLog (MovieTitle, ActionPerformed, ActionDate)
        SELECT MovieTitle, 'Duplicate Insert Attempt', GETDATE() FROM inserted;
    END
    ELSE
    BEGIN
        INSERT INTO Movies (MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration)
        SELECT MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration FROM inserted;
    END
END;

drop trigger TR_PreventDuplicateMovieTitle

--4. Create trigger that prevents to insert pre-release movies.
CREATE OR ALTER TRIGGER TR_PreventPreReleaseMovies
ON Movies
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE ReleaseYear < YEAR(GETDATE()))
    BEGIN
        PRINT 'Cannot insert pre-release movies.';
    END
    ELSE
    BEGIN
        INSERT INTO Movies (MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration)
        SELECT MovieID, MovieTitle, ReleaseYear, Genre, Rating, Duration FROM inserted;
    END
END;

drop trigger TR_PreventPreReleaseMovies

--5. Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.
CREATE OR ALTER TRIGGER TR_ValidateMovieDuration
ON Movies
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Duration > 120)
    BEGIN
        PRINT 'Movie duration cannot be greater than 120 minutes.';
    END
    ELSE
    BEGIN
        UPDATE Movies
        SET MovieTitle = inserted.MovieTitle,
            ReleaseYear = inserted.ReleaseYear,
            Genre = inserted.Genre,
            Rating = inserted.Rating,
            Duration = inserted.Duration
        FROM inserted WHERE Movies.MovieID = inserted.MovieID;
    END
END;

drop trigger TR_ValidateMovieDuration