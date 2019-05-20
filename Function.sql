-- Phong
-- Get age person by profileNumber
CREATE FUNCTION AGE
( @profileNumber int )
RETURN int
AS
BEGIN
	DECLARE @age int
	if NOT EXISTS(SELECT * FROM Person WHERE profileNumber=@profileNumber) RETURN -1;
	ELSE
		SELECT @age = year(getdate())-year((SELECT dateOfBirth FROM Person WHERE profileNumber=@profileNumber));
	RETURN @age
END
