-- Creates the database for this project. 
-- THIS CODE HAS NOT BEEN RUN YET
--CREATE DATABASE ProjectDatabase;
--GO

USE ProjectDatabase;

CREATE TABLE Cats (
    CatID INT IDENTITY (1,1) PRIMARY KEY,
    Name nvarchar (50) NULL, 
    Age INT NULL, 
    Adopted BIT, 
    Breed nvarchar (50) NOT NULL, 
    CoatColor nvarchar (50) NOT NULL,
    Sex nvarchar (1) NULL
);
-- The Above code has been run. 


CREATE TABLE Employee_Volunteer (
    EmployeeID INT IDENTITY (1,1) PRIMARY KEY, 
    Name nvarchar(50) NOT NULL, 
    SocialSecurityNumber char(9), 
    Employed BIT NOT NULL, 
    PositionTitle nvarchar(20),
    HourlyWage REAL NOT NULL, 
    DateHired DATETIME NOT NULL
);
-- The above code has been run

CREATE TABLE Intake_Card (
    IntakeID INT IDENTITY (1,1) PRIMARY KEY, 
    CatID INT,
    EmployeeID INT, 
    PreviousOwnerName NVARCHAR(50) NULL, 
    LocationFound nvarchar(50) NULL, 
    DateSurrendered DATETIME NOT NULL, 

    CONSTRAINT FK_IntakeCard_Cats FOREIGN KEY (CatID)
    REFERENCES Cats (CatID),
    CONSTRAINT FK_IntakeCard_EmployeeID FOREIGN KEY(EmployeeID)
    REFERENCES Employee_Volunteer (EmployeeID)
);
-- The above code has been run


CREATE TABLE Vet_Visits (
    VisitID INT IDENTITY (1,1) PRIMARY KEY, 
    CatID INT, 
    Weight REAL NULL, 
    BodyConditionScore INT NULL, 
    Diagnosis nvarchar(100) NULL, 
    VetNotes nvarchar(300) NULL,
    AppointmentDate DATETIME NOT NULL, 

    CONSTRAINT FK_VetVisits_CatID FOREIGN KEY(CatID) 
    REFERENCES Cats (CatID),
);
-- The above code has been run. 
--This table will also store upcoming vet visits. Important when creating the Todays_Appointments_procedure

CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY, 
    ProductName nvarchar(50) NOT NULL, 
    ProductType nvarchar(30) NULL,
    Stock INT NOT NULL,
    MostRecentExpDate DATETIME NULL,
    CostPerUnit Money NULL  
);
-- The above table has been run

CREATE TABLE Visitors (
    VisitorID INT IDENTITY (1,1) PRIMARY KEY, 
    VisitorName nvarchar(50) NOT NULL, 
    VisitorPhoneNumber char(10),
    VisitorCity varchar(50)
);
-- The above table has been run

CREATE TABLE Adoption_Applications (
    ApplicationID INT IDENTITY (1,1) PRIMARY KEY,
    CatID INT NOT NULL, 
    VisitorID INT NOT NULL,
    AdoptionDate DATETIME NOT NULL,
    AdoptionFee REAL NOT NULL
    CONSTRAINT FK_AdoptionApp_CatID FOREIGN KEY(CatID)
    REFERENCES Cats(CatID),
);
-- The above table has been run.

CREATE TABLE Reservations (
    ReservationID INT IDENTITY (1,1) PRIMARY KEY,
    VisitorID INT NOT NULL, 
    CatID INT NOT NULL, 
    ReservationDate DATETIME
    CONSTRAINT FK_Reservation_VisitorID FOREIGN KEY(VisitorID)
    REFERENCES Visitors(VisitorID),
    CONSTRAINT FK_Reservation_CatID FOREIGN KEY(CatID)
    REFERENCES Cats(CatID),
);

-- All of my tables are completed. 
-- THIS CODE HAS NOT BEEN RUN YET

