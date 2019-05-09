-- CREATING DATABASE
CREATE DATABASE TickLabInfoSystem;
USE TickLabInfoSystem;
-- CREATING TABLE
    -- TickLab ID CARD
        CREATE TABLE TickLabIDCard (
            profileNumber int,
            dateOfIssue datetime,
            rfidNumber int,
            PRIMARY KEY(rfidNumber)
        );
    -- Contact address
        CREATE TABLE PersonContactAddress (
            profileNumber int,
            contactAddress nchar
        );
    -- Email address
        CREATE TABLE PersonEmailAddress (
            profileNumber int,
            emailAddress char
        );
    -- System roles
        CREATE TABLE PersonSystemRole (
            profileNumber int,
            systemRole char
        );
    -- Related documents
        CREATE TABLE PersonRelatedDoc (
            profileNumber int,
            documentURL char
        );
    -- Person phone number
        CREATE TABLE PersonPhoneNumber (
            profileNumber int,
            phoneNumber char
        );
    -- Person
        CREATE TABLE Person (
            profileNumber int,
            username char,
            passwd char,
            gender boolean,
            permanentAddress nchar,
            dateOfBirth datetime,
            firstName nchar,
            middleName nchar,
            lastName nchar,
            nationality nchar,
            nationalIDNumber char,
            nationalIDIssueDate datetime,
            passportNumber char,
            passportPlaceOfIssue char,
            passportDateOfIssue datetime,
            passportDateOfExpiry datetime,
            profilePhotoURL char,
            PRIMARY KEY(profileNumber)
        );