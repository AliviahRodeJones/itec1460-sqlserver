-- Change to the Northwind database. 
USE Northwind;
GO

-- Procedure 1: No parameters
-- This procedure prints a welcome message. 

CREATE OR ALTER PROCEDURE WelcomeMessage
AS
BEGIN
    SET NOCOUNT ON;
    PRINT 'Welcome to the Northwind Database!';
END
GO

--Test it
EXEC WelcomeMessage; 
GO

-- Procedure 2: One input parameter
-- Looks up a customer's company name by CustomerID
CREATE OR ALTER PROCEDURE GetCustomerName
    @CustomerID NCHAR(5)
AS
BEGIN
    -- Set NOCOUNT ON -- supresses the X rows affected messages
    SET NOCOUNT ON

    -- Declair a new variable to store a company name
    DECLARE @CompanyName NVARCHAR(40);

    -- Retrieve the compan name from the database table
    SELECT @CompanyName = CompanyName
    FROM Customers
    WHERE CustomerID = @CustomerID;

    -- Boolean condition - an if statement - 
    -- to check if the company name was found
    IF @CompanyName IS NULL
        PRINT 'Customer not found.';
    ELSE 
        PRINT 'Company Name: ' + @CompanyName;
END
GO

-- Test with a valid customer
EXEC GetCustomerName @CustomerID = 'ALFKI';

-- Test with an invalid customer
EXEC GetCustomerName @CustomerID = 'ZZZZZ';

-- Procedure 3: One input parameter, one output parameter
-- Returns the total number of orders for a customer
CREATE OR ALTER PROCEDURE GetCustomerOrderCount
    @CustomerID NCHAR(5), 
    @OrderCount INT OUTPUT
AS 
BEGIN
    SET NOCOUNT ON; --no output for the number of rows. 

    --Retrieve the order count from the orders table for 
    -- the customer ID that was passed to the stored procedure
    SELECT @OrderCount = COUNT(*)
    FROM Orders
    WHERE CustomerID = @CustomerID
END
GO

-- Declare the @OrderCount cariable
DECLARE @OrderCount INT;

-- Test the stored procedure
EXEC GetCustomerOrderCount
    @CustomerID = 'ALFKI', 
    @OrderCount = @OrderCount OUTPUT;

-- Call the print function & display the number of orders at the command line
PRINT 'Order count for ALFKI: ' + CAST(@OrderCount AS NVARCHAR(10));
GO


--Procedure 4: Input and output parametrs with error handling.
-- Calculates the total dollar amout for a given order. 
CREATE OR ALTER PROCEDURE CalculateOrderTotal
    @OrderID INT,
    @TotalAmount MONEY OUTPUT
AS 
BEGIN  
    -- Supresses the number of row messages that you usually see
    SET NOCOUNT ON;

    --Retrieve the data from the table
    SELECT @TotalAmount = SUM(UnitPrice * Quantity * (1-Discount))
    FROM [Order Details]
    WHERE OrderID = @OrderID;

    -- Error handling from the case where the total amount is null
    IF @TotalAmount IS NULL
    BEGIN
        -- Set the total amount to 0
        SET @TotalAmount = 0;
        PRINT 'Order ' + Cast(@OrderID AS NVARCHAR(10)) + ' not found'
        RETURN; -- Ends the procedure
    END
    
    --Only prints the total amount if there is a value (it's not null)
    PRINT 'Total for Order ' + CAST(@OrderID AS NVARCHAR(10)) + ': $' + CAST(@TotalAmount AS NVARCHAR(20))
END
GO        

-- Test with a valid order
DECLARE @TotalAmount MONEY;

--SELECT * FROM Orders

EXEC CalculateOrderTotal
    @OrderID = '10249',
    @TotalAmount = @TotalAmount OUTPUT;

PRINT ('Returned total: $' + CAST(@TotalAmount AS NVARCHAR(20)));
GO


-- Test with an invalid order
DECLARE @TotalAmount MONEY;

--SELECT * FROM Orders

EXEC CalculateOrderTotal
    @OrderID = '99999',
    @TotalAmount = @TotalAmount OUTPUT;

PRINT ('Returned total: $' + CAST(@TotalAmount AS NVARCHAR(20)));
GO

-- Module 7 Part 2 LAB --

USE Northwind;
GO

-- =============================================
-- Part 2, Procedure 1: GetProductName
-- =============================================

CREATE OR ALTER PROCEDURE GetProductName
    @ProductID INT,
    @ProductName NVARCHAR(40) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @ProductName = ProductName
    FROM Products
    WHERE ProductID = @ProductID;

    IF @ProductName IS NULL
        PRINT 'Product not found.';
    ELSE
        PRINT 'Product Name: ' + @ProductName;
END
GO

-- Test it
DECLARE @ProductName NVARCHAR(40);

EXEC GetProductName
    @ProductID = 1,
    @ProductName = @ProductName OUTPUT;
GO


-- =============================================
-- Part 2, Procedure 2: GetEmployeeOrderCount
-- =============================================

CREATE OR ALTER PROCEDURE GetEmployeeOrderCount
    @EmployeeID INT,
    @OrderCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @OrderCount = COUNT(*) 
    FROM Orders
    WHERE EmployeeID = @EmployeeID

    PRINT (@EmployeeID + CAST(@OrderCount AS NVARCHAR(10)));
    END
GO

-- Test it
DECLARE @OrderCount INT;

EXEC GetEmployeeOrderCount
    @EmployeeID = 5,
    @OrderCount = @OrderCount OUTPUT;
GO


--Part 3: Check if a product needs reordering
CREATE OR ALTER PROCEDURE CheckProductStock
    @ProductID INT,
    @NeedsReorder BIT Output
AS 
    BEGIN
    SET NOCOUNT ON
    
    DECLARE @UnitsInStock NVARCHAR(10);
    DECLARE @ReorderLevel NVARCHAR(10);

    SELECT @UnitsInStock = UnitsInStock, @ReorderLevel = ReorderLevel
    FROM Products
    WHERE ProductID = @ProductID;

    IF @UnitsInStock < @ReorderLevel 
        BEGIN
        SET @NeedsReorder = 1
        PRINT ('Product ' + CAST(@ProductID AS NVARCHAR(10)) + ' needs reordering'); 
        END
    IF @UnitsInStock > @ReorderLevel 
        BEGIN
        SET @NeedsReorder = 0
        PRINT ('Product ' + CAST(@ProductID AS NVARCHAR(10)) + ' stock is OK.');
        END
    END
GO

-- Test CheckProductStock
DECLARE @NeedsReorder BIT;

EXEC CheckProductStock
    @ProductID = 2,
    @NeedsReorder = @NeedsReorder OUTPUT;

PRINT 'Needs Reorder flag: ' + CAST(@NeedsReorder AS VARCHAR(1));
GO

