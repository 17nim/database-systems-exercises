CREATE DATABASE if NOT EXISTS small_library_db;

USE small_library_db;

CREATE TABLE if NOT EXISTS books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    ISBN CHAR(13) UNIQUE,
    PublicationYear YEAR,
    Genre VARCHAR(50),
    NumofPages SMALLINT UNSIGNED,
    AvailableCopies SMALLINT UNSIGNED,
    LastBorrowedDate DATE
);

CREATE INDEX Author_index ON books(Author);
CREATE INDEX Title_index ON books(Title);
CREATE INDEX ISBN_index ON books(ISBN);

FLUSH PRIVILEGES;

CREATE ROLE 'Librarian';
CREATE ROLE 'Assistants';
CREATE ROLE 'Members';

GRANT ALL ON books TO 'Librarian';
GRANT VIEW, UPDATE(AvailableCopies, LastBorrowedDate) ON books TO 'Assistants';
GRANT VIEW(Title, Author, AvailableCopies) ON books TO 'Members';

GRANT Librarian TO 'Jane';
GRANT Assistants TO 'Bob';