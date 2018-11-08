CREATE FUNCTION [dbo].[Fn_Base64Decode](@Input VARCHAR(MAX))
RETURNS VARCHAR(MAX)
BEGIN
	DECLARE @DecodedOutput VARCHAR(MAX)
	set @DecodedOutput = cast('' as xml).value('xs:base64Binary(sql:variable("@Input"))', 'varbinary(max)')
	RETURN @DecodedOutput
END
