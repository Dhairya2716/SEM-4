-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
PersonID INT PRIMARY KEY,
PersonName VARCHAR(100) NOT NULL,
Salary DECIMAL(8,2) NOT NULL,
JoiningDate DATETIME NULL,
City VARCHAR(100) NOT NULL,
Age INT NULL,
BirthDate DATETIME NOT NULL
);

-- Creating PersonLog Table
CREATE TABLE PersonLog (
PLogID INT PRIMARY KEY IDENTITY(1,1),
PersonID INT NOT NULL,
PersonName VARCHAR(250) NOT NULL,
Operation VARCHAR(50) NOT NULL,
UpdateDate DATETIME NOT NULL,
--FOREIGN KEY (PersonID) REFERENCES PersonInfo(PersonID) ON DELETE CASCADE
);

-----------------Part – A

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation 
--on the PersonInfo table to display a message “Record is Affected.”

create or alter trigger tr_display_msg
on PersonInfo 
after insert, update, delete
as 
begin 
	print('Record is affected')
end

insert into PersonInfo values(101,'malay',1000,'2020-7-7','junagadh',19,'2005-7-7')

drop trigger tr_display_msg

--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation 
--on the PersonInfo table. For that, log all operations performed on the person table into PersonLog.

----inserted

create or alter trigger tr_person_after_insert
on PersonInfo
after insert
as 
begin 
	declare @pid int, @pname varchar(100)
	select @pid = PersonID from inserted
	select @pname = PersonName from inserted

	insert into PersonLog
	values(@pid,@pname,'insert',getdate())
end

select * from PersonInfo
select * from PersonLog
insert into PersonInfo values(101,'malay',1000,'2020-7-7','junagadh',19,'2005-7-7')
insert into PersonInfo values(102,'DHAIRYA',1216,'2023-7-5','Rajkot',19,'2006-1-12')
insert into PersonInfo values(103,'KALP',1234,'2023-8-5','JAMNAGAR',19,'2005-11-12')

drop trigger tr_person_after_insert 
----update

create or alter trigger tr_person_after_update
on PersonInfo
after update
as
begin
	declare @uname varchar(100), @uid int
	
	update PersonInfo
	set PersonName = @uname
	where PersonID = @uid
end

drop trigger tr_person_after_update

update PersonInfo set PersonName = 'Meet' where PersonID = 103

---delete---

create or alter trigger tr_person_after_delete
on PersonInfo
after delete
as 
begin 
	declare @pid int, @pname varchar(100)
	select @pid = PersonID from deleted
	select @pname = PersonName from deleted

	insert into PersonLog
	values(@pid,@pname,'delete',getdate())
end

delete from PersonInfo where PersonID = 101

drop trigger tr_person_after_delete


--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation
-- on the PersonInfo table. For that, log all operations performed on the person table into PersonLog.

----inserted

create or alter trigger tr_person_instead_of_insert
on PersonInfo
instead of insert
as 
begin 
	declare @pid int, @pname varchar(100)
	select @pid = PersonID from inserted
	select @pname = PersonName from inserted

	insert into PersonLog
	values(@pid,@pname,'insert',getdate())
end

insert into PersonInfo values(105,'instead',8946,'2020-5-8','asd',45,'2004-1-6')
select * from PersonInfo
select * from PersonLog
drop trigger tr_person_instead_of_insert

---update

create or alter trigger tr_person_instead_of_update
on PersonInfo
instead of update
as
begin
	declare @uname varchar(100), @uid int
	
	update PersonInfo
	set PersonName = @uname
	where PersonID = @uid
end

update PersonInfo set PersonName = 'testing' where PersonID = 104
select * from PersonInfo
select * from PersonLog

drop trigger tr_person_instead_of_update

---delete

create or alter trigger tr_person_instead_of_delete
on PersonInfo
instead of delete
as 
begin 
	declare @pid int, @pname varchar(100)
	select @pid = PersonID from deleted
	select @pname = PersonName from deleted

	insert into PersonLog
	values(@pid,@pname,'delete',getdate())
end

delete from PersonInfo where PersonID = 104

select * from PersonInfo
select * from PersonLog

drop trigger tr_person_instead_of_delete

--4. Create a trigger that fires on INSERT operation on the PersonInfo table 
--to convert person name into uppercase whenever the record is inserted.

create or alter trigger tr_convert_to_uppercase
on PersonInfo
after insert
as
begin
	declare @pid int, @pname varchar(100)
	select @pid = PersonID from inserted
	select @pname = PersonName from inserted

	update PersonInfo
	set PersonName = UPPER(@pname)
	where PersonID = @pid
end

insert into PersonInfo values(104,'viraj',1000,'2022-8-9','morbi',20,'1990-1-5')

drop trigger tr_convert_to_uppercase

select * from PersonInfo
select * from PersonLog


--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.

create or alter trigger tr_prevent_duplicate_entries
on PersonInfo
instead of insert
as 
begin
	insert into PersonInfo 
	select PersonID,PersonName,Salary ,JoiningDate, City,Age,BirthDate from inserted
	where PersonName not in (select PersonName from PersonInfo) 
end


insert into PersonInfo values(104,'viraj',1000,'2022-8-9','morbi',20,'1990-1-5')
drop trigger tr_prevent_duplicate_entries

select * from PersonInfo
select * from PersonLog
--6. Create trigger that prevent Age below 18 years.

create or alter trigger tr_prevent_age_below_18
on PersonInfo
instead of insert
as 
begin
	insert into PersonInfo 
	select PersonID,PersonName,Salary ,JoiningDate, City,Age,BirthDate from inserted
	where Age > 18 
end


insert into PersonInfo values(107,'viraj',1000,'2022-8-9','morbi',7,'1990-1-5')
insert into PersonInfo values(108,'manu',5000,'2023-8-9','morbi',20,'1991-1-5')
drop trigger tr_prevent_age_below_18


--Part – B
--7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update that age in Person table.

create or alter trigger tr_cal_age
on PersonInfo
after insert
as 
begin
	update PersonInfo
	set age = Datediff(year, JoiningDate, GETDATE())
	where PersonID in (select PersonID from PersonInfo)
end

drop trigger tr_cal_age

--8. Create a Trigger to Limit Salary Decrease by a 10%.

create or alter trigger tr_limit_salary
on PersonInfo
after update
as 
begin
	declare @oldsalary decimal(8,2), @newsalary decimal(8,2), @pid int
	select @oldsalary = Salary, @pid = personID
	from deleted
	select @newsalary = Salary
	from inserted where PersonID = @pid

	if (@newsalary < @oldsalary * 0.9)
	Begin
		update PersonInfo
		set Salary = @oldsalary
		where PersonID = @pid
	end
end

insert into PersonInfo values(112,'cutinsalary',1000,'2022-2-2','surat',25,'1999-8-9')

select * from PersonInfo
drop trigger tr_limit_salary

--Part – C
--9. Create Trigger to Automatically Update JoiningDate to Current Date 
--on INSERT if JoiningDate is NULL during an INSERT.

create or alter trigger tr_update_date
on PersonInfo
after insert
as
begin
	declare @joindate datetime
	if (@joindate is null)
	begin
		update PersonInfo
		set JoiningDate = GETDATE()
		where PersonID in (select PersonID from PersonInfo)
	end
end

insert into PersonInfo values(111,'nulldate',5000,null,'baroda',21,'2000-8-9')

select * from PersonInfo
drop trigger tr_update_date

--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table 
--it prints ‘Record deleted successfully from PersonLog’.

create or alter trigger tr_delete_dialog
on PersonLog
after delete
as 
begin
	print('Record is deleted successfully')
end

select * from PersonLog

delete from PersonLog where PersonID = 105
drop trigger tr_delete_dialog
