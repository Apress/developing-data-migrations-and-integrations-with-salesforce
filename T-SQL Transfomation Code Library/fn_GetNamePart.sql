

CREATE function [dbo].[fn_GetNamePart](@FullName NVarchar(3000),@Namepart Char(1))
returns Nvarchar(1000)   
-- @Namepart : F=First,M=Middle,L=Last
begin
	Declare @FirstName Varchar(1000)
	Declare @MiddleName Varchar(1000)
	Declare @LastName Varchar(1000)
	Declare @Return Varchar(1000)

	select @FullName=rtrim(ltrim(coalesce(@FullName,'')))+' '
	SELECT @FirstName= SUBSTRING(@FullName, 1, CHARINDEX(' ', @FullName) - 1) 
	
	select @FullName=' '+rtrim(ltrim(@FullName))
	SELECT @LastName=  REVERSE(SUBSTRING(REVERSE(@FullName), 1, CHARINDEX(' ', REVERSE(@FullName)) - 1)) 
	SELECT @MiddleName=replace(replace(@FullName,@FirstName,''),@LastName,'')

	SELECT @Return = case when @Namepart = 'F' then @FirstName
				when @Namepart = 'M' then @MiddleName
				when @Namepart = 'L' then @LastName
			else Null end

	Return rtrim(ltrim(@Return))
end








