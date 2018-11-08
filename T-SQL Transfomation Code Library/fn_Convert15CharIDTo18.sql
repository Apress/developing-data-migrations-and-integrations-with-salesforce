-- =============================================
-- Author:        Joel Mansford
-- Create date:     Jan 2010
-- Description:    Converts 15char SF Ids to 18char ones
-- History:	
--	  June 2010 - issue with over-running and incorrectly producing ']' as a character with input such as '0033000000dGpDN'
-- =============================================

CREATE FUNCTION dbo.fn_Convert15CharIDTo18
(    @InputId char(15)
)
RETURNS char(18)
AS
BEGIN
    -- Hacky way to raise an error but it works and there’s no alternative!
    DECLARE @ErrorStringReally int
    IF LEN(@InputId)<>15
        SET @ErrorStringReally ='Input Salesforce Id must be exactly 15 characters input was “'+ @InputId+'”'
    DECLARE @OutputId char(18)
    DECLARE @Hash varchar(3)
    SET @Hash = ''
    DECLARE @Chunk tinyint
	DECLARE @ThisChunk char(5)
	DECLARE @CharPos tinyint
    DECLARE @ThisHashDigit tinyint

    -- Split string in to 3 chunks of 5chars
    SET @Chunk = 1
    WHILE @Chunk<=3
    BEGIN
        SELECT @ThisChunk = RIGHT(LEFT(@InputId,@Chunk*5),5)
        SET @ThisHashDigit = 0
        SET @CharPos = 1
        -- Iterate over the chunk
        WHILE @CharPos<=5
        BEGIN
            IF ASCII(SUBSTRING(@ThisChunk,@CharPos,1)) BETWEEN 65 AND 90 -- If Uppercase
				-- then add a binary ’1′ digit in the appropriate position, otherwise it’s still 0
                SET @ThisHashDigit +=POWER(2,@CharPos-1)
            SET @CharPos+=1
        END
        IF @ThisHashDigit>=26
			-- Digits 0-9, minus 26 as SFDC have numbers come ‘after’ letters
            SET @Hash +=CHAR(@ThisHashDigit+48-26) 
        ELSE
            -- Letter ‘A’
            SET @Hash +=CHAR(@ThisHashDigit+65)
        SET @Chunk+=1
    END
    SET @OutputId = @InputId + @Hash
    RETURN @OutputId
END