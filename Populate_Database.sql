USE ProjectDatabase;

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

INSERT INTO dbo.Employee_Volunteer(Name, SocialSecurityNumber, Employed, PositionTitle, HourlyWage, DateHired)
VALUES
('Ignatio G', '111111111', 1, 'Manager', 25.55, '2024-12-01'), 
('Samantha M', '222222222', 1, 'Volunteer', 0, '2024-12-15'), 
('Richard H', '333333333', 1, 'Employee', 15.55, '2025-01-05'),
('Matty S', '444444444', 1, 'Volunteer', 0, '2025-09-01'),
('Michael G', '555555555', 0, 'Manager', 25.55, '2024-01-01');
--  All above code has been run. 

INSERT INTO dbo.Intake_Card(IntakeID, CatID, EmployeeID, PreviousOwnerName, LocationFound, DateSurrendered)
VALUES
(1, 2002, 1, 'Robert R', 'NA', '2024-12-04'), 
(2, 1002, 1, 'NA', 'Burnsville,MN', '2025-01-12'), 
(3, 1003, 2, 'NA', 'Minneapolis,MN', '2025-04-21'), 
(4, 1004, 3, 'NA', 'Edina,MN', '2025-10-15'), 
(5, 1005, 2, 'Linda B', 'NA', '2025-11-20');
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
