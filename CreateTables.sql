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
        username VARCHAR(256),
        passwd VARCHAR(256),
        gender BIT,
        permanentAddress VARCHAR(256),
        dateOfBirth DATE,
        firstName VARCHAR(256),
        middleName VARCHAR(256),
        lastName VARCHAR(256),
        nationality VARCHAR(256),
        nationalIDNumber VARCHAR(9),
        nationalIDIssueDate DATE,
        passportNumber VARCHAR(256),
        passportPlaceOfIssue VARCHAR(256),
        passportDateOfIssue DATE,
        passportDateOfExpiry DATE,
        profilePhotoURL VARCHAR(256),
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
        departmentName VARCHAR(256),
        departmentDescription VARCHAR(256),
        PRIMARY KEY(departmentID)
    );
    -- Project
    CREATE TABLE Project (
        projectID INT NOT NULL,
        projectName VARCHAR(256),
        projectStartTime DATE,
        projectEndTime DATE,
        projectStatus VARCHAR(256),
        expectedFinishTime DATE,
        projectDescription VARCHAR(256),
        TickLabBudget MONEY,
        projectManager INT,
        ofDepartment INT,
        PRIMARY KEY(projectID),
        FOREIGN KEY(projectManager) REFERENCES Person(profileNumber),
        FOREIGN KEY(ofDepartment) REFERENCES Department(departmentID)
    );
        -- Project's paricipant
    CREATE TABLE ProjectParticipant (
        participantID INT NOT NULL,
        projectID INT,
        profileNumber INT,
        formDate DATE,
        toDate DATE,
        PRIMARY KEY(participantID),
        FOREIGN KEY(projectID) REFERENCES Project(projectID),
        FOREIGN KEY(profileNumber) REFERENCES Person(profileNumber)
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
        internalProjectID INT NOT NULL,
        PRIMARY KEY(internalProjectID),
        FOREIGN KEY(internalProjectID) REFERENCES Project(projectID)
    );
    -- Community activity
    CREATE TABLE CommunityActivity (
        communityID INT NOT NULL,
        place VARCHAR(256),
        PRIMARY KEY(communityID)
    );
    -- Seminar workshop
    CREATE TABLE SeminarWorkshop (
        projectID INT NOT NULL,
        topic VARCHAR(256),
        communityID INT,
        FOREIGN KEY(projectID) REFERENCES Project(projectID),
        FOREIGN KEY(communityID) REFERENCES CommunityActivity(communityID)
    );
    -- Interview
    CREATE TABLE Interview (
        projectID INT,
        requirement VARCHAR(256),
        communityID INT,
        FOREIGN KEY(projectID) REFERENCES Project(projectID),
        FOREIGN KEY(communityID) REFERENCES CommunityActivity(communityID)
    );
    -- Application form
    CREATE TABLE ApplicationForm (
        communityIDForm INT NOT NULL,
        formID INT NOT NULL,
        formFirstName VARCHAR(256),
        formMiddleName VARCHAR(256),
        formLastName VARCHAR(256),
        formGender BIT,
        formDateOfBirth DATE,
        formPhoneNumber VARCHAR(11),
        formContactAddress VARCHAR(256),
        formSocialAccount VARCHAR(256),
        formEmail VARCHAR(256),
        formCVURL VARCHAR(256),
        PRIMARY KEY(communityIDForm, formID),
        FOREIGN KEY(communityIDForm) REFERENCES CommunityActivity(communityID)
    );
    -- Company
    CREATE TABLE Company (
        taxIDNumber VARCHAR(9) NOT NULL,
        conpanyName VARCHAR(256),
        companyDescription VARCHAR(256),
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
        posName VARCHAR(256),
        posDescription VARCHAR(256),
        posInDepartment INT,
        PRIMARY KEY(posID),
        FOREIGN KEY(posInDepartment) REFERENCES Department(departmentID)
    );
    -- Person take position
    CREATE TABLE Taking (
        profileNumberTake INT NOT NULL,
        posIDTake INT NOT NULL,
        takeFromDate DATE,
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
        whatToDo VARCHAR(256),
        taskDescription VARCHAR(256),
        taskStatus VARCHAR(256),
        ofProject INT,
        PRIMARY KEY(taskID),
        FOREIGN KEY(ofProject) REFERENCES Project(projectID)
    );
    -- Task's participant
    CREATE TABLE TaskParticipant (
        participantID INT NOT NULL,
        taskID INT NOT NULL,
        fromDate DATE,
        toDate DATE,
        PRIMARY KEY(participantID, taskID),
        FOREIGN KEY(participantID) REFERENCES ProjectParticipant(participantID),
        FOREIGN KEY(taskID) REFERENCES Task(taskID)
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
        dutyName VARCHAR(256),
        shift VARCHAR(256),
        dutyDescription VARCHAR(256),
        PRIMARY KEY(dutyID)
    );
    -- Has to do duty
    CREATE TABLE HaveToDoDuty (
        profileNumberDuty INT NOT NULL,
        dutyID INT NOT NULL,
        PRIMARY KEY(profileNumberDuty, dutyID),
        FOREIGN KEY(profileNumberDuty) REFERENCES Person(profileNumber),
        FOREIGN KEY(dutyID) REFERENCES Duty(dutyID)
    );
    -- Infrastructures
    CREATE TABLE Infrastructure (
        infraID INT NOT NULL,
        infraName VARCHAR(256),
        totalNumber INT,
        numberOfAvailable INT,
        infraDescription VARCHAR(256),
        PRIMARY KEY(infraID)
    );
    -- Borrow record
    CREATE TABLE BorrowRecord (
        borrowID INT NOT NULL,
        borrowDate DATE,
        borrowStatus BIT,
        borrower INT,
        PRIMARY KEY(borrowID),
        FOREIGN KEY(borrower) REFERENCES Person(profileNumber)
    );
    -- Include
    CREATE TABLE Including (
        borrowIDInclude INT NOT NULL,
        infraIDInclude INT NOT NULL,
        numberOfItem INT,
        dueDate DATE,
        returnDate DATE,
        PRIMARY KEY(borrowIDInclude, infraIDInclude),
        FOREIGN KEY(borrowIDInclude) REFERENCES BorrowRecord(borrowID),
        FOREIGN KEY(infraIDInclude) REFERENCES Infrastructure(infraID)
    );
    -- Fund
    CREATE TABLE Fund (
        fundID INT NOT NULL,
        currentBudget MONEY,
        originalCapital MONEY,
        treasurer INT,
        PRIMARY KEY(fundID),
        FOREIGN KEY(treasurer) REFERENCES Person(profileNumber)
    );
    -- Revenue category
    CREATE TABLE RevenueCategory (
        revenueID INT NOT NULL,
        revenueName VARCHAR(256),
        moneyHaveToPay MONEY,
        moneyPay MONEY,
        moneyRest MONEY,
        revenueDeadline DATE,
        revenueDescription VARCHAR(256),
        fundIDRevenue INT,
        PRIMARY KEY(revenueID),
        FOREIGN KEY(fundIDRevenue) REFERENCES Fund(fundID)
    );
    -- Expediture category
    CREATE TABLE ExpeditureCategory (
        expeditureID INT NOT NULL,
        expeditureName VARCHAR(256),
        expeditureDate DATE,
        expeditureMoney MONEY,
        expeditureDescription VARCHAR(256),
        fundIDExpediture INT,
        PRIMARY KEY(expeditureID),
        FOREIGN KEY(fundIDExpediture) REFERENCES Person(profileNumber)
    );
    -- Have to pay
    CREATE TABLE HaveToPay (
        profileNumberPay INT NOT NULL,
        revenueIDPay INT NOT NULL,
        weighting FLOAT,
        amount INT,
        PRIMARY KEY(profileNumberPay, revenueIDPay),
        FOREIGN KEY(profileNumberPay) REFERENCES Person(profileNumber),
        FOREIGN KEY(revenueIDPay) REFERENCES RevenueCategory(revenueID)
    );