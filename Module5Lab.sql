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