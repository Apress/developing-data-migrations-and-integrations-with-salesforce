Create Procedure [dbo].[sp_GetDirTree](@BackupDirectory varchar(4000))   as
begin
  IF OBJECT_ID('tempdb..#DirTree') IS NOT NULL
    DROP TABLE #DirTree

  IF OBJECT_ID('tempdb..#ParentDirectoryIDs') IS NOT NULL
    DROP TABLE #ParentDirectoryIDs

  CREATE TABLE #DirTree (
    Id int identity(1,1),
    SubDirectory nvarchar(255),
    Depth smallint,
    FileFlag bit,
    ParentDirectoryID int
   )

   INSERT INTO #DirTree (SubDirectory, Depth, FileFlag)
   EXEC master..xp_dirtree @BackupDirectory, 10, 1

   UPDATE #DirTree
   SET ParentDirectoryID = (
    SELECT MAX(Id) FROM #DirTree d2
    WHERE Depth = d.Depth - 1 AND d2.Id < d.Id
   )
   FROM #DirTree d

  DECLARE 
    @ID INT,
    @BackupFile VARCHAR(MAX),
    @Depth TINYINT,
    @FileFlag BIT,
    @ParentDirectoryID INT,
    @wkSubParentDirectoryID INT,
    @wkSubDirectory VARCHAR(MAX)

  DECLARE @BackupFiles TABLE
  (
    FileNamePath VARCHAR(MAX),
    TransLogFlag BIT,
    BackupFile VARCHAR(MAX),    
    DatabaseName VARCHAR(MAX)
  )

  DECLARE FileCursor CURSOR LOCAL FORWARD_ONLY FOR
  SELECT * FROM #DirTree WHERE FileFlag = 1

  OPEN FileCursor
  FETCH NEXT FROM FileCursor INTO 
    @ID,
    @BackupFile,
    @Depth,
    @FileFlag,
    @ParentDirectoryID  

  SET @wkSubParentDirectoryID = @ParentDirectoryID

  WHILE @@FETCH_STATUS = 0
  BEGIN
    --loop to generate path in reverse, starting with backup file then prefixing subfolders in a loop
    WHILE @wkSubParentDirectoryID IS NOT NULL
    BEGIN
      SELECT @wkSubDirectory = SubDirectory, @wkSubParentDirectoryID = ParentDirectoryID 
      FROM #DirTree 
      WHERE ID = @wkSubParentDirectoryID

      SELECT @BackupFile = @wkSubDirectory + '\' + @BackupFile
    END

    --no more subfolders in loop so now prefix the root backup folder
    SELECT @BackupFile = @BackupDirectory + @BackupFile

    --put backupfile into a table and then later work out which ones are log and full backups  
    INSERT INTO @BackupFiles (FileNamePath) VALUES(@BackupFile)

    FETCH NEXT FROM FileCursor INTO 
      @ID,
      @BackupFile,
      @Depth,
      @FileFlag,
      @ParentDirectoryID 

    SET @wkSubParentDirectoryID = @ParentDirectoryID      
  END

  CLOSE FileCursor
  DEALLOCATE FileCursor
-- Populate Full Path
alter table #DirTree add Full_Path varchar(4000)

declare @minID int
declare @currPath varchar(4000)


update #DirTree set Full_Path=''

Select distinct ParentDirectoryID 
into #ParentDirectoryIDs 
	from #DirTree 
	where ParentDirectoryID is not null
	--and id<15


WHILE (select count(1) from #ParentDirectoryIDs) > 0
begin 
	select @minID=min(ParentDirectoryID) from #ParentDirectoryIDs
	select @currPath=Full_Path+SubDirectory from #DirTree where id= @minID

	Update #DirTree set Full_Path=Full_Path+'\'+@currPath where ParentDirectoryID=@minID and ParentDirectoryID is not null

	delete from #ParentDirectoryIDs where ParentDirectoryID=@minID
end
update #DirTree set Full_Path=Full_Path+'\'+SubDirectory 

select * from #DirTree

  IF OBJECT_ID('tempdb..#DirTree') IS NOT NULL
    DROP TABLE #DirTree

  IF OBJECT_ID('tempdb..#ParentDirectoryIDs') IS NOT NULL
    DROP TABLE #ParentDirectoryIDs

end
GO


