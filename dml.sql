-- the ":" denotes a variable being received from the backend

-- CHECKOUTS PAGE

-- get all memberID's and memberLastName's for Member dropdown
SELECT memberID, memberLastName FROM Members

-- get all employeeID's and employeeLastName's for Employee dropdown
SELECT employeeID, employeeLastName FROM Employees

-- display all checkouts
SELECT checkoutID, CONCAT(Members.memberFirstName,' ',Members.memberLastName) AS member, CONCAT(Employees.employeeFirstName,' ',Employees.employeeLastName) AS employee,
dateCheckedOut, dateDue
FROM Checkouts
INNER JOIN Members ON Checkouts.memberID = Members.memberID
INNER JOIN Employees ON Checkouts.employeeID = Employees.employeeID

-- display all checkouts with their respective books and dateReturned
SELECT Checkouts.checkoutID, bookTitle, dateReturned
FROM Checkouts
INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID
INNER JOIN Books on Books.bookID = BooksCheckouts.bookID

-- add a new checkout
INSERT INTO Checkouts (memberID, employeeID, dateCheckedOut, dateDue) 
VALUES (:memberID_from_dropdown_input, :employeeID_from_dropdown_input, :dateCheckedOutInput, :dateDueInput)

-- update a checkout
UPDATE Checkouts 
SET memberID = :memberID_from_dropdown_input, employeeID = :employeeID_from_dropdown_input, 
dateCheckedOut = :dateCheckedOutInput, dateDue = :dateDueInput
WHERE checkoutID = :checkoutID_from_update_form

-- delete a checkout
DELETE FROM Checkouts WHERE checkoutID = :checkoutIDInput




--------------------------------------------------------------------------
-- BOOKS PAGE

-- display all books with their author
SELECT Books.bookID, bookTitle, CONCAT(Authors.authorFirstName,' ',Authors.authorLastName) AS author, genre, numCopies
FROM Books
INNER JOIN BooksAuthors ON Books.bookID = BooksAuthors.bookID
INNER JOIN Authors on Authors.authorID = BooksAuthors.authorID

-- add a new book 
INSERT INTO Books (bookTitle, genre, numCopies) 
VALUES (:bookTitleInput, :genreInput, :numCopiesInput)




--------------------------------------------------------------------------
-- AUTHORS PAGE
-- display all authors
SELECT authorID, authorFirstName, authorLastName 
FROM Authors

-- add a new author
INSERT INTO Authors (authorFirstName, authorLastName)
VALUES (:authorFirstNameInput, :authorLastNameInput)



--------------------------------------------------------------------------
-- MEMBERS PAGE
-- display all members for the Members Page
SELECT memberID, memberFirstName, memberLastName, memberEmail 
FROM Members

-- add a new member for the Members Page
INSERT INTO Members (memberFirstName, memberLastName, memberEmail) 
VALUES (:memberFirstNameInput, :memberLastNameInput, :memberEmailInput)



--------------------------------------------------------------------------
-- EMPLOYEES PAGE
-- display all employees
SELECT employeeFirstName, employeeLastName, employeeEmail 
FROM Employees

-- add a new employee
INSERT INTO Employees (employeeFirstName, employeeLastName, employeeEmail) 
VALUES (:employeeFirstNameInput, :employeeLastNameInput, :employeeEmailInput)





--------------------------------------------------------------------------
-- BOOKS WITH AUTHORS PAGE
-- get all bookID's and bookTitle's for Book dropdown
SELECT bookID, bookTitle FROM Books

-- get all authorID's and authorLastName's for Author dropdown
SELECT authorID, authorLastName FROM Authors

-- display all book and author ids (M:M)
SELECT BooksAuthors.booksAuthorsID, Books.bookID, Authors.authorID
FROM Books
INNER JOIN BooksAuthors ON Books.bookID = BooksAuthors.bookID
INNER JOIN Authors on Authors.authorID = BooksAuthors.authorID

-- give a book an author (M:M relationship)
INSERT INTO BooksAuthors (bookID, authorID)
VALUES (:bookID_from_form, :authorID_from_dropdown_input)





--------------------------------------------------------------------------
--BOOKS IN CHECKOUTS PAGE

-- get all bookID's and bookTitle's for Book dropdown
SELECT bookID, bookTitle FROM Books

-- get all checkoutID's for CheckoutID dropdown
SELECT checkoutID FROM Checkouts

-- display all checkouts and books (M:M)
SELECT BooksCheckouts.booksCheckoutsID, Checkouts.checkoutID, Books.bookID, dateReturned
FROM Checkouts
INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID
INNER JOIN Books on Books.bookID = BooksCheckouts.bookID

-- add a book to a checkout (adding to a M:M relationship)
INSERT INTO BooksCheckouts (bookID, checkoutID, dateReturned)
VALUES (:bookID_from_dropdown_input, :checkoutID_from_dropdown_input, :dateReturnedInput)

-- update the dateReturned in BooksCheckouts (updating a M:M relationship)
UPDATE BooksCheckouts
SET dateReturned = :dateReturnedInput
WHERE BooksCheckouts.booksCheckoutsID = :booksCheckoutsID_from_update_form

