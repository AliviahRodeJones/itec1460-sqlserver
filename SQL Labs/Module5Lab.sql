-- Create a new cutomer in the Customers table
INSERT INTO Customers (CustomerID, CompanyName, ContactName, Country)
VALUES('STUDE', 'Student Company', 'Aliviah Rode-Jones', 'USA');

-- Verify that the record was inserted correctly.
SELECT * FROM Customers WHERE CustomerID = 'STUDE'

-- Create a new order for the customer we created
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipCountry)
VALUES ('STUDE', 1, GETDATE(), 'USA');

-- Verify that the order was entered
SELECT * FROM Orders WHERE CustomerID = 'STUDE';

-- Change the Contact Name for our customer
UPDATE Customers SET ContactName = 'New Contact Name'
WHERE CustomerID = 'STUDE';

-- Change the shipping country for our order
UPDATE Orders SET ShipCountry = 'New Country'
WHERE CustomerID = 'STUDE';

-- Delete the order we inserted for the new customer
DELETE FROM Orders WHERE CustomerID = 'STUDE';

-- Verify the order was deleted
SELECT OrderID, CustomerID FROM Orders WHERE CustomerID = 'STUDE';

-- Let's remove the test customer from the Customers table
DELETE FROM Customers WHERE CustomerID = 'STUDE';

-- Verify the customer was removed
SELECT * FROM Customers WHERE CustomerID = 'STUDE';

-- Exercise 2:1 adding a new suppliers
INSERT INTO Suppliers (CompanyName, ContactName, ContactTitle, Country)
VALUES ('Pop-up Foods', 'Aliviah Rode-Jones', 'Owner', 'USA');

-- Checking previous 'insert into' query
SELECT * FROM Suppliers WHERE CompanyName = 'Pop-up Foods';

-- Exercise 2:2 writing first complete insert
INSERT INTO Products (ProductName, SupplierID, CategoryID, UnitPrice, UnitsInStock)
VALUES ('House Special Pizza', 30, 2, 15.99, 50);

-- Checking previous insert into query, and the three below queries
SELECT * FROM Products WHERE ProductName = 'House Special Pizza';

-- Exercise 2:3 practice update
UPDATE Products
SET UnitPrice = 14.99
WHERE ProductName = 'House Special Pizza';

-- Excercise 2:4 write your own update
UPDATE Products
SET UnitsInStock = 25, UnitPrice = 17.99
WHERE ProductName = 'House Special Pizza';

-- Exercise 2:5 Practice delete
DELETE FROM Products WHERE ProductName = 'House Special Pizza';

--Part 2 Challenge Create your own menu item
INSERT INTO Products (ProductName, SupplierID, CategoryID, UnitPrice, UnitsInStock)
VALUES ('Cheesy Classic Ravioli', 30, 5, $10.99, 200);

-- Updates menu item .
UPDATE Products
SET UnitsInStock = 100, UnitPrice = $12.50
WHERE ProductName = 'Cheesy Classic Ravioli';

-- Deletes the new product.
DELETE FROM Products WHERE ProductName = 'Cheesy Classic Ravioli';

-- Checks if the query was update correctly.
SELECT * FROM Products WHERE ProductName = 'Cheesy Classic Ravioli';
