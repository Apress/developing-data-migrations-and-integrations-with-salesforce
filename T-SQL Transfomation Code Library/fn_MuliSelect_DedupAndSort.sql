Create FUNCTION dbo.fn_MuliSelect_DedupAndSort(@List nVARCHAR(MAX))
RETURNS nVARCHAR(MAX)
AS
	BEGIN
	DECLARE @Delim CHAR=';'

	DECLARE @ParsedList TABLE
	(
	Item nVARCHAR(MAX)
	)
	DECLARE @list1 nVARCHAR(MAX), @Pos INT, @rList nVARCHAR(MAX)
	SET @list = LTRIM(RTRIM(@list)) + @Delim
	SET @pos = CHARINDEX(@delim, @list, 1)
	WHILE @pos > 0
	BEGIN
		SET @list1 = LTRIM(RTRIM(LEFT(@list, @pos - 1)))
		IF @list1 <> ''
			INSERT INTO @ParsedList VALUES (CAST(@list1 AS nVARCHAR(MAX)))
			SET @list = SUBSTRING(@list, @pos+1, LEN(@list))
			SET @pos = CHARINDEX(@delim, @list, 1)
			END
	SELECT 
		@rlist = COALESCE(@rlist+@Delim,'') + item
	FROM (SELECT DISTINCT Item FROM @ParsedList) t
	RETURN @rlist
END
GO