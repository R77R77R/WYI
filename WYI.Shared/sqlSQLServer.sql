USE [Studio]
-- [Ca_Book] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Book' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Book ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Email] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Message] NVARCHAR(MAX)
, CONSTRAINT [PK_Ca_Book] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Book NVARCHAR(64)
DECLARE cursor_Ca_Book CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Book') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Email','Message'))

OPEN cursor_Ca_Book
FETCH NEXT FROM cursor_Ca_Book INTO @name_Ca_Book

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Book.' + @name_Ca_Book;
    
    DECLARE @sql_Ca_Book NVARCHAR(MAX);
    SET @sql_Ca_Book = 'ALTER TABLE Ca_Book DROP COLUMN ' + QUOTENAME(@name_Ca_Book)
    EXEC sp_executesql @sql_Ca_Book
    
    
    FETCH NEXT FROM cursor_Ca_Book INTO @name_Ca_Book
END

CLOSE cursor_Ca_Book;
DEALLOCATE cursor_Ca_Book;


-- [Ca_Book.Caption] -------------


-- [Ca_Book.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Book') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Book ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Book_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Book_Caption = 'ALTER TABLE Ca_Book ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Book_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BookCaption')
    BEGIN
    ALTER TABLE Ca_Book DROP  CONSTRAINT [Constraint_Ca_BookCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BookCaption')
    BEGIN
    ALTER TABLE Ca_Book DROP  CONSTRAINT [UniqueNonclustered_Ca_BookCaption]
    END

-- [Ca_Book.Email] -------------


-- [Ca_Book.Email] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Book') AND name='Email')
    BEGIN
     ALTER TABLE Ca_Book ALTER COLUMN [Email] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Book_Email NVARCHAR(MAX);
    SET @sql_add_Ca_Book_Email = 'ALTER TABLE Ca_Book ADD [Email] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Book_Email
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BookEmail')
    BEGIN
    ALTER TABLE Ca_Book DROP  CONSTRAINT [Constraint_Ca_BookEmail]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BookEmail')
    BEGIN
    ALTER TABLE Ca_Book DROP  CONSTRAINT [UniqueNonclustered_Ca_BookEmail]
    END

-- [Ca_Book.Message] -------------


-- [Ca_Book.Message] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Book') AND name='Message')
    BEGIN
     ALTER TABLE Ca_Book ALTER COLUMN [Message] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Book_Message NVARCHAR(MAX);
    SET @sql_add_Ca_Book_Message = 'ALTER TABLE Ca_Book ADD [Message] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Book_Message
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BookMessage')
    BEGIN
    ALTER TABLE Ca_Book DROP  CONSTRAINT [Constraint_Ca_BookMessage]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BookMessage')
    BEGIN
    ALTER TABLE Ca_Book DROP  CONSTRAINT [UniqueNonclustered_Ca_BookMessage]
    END
-- [Ca_EndUser] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_EndUser' AND xtype='U')

BEGIN

    CREATE TABLE Ca_EndUser ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[AuthType] INT
, CONSTRAINT [PK_Ca_EndUser] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_EndUser NVARCHAR(64)
DECLARE cursor_Ca_EndUser CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','AuthType'))

OPEN cursor_Ca_EndUser
FETCH NEXT FROM cursor_Ca_EndUser INTO @name_Ca_EndUser

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_EndUser.' + @name_Ca_EndUser;
    
    DECLARE @sql_Ca_EndUser NVARCHAR(MAX);
    SET @sql_Ca_EndUser = 'ALTER TABLE Ca_EndUser DROP COLUMN ' + QUOTENAME(@name_Ca_EndUser)
    EXEC sp_executesql @sql_Ca_EndUser
    
    
    FETCH NEXT FROM cursor_Ca_EndUser INTO @name_Ca_EndUser
END

CLOSE cursor_Ca_EndUser;
DEALLOCATE cursor_Ca_EndUser;


-- [Ca_EndUser.Caption] -------------


-- [Ca_EndUser.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Caption = 'ALTER TABLE Ca_EndUser ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserCaption')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserCaption')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserCaption]
    END

-- [Ca_EndUser.AuthType] -------------


-- [Ca_EndUser.AuthType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='AuthType')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [AuthType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_AuthType NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_AuthType = 'ALTER TABLE Ca_EndUser ADD [AuthType] INT'
    EXEC sp_executesql @sql_add_Ca_EndUser_AuthType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserAuthType')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserAuthType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserAuthType')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserAuthType]
    END
-- [Ca_File] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_File' AND xtype='U')

BEGIN

    CREATE TABLE Ca_File ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
        ,[Desc] NVARCHAR(MAX)
        ,[Suffix] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
        ,[Size] BIGINT
        ,[Thumbnail] VARBINARY(MAX)
        ,[Owner] BIGINT
, CONSTRAINT [PK_Ca_File] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_File NVARCHAR(64)
DECLARE cursor_Ca_File CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Desc','Suffix','Size','Thumbnail','Owner'))

OPEN cursor_Ca_File
FETCH NEXT FROM cursor_Ca_File INTO @name_Ca_File

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_File.' + @name_Ca_File;
    
    DECLARE @sql_Ca_File NVARCHAR(MAX);
    SET @sql_Ca_File = 'ALTER TABLE Ca_File DROP COLUMN ' + QUOTENAME(@name_Ca_File)
    EXEC sp_executesql @sql_Ca_File
    
    
    FETCH NEXT FROM cursor_Ca_File INTO @name_Ca_File
END

CLOSE cursor_Ca_File;
DEALLOCATE cursor_Ca_File;


-- [Ca_File.Caption] -------------


-- [Ca_File.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Caption] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_File_Caption = 'ALTER TABLE Ca_File ADD [Caption] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_File_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileCaption')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileCaption')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileCaption]
    END

-- [Ca_File.Desc] -------------


-- [Ca_File.Desc] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Desc')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Desc] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Desc NVARCHAR(MAX);
    SET @sql_add_Ca_File_Desc = 'ALTER TABLE Ca_File ADD [Desc] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_File_Desc
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileDesc')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileDesc]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileDesc')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileDesc]
    END

-- [Ca_File.Suffix] -------------


-- [Ca_File.Suffix] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Suffix')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Suffix] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Suffix NVARCHAR(MAX);
    SET @sql_add_Ca_File_Suffix = 'ALTER TABLE Ca_File ADD [Suffix] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_File_Suffix
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileSuffix')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileSuffix]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileSuffix')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileSuffix]
    END

-- [Ca_File.Size] -------------


-- [Ca_File.Size] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Size')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Size] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Size NVARCHAR(MAX);
    SET @sql_add_Ca_File_Size = 'ALTER TABLE Ca_File ADD [Size] BIGINT'
    EXEC sp_executesql @sql_add_Ca_File_Size
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileSize')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileSize]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileSize')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileSize]
    END

-- [Ca_File.Thumbnail] -------------


-- [Ca_File.Thumbnail] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Thumbnail')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Thumbnail] VARBINARY(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Thumbnail NVARCHAR(MAX);
    SET @sql_add_Ca_File_Thumbnail = 'ALTER TABLE Ca_File ADD [Thumbnail] VARBINARY(MAX)'
    EXEC sp_executesql @sql_add_Ca_File_Thumbnail
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileThumbnail')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileThumbnail]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileThumbnail')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileThumbnail]
    END

-- [Ca_File.Owner] -------------


-- [Ca_File.Owner] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Owner')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Owner] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Owner NVARCHAR(MAX);
    SET @sql_add_Ca_File_Owner = 'ALTER TABLE Ca_File ADD [Owner] BIGINT'
    EXEC sp_executesql @sql_add_Ca_File_Owner
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileOwner')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileOwner]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileOwner')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileOwner]
    END
-- [Social_FileBind] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Social_FileBind' AND xtype='U')

BEGIN

    CREATE TABLE Social_FileBind ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [File] BIGINT
        ,[Moment] BIGINT
        ,[Desc] NVARCHAR(MAX)
, CONSTRAINT [PK_Social_FileBind] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Social_FileBind NVARCHAR(64)
DECLARE cursor_Social_FileBind CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Social_FileBind') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','File','Moment','Desc'))

OPEN cursor_Social_FileBind
FETCH NEXT FROM cursor_Social_FileBind INTO @name_Social_FileBind

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Social_FileBind.' + @name_Social_FileBind;
    
    DECLARE @sql_Social_FileBind NVARCHAR(MAX);
    SET @sql_Social_FileBind = 'ALTER TABLE Social_FileBind DROP COLUMN ' + QUOTENAME(@name_Social_FileBind)
    EXEC sp_executesql @sql_Social_FileBind
    
    
    FETCH NEXT FROM cursor_Social_FileBind INTO @name_Social_FileBind
END

CLOSE cursor_Social_FileBind;
DEALLOCATE cursor_Social_FileBind;


-- [Social_FileBind.File] -------------


-- [Social_FileBind.File] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_FileBind') AND name='File')
    BEGIN
     ALTER TABLE Social_FileBind ALTER COLUMN [File] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_FileBind_File NVARCHAR(MAX);
    SET @sql_add_Social_FileBind_File = 'ALTER TABLE Social_FileBind ADD [File] BIGINT'
    EXEC sp_executesql @sql_add_Social_FileBind_File
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_FileBindFile')
    BEGIN
    ALTER TABLE Social_FileBind DROP  CONSTRAINT [Constraint_Social_FileBindFile]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_FileBindFile')
    BEGIN
    ALTER TABLE Social_FileBind DROP  CONSTRAINT [UniqueNonclustered_Social_FileBindFile]
    END

-- [Social_FileBind.Moment] -------------


-- [Social_FileBind.Moment] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_FileBind') AND name='Moment')
    BEGIN
     ALTER TABLE Social_FileBind ALTER COLUMN [Moment] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_FileBind_Moment NVARCHAR(MAX);
    SET @sql_add_Social_FileBind_Moment = 'ALTER TABLE Social_FileBind ADD [Moment] BIGINT'
    EXEC sp_executesql @sql_add_Social_FileBind_Moment
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_FileBindMoment')
    BEGIN
    ALTER TABLE Social_FileBind DROP  CONSTRAINT [Constraint_Social_FileBindMoment]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_FileBindMoment')
    BEGIN
    ALTER TABLE Social_FileBind DROP  CONSTRAINT [UniqueNonclustered_Social_FileBindMoment]
    END

-- [Social_FileBind.Desc] -------------


-- [Social_FileBind.Desc] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_FileBind') AND name='Desc')
    BEGIN
     ALTER TABLE Social_FileBind ALTER COLUMN [Desc] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_FileBind_Desc NVARCHAR(MAX);
    SET @sql_add_Social_FileBind_Desc = 'ALTER TABLE Social_FileBind ADD [Desc] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Social_FileBind_Desc
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_FileBindDesc')
    BEGIN
    ALTER TABLE Social_FileBind DROP  CONSTRAINT [Constraint_Social_FileBindDesc]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_FileBindDesc')
    BEGIN
    ALTER TABLE Social_FileBind DROP  CONSTRAINT [UniqueNonclustered_Social_FileBindDesc]
    END
-- [Social_Moment] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Social_Moment' AND xtype='U')

BEGIN

    CREATE TABLE Social_Moment ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Title] NVARCHAR(MAX)
        ,[Summary] NVARCHAR(MAX)
        ,[FullText] NVARCHAR(MAX)
        ,[PreviewImgUrl] NVARCHAR(MAX)
        ,[Link] NVARCHAR(MAX)
        ,[Type] INT
        ,[State] INT
        ,[MediaType] INT
, CONSTRAINT [PK_Social_Moment] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Social_Moment NVARCHAR(64)
DECLARE cursor_Social_Moment CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Title','Summary','FullText','PreviewImgUrl','Link','Type','State','MediaType'))

OPEN cursor_Social_Moment
FETCH NEXT FROM cursor_Social_Moment INTO @name_Social_Moment

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Social_Moment.' + @name_Social_Moment;
    
    DECLARE @sql_Social_Moment NVARCHAR(MAX);
    SET @sql_Social_Moment = 'ALTER TABLE Social_Moment DROP COLUMN ' + QUOTENAME(@name_Social_Moment)
    EXEC sp_executesql @sql_Social_Moment
    
    
    FETCH NEXT FROM cursor_Social_Moment INTO @name_Social_Moment
END

CLOSE cursor_Social_Moment;
DEALLOCATE cursor_Social_Moment;


-- [Social_Moment.Title] -------------


-- [Social_Moment.Title] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='Title')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [Title] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_Title NVARCHAR(MAX);
    SET @sql_add_Social_Moment_Title = 'ALTER TABLE Social_Moment ADD [Title] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Social_Moment_Title
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentTitle')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentTitle]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentTitle')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentTitle]
    END

-- [Social_Moment.Summary] -------------


-- [Social_Moment.Summary] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='Summary')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [Summary] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_Summary NVARCHAR(MAX);
    SET @sql_add_Social_Moment_Summary = 'ALTER TABLE Social_Moment ADD [Summary] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Social_Moment_Summary
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentSummary')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentSummary]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentSummary')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentSummary]
    END

-- [Social_Moment.FullText] -------------


-- [Social_Moment.FullText] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='FullText')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [FullText] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_FullText NVARCHAR(MAX);
    SET @sql_add_Social_Moment_FullText = 'ALTER TABLE Social_Moment ADD [FullText] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Social_Moment_FullText
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentFullText')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentFullText]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentFullText')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentFullText]
    END

-- [Social_Moment.PreviewImgUrl] -------------


-- [Social_Moment.PreviewImgUrl] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='PreviewImgUrl')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [PreviewImgUrl] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_PreviewImgUrl NVARCHAR(MAX);
    SET @sql_add_Social_Moment_PreviewImgUrl = 'ALTER TABLE Social_Moment ADD [PreviewImgUrl] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Social_Moment_PreviewImgUrl
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentPreviewImgUrl')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentPreviewImgUrl]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentPreviewImgUrl')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentPreviewImgUrl]
    END

-- [Social_Moment.Link] -------------


-- [Social_Moment.Link] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='Link')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [Link] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_Link NVARCHAR(MAX);
    SET @sql_add_Social_Moment_Link = 'ALTER TABLE Social_Moment ADD [Link] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Social_Moment_Link
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentLink')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentLink]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentLink')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentLink]
    END

-- [Social_Moment.Type] -------------


-- [Social_Moment.Type] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='Type')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [Type] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_Type NVARCHAR(MAX);
    SET @sql_add_Social_Moment_Type = 'ALTER TABLE Social_Moment ADD [Type] INT'
    EXEC sp_executesql @sql_add_Social_Moment_Type
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentType')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentType')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentType]
    END

-- [Social_Moment.State] -------------


-- [Social_Moment.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='State')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [State] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_State NVARCHAR(MAX);
    SET @sql_add_Social_Moment_State = 'ALTER TABLE Social_Moment ADD [State] INT'
    EXEC sp_executesql @sql_add_Social_Moment_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentState')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentState')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentState]
    END

-- [Social_Moment.MediaType] -------------


-- [Social_Moment.MediaType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Social_Moment') AND name='MediaType')
    BEGIN
     ALTER TABLE Social_Moment ALTER COLUMN [MediaType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Social_Moment_MediaType NVARCHAR(MAX);
    SET @sql_add_Social_Moment_MediaType = 'ALTER TABLE Social_Moment ADD [MediaType] INT'
    EXEC sp_executesql @sql_add_Social_Moment_MediaType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Social_MomentMediaType')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [Constraint_Social_MomentMediaType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Social_MomentMediaType')
    BEGIN
    ALTER TABLE Social_Moment DROP  CONSTRAINT [UniqueNonclustered_Social_MomentMediaType]
    END
-- [Sys_Log] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Sys_Log' AND xtype='U')

BEGIN

    CREATE TABLE Sys_Log ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Location] NVARCHAR(MAX)
        ,[Content] NVARCHAR(MAX)
        ,[Sql] NVARCHAR(MAX)
, CONSTRAINT [PK_Sys_Log] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Sys_Log NVARCHAR(64)
DECLARE cursor_Sys_Log CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Sys_Log') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Location','Content','Sql'))

OPEN cursor_Sys_Log
FETCH NEXT FROM cursor_Sys_Log INTO @name_Sys_Log

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Sys_Log.' + @name_Sys_Log;
    
    DECLARE @sql_Sys_Log NVARCHAR(MAX);
    SET @sql_Sys_Log = 'ALTER TABLE Sys_Log DROP COLUMN ' + QUOTENAME(@name_Sys_Log)
    EXEC sp_executesql @sql_Sys_Log
    
    
    FETCH NEXT FROM cursor_Sys_Log INTO @name_Sys_Log
END

CLOSE cursor_Sys_Log;
DEALLOCATE cursor_Sys_Log;


-- [Sys_Log.Location] -------------


-- [Sys_Log.Location] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Sys_Log') AND name='Location')
    BEGIN
     ALTER TABLE Sys_Log ALTER COLUMN [Location] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Sys_Log_Location NVARCHAR(MAX);
    SET @sql_add_Sys_Log_Location = 'ALTER TABLE Sys_Log ADD [Location] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Sys_Log_Location
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Sys_LogLocation')
    BEGIN
    ALTER TABLE Sys_Log DROP  CONSTRAINT [Constraint_Sys_LogLocation]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Sys_LogLocation')
    BEGIN
    ALTER TABLE Sys_Log DROP  CONSTRAINT [UniqueNonclustered_Sys_LogLocation]
    END

-- [Sys_Log.Content] -------------


-- [Sys_Log.Content] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Sys_Log') AND name='Content')
    BEGIN
     ALTER TABLE Sys_Log ALTER COLUMN [Content] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Sys_Log_Content NVARCHAR(MAX);
    SET @sql_add_Sys_Log_Content = 'ALTER TABLE Sys_Log ADD [Content] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Sys_Log_Content
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Sys_LogContent')
    BEGIN
    ALTER TABLE Sys_Log DROP  CONSTRAINT [Constraint_Sys_LogContent]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Sys_LogContent')
    BEGIN
    ALTER TABLE Sys_Log DROP  CONSTRAINT [UniqueNonclustered_Sys_LogContent]
    END

-- [Sys_Log.Sql] -------------


-- [Sys_Log.Sql] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Sys_Log') AND name='Sql')
    BEGIN
     ALTER TABLE Sys_Log ALTER COLUMN [Sql] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Sys_Log_Sql NVARCHAR(MAX);
    SET @sql_add_Sys_Log_Sql = 'ALTER TABLE Sys_Log ADD [Sql] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Sys_Log_Sql
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Sys_LogSql')
    BEGIN
    ALTER TABLE Sys_Log DROP  CONSTRAINT [Constraint_Sys_LogSql]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Sys_LogSql')
    BEGIN
    ALTER TABLE Sys_Log DROP  CONSTRAINT [UniqueNonclustered_Sys_LogSql]
    END
-- [Sys_PageLog] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Sys_PageLog' AND xtype='U')

BEGIN

    CREATE TABLE Sys_PageLog ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Ip] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Request] NVARCHAR(MAX)
, CONSTRAINT [PK_Sys_PageLog] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Sys_PageLog NVARCHAR(64)
DECLARE cursor_Sys_PageLog CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Sys_PageLog') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Ip','Request'))

OPEN cursor_Sys_PageLog
FETCH NEXT FROM cursor_Sys_PageLog INTO @name_Sys_PageLog

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Sys_PageLog.' + @name_Sys_PageLog;
    
    DECLARE @sql_Sys_PageLog NVARCHAR(MAX);
    SET @sql_Sys_PageLog = 'ALTER TABLE Sys_PageLog DROP COLUMN ' + QUOTENAME(@name_Sys_PageLog)
    EXEC sp_executesql @sql_Sys_PageLog
    
    
    FETCH NEXT FROM cursor_Sys_PageLog INTO @name_Sys_PageLog
END

CLOSE cursor_Sys_PageLog;
DEALLOCATE cursor_Sys_PageLog;


-- [Sys_PageLog.Ip] -------------


-- [Sys_PageLog.Ip] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Sys_PageLog') AND name='Ip')
    BEGIN
     ALTER TABLE Sys_PageLog ALTER COLUMN [Ip] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Sys_PageLog_Ip NVARCHAR(MAX);
    SET @sql_add_Sys_PageLog_Ip = 'ALTER TABLE Sys_PageLog ADD [Ip] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Sys_PageLog_Ip
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Sys_PageLogIp')
    BEGIN
    ALTER TABLE Sys_PageLog DROP  CONSTRAINT [Constraint_Sys_PageLogIp]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Sys_PageLogIp')
    BEGIN
    ALTER TABLE Sys_PageLog DROP  CONSTRAINT [UniqueNonclustered_Sys_PageLogIp]
    END

-- [Sys_PageLog.Request] -------------


-- [Sys_PageLog.Request] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Sys_PageLog') AND name='Request')
    BEGIN
     ALTER TABLE Sys_PageLog ALTER COLUMN [Request] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Sys_PageLog_Request NVARCHAR(MAX);
    SET @sql_add_Sys_PageLog_Request = 'ALTER TABLE Sys_PageLog ADD [Request] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Sys_PageLog_Request
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Sys_PageLogRequest')
    BEGIN
    ALTER TABLE Sys_PageLog DROP  CONSTRAINT [Constraint_Sys_PageLogRequest]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Sys_PageLogRequest')
    BEGIN
    ALTER TABLE Sys_PageLog DROP  CONSTRAINT [UniqueNonclustered_Sys_PageLogRequest]
    END