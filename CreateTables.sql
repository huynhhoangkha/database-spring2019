-- CREATE DATABASE
CREATE DATABASE TickLabInfoSystem;
USE TickLabInfoSystem;
-- CREATE TABLE
    -- Project Fund Contributor
    CREATE TABLE ProjectFundContributor (
        projectFundContributor INT NOT NULL,
        PRIMARY KEY(projectFundContributor)
    );
    -- Person
    CREATE TABLE Person (
        profileNumber INT NOT NULL,
        username TEXT,
        passwd TEXT,
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
        projectFundContributor INT,
        PRIMARY KEY(profileNumber),
        FOREIGN KEY(projectFundContributor) REFERENCES ProjectFundContributor(projectFundContributor)
    );
    -- TickLab ID CARD
    CREATE TABLE TickLabIDCard (
        profileNumber INT NOT NULL,
        dateOfIssue DATE NOT NULL,
        rfidNumber VARCHAR(9) NOT NULL,
        PRIMARY KEY(profileNumber, dateOfIssue, rfidNumber),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Contact address
    CREATE TABLE PersonContactAddress (
        profileNumber INT NOT NULL,
        contactAddress VARCHAR(256) NOT NULL,
        PRIMARY KEY(profileNumber, contactAddress),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Email address
    CREATE TABLE PersonEmailAddress (
        profileNumber INT NOT NULL,
        emailAddress VARCHAR(256) NOT NULL,
        PRIMARY KEY(profileNumber, emailAddress),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- System roles
    CREATE TABLE PersonSystemRole (
        profileNumber INT NOT NULL,
        systemRole VARCHAR(256) NOT NULL,
        PRIMARY KEY(profileNumber, systemRole),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Person related documents
    CREATE TABLE PersonRelatedDoc (
        profileNumber INT NOT NULL,
        personDocumentURL VARCHAR(256) NOT NULL,
        PRIMARY KEY(profileNumber, personDocumentURL),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Person phone number
    CREATE TABLE PersonPhoneNumber (
        profileNumber INT NOT NULL,
        phoneNumber VARCHAR(11) NOT NULL,
        PRIMARY KEY(profileNumber, phoneNumber),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
    );
    -- Department
    CREATE TABLE Department (
        departmentID INT NOT NULL,
        departmentName TEXT,
        departmentDescription TEXT,
        PRIMARY KEY(departmentID)
    );
    -- Project
    CREATE TABLE Project (
        projectID INT NOT NULL,
        projectName TEXT,
        projectStartTime DATE,
        projectEndTime DATE,
        projectStatus TEXT,
        expectedFinishTime DATE,
        projectDescription TEXT,
        TickLabBudget MONEY,
        projectManagerProfileNumber INT,
        belongToDepartmentHave INT,
        PRIMARY KEY(projectID),
        FOREIGN KEY(projectManagerProfileNumber) REFERENCES Person(profileNumber),
        FOREIGN KEY(belongToDepartmentHave) REFERENCES Department(departmentID)
    );
    -- Project related documents
    CREATE TABLE ProjectRelatedDoc (
        projectID INT NOT NULL,
        projectDocumentURL VARCHAR(256) NOT NULL,
        PRIMARY KEY(projectID, projectDocumentURL),
        FOREIGN KEY(projectID) REFERENCES Project(projectID) 
    );
    -- Contributing
    CREATE TABLE Contributing (
        projectFundContributor INT NOT NULL,
        projectID INT NOT NULL,
        contributingDate DATETIME,
        amountOfMoney MONEY,
        PRIMARY KEY(projectFundContributor, projectID),
        FOREIGN KEY(projectFundContributor) REFERENCES ProjectFundContributor(projectFundContributor),
        FOREIGN KEY(projectID) REFERENCES Project(projectID)
    );
    -- Internal project
    CREATE TABLE InternalProject (
        projectID INT,
        FOREIGN KEY(projectID) REFERENCES Project(projectID)
    );
    -- Community activity
    CREATE TABLE CommunityActivity (
        communityID INT,
        place TEXT,
        PRIMARY KEY(communityID)
    );
    -- Seminar workshop
    CREATE TABLE SeminarWorkshop (
        projectID INT,
        topic TEXT,
        communityID INT,
        FOREIGN KEY(projectID) REFERENCES Project(projectID),
        FOREIGN KEY(communityID) REFERENCES CommunityActivity(communityID)
    );
    -- Interview
    CREATE TABLE Interview (
        projectID INT,
        requirement TEXT,
        communityID INT,
        FOREIGN KEY(projectID) REFERENCES Project(projectID),
        FOREIGN KEY(communityID) REFERENCES CommunityActivity(communityID)
    );
    -- Application form
    CREATE TABLE ApplicationForm (
        communityIDForm INT NOT NULL,
        formID INT NOT NULL,
        formFirstName TEXT,
        formMiddleName TEXT,
        formLastName TEXT,
        formGender BIT,
        formDateOfBirth DATE,
        formPhoneNumber VARCHAR(11),
        formContactAddress TEXT,
        formSocialAccount TEXT,
        formEmail TEXT,
        formCVURL TEXT,
        PRIMARY KEY(communityIDForm, formID),
        FOREIGN KEY(communityIDForm) REFERENCES CommunityActivity(communityID)
    );
    -- Company
    CREATE TABLE Company (
        taxIDNumber VARCHAR(9) NOT NULL,
        conpanyName TEXT,
        companyDescription TEXT,
        projectFundContributor INT,
        PRIMARY KEY(taxIDNumber),
        FOREIGN KEY(projectFundContributor) REFERENCES ProjectFundContributor(projectFundContributor)
    );
    -- Company related documents
    CREATE TABLE CompanyRelatedDoc (
        taxIDNumber VARCHAR(9) NOT NULL,
        companyDocumentURL VARCHAR(256) NOT NULL,
        PRIMARY KEY(taxIDNumber, companyDocumentURL),
        FOREIGN KEY(taxIDNumber) REFERENCES Company(taxIDNumber)
    );
    -- Position
    CREATE TABLE WorkPosition (
        posID INT NOT NULL,
        posName TEXT,
        posDescription TEXT,
        posInDepartment INT,
        PRIMARY KEY(posID),
        FOREIGN KEY(posInDepartment) REFERENCES Department(departmentID)
    );
    -- Person take position
    CREATE TABLE Taking (
        profileNumberTake INT NOT NULL,
        posIDTake INT NOT NULL,
        takeFromdate DATE,
        takeToDate DATE,
        PRIMARY KEY(profileNumberTake, posIDTake),
        FOREIGN KEY(profileNumberTake) REFERENCES Person(profileNumber),
        FOREIGN KEY(posIDTake) REFERENCES WorkPosition(posID)
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
        taskRemark VARCHAR(256) NOT NULL,
        PRIMARY KEY(taskID, taskRemark),
        FOREIGN KEY(taskID) REFERENCES Task(taskID)
    );
    -- Duty
    CREATE TABLE Duty (
        dutyID INT NOT NULL,
        dutyName TEXT,
        shift TEXT,
        dutyDescription TEXT,
        PRIMARY KEY(dutyID)
    );
    -- Has to do duty
    CREATE TABLE HaveToDoDuty (
        profileNumberDuty INT,
        dutyID INT,
        PRIMARY KEY(profileNumberDuty, dutyID),
        FOREIGN KEY(profileNumberDuty) REFERENCES Person(profileNumber),
        FOREIGN KEY(dutyID) REFERENCES Duty(dutyID)
    );
    -- Infrastructures
    CREATE TABLE Infrastructure (
        infraID INT NOT NULL,
        infraName TEXT,
        totalNumber INT,
        numberOfAvailable INT,
        infraDescription TEXT,
        PRIMARY KEY(infraID)
    );
    -- Borrow record
    CREATE TABLE BorrowRecord (
        borrowID INT,
        borrowDate DATE,
        borrowStatus BIT,
        borrower INT,
        PRIMARY KEY(borrowID),
        FOREIGN KEY(borrower) REFERENCES Person(profileNumber)
    );
    -- Include
    CREATE TABLE Including (
        borrowIDInclude INT,
        infraIDInclude INT,
        numberOfItem INT,
        dueDate DATE,
        returnDate DATE,
        PRIMARY KEY(borrowIDInclude, infraIDInclude),
        FOREIGN KEY(borrowIDInclude) REFERENCES BorrowRecord(borrowID),
        FOREIGN KEY(infraIDInclude) REFERENCES Infrastructure(infraID)
    );
    -- Fund
    CREATE TABLE Fund (
        fundID INT,
        currentBudget MONEY,
        originalCapital MONEY,
        treasurer INT,
        PRIMARY KEY(fundID),
        FOREIGN KEY(treasurer) REFERENCES Person(profileNumber)
    );
    -- Revenue category
    CREATE TABLE RevenueCategory (
        revenueID INT,
        revenueName TEXT,
        moneyHaveToPay MONEY,
        moneyPay MONEY,
        moneyRest MONEY,
        revenueDeadline DATE,
        revenueDescription TEXT,
        fundIDRevenue INT,
        PRIMARY KEY(revenueID),
        FOREIGN KEY(fundIDRevenue) REFERENCES Fund(fundID)
    );
    -- Expediture category
    CREATE TABLE ExpeditureCategory (
        expeditureID INT,
        expeditureName TEXT,
        expeditureDate DATE,
        expeditureMoney MONEY,
        expeditureDescription TEXT,
        fundIDExpediture INT,
        PRIMARY KEY(expeditureID),
        FOREIGN KEY(fundIDExpediture) REFERENCES Person(profileNumber)
    );
    -- Have to pay
    CREATE TABLE HaveToPay (
        profileNumberPay INT,
        revenueIDPay INT,
        weighting FLOAT,
        amount INT,
        PRIMARY KEY(profileNumberPay, revenueIDPay),
        FOREIGN KEY(profileNumberPay) REFERENCES Person(profileNumber),
        FOREIGN KEY(revenueIDPay) REFERENCES RevenueCategory(revenueID)
    );