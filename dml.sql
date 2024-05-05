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

-- add a new book 
INSERT INTO Books (bookTitle, genre, numCopies) 
VALUES (:bookTitleInput, :genreInput, :numCopiesInput)



--------------------------------------------------------------------------
-- AUTHORS
-- display all authors
SELECT authorID, authorFirstName, authorLastName 
FROM Authors

-- add a new author
INSERT INTO Authors (authorFirstName, authorLastName)
VALUES (:authorFirstNameInput, :authorLastNameInput)



--------------------------------------------------------------------------
-- CHECKOUTS PAGE/CHECKED-OUT BOOKS 

-- get all memberID's and memberLastName's for Member dropdown
SELECT memberID, memberLastName FROM Members

-- get all employeeID's and employeeLastName's for Employee dropdown
SELECT employeeID, employeeLastName FROM Employees

-- display all checkouts
SELECT checkoutID, Members.memberLastName AS memberLastName, Employees.employeeLastName AS employeeLastName,
dateCheckedOut, dateDue
FROM Checkouts
INNER JOIN Members ON Checkouts.memberID = Members.memberID
INNER JOIN Employees ON Checkouts.employeeID = Employees.employeeID

-- display all checkouts with their respective books and dateReturned
SELECT Checkouts.checkoutID, bookTitle, dateReturned
FROM Checkouts
INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID
INNER JOIN Books on Books.bookID = BooksCheckouts.bookID
ORDER BY checkoutID

-- add a new checkout
INSERT INTO Checkouts (memberID, employeeID, dateCheckedOut, dateDue) 
VALUES (:memberID_from_dropdown_input, :employeeID_from_dropdown_input, :dateCheckedOutInput, :dateDueInput)

-- add books to a checkout (adding to a M:M relationship)
INSERT INTO BooksCheckouts (bookID, checkoutID)
VALUES (:bookID_from_dropdown_input, :checkoutID_from_dropdown_input)

-- update the dateReturned in BooksCheckouts (updating a M:M relationship)
UPDATE BooksCheckouts
SET dateReturned = :dateReturnedInput
WHERE BooksCheckouts.bookID = :bookID_from_update_form

-- delete a checkout
DELETE FROM Checkouts WHERE checkoutID = :checkoutIDInput

-- dis-associate a checkout from its books (deleting a M:M relationship) 
DELETE FROM BooksCheckouts WHERE checkoutID = :checkoutIDInput AND bookID = :bookIDInput

-- update a checkout
UPDATE Checkouts 
SET memberID = :memberID_from_dropdown_input, employeeID = :employeeID_from_dropdown_input, 
dateCheckedOut = :dateCheckedOutInput, dateDue = :dateDueInput
WHERE checkoutID = :checkoutID_from_update_form




--------------------------------------------------------------------------
-- EMPLOYEES PAGE
-- display all employees
SELECT employeeFirstName, employeeLastName, employeeEmail 
FROM Employees

-- add a new employee
INSERT INTO Employees (employeeFirstName, employeeLastName, employeeEmail) 
VALUES (:employeeFirstNameInput, :employeeLastNameInput, :employeeEmailInput)
