-- Phong
-- Get age person by profileNumber
CREATE FUNCTION AGE
( @profileNumber int )
returns int
AS
BEGIN
	DECLARE @age int
	if NOT EXISTS(SELECT * FROM Person WHERE profileNumber=@profileNumber) return -1;
	else
		SELECT @age = year(getdate())-year((SELECT dateOfBirth FROM Person WHERE profileNumber=@profileNumber));
	return @age
END
