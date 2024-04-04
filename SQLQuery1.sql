--CREATE DATABASE AuctionApp;

USE AuctionApp;

CREATE TABLE Users (
	ID INT PRIMARY KEY,
	UserName NVARCHAR(32) NOT NULL UNIQUE,
	Balance INT DEFAULT(0)
)

CREATE TABLE Auctions (
	ID INT PRIMARY KEY,
	Title NVARCHAR(32) NOT NULL,
	UserId INT NOT NULL,
	TimeStart DATETIME,
	Duration BIGINT,
	AuctionStatus NVARCHAR(32) NOT NULL,

	FOREIGN KEY (UserId) REFERENCES Users(ID)
)

CREATE TABLE Lots (
	ID INT PRIMARY KEY,
	AuctionId INT NOT NULL,
	Title NVARCHAR(64) NOT NULL,
	LotDescription NVARCHAR(512),
	Price INT

	FOREIGN KEY (AuctionId) REFERENCES Auctions(ID)
)

CREATE TABLE Bids (
	ID INT PRIMARY KEY,
	AuctionId INT NOT NULL,
	LotId INT NOT NULL,
	UserId INT NOT NULL,
	Price INT NOT NULL,
	TimePlaced DATETIME NOT NULL

	FOREIGN KEY (AuctionId) REFERENCES Auctions(ID),
	FOREIGN KEY (LotId) REFERENCES Lots(ID),
	FOREIGN KEY (UserId) REFERENCES Users(ID)
)

CREATE TABLE AuctionReview (
	ID INT PRIMARY KEY,
	UserId INT NOT NULL,
	AuctionId INT NOT NULL,
	ReviewText NVARCHAR(1024),
	Rating INT NOT NULL

	FOREIGN KEY (UserId) REFERENCES Users(ID),
	FOREIGN KEY (AuctionId) REFERENCES Auctions(ID)
)

CREATE TABLE UserWatchlist (
	ID INT PRIMARY KEY,
	UserId INT NOT NULL,
	AuctionId INT NOT NULL

	FOREIGN KEY (UserId) REFERENCES Users(ID),
	FOREIGN KEY (AuctionId) REFERENCES Auctions(ID)
)