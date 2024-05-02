
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Foreign and Primary keys for all tables described using alter table to introduce CASCADE statements

-- -----------------------------------------------------
-- Table `Authors`
-- -----------------------------------------------------

/* Represents the individual author for each book(s) */ 

CREATE OR REPLACE TABLE `Authors` (
  `authorID` INT NOT NULL AUTO_INCREMENT,
  `authorFirstName` varchar(255) NOT NULL,
  `authorLastName` varchar(255) NOT NULL,
  PRIMARY KEY (`authorID`),
  UNIQUE (`authorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- -----------------------------------------------------
-- Insert `Authors`
-- -----------------------------------------------------

INSERT INTO `Authors` (`authorID`, `authorFirstName`, `authorLastName`) VALUES
(1, 'J.K.', 'Rowling'),
(2, 'Jane', 'Austen'),
(3, 'Conan', 'Doyle'),
(4, 'Stephen', 'King'),
(5, 'Peter', 'Straub');

-- -----------------------------------------------------
-- Table `Books`
-- ----------------------------------------------------- 

/* Represents a book title in the library */ 

CREATE OR REPLACE TABLE `Books` (
  `bookID` INT NOT NULL AUTO_INCREMENT,
  `bookTitle` varchar(255) NOT NULL,
  `genre` varchar(45) NOT NULL,
  `numCopies` INT NOT NULL,
  PRIMARY KEY (`bookID`),
  UNIQUE (`bookID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- -----------------------------------------------------
-- Insert `Books`
-- -----------------------------------------------------

INSERT INTO `Books` (`bookID`, `bookTitle`, `genre`, `numCopies`) VALUES
(1, 'Harry Potter and the Chamber of Secrets', 'fantasy', 5),
(2, 'Harry Potter and the Prisoner of Azkaban', 'fantasy', 5),
(3, 'Sherlock Holmes', 'mystery', 5),
(4, 'Pride and Prejudice', 'mystery', 5),
(5, 'The Talisman', 'fantasy', 5);

-- -----------------------------------------------------
-- Table `Employees`
-- -----------------------------------------------------

/* Records employee information including name, email and ID */ 

CREATE OR REPLACE TABLE `Employees` (
  `employeeID` INT NOT NULL AUTO_INCREMENT,
  `employeeFirstName` varchar(255) NOT NULL,
  `employeeLastName` varchar(255) NOT NULL,
  `employeeEmail` varchar(255) NOT NULL,
  PRIMARY KEY (`employeeID`),
  UNIQUE (`employeeID`),
  UNIQUE (`employeeEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- -----------------------------------------------------
-- Insert `Employees`
-- -----------------------------------------------------

INSERT INTO `Employees` (`employeeID`, `employeeFirstName`, `employeeLastName`, `employeeEmail`) VALUES
(1, 'Haley', 'Smith', 'haleysmith@gmail.com'),
(2, 'John', 'Martin', 'johnmartin@gmail.com'),
(3, 'Sue', 'Sylvester', 'suesylvester@gmail.com'),
(4, 'Brad', 'Pitt', 'bradpitt@gmail.com'),
(5, 'Annie', 'Hall', 'anniehall@gmail.com');

-- -----------------------------------------------------
-- Table `Members`
-- -----------------------------------------------------

/* Records members of the library including name, email and ID */ 

CREATE OR REPLACE TABLE `Members` (
  `memberID` INT NOT NULL AUTO_INCREMENT,
  `memberFirstName` varchar(255) NOT NULL,
  `memberLastName` varchar(255) NOT NULL,
  `memberEmail` varchar(255) NOT NULL,
  PRIMARY KEY (`memberID`),
  UNIQUE (`memberID`),
  UNIQUE (`memberEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- -----------------------------------------------------
-- Insert `Members`
-- -----------------------------------------------------

INSERT INTO `Members` (`memberID`, `memberFirstName`, `memberLastName`, `memberEmail`) VALUES
(1, 'Taylor', 'Swift', 'swiftie101@gmail.com'),
(2, 'John', 'Cena', 'biker23@gmail.com'),
(3, 'Eddie', 'Murphy', 'edmurphy@yahoo.com'),
(4, 'Hannah', 'Montana', 'cowgirl3@yahoo.com'),
(5, 'Miley', 'Cyrus', 'singsingsing@gmail.com');

-- -----------------------------------------------------
-- Table `BooksAuthors`
-- -----------------------------------------------------

/* Book details for authors and books */ 

CREATE OR REPLACE TABLE `BooksAuthors` (
  `booksAuthorsID` INT NOT NULL AUTO_INCREMENT,
  `Books_bookID` INT,
  `Authors_authorID` INT,
  PRIMARY KEY (`booksAuthorsID`),
  UNIQUE (`booksAuthorsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

ALTER TABLE `BooksAuthors`
  ADD CONSTRAINT `fk_Books_has_Authors_Authors1`
    FOREIGN KEY (`Authors_authorID`)
    REFERENCES `Authors` (`authorID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE `BooksAuthors`
  ADD CONSTRAINT `fk_Books_has_Authors_Books1`
    FOREIGN KEY  (`Books_bookID`)
    REFERENCES `Books` (`BookID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Insert `BooksAuthors`
-- -----------------------------------------------------

INSERT INTO `BooksAuthors` (`booksAuthorsID`, `Books_bookID`, `Authors_authorID`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 3),
(4, 4, 2),
(5, 5, 4),
(6, 5, 5);

-- -----------------------------------------------------
-- Table `Checkouts`
-- -----------------------------------------------------

/* Information about the checkout of a book */ 

CREATE OR REPLACE TABLE `Checkouts` (
  `checkoutID` INT NOT NULL AUTO_INCREMENT,
  `Members_memberID` INT,
  `Employees_employeeID` INT,
  `dateCheckedOut` date NOT NULL,
  `dateDue` date NOT NULL,
  PRIMARY KEY (`checkoutID`),
  UNIQUE (`checkoutID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

ALTER TABLE `Checkouts`
  ADD CONSTRAINT `fk_Checkouts_Employees1`
    FOREIGN KEY (`Employees_employeeID`)
    REFERENCES `Employees` (`employeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE `Checkouts`
  ADD CONSTRAINT `fk_Checkouts_Members`
    FOREIGN KEY (`Members_memberID`)
    REFERENCES `Members` (`memberID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

    -- -----------------------------------------------------
-- Insert `Checkouts`
-- -----------------------------------------------------

INSERT INTO `Checkouts` (`checkoutID`, `Members_memberID`, `Employees_employeeID`, `dateCheckedOut`, `dateDue`) VALUES
(1, 3, 1, '2024-04-09', '2024-04-29'),
(2, 3, 5, '2023-03-05', '2023-03-25'),
(3, 2, 4, '2023-11-02', '2023-11-23'),
(4, 1, 4, '2022-05-05', '2022-05-25'),
(5, 4, 2, '2023-12-06', '2023-12-26');

-- -----------------------------------------------------
-- Table `BooksCheckouts`
-- -----------------------------------------------------

/* Checkout details for book and checkout */ 

CREATE OR REPLACE TABLE `BooksCheckouts` (
  `booksCheckoutsID` INT NOT NULL AUTO_INCREMENT,
  `Checkouts_checkoutID` INT,
  `Books_bookID` INT,
  `dateReturned` date DEFAULT NULL,
  PRIMARY KEY  (`booksCheckoutsID`),
  UNIQUE (`booksCheckoutsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

ALTER TABLE `BooksCheckouts`
  ADD CONSTRAINT `fk_Checkouts_has_Books_Books1`
    FOREIGN KEY (`Books_bookID`)
    REFERENCES `Books` (`bookID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
  
ALTER TABLE `BooksCheckouts`
  ADD CONSTRAINT `fk_Checkouts_has_Books_Checkouts1`
    FOREIGN KEY  (`Checkouts_checkoutID`)
    REFERENCES `Checkouts` (`checkoutID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Insert `BooksCheckouts`
-- -----------------------------------------------------

INSERT INTO `BooksCheckouts` (`booksCheckoutsID`, `Checkouts_checkoutID`, `Books_bookID`, `dateReturned`) VALUES
(16, 1, 2, NULL),
(17, 2, 2, '2023-03-20'),
(18, 4, 3, '2022-05-22'),
(19, 4, 5, '2022-05-10'),
(20, 3, 4, '2023-11-20');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

