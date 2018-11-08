CREATE FUNCTION [dbo].[Fn_Base64Encode](@Input VARCHAR(MAX))
RETURNS VARCHAR(MAX)
BEGIN
	declare @source varbinary(max)
	declare @encoded varchar(max)
	set @source = convert(varbinary(max), @Input)
	set @encoded = cast('' as xml).value('xs:base64Binary(sql:variable("@source"))', 'varchar(max)')
	RETURN @encoded
END
GO