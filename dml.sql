-- the ":" denotes a variable being received from the backend

-- MEMBERS
-- display all members for the Members Page
SELECT memberID, memberFirstName, memberLastName, memberEmail 
FROM Members

-- add a new member for the Members Page
INSERT INTO Members (memberFirstName, memberLastName, memberEmail) 
VALUES (:memberFirstNameInput, :memberLastNameInput, :memberEmailInput)
--------------------------------------------------------------------------




-- BOOKS
-- display all books
SELECT bookID, bookTitle, genre, numCopies 
FROM Books

-- display all books with their author 
SELECT Books.bookID, bookTitle, genre, numCopies, authorLastName AS author
FROM Books
INNER JOIN BooksAuthors ON Books.bookID = BooksAuthors.bookID
INNER JOIN Authors on Authors.authorID = BooksAuthors.authorID

-- add a new book 
INSERT INTO Books (bookTitle, genre, numCopies) 
VALUES (:bookTitleInput, :genreInput, :numCopiesInput)

-- give a book an author/authors (M:M relationship)
INSERT INTO BooksAuthors (bookID, authorID)
VALUES (:bookIDInput, :authorIDInput)

--------------------------------------------------------------------------



-- AUTHORS
-- display all authors
SELECT authorID, authorFirstName, authorLastName 
FROM Authors

-- display all authors with their respective books
SELECT Authors.authorID, authorFirstName, authorLastName, bookTitle
FROM Authors
INNER JOIN BooksAuthors ON Authors.authorID = BooksAuthors.authorID
INNER JOIN Books on Books.bookID = BooksAuthors.bookID

-- add a new author
INSERT INTO Authors (authorFirstName, authorLastName)
VALUES (:authorFirstNameInput, :authorLastNameInput)

--------------------------------------------------------------------------



-- CHECKOUTS PAGE/Checked-out books page?
-- get all memberID's and memberLastName's for Member dropdown
SELECT memberID, memberLastName FROM Members

-- get all employeeID's and employeeLastName's for Employee dropdown
SELECT employeeID, employeeLastName FROM Employees

-- display all checkouts 
SELECT checkoutID, dateCheckedOut, dateDue, 
Members.memberLastName AS memberLastName, Employees.employeeLastName AS employeeLastName
FROM Checkouts
INNER JOIN Members ON Checkouts.memberID = Members.memberID
INNER JOIN Employees ON Checkouts.employeeID = Employees.employeeID


-- display all checkouts with their respective books and the date returned
SELECT Checkouts.checkoutID, bookTitle, dateReturned
FROM Checkouts
INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID
INNER JOIN Books on Books.bookID = BooksCheckouts.bookID
ORDER BY checkoutID

-- add a new checkout
INSERT INTO Checkouts (memberID, employeeID, dateCheckedOut, dateDue) 
VALUES (:memberID_from_dropdown_Input, :employeeID_from_dropdown_input, :dateCheckedOutInput, :dateDueInput)

-- add books to a checkout (adding to a M:M relationship)
INSERT INTO BooksCheckouts (bookID, checkoutID, dateReturned)
VALUES (:bookIDInput, :checkoutIDInput, :dateReturnedInput)

-- update the dateReturned in BooksCheckouts (updating a M:M relationship)
UPDATE BooksCheckouts
SET dateReturned = :dateReturnedInput
WHERE BooksCheckouts.bookID = :bookID_from_update_form

-- delete a checkout
DELETE FROM Checkouts WHERE checkoutID = :checkoutIDInput

-- dis-associate books from a checkout (deleting a M:M relationship) (is this needed or does cascade take care of this??)
DELETE FROM BooksCheckouts WHERE checkoutID = :checkoutIDInput AND bookID = :bookIDInput

-- update a checkout
UPDATE Checkouts 
SET employeeID = :employeeID_from_dropdown_input, dateDue = :dateDueInput
WHERE checkoutID = :checkoutID_from_update_form

--------------------------------------------------------------------------




-- EMPLOYEES PAGE
-- display all employees
SELECT employeeFirstName, employeeLastName, employeeEmail 
FROM Employees

-- add a new employee
INSERT INTO Employees (employeeFirstName, employeeLastName, employeeEmail) 
VALUES (:employeeFirstNameInput, :employeeLastNameInput, :employeeEmailInput)

