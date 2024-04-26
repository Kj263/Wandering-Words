-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 26, 2024 at 03:03 PM
-- Server version: 10.6.17-MariaDB-log
-- PHP Version: 8.2.17

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
--

-- --------------------------------------------------------

--
-- Table structure for table `Authors`
--

CREATE OR REPLACE TABLE `Authors` (
  `authorID` int(11) NOT NULL,
  `authorFirstName` varchar(255) NOT NULL,
  `authorLastName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Authors`
--

INSERT INTO `Authors` (`authorID`, `authorFirstName`, `authorLastName`) VALUES
(1, 'J.K.', 'Rowling'),
(2, 'Jane', 'Austen'),
(3, 'Conan', 'Doyle'),
(4, 'Stephen ', 'King'),
(5, 'Peter', 'Straub');

-- --------------------------------------------------------

--
-- Table structure for table `Books`
--

CREATE OR REPLACE TABLE `Books` (
  `bookID` int(11) NOT NULL,
  `bookTitle` varchar(255) NOT NULL,
  `genre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Books`
--

INSERT INTO `Books` (`bookID`, `bookTitle`, `genre`) VALUES
(1, 'Harry Potter and the Chamber of Secrets', 'fantasy'),
(2, 'Harry Potter and the Prisoner of Azkaban', 'fantasy'),
(3, 'Sherlock Holmes', 'mystery'),
(4, 'Pride and Prejudice', 'historical fiction'),
(5, 'The Talisman', 'fantasy');

-- --------------------------------------------------------

--
-- Table structure for table `BooksAuthors`
--

CREATE OR REPLACE TABLE `BooksAuthors` (
  `booksAuthorsID` int(11) NOT NULL,
  `Books_bookID` int(11) NOT NULL,
  `Authors_authorID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `BooksAuthors`
--

INSERT INTO `BooksAuthors` (`booksAuthorsID`, `Books_bookID`, `Authors_authorID`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 3),
(4, 4, 2),
(5, 5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `BooksCheckouts`
--

CREATE OR REPLACE TABLE `BooksCheckouts` (
  `booksCheckoutsID` int(11) NOT NULL,
  `Checkouts_checkoutID` int(11) NOT NULL,
  `Books_bookID` int(11) NOT NULL,
  `dateCheckedOut` date DEFAULT NULL,
  `dateDue` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `BooksCheckouts`
--

INSERT INTO `BooksCheckouts` (`booksCheckoutsID`, `Checkouts_checkoutID`, `Books_bookID`, `dateCheckedOut`, `dateDue`) VALUES
(1, 1, 2, '2024-04-09', '2024-04-29'),
(2, 2, 2, '2023-03-05', '2023-03-25'),
(3, 4, 3, '2023-11-02', '2023-11-23'),
(4, 4, 5, '2022-09-10', '2022-09-30'),
(5, 3, 4, '2023-12-06', '2023-12-26');

-- --------------------------------------------------------

--
-- Table structure for table `Checkouts`
--

CREATE OR REPLACE TABLE `Checkouts` (
  `checkoutID` int(11) NOT NULL,
  `Members_memberID` int(11) NOT NULL,
  `Employees_employeeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Checkouts`
--

INSERT INTO `Checkouts` (`checkoutID`, `Members_memberID`, `Employees_employeeID`) VALUES
(1, 3, 1),
(2, 3, 5),
(3, 2, 4),
(4, 1, 4),
(5, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Employees`
--

CREATE OR REPLACE TABLE `Employees` (
  `employeeID` int(11) NOT NULL,
  `employeeFirstName` varchar(255) NOT NULL,
  `employeeLastName` varchar(255) NOT NULL,
  `employeeEmail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Employees`
--

INSERT INTO `Employees` (`employeeID`, `employeeFirstName`, `employeeLastName`, `employeeEmail`) VALUES
(1, 'Haley', 'Smith', 'haleysmith@gmail.com'),
(2, 'John', 'Martin', 'johnmartin@gmail.com'),
(3, 'Sue', 'Sylvester', 'suesylvester@gmail.com'),
(4, 'Brad', 'Pitt', 'bradpitt@gmail.com'),
(5, 'Annie', 'Hall', 'anniehall@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `Members`
--

CREATE OR REPLACE TABLE `Members` (
  `memberID` int(11) NOT NULL,
  `memberFirstName` varchar(255) NOT NULL,
  `memberLastName` varchar(255) NOT NULL,
  `memberEmail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Members`
--

INSERT INTO `Members` (`memberID`, `memberFirstName`, `memberLastName`, `memberEmail`) VALUES
(1, 'Taylor', 'Swift', 'swiftie101@gmail.com'),
(2, 'John', 'Cena', 'biker23@gmail.com'),
(3, 'Eddie', 'Murphy', 'edmurphy@yahoo.com'),
(4, 'Hannah', 'Montana', 'cowgirl3@yahoo.com'),
(5, 'Miley', 'Cyrus', 'singsingsing@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Authors`
--
ALTER TABLE `Authors`
  ADD PRIMARY KEY (`authorID`),
  ADD UNIQUE KEY `authorID_UNIQUE` (`authorID`);

--
-- Indexes for table `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`bookID`),
  ADD UNIQUE KEY `bookID_UNIQUE` (`bookID`);

--
-- Indexes for table `BooksAuthors`
--
ALTER TABLE `BooksAuthors`
  ADD PRIMARY KEY (`booksAuthorsID`,`Books_bookID`,`Authors_authorID`),
  ADD UNIQUE KEY `booksDetailsID_UNIQUE` (`booksAuthorsID`),
  ADD KEY `fk_Books_has_Authors_Authors1_idx` (`Authors_authorID`),
  ADD KEY `fk_Books_has_Authors_Books1_idx` (`Books_bookID`);

--
-- Indexes for table `BooksCheckouts`
--
ALTER TABLE `BooksCheckouts`
  ADD PRIMARY KEY (`booksCheckoutsID`,`Checkouts_checkoutID`,`Books_bookID`),
  ADD UNIQUE KEY `checkoutDetailsID_UNIQUE` (`booksCheckoutsID`),
  ADD KEY `fk_Checkouts_has_Books_Books1_idx` (`Books_bookID`),
  ADD KEY `fk_Checkouts_has_Books_Checkouts1_idx` (`Checkouts_checkoutID`);

--
-- Indexes for table `Checkouts`
--
ALTER TABLE `Checkouts`
  ADD PRIMARY KEY (`checkoutID`,`Members_memberID`,`Employees_employeeID`),
  ADD UNIQUE KEY `checkoutID_UNIQUE` (`checkoutID`),
  ADD KEY `fk_Checkouts_Employees1_idx` (`Employees_employeeID`),
  ADD KEY `fk_Checkouts_Members` (`Members_memberID`);

--
-- Indexes for table `Employees`
--
ALTER TABLE `Employees`
  ADD PRIMARY KEY (`employeeID`),
  ADD UNIQUE KEY `employeeID_UNIQUE` (`employeeID`),
  ADD UNIQUE KEY `employeeEmail_UNIQUE` (`employeeEmail`);

--
-- Indexes for table `Members`
--
ALTER TABLE `Members`
  ADD PRIMARY KEY (`memberID`),
  ADD UNIQUE KEY `memberID_UNIQUE` (`memberID`),
  ADD UNIQUE KEY `memberEmail_UNIQUE` (`memberEmail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Authors`
--
ALTER TABLE `Authors`
  MODIFY `authorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Books`
--
ALTER TABLE `Books`
  MODIFY `bookID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `BooksAuthors`
--
ALTER TABLE `BooksAuthors`
  MODIFY `booksAuthorsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `BooksCheckouts`
--
ALTER TABLE `BooksCheckouts`
  MODIFY `booksCheckoutsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Checkouts`
--
ALTER TABLE `Checkouts`
  MODIFY `checkoutID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Employees`
--
ALTER TABLE `Employees`
  MODIFY `employeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Members`
--
ALTER TABLE `Members`
  MODIFY `memberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Below are the Cascade Update and Delete Options for each Foreign Key
-- Constraints for table `BooksAuthors`
--
ALTER TABLE `BooksAuthors`
  ADD CONSTRAINT `fk_Books_has_Authors_Authors1` FOREIGN KEY (`Authors_authorID`) REFERENCES `Authors` (`authorID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Books_has_Authors_Books1` FOREIGN KEY (`Books_bookID`) REFERENCES `Books` (`bookID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `BooksCheckouts`
--
ALTER TABLE `BooksCheckouts`
  ADD CONSTRAINT `fk_Checkouts_has_Books_Books1` FOREIGN KEY (`Books_bookID`) REFERENCES `Books` (`bookID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Checkouts_has_Books_Checkouts1` FOREIGN KEY (`Checkouts_checkoutID`) REFERENCES `Checkouts` (`checkoutID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Checkouts`
--
ALTER TABLE `Checkouts`
  ADD CONSTRAINT `fk_Checkouts_Employees1` FOREIGN KEY (`Employees_employeeID`) REFERENCES `Employees` (`employeeID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Checkouts_Members` FOREIGN KEY (`Members_memberID`) REFERENCES `Members` (`memberID`) ON UPDATE CASCADE;

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
