USE master -- switch to master db before creating new db
GO

-- TO DO: Drop database if exists

CREATE DATABASE prs -- create the prs db

USE prs -- switch to using prs db
GO

CREATE TABLE Users ( -- create Users table

	Id				INT				NOT NULL IDENTITY PRIMARY KEY,
	Username		NVARCHAR(30)	NOT NULL UNIQUE, -- KM: why did you choose nvarchar?
	Password		NVARCHAR(30)	NOT NULL, -- KM: why did you choose nvarchar?
	FirstName		NVARCHAR(30)	NOT NULL, -- KM: why did you choose nvarchar?
	LastName		NVARCHAR(30)	NOT NULL, -- KM: why did you choose nvarchar?
	Phone			VARCHAR(12)		NULL,
	Email			VARCHAR(255)	NULL,
	IsReviewer		BIT				NOT NULL,
	IsAdmin			BIT				NOT NULL

);

CREATE TABLE Vendors ( -- create Vendors table

	Id				INT				NOT NULL IDENTITY PRIMARY KEY,
	Code			VARCHAR(30)		NOT NULL UNIQUE,
	Name			VARCHAR(30)		NOT NULL,
	Address			VARCHAR(30)		NOT NULL,
	City			VARCHAR(30)		NOT NULL,
	State			VARCHAR(2)		NOT NULL,
	Zip				VARCHAR(5)		NOT NULL,
	Phone			VARCHAR(12)		NULL,
	Email			VARCHAR(255)	NULL

);

CREATE TABLE Products ( -- create Products table

	Id				INT				NOT NULL IDENTITY PRIMARY KEY,
	PartNbr			VARCHAR(30)		NOT NULL UNIQUE,
	Name			VARCHAR(30)		NOT NULL,
	Price			DECIMAL(11,2)	NOT NULL,
	Unit			VARCHAR(30)		NOT NULL,
	PhotoPath		VARCHAR(255)	NULL,
	VendorID		INT				NOT NULL REFERENCES Vendors(Id)

);

CREATE TABLE Requests ( -- create Requests table

	Id				INT				NOT NULL IDENTITY PRIMARY KEY,
	Description		VARCHAR(80)		NOT NULL,
	Justification	VARCHAR(80)		NOT NULL,
	RejectionReason	VARCHAR(80)		NULL,
	DeliveryMode	VARCHAR(80)		NOT NULL DEFAULT 'Pickup',
	SubmittedDate	DATE			NOT NULL DEFAULT GETDATE(),
	DateNeeded		DATE			NOT NULL,
	Status			VARCHAR(10)		NOT NULL DEFAULT 'NEW',
	Total			DECIMAL(11,2)	NOT NULL DEFAULT 0,
	UserId			INT				NOT NULL REFERENCES Users(Id)

);

CREATE TABLE RequestLines ( -- create RequestLines table

	Id				INT				NOT NULL IDENTITY PRIMARY KEY,
	RequestID		INT				NOT NULL REFERENCES Requests(Id),
	ProductID		INT				NOT NULL REFERENCES Products(Id),
	Quantity		INT				NOT NULL DEFAULT 0

);