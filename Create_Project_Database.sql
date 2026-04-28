-- Creates the database for this project. 
CREATE DATABASE ProjectDatabase;
GO

USE ProjectDatabase;

CREATE TABLE "Cats" (
    "CatID" INT IDENTITY (1,1) PRIMARY KEY,
    "Name" nvarchar (50) NULL, 
    "Age" INT NULL, 
    "Adopted" Boolean NOT NULL, 
    "Breed" nvarchar (50) NOT NULL, 
    "CoatColor" nvarchar (50) NOT NULL,
    "Sex" nvarchar (1) NULL
);


CREATE TABLE "Employee_Volunteer" (
    "EmployeeID" INT IDENTITY (1,1) PRIMARY KEY, 
    "Name" nvarchar(50) NOT NULL, 
    "SocialSecurityNumber" char(9), 
    "Employed" Boolean NOT NULL, 
    "HourlyWage" REAL NOT NULL, 
    "DateHired" DATETIME NOT NULL
);


CREATE TABLE "Intake_Card" (
    "IntakeID" INT IDENTITY (1,1) PRIMARY KEY, 
    "CatID" INT,
    "EmployeeID" INT, 
    "PreviousOwnerName" NVARCHAR(50) NULL, 
    "LocationFound" nvarchar(50) NULL, 
    "DateSurrendered" DATETIME NOT NULL, 

    CONSTRAINT "FK_Cat_IntakeCard" FOREIGN KEY ("CatID")
    REFERENCES "Cats" ("CatID"),
    CONSTRAINT "FK_Submitter_EmployeeID" FOREIGN KEY("EmployeeID")
    REFERENCES "Employee_Volunteer" ("EmployeeID")
);

CREATE TABLE "Vet_Visits" (
    "VisitID" INT IDENTITY (1,1) PRIMARY KEY, 
    "CatID" INT, -- TODO: Create foreign key
    "Weight" REAL NULL, 
    "BodyConditionScore" INT NULL, 
    "Diagnosis" nvarchar(100) NULL, 
    "VetNotes" text(300) NULL,
    "AppointmentDate" DATETIME NOT NULL
);
--This table will also store upcoming vet visits. When creating the Todays_Appointments_procedure

CREATE TABLE "Inventory" (
    "ProductID" INT PRIMARY KEY, 
    ProductName nvarchar(50) NOT NULL, 
    ProductType nvarchar(30) NULL,
    Stock INT NOT NULL,
    "MostRecentExpDate" DATETIME NULL,
    "CostPerUnit" Money NULL  
);

CREATE TABLE "Visitors" (
    "VisitorID" INT IDENTITY (1,1) PRIMARY KEY, 
    "VisitorName" nvarchar(50) NOT NULL, 
    "VisitorPhoneNumber" char(10),
    "VisitorCity" varchar(50)
);

CREATE TABLE "Adoption_Applications" (
    "ApplicationID" INT IDENTITY (1,1) PRIMARY KEY,
    "CatID" INT NOT NULL, 
    "VisitorID" INT NOT NULL,
    "AdoptionDate" DATETIME NOT NULL,
    "AdoptionFee" REAL NOT NULL
);

CREATE TABLE "Reservations" (
    "ReservationID" INT IDENTITY (1,1) PRIMARY KEY,
    "VisitorID" INT NOT NULL, 
    "CatID" INT NOT NULL, 
    "ReservationDate" DATETIME
)
