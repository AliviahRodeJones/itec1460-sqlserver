USE ProjectDatabase;
-- Creates a procedure for getting a catID by the cat name.
CREATE OR ALTER PROCEDURE getByName 
    @Name NVARCHAR(50)
AS 
BEGIN
    SET NOCOUNT ON
    Select CatID from Cats where Name = @Name
END
GO

INSERT INTO dbo.Cats(Name, Age, Adopted, Breed, CoatColor, Sex)
VALUES('Lucy', 3, 0, 'Siamese', 'Brown/White', 'F');
-- First test sample data. 
Delete from Cats Where Name = 'Lucy';

INSERT INTO dbo.Cats(Name, Age, Adopted, Breed, CoatColor, Sex)
VALUES
('Fuzzy', 13, 0, 'Long-hair', 'White', 'F'), 
('Oliver', 7, 0,'Short-hair Tabby', 'Brown', 'M'),
('Lucky', 12, 1, 'Short-hair', 'Black', 'F'),
('Bob', 4, 0, 'Persian', 'White', 'M');
-- Inserts sample data for the cats database. 

INSERT INTO dbo.Cats(Name, Age, Adopted, Breed, CoatColor, Sex)
VALUES
('Dave', 9, 1, )


INSERT INTO dbo.Employee_Volunteer(Name, SocialSecurityNumber, Employed, PositionTitle, HourlyWage, DateHired)
VALUES
('Ignatio G', '111111111', 1, 'Manager', 25.55, '2024-12-01'), 
('Samantha M', '222222222', 1, 'Volunteer', 0, '2024-12-15'), 
('Richard H', '333333333', 1, 'Employee', 15.55, '2025-01-05'),
('Matty S', '444444444', 1, 'Volunteer', 0, '2025-09-01'),
('Michael G', '555555555', 0, 'Manager', 25.55, '2024-01-01');
--  All above code has been run. 

INSERT INTO dbo.Intake_Card(CatID, EmployeeID, PreviousOwnerName, LocationFound, DateSurrendered)
VALUES
(2002, 1, 'Robert R', 'NA', '2024-12-04'), 
(1002, 1, 'NA', 'Burnsville,MN', '2025-01-12'), 
(1003, 2, 'NA', 'Minneapolis,MN', '2025-04-21'), 
(1004, 3, 'NA', 'Edina,MN', '2025-10-15'), 
(1005, 2, 'Linda B', 'NA', '2025-11-20');
-- All above code has been run. 

Insert INTO dbo.Vet_Visits(CatID, Weight, BodyConditionScore, Diagnosis, VetNotes, AppointmentDate)
VALUES
(2002, 8, 4, 'NA', 'Healthy cat', '2024-12-06'),
(1002, 14.5, 6, 'NA', 'Healthy cat', '2025-01-14'),
(1003, 10, 6, 'NA', 'Healthy cat', '2025-04-23'),
(1002, 16.5, 7, 'Slightly Overweight', 'Fluffy is slightly overweight and needs to loose 2 lbs to be in healthy range', '2025-04-30'),
(1004, 10.5, 6, 'Upper Respiratory Infection', 'Needs antibiotics. Clean eye/nose discharge daily. Encourage eating and hydration', '2025-10-16'),
(1005, 8.5, 4, 'NA', 'Healthy cat', '2025-11-22');
-- All above code has been run

INSERT INTO dbo.Inventory(ProductID, ProductName, ProductType, Stock, MostRecentExpDate, CostPerUnit)
VALUES
(5023, 'Purina Cat Chow', 'Cat Food', 5, '2026-05-01', 12.50),
(5025, 'Purina Tidy Cats', 'Cat Litter', 3, NULL, 16.99),
(5045, 'Temptations', 'Cat Treats', 7, '2026-06-12', 6.99),
(5001, 'Feather Toy', 'Cat Toy', 4, NULL, 2.50);
-- This insert statement represents supplies that the organization already owns. 

INSERT INTO dbo.Inventory(ProductID, ProductName, ProductType, Stock, MostRecentExpDate, CostPerUnit)
VALUES 
(5046, 'Arm & Hammer Litter', 'Cat Litter', 2, NULL, NULL),
(5047, 'Fancy Feast', 'Cat Food', 10, '2026-12-28', NULL),
(5048, 'Catnip Mouse', 'Cat Toy', 5, NULL, NULL);
-- This insert statement represents a donation of supplise that the organization recieved. 
-- Some values are left null to simulate this. 

INSERT INTO dbo.Visitors(VisitorName, VisitorPhoneNumber, VisitorCity)
VALUES
('Wendy N', '1111111111', 'Minneapolis'),
('Mei R', '2222222222', 'Bloomington'),
('Wayne M', '3333333333', 'St.Paul'),
('Mateo J', '4444444444', 'St.Paul');
-- This statement has been run. 

INSERT INTO dbo.Reservations(VisitorID, CatID, ReservationDate)
VALUES
(1, 1004, '2025-01-22'),
(2, 1005, '2025-04-25'), 
(3, 1002, '2025-04-29'),
(4, 1003, '2025-05-02');

-- First Insert catIDs for "previously adopted cats"
INSERT INTO dbo.Cats(Name, Age, Adopted, Breed, CoatColor, Sex)
VALUES 
('Grumbly', 9, 1, 'Short-hair', 'Brown', 'M'), 
('Loki', 5, 1, 'Short-hair Tabby', 'Grey', 'M'),
('Kitty', 2, 1, 'Long-hair', 'Black', 'F'),
('Pepper', 10, 1, 'Short-hair Calico', 'White/Orange/Grey','F');

INSERT INTO dbo.Visitors(VisitorName, VisitorPhoneNumber, VisitorCity)
VALUES
('Mat S', '1234567890', 'Minneapolis'),
('Stephen G', '2345678901', 'Blaine'),
('Jordan H', '3456789012', 'Maple Grove');

INSERT INTO dbo.Adoption_Applications(CatID, VisitorID, AdoptionDate, AdoptionFee)
VALUES
(1004, 1, '2025-01-28', 125),
(2003, 1002, '2024-10-12', 150),
(2004, 1003, '2024-12-08', 200),
(2005, 1004, '2024-12-24', 150),
(2006, 1004, '2024-12-24', 150);
-- ALL CODE HAS BEEN RUN
