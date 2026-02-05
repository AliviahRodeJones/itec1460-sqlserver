-- Query #1: Using a Join to retrieve data from two tables
-- The default JOIN type in INNER JOIN
SELECT C.CompanyName, O.OrderDate
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID;

-- Query #2: Left join to show all of the customers, even those without any orders
SELECT c.CustomerID, c.CompanyName, o.OrderID, o.OrderDate
FROM Customers AS c
LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID;

-- Query #3: Using buit-in Functions
SELECT OrderID, ROUND( SUM(UnitPrice * Quantity * (1-Discount)), 2) AS TotalValue,
COUNT(*) AS NumberOfItems
FROM[Order Details]
GROUP BY OrderID 
ORDER BY TotalValue DESC;

--Query #4: Group records to get the number of times each product is ordered 
-- then filter using HAVING to only get products ordered more than 10 times. 
SELECT p.ProductID, p.ProductName, COUNT(od.OrderID) AS TimesOrdered
FROM Products AS p
JOIN [Order Details] AS od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING COUNT(od.OrderID) > 10
ORDER BY TimesOrdered DESC;

-- Query #5: Use a subquery to get average price of a product, then display
-- the product info for products where the price is above agerage
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (
    SELECT AVG(UnitPrice) FROM Products
)
ORDER BY UnitPrice;

-- Query #6: Join three tables together
SELECT o.OrderID, o.OrderDate, p.ProductName, od.Quantity, od.UnitPrice
FROM Orders AS o
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
JOIN Products AS p ON od.ProductID = p.ProductID
WHERE o.OrderID = 10248
ORDER BY p.ProductName;

-- Query #7: Get average product price by category
SELECT c.CategoryName, ROUND(AVG(p.UnitPrice), 2) AS AveragePrice
FROM Categories AS c 
JOIN Products AS p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY AveragePrice DESC;

-- Query #8: Count orders by employee
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS EmployeeName, COUNT(o.OrderID) AS NumberOfOrders
FROM Employees as e
JOIN Orders AS o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY NumberOfOrders DESC;

-- Query #9: Count orders per customer
SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY NumberOfOrders DESC;

-- Query #10: Calculate total revenue per order
SELECT OrderID, ROUND(SUM(UnitPrice * Quantity * (1-Discount)), 2) AS TotalRevenue
FROM [Order Details]
GROUP BY OrderID
ORDER BY TotalRevenue DESC;

-- Query #11: Filter orders by year
SELECT OrderID, CustomerID, OrderDate
FROM Orders
WHERE YEAR(OrderDate) = 1997
Order BY OrderDate;

-- Query #12: Main Challenge Query
SELECT TOP 10 c.CustomerID, c.CompanyName, ROUND(SUM(od.UnitPrice * od.Quantity * (1-Discount)), 2) AS TotalRevenue, COUNT(od.OrderID) AS NumberOfOrders
FROM Customers AS c
JOIN Orders o ON c.CustomerID =o.CustomerID
JOIN [Order Details] AS od ON o.OrderID = od.OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalRevenue DESC;


 
