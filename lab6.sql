-------------------------------LAB-06---------------------------------------------------


CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
); 

--  Insert data into the Products table 
INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(101, 'Smartphone', 35000), 
(102, 'Laptop', 65000), 
(103, 'Headphones', 5500), 
(104, 'Television', 85000), 
(105, 'Gaming Console', 32000); 

select * from Products

----PART-A

--1. Create a cursor Product_Cursor to fetch all the rows from a products table.

declare @ID int, @Name varchar(100), @Price decimal(10,2) 

	declare cursor_FetchData cursor
	for
		select * 
		from Products

	open cursor_FetchData

	fetch next from cursor_FetchData
	into @ID, @Name, @Price

	while @@FETCH_STATUS = 0
	begin
		print(cast(@ID as varchar(100)) + ' ' + @Name + ' ' +  cast(@Price as varchar(100)))
		fetch next from cursor_FetchData
		into @ID, @Name, @Price
	end

	close cursor_FetchData

	deallocate cursor_FetchData

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.(Example: 1_Smartphone)

declare @PID int, @PName varchar(100)

	declare Product_Cursor_Fetch cursor
	for 
		select Product_id, Product_Name 
		from Products

	open Product_Cursor_Fetch

	fetch next from Product_Cursor_Fetch
	into @PID, @PName

	while @@FETCH_STATUS = 0
	begin
		print(cast(@PID as varchar(100)) + '_' + @PName)
		fetch next from Product_Cursor_Fetch
		into @PID, @PName
	end

	close Product_Cursor_Fetch

	deallocate Product_Cursor_Fetch

--3. Create a Cursor to Find and Display Products Above Price 30,000.

declare @ID int, @name varchar(100), @price int

	declare Display_Product_Price_Fetch cursor
	for 
		select  * 
		from Products
		where Price > 30000

	open Display_Product_Price_Fetch

	fetch next from Display_Product_Price_Fetch
	into @ID , @name , @price

	while @@FETCH_STATUS = 0
	begin
		print(cast(@ID as varchar(100)) + ' ' + @name + ' ' + (cast(@price as varchar(100))))
		fetch next from Display_Product_Price_Fetch
		into @ID , @name , @price
	end

	close Display_Product_Price_Fetch

	deallocate Display_Product_Price_Fetch



--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.


declare @ID int 

	declare Product_CursorDelete cursor
	for 
		select Product_id from Products

	open Product_CursorDelete

	fetch next from Product_CursorDelete
	into @ID 

	while @@FETCH_STATUS = 0
	begin
		
		delete from Products
		where Product_id = @ID

		fetch next from Product_CursorDelete
		into @ID 
	end

	close Product_CursorDelete

	deallocate Product_CursorDelete


----PART-B

--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table 
--and increases the price by 10%.

declare @ID int;

	declare Product_CursorUpdate cursor
	for 
		select Product_id from Products

	open Product_CursorUpdate

	Fetch next from Product_CursorUpdate
	into @ID

	while @@FETCH_STATUS = 0
		Begin
			update Products
			set Price = Price + Price*0.1
			where Product_id = @ID

			fetch next from Product_CursorUpdate
			into @ID
		END

	close Product_CursorUpdate

	deallocate Product_CursorUpdate

	select * from Products

--6. Create a Cursor to Rounds the price of each product to the nearest whole number.


declare @Price int

	declare Product_CursorRound cursor
	for 
		select Price from Products

	open Product_CursorRound

	fetch next from Product_CursorRound
	into @Price

	while @@FETCH_STATUS=0
	begin
		update Products
		set Price=Round(Price,0)
		
		fetch next from Product_CursorRound 
		into @Price

	end

	close Product_CursorRound

	deallocate Product_CursorRound
		
	select * from Products

----------PART-C

--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”
--(Note: Create NewProducts table first with same fields as Products table)

CREATE TABLE NewProducts ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
); 

declare @ID int, @name varchar(100), @price int

	declare newproduct_cursour cursor
	for 
	select Product_id,Product_Name,Price
	from Products

	open newproduct_cursour

	fetch next from newproduct_cursour
	into @ID, @name, @price

	while @@FETCH_STATUS=0
	begin
		if @name = 'Laptop'
			insert into NewProducts(Product_id,Product_Name,Price) values(@ID,@name,@price)

		fetch next from newproduct_cursour
		into @ID, @name, @price
	end

	close newproduct_cursour

	deallocate newproduct_cursour

select * from NewProducts

--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products
--with a price above 50000 to an archive table, removing them from the original Products table.

CREATE TABLE ArchivedProducts ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
);

declare @ID int, @name varchar(100), @price int

	declare ArchivedProducts_cursour cursor
	for 
	select Product_id,Product_Name,Price
	from Products where Price > 50000

	open ArchivedProducts_cursour

	fetch next from ArchivedProducts_cursour
	into @ID, @name, @price

	while @@FETCH_STATUS=0
	begin
			insert into ArchivedProducts(Product_id,Product_Name,Price) values(@ID,@name,@price)
			delete from Products where Product_id = @ID

		fetch next from ArchivedProducts_cursour
		into @ID, @name, @price
	end

	close ArchivedProducts_cursour

	deallocate ArchivedProducts_cursour

select * from ArchivedProducts
select * from Products
