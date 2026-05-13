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

CREATE OR ALTER VIEW VisitorInfoAndReservations AS
SELECT 
    r.ReservationID, 
    r.ReservationDate, 
    r.VisitorID, 
    r.CatID,
    v.VisitorName,
    v.VisitorPhoneNumber,
    v.VisitorCity
    FROM Reservations as r
    LEFT JOIN Visitors v ON r.VisitorID = v.VisitorID
    WHERE r.ReservationDate <= GETDATE();
    -- This view shows every current reservation with data from the Visitors table and Reservations table. 
                        
SELECT * FROM VisitorInfoAndReservations
ORDER BY ReservationDate
