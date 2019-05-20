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