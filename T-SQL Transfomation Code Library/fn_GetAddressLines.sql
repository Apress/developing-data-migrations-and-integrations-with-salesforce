

Create function [dbo].[fn_GetAddressLines](@Address nVarchar(3000),@Linepart Char(2))
returns nvarchar(1000)   
-- @Linepart : L1=First,L2=L3=Last
begin

	Declare @Line1 nVarchar(3000)
	Declare @Line2 nVarchar(3000)
	Declare @Line3 nVarchar(3000)
	Declare @Return nVarchar(3000)

	select @Address=rtrim(ltrim(coalesce(@Address,'')))
	SELECT @Line1= rtrim(ltrim(coalesce(@Address,'')))
	SELECT @Line2=''
	SELECT @Line3=''


	if @Address like '%'+char(10)+'%' 
	Begin
		SELECT @Line1= SUBSTRING(@Address, 1, CHARINDEX(Char(10), @Address) - 1) 
	    SELECT @Line2=substring(replace(@Address,@Line1,''),2,3000)
	end

	select @Address=@Line2

	if @Address like '%'+char(10)+'%' 
	Begin
		SELECT @Line2= SUBSTRING(@Address, 1, CHARINDEX(Char(10), @Address) - 1) 
	    SELECT @Line3=substring(replace(@Address,@Line2,''),2,3000)
		SELECT @Line3=replace(@Line3,char(10),'-')
	end

	SELECT @Return = case when @Linepart = 'L1' then @Line1
				when @Linepart = 'L2' then @Line2
				when @Linepart = 'L3' then @Line3
			else Null end

	Return rtrim(ltrim(@Return))
end