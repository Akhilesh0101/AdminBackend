

create DATABASE NatureHub3;
USE NatureHub3;

-- Create Roles Table (with two roles: Admin and User)
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(10) NOT NULL UNIQUE
);

-- Insert default roles into the Roles table
INSERT INTO Roles (RoleName)
VALUES ('Admin'), ('User');

-- Admin Table 
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(20) NOT NULL UNIQUE,
    Password NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    RoleID INT NOT NULL,
    CONSTRAINT CHK_Password_Validation CHECK (
        LEN(Password) >= 8 AND
        Password LIKE '%[A-Z]%' AND  
        Password LIKE '%[a-z]%' AND  
        Password LIKE '%[0-9]%' 
    ),
	CONSTRAINT CHK_Email_Validation CHECK (
        Email LIKE '%_@__%.__%' -- basic validation for an email address format
    ),
    CONSTRAINT FK_Admin_Role FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE CASCADE ON UPDATE CASCADE,
   
);
insert into Admin values('Akhilesh','Akhilesh123','akhilesh@gmail.com',1)

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(20) NOT NULL,
	UserImage VARBINARY(MAX),
    Email NVARCHAR(25) NOT NULL UNIQUE,
    Password NVARCHAR(20) NOT NULL,
    RoleID INT NOT NULL,
	  CONSTRAINT CHK_Password_Validation_User CHECK (
        LEN(Password) >= 8 AND
        Password LIKE '%[A-Z]%' AND  
        Password LIKE '%[a-z]%' AND  
        Password LIKE '%[0-9]%' 
    ),
	CONSTRAINT CHK_Email_Validation_User CHECK (
        Email LIKE '%_@__%.__%' -- basic validation for an email address format
    ),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE Users
DROP COLUMN UserImage;

select *from Users 
insert into Users values('Akhil','akhil@gmail.com','Akhil123',2)
insert into Users values('Aaditya','aaditya@gmail.com','Aadi123456',2)

select * from users
-- Fixed Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(20) NOT NULL UNIQUE
);

-- Populate Fixed Categories
INSERT INTO Categories (CategoryName) 
VALUES ('Hair'), ('Skin'), ('Body'), ('Digestion'), ('Immunity');

-- Products Table

ALTER TABLE Products
ALTER COLUMN CreatedByAdminID INT NULL;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(30) NOT NULL,
    Productimg VARBINARY(MAX),
    Price DECIMAL(10, 2) NOT NULL,
    Description NVARCHAR(MAX),
    StockQuantity INT DEFAULT 0,
    CategoryID INT NOT NULL,
    CreatedByAdminID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CreatedByAdminID) REFERENCES Admin(AdminID) ON DELETE CASCADE ON UPDATE CASCADE
);
select * from Products

--  Cart Table (for storing products in a user's cart)
CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,  -- Default quantity is 0
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Remedies Table
ALTER TABLE Remedies
ALTER COLUMN CreatedByAdminID INT NULL;
CREATE TABLE Remedies (
    RemedyID INT PRIMARY KEY IDENTITY(1,1),
    RemedyName NVARCHAR(100) NOT NULL,
    Remediesimg VARBINARY(MAX),
    Description NVARCHAR(MAX),
    Benefits NVARCHAR(MAX),
    PreparationMethod NVARCHAR(MAX),
    UsageInstructions NVARCHAR(MAX),
    CategoryID INT NOT NULL,
    CreatedByAdminID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CreatedByAdminID) REFERENCES Admin(AdminID) ON DELETE CASCADE ON UPDATE CASCADE
);
select * from Remedies

-- Health Tips Table
ALTER TABLE HealthTips
ALTER COLUMN CreatedByAdminID INT NULL;
CREATE TABLE HealthTips (
    TipID INT PRIMARY KEY IDENTITY(1,1),
    TipTitle NVARCHAR(100) NOT NULL,
    TipDescription NVARCHAR(MAX),
    HealthTipsimg VARBINARY(MAX),
    CategoryID INT NOT NULL,
    CreatedByAdminID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CreatedByAdminID) REFERENCES Admin(AdminID) ON DELETE CASCADE ON UPDATE CASCADE
);
select * from HealthTips
-- Address Table
CREATE TABLE Address (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Street NVARCHAR(100),
    PhoneNumber VARCHAR(10) NOT NULL UNIQUE CHECK (PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Country NVARCHAR(50),
    ZipCode NVARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE
);



-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- Bookmark Table
CREATE TABLE Bookmark (
    BookmarkID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    RemedyID INT NOT NULL, -- Links directly to Remedies
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ,
    FOREIGN KEY (RemedyID) REFERENCES Remedies(RemedyID) ON DELETE CASCADE ON UPDATE CASCADE
);

select * from Products order by ProductID


--products














































