-- CREATE DATABASE
CREATE DATABASE TickLabInfoSystem;
-- CREATE TABLE
    -- Person
    CREATE TABLE Person (
        profileNumber INT NOT NULL,
        username VARCHAR(10),
        passwd VARCHAR (10),
        gender BIT,
        permanentAddress TEXT,
        dateOfBirth DATE,
        firstName TEXT,
        middleName TEXT,
        lastName TEXT,
        nationality TEXT,
        nationalIDNumber VARCHAR(9),
        nationalIDIssueDate DATE,
        passportNumber TEXT,
        passportPlaceOfIssue TEXT,
        passportDateOfIssue DATE,
        passportDateOfExpiry DATE,
        profilePhotoURL TEXT,
        PRIMARY KEY(profileNumber)
    );
    -- TickLab ID CARD
    CREATE TABLE TickLabIDCard (
        profileNumber INT NOT NULL,
        dateOfIssue DATE NOT NULL,
        rfidNumber INT NOT NULL,
        PRIMARY KEY(profileNumber, dateOfIssuem, rfidNumber),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Contact address
    CREATE TABLE PersonContactAddress (
        profileNumber INT NOT NULL,
        contactAddress TEXT NOT NULL,
        PRIMARY KEY(profileNumber, contactAddress),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Email address
    CREATE TABLE PersonEmailAddress (
        profileNumber INT NOT NULL,
        emailAddress TEXT NOT NULL,
        PRIMARY KEY(profileNumber, emailAddress),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- System roles
    CREATE TABLE PersonSystemRole (
        profileNumber INT NOT NULL,
        systemRole TEXT NOT NULL,
        PRIMARY KEY(profileNumber, systemRole),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Person related documents
    CREATE TABLE PersonRelatedDoc (
        profileNumber INT NOT NULL,
        personDocumentURL TEXT NOT NULL,
        PRIMARY KEY(profileNumber, documentURL),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Person phone number
    CREATE TABLE PersonPhoneNumber (
        profileNumber INT NOT NULL,
        phoneNumber TEXT NOT NULL,
        PRIMARY KEY(profileNumber, phoneNumber),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Department
    CREATE TABLE Department (
        departmentID INT NOT NULL,
        departmentName TEXT,
        departmentID INT,
        departmentDescription TEXT,
        PRIMARY KEY(departmentID)
    );
    -- Project
    CREATE TABLE Project (
        projectName TEXT,
        projectID VARCHAR(10) NOT NULL,
        projectStartTime DATE,
        projectEndTime DATE,
        projectStatus TEXT,
        expectedFinishTime DATE,
        projectDescription TEXT,
        TickLabBudget INT,
        projectManagerProfileNumber INT,
        belongToDepartmentHave INT,
        PRIMARY KEY(projectID),
        FOREIGN KEY(projectManagerProfileNumber) REFERENCES Person(profileNumber),
        FOREIGN KEY(belongToDepartmentHave) REFERENCES Department(departmentID)
    );
    -- Project related documents
    CREATE TABLE ProjectRelatedDoc (
        projectID INT NOT NULL,
        projectDocumentURL TEXT NOT NULL,
        PRIMARY KEY(projectID, projectDocumentURL),
        FOREIGN KEY(projectID) REFERENCES Project(projectID) 
    );
    -- Company
    CREATE TABLE Company (
        taxIDNumber VARCHAR(9) NOT NULL,
        conpanyName TEXT,
        companyDescription TEXT,
        PRIMARY KEY(taxIDNumber)
    );
    -- Company related documents
    CREATE TABLE CompanyRelatedDoc (
        taxIDNumber VARCHAR(9) NOT NULL,
        companyDocumentURL TEXT,
        PRIMARY KEY(taxIDNumber, companyDocumentURL),
        FOREIGN KEY(taxIDNumber) REFERENCES Company(taxIDNumber)
    );
    -- Position
    CREATE TABLE Position (
        posID INT NOT NULL,
        posName TEXT,
        posDescription TEXT,
        PRIMARY KEY(posID)
    );
    -- Person take position
    CREATE TABLE "Take" (
        profileNumberTake INT NOT NULL,
        posIDTake INT NOT NULL,
        takeFromdate DATE,
        takeToDate DATE,
        PRIMARY KEY(profileNumberTake, posIDTake),
        FOREIGN KEY(profileNumberTake) REFERENCES Person(profileNumber),
        FOREIGN KEY(posIDTake) REFERENCES Position(posID)
    );
    -- Task
    CREATE TABLE Task (
        taskID INT NOT NULL,
        taskStartTime DATE,
        taskEndTime DATE,
        whatToDo TEXT,
        taskDescription TEXT,
        taskStatus TEXT,
        PRIMARY KEY(taskID)
    );
    -- Task's paricipate
    CREATE TABLE Participate (
        profileNumberParticipate INT NOT NULL,
        taskIDParticipate INT NOT NULL,
        score INT,
        PRIMARY KEY(profileNumberParticipate, taskIDParticipate),
        FOREIGN KEY(profileNumberParticipate) REFERENCES Person(profileNumber),
        FOREIGN KEY(taskIDParticipate) REFERENCES Task(taskID)
    );
    -- Task remake
    CREATE TABLE TaskRemark (
        taskID INT NOT NULL,
        taskRemark TEXT NOT NULL,
        PRIMARY KEY(taskID, taskRemark),
        FOREIGN KEY(taskID) REFERENCES Task(taskID)
    );
    -- Daily duty
    CREATE TABLE DailyDuty (
        dutyID INT NOT NULL,
        dutyName TEXT,
        dutyDescription TEXT,
        PRIMARY KEY(dutyID)
    )
    -- Duty shift
    -- Application form
    -- Seminar workshop
    -- Interview
    -- Community activity
    -- Infrastructures
    -- Include
    -- Borrow record
    -- Revenue category
    -- Expediture category
    -- Fund
    -- Have to pay