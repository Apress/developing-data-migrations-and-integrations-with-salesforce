Create Function [dbo].[fn_Format_for_ContentNoteText](@strText nVARCHAR(max))
RETURNS VARCHAR(max)
AS
BEGIN
	set @strText=replace(@strText,'&','&amp;')
	set @strText=replace(@strText,'<','&lt;')
	set @strText=replace(@strText,'>','&gt;')
	set @strText=replace(@strText,'"','&quot;')
	set @strText=replace(@strText,'''','&#39;')
	set @strText=replace(@strText,char(9),'     ')
	set @strText=replace(@strText,char(10),'<br>')
	set @strText=replace(@strText,char(23),'<br>')
	set @strText=replace(@strText,char(13),'<br>')

    RETURN coalesce(@strText,'')
END
