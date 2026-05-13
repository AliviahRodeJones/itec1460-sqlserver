USE ProjectDatabase;

ALTER TABLE Employee_Volunteer
ALTER COLUMN SocialSecurityNumber
ADD MASKED WITH (FUNCTION = 'default()');

SELECT * FROM Employee_Volunteer

CREATE LOGIN Manager WITH PASSWORD = '15498';
CREATE USER Ignatio_G FOR LOGIN Manager;

CREATE LOGIN Employee1 WITH PASSWORD = 'Empl123*';
CREATE LOGIN Volunteer1 WITH PASSWORD = 'Voln123*';
CREATE LOGIN Volunteer2 WITH PASSWORD = 'Voln234*'
-- Creates three different logins
CREATE USER Samantha_M FOR LOGIN Volunteer1;
CREATE USER Richard_H FOR LOGIN Employee1;
CREATE USER Matty_S FOR LOGIN Volunteer2;

GRANT SELECT, INSERT, UPDATE, DELETE TO Ignatio_G;
GRANT UNMASK TO Ignatio_G;
GRANT SELECT, INSERT, UPDATE TO Samantha_M, Richard_H, Matty_S

