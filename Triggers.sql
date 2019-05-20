-- Kha
-- Before
CREATE TRIGGER bfEmailInsert
ON PersonEmailAddress
INSTEAD OF INSERT
AS
DECLARE
    @profileNumber INT,
    @emailAddress VARCHAR(256)
SELECT @profileNumber = inserted.profileNumber FROM inserted
SELECT @emailAddress = inserted.emailAddress FROM inserted
BEGIN TRAN
    IF @profileNumber IS NULL OR @emailAddress IS NULL
        BEGIN
            PRINT N'Primary key cannot be NULL'
            ROLLBACK
        END
    ELSE
        IF NOT EXISTS(SELECT profileNumber FROM Person WHERE profileNumber = @profileNumber)
            BEGIN
                PRINT N'No one has that profile number.'
                ROLLBACK
            END
        ELSE
		BEGIN
			INSERT INTO PersonEmailAddress VALUES(@profileNumber, @emailAddress)
			COMMIT
		END

GO

-- Before 2
ALTER TRIGGER aftDeleteWorkPos 
ON WorkPosition
INSTEAD OF DELETE
AS
DECLARE
    @posID INT,
    @posName VARCHAR(256),
    @posDescription VARCHAR(256),
    @posInDepartment INT
SELECT @posID = deleted.posID FROM deleted
BEGIN TRAN
    DELETE FROM Taking WHERE posIDTake = @posID
	DELETE FROM WorkPosition WHERE posID = @posID
    COMMIT
GO

-- After
CREATE TRIGGER aftInsertBorrowRecord ON BorrowRecord
FOR INSERT
AS
DECLARE
	@borrowRecordID INT,
	@infraID INT,
	@numberOfItem INT

	SELECT @borrowRecordID = inserted.borrowID FROM inserted
BEGIN
	SELECT @numberOfItem = numberOfItem, @infraID = infraIDInclude
	FROM Including
	WHERE borrowIDInclude = @borrowRecordID

	UPDATE Infrastructure
	SET numberOfAvailable -= @numberOfItem
	WHERE infraID = @infraID
END