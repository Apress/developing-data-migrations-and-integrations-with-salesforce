/****** Object:  UserDefinedFunction [dbo].[fn_GetFileFromPath]    Script Date: 02/25/2015 16:09:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[fn_GetFileFromPath](@PathFile NVARCHAR(1000))
RETURNS NVARCHAR(1000)
AS
BEGIN
	declare @FileName NVARCHAR(1000)
	SELECT @PathFile='\'+replace(@PathFile,'/','\') -- For Unix Type Paths
	SELECT @FileName=reverse(left(reverse(@PathFile),
						charindex('\',reverse(@PathFile),
								  1) - 1))
	RETURN @FileName
END





GO


