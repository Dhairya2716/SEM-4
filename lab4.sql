-----------------------LAB-04

--------PART-A
select * from person
select * from Department

--1. Write a function to print "hello world".

create or alter function PR_FUNCTION_HELLO_WORLD()
RETURNS varchar(20)
AS
BEGIN
	Declare @value varchar(20)
	set @value = 'Hello world';
	return @value;
END

select dbo.PR_FUNCTION_HELLO_WORLD()

--2. Write a function which returns addition of two numbers.

create or alter function FN_ADDITION(
	@n1 int,
	@n2 int
)
RETURNS int
AS
BEGIN
	Declare @Sum int
	set @Sum = @n1 + @n2
	return @Sum
END

select dbo.FN_ADDITION(1,2) as addition;

--3. Write a function to check whether the given number is ODD or EVEN.

create or alter function FN_ODD_OR_EVEN(
	@num int
)
RETURNS varchar(20)
AS
BEGIN
	Declare @MSG varchar(20)
	IF @num % 2 = 0
		set @MSG = 'EVEN'
	ELSE
		set @MSG = 'ODD'

	RETURN @MSG
END

select dbo.FN_ODD_OR_EVEN(5) as checked;

--4. Write a function which returns a table with details of a person whose first name starts with B.

create or alter function FN_FIRSTNAME_WITH_B()
RETURNS TABLE
AS
	RETURN(Select FirstName from Person where FirstName like 'B%')

select * from dbo.FN_FIRSTNAME_WITH_B()

--5. Write a function which returns a table with unique first names from the person table.

create or alter function FN_UNIQUE_NAMES()
RETURNS TABLE
AS
	RETURN(Select Distinct FirstName from Person)

select * from FN_UNIQUE_NAMES()

--6. Write a function to print number from 1 to N. (Using while loop)

create or alter function FR_Print1ToN(@num int)
	returns varchar(100)
as
begin
	declare @i int = 1;
	declare @n varchar(100) = '';
	while @i <= @num
		begin
			set @n= @n + cast(@i as varchar)+ ' '
			set @i = @i + 1
		end
	return @n
end

select dbo.FR_Print1ToN(5) as num;

--7. Write a function to find the factorial of a given integer.

create or alter function FN_calculatefactorial(@num int)
RETURNS BIGINT
AS
BEGIN
	declare @Sum int = 1;
	declare @count int = 1;
	BEGIN
		while(@count <= @num)
			BEGIN
				set @Sum = @Sum * @count
				set @count +=  1
			END
	END
	RETURN @Sum
END

select dbo.FN_calculatefactorial(5)

------PART-B

--8. Write a function to compare two integers and return the comparison result. (Using Case statement)

create or alter function FN_CompareIntegers(@Integer1 int, @Integer2 int)
	returns varchar(50)
as
begin
    declare @Result varchar(50)

    set @Result = case
                    when @Integer1 > @Integer2 then 'Integer1 is greater than Integer2'
                    when @Integer1 < @Integer2 then 'Integer2 is greater than Integer1'
                    else 'Integer1 is equal to Integer2'
				end
    return @Result
end

select dbo.FN_CompareIntegers(5,6)

--9. Write a function to print the sum of even numbers between 1 to 20.

create or alter function FN_EvenSum1To20()
	returns int
as
begin
	declare @result int = 0;
	declare @i int = 1;
	while @i <= 20
		begin
			if @i % 2 = 0
				set @result = @result + @i
			set @i = @i + 1
		end
	return @result
end

select dbo.FN_EvenSum1To20()


--10. Write a function that checks if a given string is a palindrome

create or alter function FN_Palindrome(@string varchar(100))
	returns varchar(100)
as
begin
	declare @reverse varchar(100) = reverse(@string);
	declare @result varchar(100);
	if @string = @reverse
		set @result = 'Palindrome'
	else
		set @result = 'Not Palindrome'
	return @result
end

select dbo.FN_Palindrome('121')


-------PART_C

--11. Write a function to check whether a given number is prime or not.

create or alter function FN_PRIME_OR_NOT(@num int)
RETURNS varchar(20)
AS
BEGIN
	declare @MSG varchar(20)= ''
	if @num = 1
		BEGIN
			set @MSG = 'not a prime'
			return @MSG
		END
	declare @count int = 0;
	declare @i int = 2;
	while @i <= @num / 2
		begin
			if @num % @i = 0
				set @count = @count + 1
				set @i = @i + 1
		end
	if @count = 0
		set @MSG = 'Prime'
	else
		set @MSG = 'Not Prime'
	return @MSG
END

select dbo.FN_PRIME_OR_NOT(5)

--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.

create or alter function FN_DateDifference(@Start datetime, @End datetime)
	returns int
as
begin
	return datediff(day, @Start, @End)
end

select dbo.FN_DateDifference('2024-12-01', '2024-12-10')


--13. Write a function which accepts two parameters year & month in integer and returns total days each year.

create or alter function FN_GetDaysInMonthYear(@Year INT, @Month INT)
	returns int
as
begin
    return case 
                when @Month in (1, 3, 5, 7, 8, 10, 12) then 31
                when @Month in (4, 6, 9, 11) then 30
                when @Month = 2 and ((@Year % 4 = 0 and @Year % 100 != 0) or @Year % 400 = 0) then 29
                when @Month = 2 then 28
                else 0
            end
end

select dbo.FN_GetDaysInMonthYear(2024, 2)


--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.

create or alter function FN_Deptid(
	@deptid int
)
RETURNS TABLE
AS
	RETURN(select * from Department where DepartmentID = @deptid)

select * from dbo.FN_Deptid(1)
	

--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.

create or alter function FN_Persondetails_JoiningDate()
	returns table
as
	return (select * from Person where JoiningDate > '1991-01-01')

select * from dbo.FN_Persondetails_JoiningDate()