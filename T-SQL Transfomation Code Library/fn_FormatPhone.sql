Create Function [dbo].[fn_FormatPhone](@strTextFull nVARCHAR(1000))
RETURNS nVARCHAR(1000)
AS
BEGIN
	declare @strText nVARCHAR(1000)
	declare @strCleanText nVARCHAR(1000)
	declare @strTextExt nVARCHAR(1000)
	select @strTextExt=''

	---
	select @strCleanText=replace(@strTextFull,' ','')
	select @strCleanText=replace(@strCleanText,'-','')
	select @strCleanText=replace(@strCleanText,'.','')
	select @strCleanText=replace(@strCleanText,'(','')
	select @strCleanText=replace(@strCleanText,')','')
	if SUBSTRING(@strCleanText,1,1)='+'  ---------------- Remove Leading Plus
		select @strCleanText=SUBSTRING(@strCleanText,2,1000)
	if SUBSTRING(@strCleanText,1,1)='1' ---------------- Remove Leading 1
		select @strCleanText=SUBSTRING(@strCleanText,2,1000)

	-- for Extensions
	if SUBSTRING(@strCleanText,11,1)='x' or SUBSTRING(@strCleanText,11,1)='e'
	begin
		select @strTextExt=SUBSTRING(@strCleanText,11,1000)
		select @strCleanText=SUBSTRING(@strCleanText,1,10)
	end

	if isnumeric(@strCleanText)=0
	begin
		return @strTextFull-- No Transformation
	end

	if len(@strCleanText)<>10
	begin 
		return @strTextFull -- No Transformation
	end 

	select @strCleanText='('+substring(@strCleanText,1,3)+') '+substring(@strCleanText,4,3)+'-'+substring(@strCleanText,7,4)

    RETURN @strCleanText+' '+@strTextExt
END