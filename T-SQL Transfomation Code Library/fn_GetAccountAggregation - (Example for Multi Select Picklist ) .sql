/****** Object:  UserDefinedFunction [dbo].[fn_GetAccountAggregation]    Script Date: 02/25/2015 16:10:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create function [dbo].[fn_GetAccountAggregation](@companyID varchar(255))
returns nvarchar(1000)   
begin
	declare @CommaString nvarchar(max)
	set @CommaString=''
	select @CommaString +=rtrim(ltrim(Type)) +';' from dbo.companytype where companyID=@companyID  -- Modify this SQL
	if len(@CommaString)>0
		begin
			-- Drop Extra Semi-Colon
			SET @CommaString = LEFT(@CommaString, LEN(@CommaString) - 1)
		end
	Return @CommaString
end

GO


