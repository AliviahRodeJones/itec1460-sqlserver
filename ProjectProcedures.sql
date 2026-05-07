USE ProjectDatabase;

Shows off the getByName procedure created in the populate_Database.sql file
EXEC getByName @Name = 'Lucky';

-- Create Procedure --
CREATE OR ALTER PROCEDURE NewCatProcedure
-- All the data for the cats table and the intake_card table. 
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
    -- Inserts data into the cats database. 
    INSERT INTO dbo.Cats(Name, Age, Adopted, Breed, CoatColor, Sex)
    VALUES
    (@Name, @Age, 0, @Breed, @CoatColor, @Sex);

    -- Finds the newly generated CatID value and declares it as a variable. 
    DECLARE @CatID INT; 
    SELECT @CatID = CatID FROM Cats WHERE Name = @Name

    -- Inserts data into the intake_card database. 
    INSERT INTO dbo.Intake_Card(CatID, EmployeeID, PreviousOwnerName, LocationFound, DateSurrendered)
    VALUES
    (@CatID, @EmployeeID, @PreviousOwnerName, @LocationFound, @DateSurrendered)

END;
-- This procedures purpose is to make inserting a new cat into the database easier. 
EXEC NewCatProcedure @Name = 'Barney', @Age = 5, @Breed = 'Persian', @CoatColor = 'White', @Sex = 'M', @EmployeeID = 1, 
@LocationFound = 'NA', @PreviousOwnerName = 'Sarah L', @DateSurrendered = '2026-04-25';



-- Retrieving Data Procedure
CREATE OR ALTER PROCEDURE TodaysAppointmentsProcedure 
@Date DATETIME
AS 
    BEGIN
    SELECT * FROM Reservations WHERE ReservationDate >= @Date AND ReservationDate < DATEADD(day, 1, @Date)
    SELECT * FROM Vet_Visits WHERE AppointmentDate >= @Date AND AppointmentDate < DATEADD(day, 1, @Date)
END;
-- This procedure is used to check Reservations and Vet_Visits for appointments scheduled for the date parameter. 

EXEC TodaysAppointmentsProcedure @Date = '2025-04-23';


-- Delete Procedure

CREATE OR ALTER PROCEDURE DeleteReservation
@ReservationID INT
AS
    BEGIN
    SET NOCOUNT ON
    DECLARE @VisitorID INT
    SELECT @VisitorID = VisitorID FROM Reservations WHERE ReservationID = @ReservationID
    DELETE FROM dbo.Reservations WHERE ReservationID = @ReservationID
    PRINT 'Successfully deleted the reservation ' + CAST (@ReservationID AS NVARCHAR(20))
    PRINT 'For visitorID number ' + CAST(@VisitorID AS NVARCHAR(20))
END;
    

INSERT INTO dbo.Reservations(VisitorID, CatID, ReservationDate)
VALUES (1003, 1002, '2025-05-07');

EXEC TodaysAppointmentsProcedure @Date = '2025-05-07';

EXEC DeleteReservation @ReservationID = 1003;
