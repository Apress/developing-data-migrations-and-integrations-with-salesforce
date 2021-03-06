Create function [dbo].[fn_GoodEmailorBlank](@EmailAddress varchar(1000))
returns varchar(1000)   
begin
	declare @return varchar(1000)
	declare @email varchar(1000)
	set @email = rtrim(ltrim(@EmailAddress))

	-- cannot end with apostrophe, but they are ok inside of a name: e.g. O'Connor
	select  @email = 
		CASE WHEN 
				 @email LIKE '%_@_%_._%' 
				 AND @email NOT LIKE '%.'
				 and @email NOT LIKE '%@%@%'
				 and @email NOT LIKE '%@%[_]%' ----- This is a Salesforce defect, Domains can have Underscores
		THEN @email
		ELSE '' 
		END
	
	---- Validate  there is no spaces or invalid Chars in the Email Address
	select  @return = 
	CASE WHEN 
			 @email LIKE '% %' or @email LIKE '%,%'  or @email LIKE '%;%' 
	THEN	''
	ELSE @email 
	END
	
	return  @return
end
GO


