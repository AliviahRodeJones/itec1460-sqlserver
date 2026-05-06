USE ProjectDatabase;

-- Shows off the getByName procedure created in the populate_Database.sql file
EXEC getByName @Name = 'Lucky';

CREATE OR ALTER PROCEDURE NewCatProcedure
@Name NVARCHAR(50),
@Age INT,
@Breed NVARCHAR(50),
@CoatColor NVARCHAR(50),
@Sex NVARCHAR(1),
@EmployeeID INT,
@PreviousOwnerName NVARCHAR(50),
@LocationFound NVARCHAR(50),
@DateSurrendered DATETIME
AS
    BEGIN
    SET NOCOUNT ON
    INSERT INTO dbo.Cats(Name, Age, Adopted, Breed, CoatColor, Sex)
    VALUES
    (@Name, @Age, 0, @Breed, @CoatColor, @Sex);

    DECLARE @CatID INT; 
    SELECT @CatID = CatID FROM Cats WHERE Name = @Name
    
    INSERT INTO dbo.Intake_Card(CatID, EmployeeID, PreviousOwnerName, LocationFound, DateSurrendered)
    VALUES
    (@CatID, @EmployeeID, @PreviousOwnerName, @LocationFound, @DateSurrendered)

END;

EXEC NewCatProcedure @Name = 'Barney', @Age = 5, @Breed = 'Persian', @CoatColor = 'White', @Sex = 'M', @EmployeeID = 1, 
@LocationFound = 'NA', @PreviousOwnerName = 'Sarah L', @DateSurrendered = '2026-04-25';


CREATE OR ALTER PROCEDURE

