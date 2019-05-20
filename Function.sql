-- Phong
-- Get person's age by profileNumber
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

-- Get number of ticklab id card by profileNumber
CREATE FUNCTION tickLabCardCount
( @profileNumber int )
returns int 
AS
BEGIN
	DECLARE @count int
	if NOT EXISTS(SELECT * FROM Person WHERE profileNumber=@profileNumber) return -1;
	else
		SELECT @count = COUNT(rfidNumber) FROM TickLabIDCard WHERE TickLabIDCard.profileNumber = @profileNumber;
	return @count
END
