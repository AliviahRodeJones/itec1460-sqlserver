USE ProjectDatabase;

CREATE VIEW VisitorView AS 
SELECT
    c.CatID, 
    c.Name, 
    c.Age, 
    c.Breed, 
    c.CoatColor, 
    c.Sex, 
    i.DateSurrendered
    FROM Cats as c
    LEFT JOIN Intake_Card i ON c.CatID = i.CatID
    WHERE c.Adopted = 0; -- A value of 0 in adopted means the cat has not yet been adopted.
-- This view shows important data from two different tables for only the cats that have not been adopted. 

SELECT * from VisitorView

CREATE VIEW CheckInventory AS 
SELECT 
    ProductID, ProductName, ProductType, Stock, MostRecentExpDate, CostPerUnit
    FROM dbo.Inventory
    WHERE Stock <= 2 OR MostRecentExpDate < GETDATE();
-- This view checks the inventory table and only shows rows where stock is less than or equal to 3
-- And the most recent experation date is in the past (expired).
    
Select * from CheckInventory