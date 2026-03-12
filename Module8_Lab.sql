CREATE DATABASE PixelPizzaPalace;
GO

USE PixelPizzaPalace;
GO

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Price       DECIMAL(5,2),
    Stock       INT
);

CREATE TABLE Sales (
    SaleID    INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity  INT,
    SaleDate  DATETIME DEFAULT GETDATE()
);

INSERT INTO Products (ProductName, Price, Stock)
VALUES 
    ('Pepperoni Pizza', 12.99, 50),
    ('Cheese Pizza',    10.99, 50),
    ('Garlic Bread',     4.99, 75),
    ('Soda',             2.50, 200);

INSERT INTO Sales (ProductID, Quantity)
VALUES (1, 3), (2, 2), (3, 5);
GO

-- Step 3: Create users and grant permissions
CREATE LOGIN Cashier WITH PASSWORD = 'Cash123!';
CREATE LOGIN Manager WITH PASSWORD = 'Mangr123!';
GO

-- Create users inside the PixelPizzaPalace database
CREATE USER Cashier FOR LOGIN Cashier;
CREATE USER Manager FOR LOGIN Manager;
GO

-- Cashier can only read the menu and add new sales. 
GRANT SELECT ON Products TO Cashier;
GRANT SELECT, INSERT ON Sales TO Cashier;
GO

-- Manager can do everything on both tables
GRANT SELECT, INSERT, UPDATE, DELETE ON Products TO Manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Sales TO Manager;
GO

-- Step 4: check the user permissions in a table. 
SELECT 
    dp.name AS UserName,
    o.name AS TableName,
    p.permission_name AS Permission
FROM sys.database_permissions p
JOIN sys.database_principals dp 
    ON p.grantee_principal_id = dp.principal_id
JOIN sys.objects o 
    ON p.major_id = o.object_id
WHERE dp.name IN ('Cashier', 'Manager')
ORDER BY UserName, TableName;
GO

SELECT 
name AS FileName,
size /128.0 AS SizeMB
FROM sys.database_files;
GO

BACKUP DATABASE PixelPizzaPalace
TO DISK = '/var/opt/mssql/data/PixelPizzaPalace.bak'
WITH FORMAT;
GO

--Step 7: Create an index
-- Create an index so searches by ProductName are faster
CREATE NONCLUSTERED INDEX IX_Products_Name 
ON Products(ProductName);
GO

-- Verify the index was created by listing all indexes on Products
SELECT 
i.name AS IndexName,
i.type_desc AS IndexType,
COL_NAME(ic.object_id, ic.column_id) AS ColumnName
FROM sys.indexes i
JOIN sys.index_columns ic 
ON i.object_id = ic.object_id AND i.index_id = ic.index_id
WHERE i.object_id = OBJECT_ID('Products')
ORDER BY i.name;
GO


-- ===== PART 2 STEP 2: ADD INVENTORY USER =====
CREATE LOGIN InventoryMgr WITH PASSWORD = 'InvMgr123!';
-- had to change this password because it doesn't meet SQL server password policy requirements. 
GO
-- Creates a new user with the previous login.
CREATE USER InventoryMgr FOR LOGIN InventoryMgr;
GO
-- Grants that new user select and update privileges on only the products table. 
GRANT SELECT, UPDATE ON Products TO InventoryMgr;
GO

-- Checking permissions with a select statement.
SELECT 
    dp.name AS UserName,
    o.name AS TableName,
    p.permission_name AS Permission
FROM sys.database_permissions p
JOIN sys.database_principals dp 
    ON p.grantee_principal_id = dp.principal_id
JOIN sys.objects o 
    ON p.major_id = o.object_id
WHERE dp.name IN ('Cashier', 'Manager', 'InventoryMgr')
ORDER BY UserName, TableName;
GO

-- ===== PART 2 STEP 3: TABLE SIZES =====
USE PixelPizzaPalace;
GO

-- Checks the sizes of our two tables. 
SELECT 
    t.name AS TableName,
    p.rows AS NumberOfRows,
    SUM(a.total_pages) * 8 AS TotalSpaceKB
FROM sys.tables t
JOIN sys.indexes i 
    ON t.object_id = i.object_id
JOIN sys.partitions p 
    ON i.object_id = p.object_id 
    AND i.index_id = p.index_id
JOIN sys.allocation_units a 
    ON p.partition_id = a.container_id
GROUP BY t.name, p.rows
ORDER BY TotalSpaceKB DESC;
GO

-- ===== PART 2 STEP 4: BACKUP AND RESTORE =====
INSERT INTO Products (ProductName, Price, Stock)
VALUES ('Ice Cream Sundae', 5.99, 60);
GO

-- Backs up the database again. 
BACKUP DATABASE PixelPizzaPalace
TO DISK = '/var/opt/mssql/data/PixelPizzaPalace_New.bak'
WITH FORMAT;
GO

DELETE FROM Products WHERE ProductName = 'Ice Cream Sundae';
GO
-- Checks the items in the Products table. 
SELECT * FROM Products;
GO

USE master;
GO

-- Take the database offline so we can restore it
ALTER DATABASE PixelPizzaPalace SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

RESTORE DATABASE PixelPizzaPalace
FROM DISK = '/var/opt/mssql/data/PixelPizzaPalace_New.bak'
WITH REPLACE;
GO

-- Bring the database back online for all users
ALTER DATABASE PixelPizzaPalace SET MULTI_USER;
GO

USE PixelPizzaPalace;
GO

SELECT * FROM Products;
GO





-- ===== PART 2 STEP 5: REFLECTION =====
/*
1: We backed up our database; gave our users a password for authentication and decreased privileges 
for authorization; and we added indexes that makes searching a database much quicker. These were the
three most important database tasks we practiced in this lab.
2: Our new database needs permission controls because of the principle of least privilege. Some users 
shouldn't have access to sensitive information. For instance a cashier shouldn’t be able to see 
their coworkers' information. Also, employees who need to acces that information, like a manager, should
be given access to it.   
3: You could loose data. If some kind of hardware or availibility issue occurs, backups allow you to 
keep a copy of that database. You can use this backup to get the database back up and running quickly. 
*/
