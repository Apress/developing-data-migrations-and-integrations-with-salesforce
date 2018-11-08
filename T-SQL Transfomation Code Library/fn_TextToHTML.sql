CREATE Function [dbo].[fn_TextToHTML](@strText nVARCHAR(max))
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

    RETURN '<pre>'+coalesce(@strText,'')+'</pre>'
END
