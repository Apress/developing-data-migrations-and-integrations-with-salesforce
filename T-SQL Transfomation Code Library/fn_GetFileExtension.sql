CREATE Function [dbo].[fn_GetFileExtension](@FileName nVARCHAR(1000))
RETURNS nVARCHAR(1000)
AS
BEGIN
	Return  
		case when substring(right(@FileName,4),1,1)='.' then right(@FileName,4) 
			 when substring(right(@FileName,5),1,1)='.' then right(@FileName,5) 
			 else '' 
		end
END