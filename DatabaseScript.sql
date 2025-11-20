-- Library System Database Creation Script
-- Run this script to create the database and tables

USE master;
GO

-- Create database if it doesn't exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'LibrarySystem')
BEGIN
    CREATE DATABASE LibrarySystem;
END
GO

USE LibrarySystem;
GO

-- Create ADMIN table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ADMIN')
BEGIN
    CREATE TABLE ADMIN (
        aid INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(100) NOT NULL,
        email NVARCHAR(100) NOT NULL UNIQUE,
        password NVARCHAR(100) NOT NULL
    );
END
GO

-- Create BRANCH table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'BRANCH')
BEGIN
    CREATE TABLE BRANCH (
        branchid INT IDENTITY(1,1) PRIMARY KEY,
        branchname NVARCHAR(100) NOT NULL
    );
END
GO

-- Create PUBLICATION table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PUBLICATION')
BEGIN
    CREATE TABLE PUBLICATION (
        pid INT IDENTITY(1,1) PRIMARY KEY,
        publication NVARCHAR(100) NOT NULL
    );
END
GO

-- Create STUDENT table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'STUDENT')
BEGIN
    CREATE TABLE STUDENT (
        sid INT IDENTITY(1,1) PRIMARY KEY,
        studentname NVARCHAR(100) NOT NULL,
        branch NVARCHAR(100),
        mobile NVARCHAR(20),
        address NVARCHAR(200),
        city NVARCHAR(100),
        pincode NVARCHAR(10),
        birthdate DATETIME,
        gender NVARCHAR(10),
        email NVARCHAR(100) NOT NULL UNIQUE,
        password NVARCHAR(100) NOT NULL,
        image NVARCHAR(200)
    );
END
GO

-- Create BOOK table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'BOOK')
BEGIN
    CREATE TABLE BOOK (
        bookid INT IDENTITY(1,1) PRIMARY KEY,
        bookname NVARCHAR(200) NOT NULL,
        author NVARCHAR(100),
        detail NVARCHAR(500),
        price FLOAT,
        publication NVARCHAR(100),
        branch NVARCHAR(100),
        quantities INT,
        availableqnt INT,
        rentqnt INT,
        image NVARCHAR(200)
    );
END
GO

-- Create RENT table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'RENT')
BEGIN
    CREATE TABLE RENT (
        rentid INT IDENTITY(1,1) PRIMARY KEY,
        bookname NVARCHAR(200),
        sid INT,
        issuedate DATETIME DEFAULT GETDATE(),
        returndate DATETIME,
        days INT,
        status INT DEFAULT 0,
        FOREIGN KEY (sid) REFERENCES STUDENT(sid)
    );
END
GO

-- Create PANALTY table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PANALTY')
BEGIN
    CREATE TABLE PANALTY (
        pid INT IDENTITY(1,1) PRIMARY KEY,
        sid INT,
        bookname NVARCHAR(200),
        issuedate DATETIME,
        returndate DATETIME,
        days INT,
        fine FLOAT,
        FOREIGN KEY (sid) REFERENCES STUDENT(sid)
    );
END
GO

-- Insert default admin user
IF NOT EXISTS (SELECT * FROM ADMIN WHERE email = 'admin@library.com')
BEGIN
    INSERT INTO ADMIN (name, email, password) 
    VALUES ('Admin', 'admin@library.com', 'admin123');
END
GO

-- Insert sample branches
IF NOT EXISTS (SELECT * FROM BRANCH)
BEGIN
    INSERT INTO BRANCH (branchname) VALUES ('Computer Science');
    INSERT INTO BRANCH (branchname) VALUES ('Information Technology');
    INSERT INTO BRANCH (branchname) VALUES ('Electronics');
    INSERT INTO BRANCH (branchname) VALUES ('Mechanical');
    INSERT INTO BRANCH (branchname) VALUES ('Civil');
END
GO

-- Insert sample publications
IF NOT EXISTS (SELECT * FROM PUBLICATION)
BEGIN
    INSERT INTO PUBLICATION (publication) VALUES ('Pearson');
    INSERT INTO PUBLICATION (publication) VALUES ('McGraw Hill');
    INSERT INTO PUBLICATION (publication) VALUES ('Wiley');
    INSERT INTO PUBLICATION (publication) VALUES ('O''Reilly');
END
GO

PRINT 'Database setup completed successfully!';
GO
