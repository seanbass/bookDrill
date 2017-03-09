USE bookDrill
GO

-- 1. How many copies of the book titled The Lost Tribe are owned by the library branch whose name is Sharpstown

-- num of copies book title the lost tribe"
-- branch "sharpstown"

SELECT NumOfCopies, Title
FROM Book
INNER JOIN BookCopies ON Book.BookID = BookCopies.BookID
INNER JOIN LibraryBranch ON BookCopies.BranchID = LibraryBranch.BranchID
WHERE Title = 'The Lost Tribe' AND LibraryBranch.BranchName = 'Sharpstown';




-- 2. How many copies of the book titled The Lost Tribe are owned by each library branch?



SELECT NumOfCopies, Title, BranchName
FROM Book
INNER JOIN BookCopies ON Book.BookID = BookCopies.BookID
INNER JOIN LibraryBranch ON BookCopies.BranchID = LibraryBranch.BranchID
WHERE Title = 'The Lost Tribe';


-- 3. Retrieve the names of all borrowers who do not have any books checked out


SELECT DISTINCT Name, Borrower.CardNo 
FROM Borrower 
INNER JOIN BookLoans ON Borrower.CardNo = BookLoans.CardNo;


-- 4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
-- retrieve the book title, the borrower's name, and the borrower's address.

-- book loans from sharpstown
-- whos duedate is TODAY
-- get title, borrower name, and address


SELECT DateDue, BranchName
FROM BookLoans
INNER JOIN LibraryBranch ON LibraryBranch.BranchID = BookLoans.BranchID
INNER JOIN Book ON BookLoans.BookID = Book.BookID
WHERE BranchName = 'Sharpstown'
AND DateDue = CONVERT(date, GETDATE());

--2011-02-25 21:17:33.933
--2011-02-25

 





-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from
-- that branch.

-- each library branches
-- get the name and total books loaned out


SELECT BranchName, COUNT(*) AS TotalBooks
FROM BookLoans
INNER JOIN LibraryBranch ON LibraryBranch.BranchID = BookLoans.BranchID
GROUP BY LibraryBranch.BranchName;




-- 6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more
-- t han five books checked out.

-- count in book loans grouped card no

-- names and addresses
-- check number of books
-- condition to >5 per borrower



SELECT Name, HomeAddress
FROM Borrower
INNER JOIN (SELECT CardNo, COUNT(*) AS theCount
FROM BookLoans
GROUP BY CardNo)myTable ON myTable.CardNo = Borrower.CardNo
WHERE myTable.theCount >= 5;  -- none above 5 change to 4 or lower for results



-- 7. For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of
-- copies owned by the library branch whose name is "Central"



-- Get all books by SK
-- Get the title and no.copies
-- Filter by branch Central

-- FOO: Book INNER JOIN BookAuthors on Book.BookID = BookAuthors.BookID
-- KUNG: INNER JOIN BookCopies ON BookCopies.NumOfCopies = BookCopies.BranchID


SELECT Book.Title, BookCopies.NumOfCopies
FROM Book
INNER JOIN BookAuthors ON Book.BookID = BookAuthors.BookID -- FOO 
INNER JOIN BookCopies ON BookCopies.BookID = BookAuthors.BookID -- KUNG
INNER JOIN LibraryBranch ON LibraryBranch.BranchID = BookCopies.BranchID
WHERE BookAuthors.AuthorName = 'Stephen King'
AND LibraryBranch.BranchName = 'Central';



-- STORED PROCUDURE


CREATE PROCEDURE GetNumOfCopies
AS
	SELECT Book.BookID, Title, PublishersName, NumOfCopies
	FROM Book
	INNER JOIN BookCopies ON BookCopies.BookID = Book.BookID
	WHERE NumOfCopies <= 5