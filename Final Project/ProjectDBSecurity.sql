USE ProjectDatabase;

ALTER TABLE Employee_Volunteer
ALTER COLUMN SocialSecurityNumber
ADD MASKED WITH (FUNCTION = 'default()');
-- This alters the employee_volunteer table to mask the columns of data for employees social security numbers

SELECT * FROM Employee_Volunteer
-- To test this. 
-- For the administrative user with unmask access, the columns won't be masked. 


CREATE LOGIN Manager WITH PASSWORD = '15498';
CREATE USER Ignatio_G FOR LOGIN Manager;
-- Creates a new manager user with the managers username. 

CREATE LOGIN Employee1 WITH PASSWORD = 'Empl123*';
CREATE LOGIN Volunteer1 WITH PASSWORD = 'Voln123*';
CREATE LOGIN Volunteer2 WITH PASSWORD = 'Voln234*'
-- Creates three different logins for employees and volunteers
CREATE USER Samantha_M FOR LOGIN Volunteer1;
CREATE USER Richard_H FOR LOGIN Employee1;
CREATE USER Matty_S FOR LOGIN Volunteer2;
-- Creates users for the three different logins. 

GRANT SELECT, INSERT, UPDATE, DELETE TO Ignatio_G;
GRANT UNMASK TO Ignatio_G;
-- The manager has select, insert, update and delete permissions, as well as unmasked data privilege. 
GRANT SELECT, INSERT, UPDATE TO Samantha_M, Richard_H, Matty_S
-- All employees and volunteers have select, insert, and update privleges. And no unmask privleges. 
-- When logged in as an employee, the social security column should be masked. 

