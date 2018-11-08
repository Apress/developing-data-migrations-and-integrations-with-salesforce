
create Function [dbo].[fn_Fix_Invalid_XML_Chars](@strText NVARCHAR(max))
RETURNS NVARCHAR(max)
AS
BEGIN
	set @strText = replace(@strText,CHAR(0x0),'')
	set @strText = replace(@strText,CHAR(0x1),'')
	set @strText = replace(@strText,CHAR(0x2),'')
	set @strText = replace(@strText,CHAR(0x3),'')
	set @strText = replace(@strText,CHAR(0x4),'')
	set @strText = replace(@strText,CHAR(0x5),'')
	set @strText = replace(@strText,CHAR(0x6),'')
	set @strText = replace(@strText,CHAR(0x7),'')
	set @strText = replace(@strText,CHAR(0x8),'')
	set @strText = replace(@strText,CHAR(0x9),'')


	set @strText = replace(@strText,CHAR(0x10),'')
	set @strText = replace(@strText,CHAR(0x11),'')
	set @strText = replace(@strText,CHAR(0x12),'')
	set @strText = replace(@strText,CHAR(0x13),'')
	set @strText = replace(@strText,CHAR(0x14),'')
	set @strText = replace(@strText,CHAR(0x15),'')
	set @strText = replace(@strText,CHAR(0x16),'')
	set @strText = replace(@strText,CHAR(0x17),'')
	set @strText = replace(@strText,CHAR(0x18),'')
	set @strText = replace(@strText,CHAR(0x19),'')

	set @strText = replace(@strText,CHAR(0xa),'')
	set @strText = replace(@strText,CHAR(0xb),'')
	set @strText = replace(@strText,CHAR(0xc),'')
	set @strText = replace(@strText,CHAR(0xd),Char(10))
	set @strText = replace(@strText,CHAR(0xe),'')
	set @strText = replace(@strText,CHAR(0xf),'')

	set @strText = replace(@strText,CHAR(0x1a),'''')
	set @strText = replace(@strText,CHAR(0x1b),'')
	set @strText = replace(@strText,CHAR(0x1c),'')
	set @strText = replace(@strText,CHAR(0x1d),'')
	set @strText = replace(@strText,CHAR(0x1e),'')
	set @strText = replace(@strText,CHAR(0x1f),'')

	set @strText = replace(@strText,CHAR(0x7f),'')
	
    RETURN @strText
END




GO


