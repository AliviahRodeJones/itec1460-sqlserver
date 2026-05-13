-- Creates the database for this project. 
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
-- Creates a table that stores cat information. 
-- Has the CatID value as a primary key. Has no foreign keys. 


CREATE TABLE Employee_Volunteer (
    EmployeeID INT IDENTITY (1,1) PRIMARY KEY, 
    Name nvarchar(50) NOT NULL, 
    SocialSecurityNumber char(9), 
    Employed BIT NOT NULL, 
    PositionTitle nvarchar(20),
    HourlyWage REAL NOT NULL, 
    DateHired DATETIME NOT NULL
);
--Creates a table that stores information about the people working at the shelter. 
-- Has the EmployeeID as a primary key. Has no foreign key. 

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
-- Creates a table that stores cat intake information.
-- Has IntakeID as a primary key. Has CatID and EmployeeID as a foreign key. 


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
-- Creates the table that stores vet visit information. 
-- Has VisitID as a primary key. Has CatID as a forign key. 
-- This table will also store upcoming vet visits. Important when creating the Todays_Appointments_procedure

CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY, 
    ProductName nvarchar(50) NOT NULL, 
    ProductType nvarchar(30) NULL,
    Stock INT NOT NULL,
    MostRecentExpDate DATETIME NULL,
    CostPerUnit Money NULL  
);
-- Creates a table that stores info about supplise the organization has. 
-- Has ProductID as a primary key. 

CREATE TABLE Visitors (
    VisitorID INT IDENTITY (1,1) PRIMARY KEY, 
    VisitorName nvarchar(50) NOT NULL, 
    VisitorPhoneNumber char(10),
    VisitorCity varchar(50)
);
-- Creates a table that stores info about visitors to the shelter. 
-- Has VisitorID as a primary key. 

CREATE TABLE Adoption_Applications (
    ApplicationID INT IDENTITY (1,1) PRIMARY KEY,
    CatID INT NOT NULL, 
    VisitorID INT NOT NULL,
    AdoptionDate DATETIME NOT NULL,
    AdoptionFee REAL NOT NULL
    CONSTRAINT FK_AdoptionApp_CatID FOREIGN KEY(CatID)
    REFERENCES Cats(CatID),
);
-- Creates a table that stores adoption application data. 
-- Has ApplicationID as a primary key. Has CatID and VisitorID as a foreign key. 

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
-- Creates a table that keeps track of current reservations made by visitors to see specific cats. 
-- Has ReservationID as a primary key. Has CatID and VisitorID as a foreign key. 