-- Query A: Shows suppliers from Germany
SELECT CompanyName, City FROM Customers
WHERE Country = 'Germany';

-- Query B: Finds all products under $20
SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice < 20;

-- Query C: Shows all customers from london. 
SELECT CompanyName, ContactName, Phone FROM Customers
WHERE City = 'London';