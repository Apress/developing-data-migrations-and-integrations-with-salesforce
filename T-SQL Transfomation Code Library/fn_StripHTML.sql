CREATE FUNCTION [dbo].[fn_StripHTML] (@HTMLText nVARCHAR(MAX))
RETURNS nVARCHAR(MAX) AS
BEGIN
    DECLARE @Start INT
    DECLARE @End INT
    DECLARE @Length INT
	SET @HTMLText=replace(@HTMLText,'<BR>',Char(10))
	SET @HTMLText=replace(@HTMLText,'</BR>',Char(10))
	SET @HTMLText=replace(@HTMLText,'&nbsp;',' ')
	SET @HTMLText=replace(@HTMLText,'&#8217;','''')
	SET @HTMLText=replace(@HTMLText,'&amp;','&')
	SET @HTMLText=replace(@HTMLText,'&quot;','"')


    SET @Start = CHARINDEX('<',@HTMLText)
    SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
    SET @Length = (@End - @Start) + 1
    WHILE @Start > 0 AND @End > 0 AND @Length > 0
    BEGIN
        SET @HTMLText = STUFF(@HTMLText,@Start,@Length,'')
        SET @Start = CHARINDEX('<',@HTMLText)
        SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
        SET @Length = (@End - @Start) + 1
    END
	--- For MS Dynamics or Emails
	SET @HTMLText=replace(@HTMLText,'{behavior:url(#default#VML);}','')
	SET @HTMLText=replace(@HTMLText,'v\:*','')
	SET @HTMLText=replace(@HTMLText,'o\:*','')
	SET @HTMLText=replace(@HTMLText,'w\:*','')
	SET @HTMLText=replace(@HTMLText,'.shape','')
	SET @HTMLText=replace(@HTMLText,'.shape','')
    RETURN LTRIM(RTRIM(@HTMLText))
END
GO