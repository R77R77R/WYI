USE [wyi]
-- [ca_enduser] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='ca_enduser' AND xtype='U')

BEGIN

    CREATE TABLE ca_enduser ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[AuthType] INT
, CONSTRAINT [PK_ca_enduser] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_ca_enduser NVARCHAR(64)
DECLARE cursor_ca_enduser CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','AuthType'))

OPEN cursor_ca_enduser
FETCH NEXT FROM cursor_ca_enduser INTO @name_ca_enduser

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping ca_enduser.' + @name_ca_enduser;
    
    DECLARE @sql_ca_enduser NVARCHAR(MAX);
    SET @sql_ca_enduser = 'ALTER TABLE ca_enduser DROP COLUMN ' + QUOTENAME(@name_ca_enduser)
    EXEC sp_executesql @sql_ca_enduser
    
    
    FETCH NEXT FROM cursor_ca_enduser INTO @name_ca_enduser
END

CLOSE cursor_ca_enduser;
DEALLOCATE cursor_ca_enduser;


-- [ca_enduser.Caption] -------------


-- [ca_enduser.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='Caption')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_Caption NVARCHAR(MAX);
    SET @sql_add_ca_enduser_Caption = 'ALTER TABLE ca_enduser ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_enduser_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserCaption')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserCaption')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserCaption]
    END

-- [ca_enduser.AuthType] -------------


-- [ca_enduser.AuthType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='AuthType')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [AuthType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_AuthType NVARCHAR(MAX);
    SET @sql_add_ca_enduser_AuthType = 'ALTER TABLE ca_enduser ADD [AuthType] INT'
    EXEC sp_executesql @sql_add_ca_enduser_AuthType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserAuthType')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserAuthType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserAuthType')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserAuthType]
    END
-- [ca_file] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='ca_file' AND xtype='U')

BEGIN

    CREATE TABLE ca_file ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
        ,[Desc] NVARCHAR(MAX)
        ,[Suffix] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
        ,[Size] BIGINT
        ,[Thumbnail] VARBINARY(MAX)
        ,[Owner] BIGINT
, CONSTRAINT [PK_ca_file] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_ca_file NVARCHAR(64)
DECLARE cursor_ca_file CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Desc','Suffix','Size','Thumbnail','Owner'))

OPEN cursor_ca_file
FETCH NEXT FROM cursor_ca_file INTO @name_ca_file

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping ca_file.' + @name_ca_file;
    
    DECLARE @sql_ca_file NVARCHAR(MAX);
    SET @sql_ca_file = 'ALTER TABLE ca_file DROP COLUMN ' + QUOTENAME(@name_ca_file)
    EXEC sp_executesql @sql_ca_file
    
    
    FETCH NEXT FROM cursor_ca_file INTO @name_ca_file
END

CLOSE cursor_ca_file;
DEALLOCATE cursor_ca_file;


-- [ca_file.Caption] -------------


-- [ca_file.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Caption')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Caption] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Caption NVARCHAR(MAX);
    SET @sql_add_ca_file_Caption = 'ALTER TABLE ca_file ADD [Caption] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_ca_file_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileCaption')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileCaption')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileCaption]
    END

-- [ca_file.Desc] -------------


-- [ca_file.Desc] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Desc')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Desc] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Desc NVARCHAR(MAX);
    SET @sql_add_ca_file_Desc = 'ALTER TABLE ca_file ADD [Desc] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_ca_file_Desc
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileDesc')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileDesc]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileDesc')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileDesc]
    END

-- [ca_file.Suffix] -------------


-- [ca_file.Suffix] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Suffix')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Suffix] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Suffix NVARCHAR(MAX);
    SET @sql_add_ca_file_Suffix = 'ALTER TABLE ca_file ADD [Suffix] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_file_Suffix
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileSuffix')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileSuffix]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileSuffix')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileSuffix]
    END

-- [ca_file.Size] -------------


-- [ca_file.Size] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Size')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Size] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Size NVARCHAR(MAX);
    SET @sql_add_ca_file_Size = 'ALTER TABLE ca_file ADD [Size] BIGINT'
    EXEC sp_executesql @sql_add_ca_file_Size
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileSize')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileSize]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileSize')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileSize]
    END

-- [ca_file.Thumbnail] -------------


-- [ca_file.Thumbnail] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Thumbnail')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Thumbnail] VARBINARY(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Thumbnail NVARCHAR(MAX);
    SET @sql_add_ca_file_Thumbnail = 'ALTER TABLE ca_file ADD [Thumbnail] VARBINARY(MAX)'
    EXEC sp_executesql @sql_add_ca_file_Thumbnail
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileThumbnail')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileThumbnail]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileThumbnail')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileThumbnail]
    END

-- [ca_file.Owner] -------------


-- [ca_file.Owner] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Owner')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Owner] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Owner NVARCHAR(MAX);
    SET @sql_add_ca_file_Owner = 'ALTER TABLE ca_file ADD [Owner] BIGINT'
    EXEC sp_executesql @sql_add_ca_file_Owner
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileOwner')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileOwner]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileOwner')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileOwner]
    END
-- [social_filebind] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='social_filebind' AND xtype='U')

BEGIN

    CREATE TABLE social_filebind ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [File] BIGINT
        ,[Moment] BIGINT
        ,[Desc] NVARCHAR(MAX)
, CONSTRAINT [PK_social_filebind] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_social_filebind NVARCHAR(64)
DECLARE cursor_social_filebind CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('social_filebind') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','File','Moment','Desc'))

OPEN cursor_social_filebind
FETCH NEXT FROM cursor_social_filebind INTO @name_social_filebind

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping social_filebind.' + @name_social_filebind;
    
    DECLARE @sql_social_filebind NVARCHAR(MAX);
    SET @sql_social_filebind = 'ALTER TABLE social_filebind DROP COLUMN ' + QUOTENAME(@name_social_filebind)
    EXEC sp_executesql @sql_social_filebind
    
    
    FETCH NEXT FROM cursor_social_filebind INTO @name_social_filebind
END

CLOSE cursor_social_filebind;
DEALLOCATE cursor_social_filebind;


-- [social_filebind.File] -------------


-- [social_filebind.File] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_filebind') AND name='File')
    BEGIN
     ALTER TABLE social_filebind ALTER COLUMN [File] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_filebind_File NVARCHAR(MAX);
    SET @sql_add_social_filebind_File = 'ALTER TABLE social_filebind ADD [File] BIGINT'
    EXEC sp_executesql @sql_add_social_filebind_File
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_filebindFile')
    BEGIN
    ALTER TABLE social_filebind DROP  CONSTRAINT [Constraint_social_filebindFile]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_filebindFile')
    BEGIN
    ALTER TABLE social_filebind DROP  CONSTRAINT [UniqueNonclustered_social_filebindFile]
    END

-- [social_filebind.Moment] -------------


-- [social_filebind.Moment] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_filebind') AND name='Moment')
    BEGIN
     ALTER TABLE social_filebind ALTER COLUMN [Moment] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_filebind_Moment NVARCHAR(MAX);
    SET @sql_add_social_filebind_Moment = 'ALTER TABLE social_filebind ADD [Moment] BIGINT'
    EXEC sp_executesql @sql_add_social_filebind_Moment
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_filebindMoment')
    BEGIN
    ALTER TABLE social_filebind DROP  CONSTRAINT [Constraint_social_filebindMoment]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_filebindMoment')
    BEGIN
    ALTER TABLE social_filebind DROP  CONSTRAINT [UniqueNonclustered_social_filebindMoment]
    END

-- [social_filebind.Desc] -------------


-- [social_filebind.Desc] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_filebind') AND name='Desc')
    BEGIN
     ALTER TABLE social_filebind ALTER COLUMN [Desc] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_filebind_Desc NVARCHAR(MAX);
    SET @sql_add_social_filebind_Desc = 'ALTER TABLE social_filebind ADD [Desc] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_social_filebind_Desc
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_filebindDesc')
    BEGIN
    ALTER TABLE social_filebind DROP  CONSTRAINT [Constraint_social_filebindDesc]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_filebindDesc')
    BEGIN
    ALTER TABLE social_filebind DROP  CONSTRAINT [UniqueNonclustered_social_filebindDesc]
    END
-- [social_moment] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='social_moment' AND xtype='U')

BEGIN

    CREATE TABLE social_moment ([ID] BIGINT NOT NULL
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
, CONSTRAINT [PK_social_moment] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_social_moment NVARCHAR(64)
DECLARE cursor_social_moment CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Title','Summary','FullText','PreviewImgUrl','Link','Type','State','MediaType'))

OPEN cursor_social_moment
FETCH NEXT FROM cursor_social_moment INTO @name_social_moment

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping social_moment.' + @name_social_moment;
    
    DECLARE @sql_social_moment NVARCHAR(MAX);
    SET @sql_social_moment = 'ALTER TABLE social_moment DROP COLUMN ' + QUOTENAME(@name_social_moment)
    EXEC sp_executesql @sql_social_moment
    
    
    FETCH NEXT FROM cursor_social_moment INTO @name_social_moment
END

CLOSE cursor_social_moment;
DEALLOCATE cursor_social_moment;


-- [social_moment.Title] -------------


-- [social_moment.Title] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='Title')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [Title] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_Title NVARCHAR(MAX);
    SET @sql_add_social_moment_Title = 'ALTER TABLE social_moment ADD [Title] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_social_moment_Title
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentTitle')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentTitle]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentTitle')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentTitle]
    END

-- [social_moment.Summary] -------------


-- [social_moment.Summary] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='Summary')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [Summary] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_Summary NVARCHAR(MAX);
    SET @sql_add_social_moment_Summary = 'ALTER TABLE social_moment ADD [Summary] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_social_moment_Summary
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentSummary')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentSummary]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentSummary')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentSummary]
    END

-- [social_moment.FullText] -------------


-- [social_moment.FullText] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='FullText')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [FullText] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_FullText NVARCHAR(MAX);
    SET @sql_add_social_moment_FullText = 'ALTER TABLE social_moment ADD [FullText] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_social_moment_FullText
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentFullText')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentFullText]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentFullText')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentFullText]
    END

-- [social_moment.PreviewImgUrl] -------------


-- [social_moment.PreviewImgUrl] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='PreviewImgUrl')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [PreviewImgUrl] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_PreviewImgUrl NVARCHAR(MAX);
    SET @sql_add_social_moment_PreviewImgUrl = 'ALTER TABLE social_moment ADD [PreviewImgUrl] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_social_moment_PreviewImgUrl
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentPreviewImgUrl')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentPreviewImgUrl]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentPreviewImgUrl')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentPreviewImgUrl]
    END

-- [social_moment.Link] -------------


-- [social_moment.Link] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='Link')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [Link] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_Link NVARCHAR(MAX);
    SET @sql_add_social_moment_Link = 'ALTER TABLE social_moment ADD [Link] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_social_moment_Link
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentLink')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentLink]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentLink')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentLink]
    END

-- [social_moment.Type] -------------


-- [social_moment.Type] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='Type')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [Type] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_Type NVARCHAR(MAX);
    SET @sql_add_social_moment_Type = 'ALTER TABLE social_moment ADD [Type] INT'
    EXEC sp_executesql @sql_add_social_moment_Type
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentType')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentType')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentType]
    END

-- [social_moment.State] -------------


-- [social_moment.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='State')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [State] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_State NVARCHAR(MAX);
    SET @sql_add_social_moment_State = 'ALTER TABLE social_moment ADD [State] INT'
    EXEC sp_executesql @sql_add_social_moment_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentState')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentState')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentState]
    END

-- [social_moment.MediaType] -------------


-- [social_moment.MediaType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('social_moment') AND name='MediaType')
    BEGIN
     ALTER TABLE social_moment ALTER COLUMN [MediaType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_social_moment_MediaType NVARCHAR(MAX);
    SET @sql_add_social_moment_MediaType = 'ALTER TABLE social_moment ADD [MediaType] INT'
    EXEC sp_executesql @sql_add_social_moment_MediaType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_social_momentMediaType')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [Constraint_social_momentMediaType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_social_momentMediaType')
    BEGIN
    ALTER TABLE social_moment DROP  CONSTRAINT [UniqueNonclustered_social_momentMediaType]
    END
-- [sys_log] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='sys_log' AND xtype='U')

BEGIN

    CREATE TABLE sys_log ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Location] NVARCHAR(MAX)
        ,[Content] NVARCHAR(MAX)
        ,[Sql] NVARCHAR(MAX)
, CONSTRAINT [PK_sys_log] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_sys_log NVARCHAR(64)
DECLARE cursor_sys_log CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('sys_log') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Location','Content','Sql'))

OPEN cursor_sys_log
FETCH NEXT FROM cursor_sys_log INTO @name_sys_log

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping sys_log.' + @name_sys_log;
    
    DECLARE @sql_sys_log NVARCHAR(MAX);
    SET @sql_sys_log = 'ALTER TABLE sys_log DROP COLUMN ' + QUOTENAME(@name_sys_log)
    EXEC sp_executesql @sql_sys_log
    
    
    FETCH NEXT FROM cursor_sys_log INTO @name_sys_log
END

CLOSE cursor_sys_log;
DEALLOCATE cursor_sys_log;


-- [sys_log.Location] -------------


-- [sys_log.Location] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('sys_log') AND name='Location')
    BEGIN
     ALTER TABLE sys_log ALTER COLUMN [Location] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_sys_log_Location NVARCHAR(MAX);
    SET @sql_add_sys_log_Location = 'ALTER TABLE sys_log ADD [Location] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_sys_log_Location
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_sys_logLocation')
    BEGIN
    ALTER TABLE sys_log DROP  CONSTRAINT [Constraint_sys_logLocation]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_sys_logLocation')
    BEGIN
    ALTER TABLE sys_log DROP  CONSTRAINT [UniqueNonclustered_sys_logLocation]
    END

-- [sys_log.Content] -------------


-- [sys_log.Content] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('sys_log') AND name='Content')
    BEGIN
     ALTER TABLE sys_log ALTER COLUMN [Content] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_sys_log_Content NVARCHAR(MAX);
    SET @sql_add_sys_log_Content = 'ALTER TABLE sys_log ADD [Content] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_sys_log_Content
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_sys_logContent')
    BEGIN
    ALTER TABLE sys_log DROP  CONSTRAINT [Constraint_sys_logContent]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_sys_logContent')
    BEGIN
    ALTER TABLE sys_log DROP  CONSTRAINT [UniqueNonclustered_sys_logContent]
    END

-- [sys_log.Sql] -------------


-- [sys_log.Sql] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('sys_log') AND name='Sql')
    BEGIN
     ALTER TABLE sys_log ALTER COLUMN [Sql] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_sys_log_Sql NVARCHAR(MAX);
    SET @sql_add_sys_log_Sql = 'ALTER TABLE sys_log ADD [Sql] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_sys_log_Sql
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_sys_logSql')
    BEGIN
    ALTER TABLE sys_log DROP  CONSTRAINT [Constraint_sys_logSql]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_sys_logSql')
    BEGIN
    ALTER TABLE sys_log DROP  CONSTRAINT [UniqueNonclustered_sys_logSql]
    END
-- [sys_pagelog] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='sys_pagelog' AND xtype='U')

BEGIN

    CREATE TABLE sys_pagelog ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Ip] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Request] NVARCHAR(MAX)
, CONSTRAINT [PK_sys_pagelog] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_sys_pagelog NVARCHAR(64)
DECLARE cursor_sys_pagelog CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('sys_pagelog') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Ip','Request'))

OPEN cursor_sys_pagelog
FETCH NEXT FROM cursor_sys_pagelog INTO @name_sys_pagelog

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping sys_pagelog.' + @name_sys_pagelog;
    
    DECLARE @sql_sys_pagelog NVARCHAR(MAX);
    SET @sql_sys_pagelog = 'ALTER TABLE sys_pagelog DROP COLUMN ' + QUOTENAME(@name_sys_pagelog)
    EXEC sp_executesql @sql_sys_pagelog
    
    
    FETCH NEXT FROM cursor_sys_pagelog INTO @name_sys_pagelog
END

CLOSE cursor_sys_pagelog;
DEALLOCATE cursor_sys_pagelog;


-- [sys_pagelog.Ip] -------------


-- [sys_pagelog.Ip] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('sys_pagelog') AND name='Ip')
    BEGIN
     ALTER TABLE sys_pagelog ALTER COLUMN [Ip] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_sys_pagelog_Ip NVARCHAR(MAX);
    SET @sql_add_sys_pagelog_Ip = 'ALTER TABLE sys_pagelog ADD [Ip] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_sys_pagelog_Ip
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_sys_pagelogIp')
    BEGIN
    ALTER TABLE sys_pagelog DROP  CONSTRAINT [Constraint_sys_pagelogIp]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_sys_pagelogIp')
    BEGIN
    ALTER TABLE sys_pagelog DROP  CONSTRAINT [UniqueNonclustered_sys_pagelogIp]
    END

-- [sys_pagelog.Request] -------------


-- [sys_pagelog.Request] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('sys_pagelog') AND name='Request')
    BEGIN
     ALTER TABLE sys_pagelog ALTER COLUMN [Request] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_sys_pagelog_Request NVARCHAR(MAX);
    SET @sql_add_sys_pagelog_Request = 'ALTER TABLE sys_pagelog ADD [Request] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_sys_pagelog_Request
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_sys_pagelogRequest')
    BEGIN
    ALTER TABLE sys_pagelog DROP  CONSTRAINT [Constraint_sys_pagelogRequest]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_sys_pagelogRequest')
    BEGIN
    ALTER TABLE sys_pagelog DROP  CONSTRAINT [UniqueNonclustered_sys_pagelogRequest]
    END