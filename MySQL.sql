-- CREATING DATABASE
CREATE DATABASE TickLabInfoSystem;
USE TickLabInfoSystem;
-- CREATING TABLE
    -- Person
        CREATE TABLE Person (
            profileNumber int NOT NULL,
            username char,
            passwd char,
            gender boolean,
            permanentAddress char,
            dateOfBirth datetime,
            firstName char,
            middleName char,
            lastName char,
            nationality char,
            nationalIDNumber char,
            nationalIDIssueDate datetime,
            passportNumber char,
            passportPlaceOfIssue char,
            passportDateOfIssue datetime,
            passportDateOfExpiry datetime,
            profilePhotoURL char,
            PRIMARY KEY(profileNumber)
        );
    -- TickLab ID CARD
        CREATE TABLE TickLabIDCard (
            profileNumber int,
            dateOfIssue datetime,
            rfidNumber int,
            PRIMARY KEY(rfidNumber),
            FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
        );
    -- Contact address
        CREATE TABLE PersonContactAddress (
            profileNumber int,
            contactAddress char,
            FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
        );
    -- Email address
        CREATE TABLE PersonEmailAddress (
            profileNumber int,
            emailAddress char,
            FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
        );
    -- System roles
        CREATE TABLE PersonSystemRole (
            profileNumber int,
            systemRole char,
            FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
        );
    -- Related documents
        CREATE TABLE PersonRelatedDoc (
            profileNumber int,
            documentURL char,
            FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
        );
    -- Person phone number
        CREATE TABLE PersonPhoneNumber (
            profileNumber int,
            phoneNumber char,
            FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
        );