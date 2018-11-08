

CREATE FUNCTION [dbo].[fn_CamelCase] (@InputString nvarchar(4000) ) 
RETURNS nVARCHAR(4000)
AS
BEGIN
DECLARE @Index          INT
DECLARE @Char           nCHAR(1)
DECLARE @PrevChar       nCHAR(1)
DECLARE @OutputString   nVARCHAR(255)

SET @OutputString = LOWER(@InputString)
SET @Index = 1

WHILE @Index <= LEN(@InputString)
	BEGIN
		SET @Char     = SUBSTRING(@InputString, @Index, 1)
		SET @PrevChar = CASE WHEN @Index = 1 THEN ' '
							 ELSE SUBSTRING(@InputString, @Index - 1, 1)
						END

		IF @PrevChar IN (' ', ';', ':', '!', '?', ',', '.', '_', '-', '/', '&', '''', '(')
		BEGIN
			IF @PrevChar != '''' OR UPPER(@Char) != 'S'
				SET @OutputString = STUFF(@OutputString, @Index, 1, UPPER(@Char))
		END

		SET @Index = @Index + 1
	END
RETURN @OutputString
END
