-- Creating the author's table for Northwinds new books. 
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY, 
    FirstName VARCHAR(50),
    LastName VARCHAR(50), 
    BirthDate DATE
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY, 
    Title VARCHAR(100), 
    AuthorID INT, --Our foreign key that links author table to books table
    PublicationYear INT, 
    Price DECIMAL(10,2)
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

Select * from Books;

-- Insert sample data for the authors
INSERT INTO Authors (AuthorID, FirstName, LastName, BirthDate)
VALUES
(1, 'Jane', 'Austen', '1775-12-16'), 
(2, 'George', 'Orwell', '1903-06-25'), 
(3, 'J.K.', 'Rowling', '1965-07-21'), 
(4, 'Ernest', 'Hemingway', '1899-07-21'), 
(5, 'Virginia', 'Woolf', '1882-01-25')

SELECT * FROM Authors;

INSERT INTO Books (BookID, Title, AuthorID, PublicationYear, Price)
VALUES
(1, 'Pride and Prejudice', 1, 1813, 12.99), 
(2, '1984', 2, 1949, 10.99), 
(3, 'Harry Potter and the Philosopher''s Stone', 3, 1997, 15.99), 
(4, 'The Old man and the Sea', 4, 1952, 11.99), 
(5, 'To the Lighthouse', 5, 1927, 13.99);

SELECT * FROM Books;

-- Create a view that cobines info from the Books and the Authors table
CREATE VIEW BookDetails AS 
SELECT b.BookID, b.Title, a.FirstName + ' ' + a.LastName AS AuthorName, b.PublicationYear, b.Price
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID;

-- Create a view that filters the records based on the publication year. 
CREATE VIEW RecentBooks AS
    SELECT BookID, Title, PublicationYear, Price 
    FROM Books
    WHERE PublicationYear > 1990;


-- Runs the two views
SELECT * FROM BookDetails; 

SELECT * FROM RecentBooks;

-- Create our aggregate query that shows the average price of books for 
-- each author and the total number of books they published. 
CREATE VIEW AuthorStats AS
    SELECT a.AuthorID, a.FirstName + '' + a.LastName AS AuthorName, 
    COUNT(b.BookID) AS BookCount, 
    AVG(b.Price) AS AverageBookPrice
    FROM Authors a
    LEFT JOIN Books b ON a.AuthorID = b.AuthorID
    GROUP BY 
        a.AuthorID, a.FirstName, a.LastName;

-- Insert a second book for George Orwell to test AuthorStats
INSERT INTO Books (BookID, Title, AuthorID, PublicationYear, Price)
VALUES (6, 'Animal Farm', 2, 1945, 55.00)

SELECT * FROM AuthorStats;

-- Create an updateable view that allows us to update the author's firstname and lastname
CREATE VIEW AuthorContactInfo AS 
    SELECT AuthorID, FirstName, LastName
    FROM Authors;

-- Update the author's name through the view
UPDATE AuthorContactInfo
SET FirstName = 'Joanne'
WHERE AuthorID = 3;

SELECT * FROM AuthorContactInfo;
SELECT * FROM Authors;

-- Create the audit table that logs all of the price changes to the books
CREATE TABLE BookPriceAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY, 
    BookID INT, 
    OldPrice DECIMAL(10,2), 
    NewPrice DECIMAL(10,2), 
    ChangeDate DATETIME DEFAULT GETDATE()
);

-- Create a trigger to add a new record to the audit table
-- whenever a book's price is changed
CREATE TRIGGER trg_BookPriceChange
ON Books
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Price)
    BEGIN
        INSERT INTO BookPriceAudit (BookID, OldPrice, NewPrice)
            SELECT i.BookID, d.Price, i.Price
            FROM inserted i 
            JOIN deleted d ON i.BookID = d.BookID
    END
END;

-- Update a book's price
UPDATE Books
SET price = 14.99
WHERE BookID = 1;

-- View the record from the audit. 
SELECT * FROM BookPriceAudit