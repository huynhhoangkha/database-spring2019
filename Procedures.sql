-- Kha
-- Insert to WorkPosition--
CREATE PROC workPosIns
    @posID INT,
    @posName TEXT,
    @posDescription TEXT,
    @posInDepartment INT
AS
    BEGIN
        IF @posID IS NULL PRINT N'posID can not be NULL'
        ELSE BEGIN
            IF EXISTS(SELECT posID FROM WorkPosition WHERE posID = @posID) PRINT N'Dupplicate posID'
            ELSE BEGIN
                IF NOT EXISTS(SELECT departmentID FROM Department WHERE departmentID = @posInDepartment)
                PRINT N'Foreign key not found'
                ELSE INSERT INTO WorkPosition VALUES(@posID, @posName, @posDescription, @posInDepartment)
            END
        END
    END
GO
---------------------------

-- Get phone number from email----
CREATE PROC getPhoneNumberByEmail
	@email VARCHAR(256)
AS
BEGIN
	DECLARE
		@profileNumber INT
	SELECT @profileNumber = profileNumber FROM PersonEmailAddress WHERE emailAddress = @email
	SELECT phoneNumber FROM PersonPhoneNumber WHERE profileNumber = @profileNumber
END
GO
-----------------------------------

-- Count how many person just use only one phone number
CREATE PROC numberOfPersonUseJustOneNumber
AS
BEGIN
	SELECT COUNT(numberOfPhoneNumber) AS numberOfPersonUseJustOneNumber FROM
	(
	SELECT COUNT(phoneNumber) AS numberOfPhoneNumber FROM	
		(SELECT firstName, lastName, phoneNumber, Person.profileNumber
		FROM
		Person INNER JOIN PersonPhoneNumber
		ON Person.profileNumber = PersonPhoneNumber.profileNumber) AS subsub
	GROUP BY profileNumber
	HAVING COUNT(phoneNumber) = 1) AS SUB
END
GO


-- Phong
-- Insert/add person phone number 
CREATE PROC addPersonPhoneNumber
	@profileNumber int,
	@phoneNumber varchar(11)
AS
BEGIN
	IF EXISTS(SELECT * FROM Person WHERE profileNumber = @profileNumber)
	BEGIN
		IF NOT EXISTS(SELECT * FROM PersonPhoneNumber WHERE phoneNumber = @phoneNumber)
			INSERT INTO PersonPhoneNumber(profileNumber, phoneNumber)
			VALUES (@profileNumber, @phoneNumber);
		ELSE PRINT N'Duplicate Phone Number'
	END
END
GO


