USE [master]
GO
/****** Object:  Database [bookDrill]    Script Date: 3/9/2017 1:58:53 PM ******/
CREATE DATABASE [bookDrill]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tester', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tester.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'tester_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tester_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [bookDrill] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bookDrill].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bookDrill] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bookDrill] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bookDrill] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bookDrill] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bookDrill] SET ARITHABORT OFF 
GO
ALTER DATABASE [bookDrill] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [bookDrill] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [bookDrill] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bookDrill] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bookDrill] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bookDrill] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bookDrill] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bookDrill] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bookDrill] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bookDrill] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bookDrill] SET  ENABLE_BROKER 
GO
ALTER DATABASE [bookDrill] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bookDrill] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bookDrill] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bookDrill] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bookDrill] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bookDrill] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bookDrill] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bookDrill] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [bookDrill] SET  MULTI_USER 
GO
ALTER DATABASE [bookDrill] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bookDrill] SET DB_CHAINING OFF 
GO
ALTER DATABASE [bookDrill] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [bookDrill] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [bookDrill]
GO
/****** Object:  StoredProcedure [dbo].[GetNumOfCopies]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNumOfCopies]
AS
	SELECT Book.BookID, Title, PublishersName, NumOfCopies
	FROM Book
	INNER JOIN BookCopies ON BookCopies.BookID = Book.BookID
	WHERE NumOfCopies <= 5
GO
/****** Object:  Table [dbo].[Book]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[PublishersName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookAuthors]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookAuthors](
	[BookID] [int] NOT NULL,
	[AuthorName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookCopies]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCopies](
	[BookID] [int] NOT NULL,
	[BranchID] [int] NOT NULL,
	[NumOfCopies] [nvarchar](50) NULL,
 CONSTRAINT [PK__BookCopi__3DE0C227EE1C64C9] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC,
	[BranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookLoans]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookLoans](
	[BookID] [int] NOT NULL,
	[BranchID] [int] NOT NULL,
	[CardNo] [int] NOT NULL,
	[DateOut] [nvarchar](50) NULL,
	[DateDue] [nvarchar](50) NULL,
 CONSTRAINT [PK__BookLoan__77F640DD32ACF208] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC,
	[BranchID] ASC,
	[CardNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Borrower]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrower](
	[CardNo] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[HomeAddress] [nvarchar](50) NULL,
	[Phone] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CardNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LibraryBranch]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibraryBranch](
	[BranchID] [int] NOT NULL,
	[BranchName] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 3/9/2017 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[Phone] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (1, N'The Lost Tribe', N'Hachette Livre')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (2, N'The Hunger Games', N'Thomson Reuters')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (3, N'Harry Potter', N'Wolters Kluwer')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (4, N'''1984''', N'Jane Smith')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (5, N'The Kite Runner', N'John Smith')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (6, N'The Book Theif', N'Random House')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (7, N'Pride and Prejudice', N'Publisher One')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (8, N'Looking for Alaska', N'Publisher Two')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (9, N'The Hobbit', N'Publisher Three')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (10, N'A Game of Thrones', N'Publisher Four')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (11, N'Ender''s Game', N'Publisher Five')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (12, N'The Help', N'Publisher Six')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (13, N'The Night Circus', N'Publisher Seven')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (14, N'This is Not My Hat', N'Publisher Eight')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (15, N'Don Quixote', N'Publisher Nine')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (16, N'The Lightning Theif', N'Publisher Ten')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (17, N'East of Eden', N'Publisher Eleven')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (18, N'A Tree Grows in Brooklyn', N'Publisher Tweleve')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (19, N'The Odyssey', N'Publisher Thirteen')
INSERT [dbo].[Book] ([BookID], [Title], [PublishersName]) VALUES (20, N'The Pillars of the Earth', N'Publisher Fourteen')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (1, N'Stephen King')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (2, N'Suzanne Collins')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (3, N'J.K Rowling')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (4, N'George Orwell')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (5, N'Khalad Hosseini')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (6, N'Markus Zusak')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (7, N'Jane Austen')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (8, N'John Green')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (9, N'J.R.R. Tolkien')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (10, N'George R.R. Martin')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (11, N'Orson Scott Card')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (12, N'Kathryn Stockett')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (13, N'Erin Morgenstern')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (14, N'Jon Klassen')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (15, N'Miguel de Cervantes')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (16, N'Rick Riordan')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (17, N'John Stienbeck')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (18, N'Betty Smith')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (19, N'Homer')
INSERT [dbo].[BookAuthors] ([BookID], [AuthorName]) VALUES (20, N'Ken Follett')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (1, 1, N'2')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (1, 2, N'10')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (2, 1, N'2')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (3, 1, N'4')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (4, 1, N'5')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (5, 1, N'4')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (6, 1, N'2')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (7, 1, N'2')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (8, 1, N'3')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (9, 1, N'7')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (10, 1, N'3')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (11, 2, N'2')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (12, 2, N'4')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (13, 2, N'7')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (14, 2, N'6')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (15, 2, N'4')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (16, 2, N'9')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (17, 2, N'2')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (18, 2, N'4')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (19, 2, N'3')
INSERT [dbo].[BookCopies] ([BookID], [BranchID], [NumOfCopies]) VALUES (20, 2, N'2')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (1, 1, 1, N'3/6/2017', N'3/15/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (1, 2, 4, N'1/1/2017', N'2/2/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (2, 1, 2, N'3/1/2017', N'3/10/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (2, 2, 3, N'1/1/2017', N'2/2/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (3, 1, 1, N'2/4/2017', N'2/7/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (3, 2, 1, N'4/4/2016', N'5/5/2016')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (4, 1, 4, N'3/7/2017', N'3/9/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (4, 2, 3, N'10/3/2015', N'10/4/2016')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (5, 1, 6, N'11/11/2012', N'11/11/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (5, 2, 2, N'1/4/2017', N'1/20/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (6, 2, 3, N'1/1/2017', N'2/1/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (7, 1, 5, N'1/1/2017', N'2/1/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (8, 1, 2, N'2/2/2017', N'3/3/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (9, 1, 6, N'7/7/2016', N'8/8/2016')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (9, 1, 7, N'9/9/2015', N'10/10/2015')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (9, 2, 3, N'3/3/2017', N'4/4/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (11, 2, 10, N'11/11/2015', N'12/12/2015')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (12, 1, 5, N'4/4/2017', N'5/5/2017')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (13, 1, 4, N'1/1/2016', N'1/2/2016')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (14, 2, 6, N'12/3/2015', N'1/5/2016')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (15, 1, 5, N'12/12/2012', N'12/16/2013')
INSERT [dbo].[BookLoans] ([BookID], [BranchID], [CardNo], [DateOut], [DateDue]) VALUES (15, 2, 4, N'10/15/2015', N'11/15/2015')
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (1, N'Sean', N'1125 Nw 9th ave', 503491231)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (2, N'Jeremy', N'9413 Nw 10th ave', 503581351)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (3, N'Garrin', N'591 SW 8th ave', 503958132)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (4, N'Ally', N'481 Wood Lane', 503813231)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (5, N'Maleah', N'223 Dance Lane', 503813821)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (6, N'Josh', N'411 Love St', 341239491)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (7, N'Michael', N'543 Bounce St', 593818323)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (8, N'Brian', N'311 Okay St', 503812322)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (9, N'Fox', N'953 Red Lane', 313495123)
INSERT [dbo].[Borrower] ([CardNo], [Name], [HomeAddress], [Phone]) VALUES (10, N'Alyssa', N'1113 Yeep', 501332931)
INSERT [dbo].[LibraryBranch] ([BranchID], [BranchName], [Address]) VALUES (1, N'Sharpstown', N'1200 NW 9th ave')
INSERT [dbo].[LibraryBranch] ([BranchID], [BranchName], [Address]) VALUES (2, N'Central', N'800 SW 8th ave')
INSERT [dbo].[LibraryBranch] ([BranchID], [BranchName], [Address]) VALUES (3, N'Midtown', N'1234 Dance Ave')
INSERT [dbo].[LibraryBranch] ([BranchID], [BranchName], [Address]) VALUES (4, N'Read Good', N'333 Reading Lane')
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Hachette Livre', N'123 Orange St.', 5035919341)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Jane Smith', N'123 Meow St.', 5035555555)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'John Smith', N'123 Bark St.', 5035551234)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Eight', N'593 Okay St.', 5039581831)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Eleven', N'593 Like St.', 5035666813)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Five', N'125 Rokit St.', 5039513845)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Four', N'195 Epson St.', 5035918313)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Fourteen', N'888 Dark St.', 5039559145)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Nine', N'591 Brown St.', 5039518314)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher One', N'123 Wee St.', 5039591239)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Seven', N'539 Hold St.', 5039581391)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Six', N'591 Liebe St.', 5039581831)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Ten', N'581 Yes St.', 5039567473)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Thirteen', N'999 Oak St.', 5031234245)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Three', N'590 Tiko St.', 5035915814)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Tweleve', N'111 Gotcha St.', 5039588811)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Publisher Two', N'395 Dance St.', 1239491581)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Random House', N'123 Purple St.', 5035912395)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Thomson Reuters', N'123 Blue St.', 5035552314)
INSERT [dbo].[Publisher] ([Name], [Address], [Phone]) VALUES (N'Wolters Kluwer', N'123 Green St.', 5035559319)
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Publisher] FOREIGN KEY([PublishersName])
REFERENCES [dbo].[Publisher] ([Name])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Publisher]
GO
ALTER TABLE [dbo].[BookCopies]  WITH CHECK ADD  CONSTRAINT [FK_BookCopies_Book] FOREIGN KEY([BranchID])
REFERENCES [dbo].[LibraryBranch] ([BranchID])
GO
ALTER TABLE [dbo].[BookCopies] CHECK CONSTRAINT [FK_BookCopies_Book]
GO
ALTER TABLE [dbo].[BookCopies]  WITH CHECK ADD  CONSTRAINT [FK_BookTOBranch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[LibraryBranch] ([BranchID])
GO
ALTER TABLE [dbo].[BookCopies] CHECK CONSTRAINT [FK_BookTOBranch]
GO
ALTER TABLE [dbo].[BookLoans]  WITH CHECK ADD  CONSTRAINT [FK_BookLoans_BookAuthors] FOREIGN KEY([BookID])
REFERENCES [dbo].[BookAuthors] ([BookID])
GO
ALTER TABLE [dbo].[BookLoans] CHECK CONSTRAINT [FK_BookLoans_BookAuthors]
GO
ALTER TABLE [dbo].[BookLoans]  WITH CHECK ADD  CONSTRAINT [FK_BookLoans_Borrower] FOREIGN KEY([CardNo])
REFERENCES [dbo].[Borrower] ([CardNo])
GO
ALTER TABLE [dbo].[BookLoans] CHECK CONSTRAINT [FK_BookLoans_Borrower]
GO
ALTER TABLE [dbo].[BookLoans]  WITH CHECK ADD  CONSTRAINT [FK_BookLoansTOBranch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[LibraryBranch] ([BranchID])
GO
ALTER TABLE [dbo].[BookLoans] CHECK CONSTRAINT [FK_BookLoansTOBranch]
GO
USE [master]
GO
ALTER DATABASE [bookDrill] SET  READ_WRITE 
GO
