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
        dateOfBirth DATETIME,
        firstName TEXT,
        middleName TEXT,
        lastName TEXT,
        nationality TEXT,
        nationalIDNumber VARCHAR(9),
        nationalIDIssueDate DATETIME,
        passportNumber TEXT,
        passportPlaceOfIssue TEXT,
        passportDateOfIssue DATETIME,
        passportDateOfExpiry DATETIME,
        profilePhotoURL TEXT,
        PRIMARY KEY(profileNumber)
    );
    -- TickLab ID CARD
    CREATE TABLE TickLabIDCard (
        profileNumber INT,
        dateOfIssue DATETIME,
        rfidNumber INT,
        PRIMARY KEY(rfidNumber),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Contact address
    CREATE TABLE PersonContactAddress (
        profileNumber INT,
        contactAddress TEXT,
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Email address
    CREATE TABLE PersonEmailAddress (
        profileNumber INT,
        emailAddress TEXT,
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- System roles
    CREATE TABLE PersonSystemRole (
        profileNumber INT,
        systemRole TEXT,
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Person related documents
    CREATE TABLE PersonRelatedDoc (
        profileNumber INT,
        documentURL TEXT,
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Person phone number
    CREATE TABLE PersonPhoneNumber (
        profileNumber INT,
        phoneNumber TEXT,
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Department
    CREATE TABLE Department (
        departmentName TEXT,
        departmentID INT,
        departmentDescription TEXT,
        PRIMARY KEY(departmentID)
    )
    -- Project
    CREATE TABLE Project (
        projectName TEXT,
        projectID VARCHAR(10) NOT NULL,
        projectStartTime DATETIME,
        projectEndTime DATETIME,
        projectStatus TEXT,
        expectedFinishTime DATETIME,
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
    );
    -- Company
    CREATE TABLE Company (
        conpanyName TEXT,
        taxIDNumber VARCHAR(9),
        companyDescription TEXT,
        PRIMARY KEY(taxIDNumber)
    );
    -- Company related documents
    CREATE TABLE CompanyRelatedDoc (
        -- multiple foreign key
    );
    -- Position
    CREATE TABLE Position (
        posID INT,
        posName TEXT,
        posDescription TEXT,
        PRIMARY KEY(posID)
    );
    -- Person take position
    CREATE TABLE "Take" (
        profileNumberTake INT,
        posIDTake INT,
        takeFromdate DATETIME,
        takeToDate DATETIME,
        FOREIGN KEY() -- multiple foreign key
    );
    -- Task
    CREATE TABLE Task (
        taskID INT,
        taskStartTime DATETIME,
        taskEndTime DATETIME,
        whatToDo TEXT,
        taskDescription TEXT,
        taskStatus TEXT,
        PRIMARY KEY(taskID)
    )
    -- Task's paricipate
    CREATE TABLE Participate (
        profileNumberParticipate INT,
        taskIDParticipate INT,
        score INT,
        FOREIGN KEY () -- multiple foreign key
    );
    -- Task remake
    -- Daily duty
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