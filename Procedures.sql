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
ALTER PROCEDURE getPhoneNumberByEmail
	@email VARCHAR(256)
AS
BEGIN
	DECLARE
		@profileNumber INT
	SELECT @profileNumber = profileNumber FROM PersonEmailAddress WHERE emailAddress = @email
	SELECT phoneNumber FROM PersonPhoneNumber WHERE profileNumber = @profileNumber
END
-----------------------------------

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


