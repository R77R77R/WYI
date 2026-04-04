USE [wyi]
-- [ca_enduser] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='ca_enduser' AND xtype='U')

BEGIN

    CREATE TABLE ca_enduser ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Username] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Email] NVARCHAR(255) COLLATE Chinese_PRC_CI_AS
        ,[Avatar] NVARCHAR(MAX)
        ,[ClerkUserID] NVARCHAR(100) COLLATE Chinese_PRC_CI_AS
        ,[Pwd] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[AuthType] INT
, CONSTRAINT [PK_ca_enduser] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_ca_enduser NVARCHAR(64)
DECLARE cursor_ca_enduser CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Username','Email','Avatar','ClerkUserID','Pwd','AuthType'))

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

-- [ca_enduser.Username] -------------


-- [ca_enduser.Username] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='Username')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [Username] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_Username NVARCHAR(MAX);
    SET @sql_add_ca_enduser_Username = 'ALTER TABLE ca_enduser ADD [Username] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_enduser_Username
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserUsername')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserUsername]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserUsername')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserUsername]
    END

-- [ca_enduser.Email] -------------


-- [ca_enduser.Email] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='Email')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [Email] NVARCHAR(255) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_Email NVARCHAR(MAX);
    SET @sql_add_ca_enduser_Email = 'ALTER TABLE ca_enduser ADD [Email] NVARCHAR(255) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_enduser_Email
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserEmail')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserEmail]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserEmail')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserEmail]
    END

-- [ca_enduser.Avatar] -------------


-- [ca_enduser.Avatar] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='Avatar')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [Avatar] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_Avatar NVARCHAR(MAX);
    SET @sql_add_ca_enduser_Avatar = 'ALTER TABLE ca_enduser ADD [Avatar] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_ca_enduser_Avatar
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserAvatar')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserAvatar]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserAvatar')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserAvatar]
    END

-- [ca_enduser.ClerkUserID] -------------


-- [ca_enduser.ClerkUserID] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='ClerkUserID')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [ClerkUserID] NVARCHAR(100) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_ClerkUserID NVARCHAR(MAX);
    SET @sql_add_ca_enduser_ClerkUserID = 'ALTER TABLE ca_enduser ADD [ClerkUserID] NVARCHAR(100) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_enduser_ClerkUserID
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserClerkUserID')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserClerkUserID]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserClerkUserID')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserClerkUserID]
    END

-- [ca_enduser.Pwd] -------------


-- [ca_enduser.Pwd] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='Pwd')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [Pwd] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_Pwd NVARCHAR(MAX);
    SET @sql_add_ca_enduser_Pwd = 'ALTER TABLE ca_enduser ADD [Pwd] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_enduser_Pwd
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserPwd')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserPwd]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserPwd')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserPwd]
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
        ,[Path] NVARCHAR(MAX)
        ,[State] INT
        ,[ContentType] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Suffix] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
        ,[Size] BIGINT
        ,[Thumbnail] VARBINARY(MAX)
        ,[Owner] BIGINT
, CONSTRAINT [PK_ca_file] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_ca_file NVARCHAR(64)
DECLARE cursor_ca_file CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Path','State','ContentType','Suffix','Size','Thumbnail','Owner'))

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

-- [ca_file.Path] -------------


-- [ca_file.Path] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Path')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Path] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Path NVARCHAR(MAX);
    SET @sql_add_ca_file_Path = 'ALTER TABLE ca_file ADD [Path] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_ca_file_Path
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_filePath')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_filePath]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_filePath')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_filePath]
    END

-- [ca_file.State] -------------


-- [ca_file.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='State')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [State] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_State NVARCHAR(MAX);
    SET @sql_add_ca_file_State = 'ALTER TABLE ca_file ADD [State] INT'
    EXEC sp_executesql @sql_add_ca_file_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileState')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileState')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileState]
    END

-- [ca_file.ContentType] -------------


-- [ca_file.ContentType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='ContentType')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [ContentType] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_ContentType NVARCHAR(MAX);
    SET @sql_add_ca_file_ContentType = 'ALTER TABLE ca_file ADD [ContentType] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_file_ContentType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileContentType')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileContentType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileContentType')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileContentType]
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
-- [kernel_client] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_client' AND xtype='U')

BEGIN

    CREATE TABLE kernel_client ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
, CONSTRAINT [PK_kernel_client] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_client NVARCHAR(64)
DECLARE cursor_kernel_client CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_client') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption'))

OPEN cursor_kernel_client
FETCH NEXT FROM cursor_kernel_client INTO @name_kernel_client

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_client.' + @name_kernel_client;
    
    DECLARE @sql_kernel_client NVARCHAR(MAX);
    SET @sql_kernel_client = 'ALTER TABLE kernel_client DROP COLUMN ' + QUOTENAME(@name_kernel_client)
    EXEC sp_executesql @sql_kernel_client
    
    
    FETCH NEXT FROM cursor_kernel_client INTO @name_kernel_client
END

CLOSE cursor_kernel_client;
DEALLOCATE cursor_kernel_client;


-- [kernel_client.Caption] -------------


-- [kernel_client.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_client') AND name='Caption')
    BEGIN
     ALTER TABLE kernel_client ALTER COLUMN [Caption] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_client_Caption NVARCHAR(MAX);
    SET @sql_add_kernel_client_Caption = 'ALTER TABLE kernel_client ADD [Caption] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_client_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_clientCaption')
    BEGIN
    ALTER TABLE kernel_client DROP  CONSTRAINT [Constraint_kernel_clientCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_clientCaption')
    BEGIN
    ALTER TABLE kernel_client DROP  CONSTRAINT [UniqueNonclustered_kernel_clientCaption]
    END
-- [kernel_unit] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_unit' AND xtype='U')

BEGIN

    CREATE TABLE kernel_unit ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
, CONSTRAINT [PK_kernel_unit] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_unit NVARCHAR(64)
DECLARE cursor_kernel_unit CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption'))

OPEN cursor_kernel_unit
FETCH NEXT FROM cursor_kernel_unit INTO @name_kernel_unit

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_unit.' + @name_kernel_unit;
    
    DECLARE @sql_kernel_unit NVARCHAR(MAX);
    SET @sql_kernel_unit = 'ALTER TABLE kernel_unit DROP COLUMN ' + QUOTENAME(@name_kernel_unit)
    EXEC sp_executesql @sql_kernel_unit
    
    
    FETCH NEXT FROM cursor_kernel_unit INTO @name_kernel_unit
END

CLOSE cursor_kernel_unit;
DEALLOCATE cursor_kernel_unit;


-- [kernel_unit.Caption] -------------


-- [kernel_unit.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='Caption')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [Caption] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_Caption NVARCHAR(MAX);
    SET @sql_add_kernel_unit_Caption = 'ALTER TABLE kernel_unit ADD [Caption] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_unit_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitCaption')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitCaption')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitCaption]
    END
-- [kernel_utilbill] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_utilbill' AND xtype='U')

BEGIN

    CREATE TABLE kernel_utilbill ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Cat] BIGINT
        ,[Provider] BIGINT
        ,[client] BIGINT
        ,[Unit] BIGINT
        ,[Amout] FLOAT
, CONSTRAINT [PK_kernel_utilbill] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_utilbill NVARCHAR(64)
DECLARE cursor_kernel_utilbill CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Cat','Provider','client','Unit','Amout'))

OPEN cursor_kernel_utilbill
FETCH NEXT FROM cursor_kernel_utilbill INTO @name_kernel_utilbill

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_utilbill.' + @name_kernel_utilbill;
    
    DECLARE @sql_kernel_utilbill NVARCHAR(MAX);
    SET @sql_kernel_utilbill = 'ALTER TABLE kernel_utilbill DROP COLUMN ' + QUOTENAME(@name_kernel_utilbill)
    EXEC sp_executesql @sql_kernel_utilbill
    
    
    FETCH NEXT FROM cursor_kernel_utilbill INTO @name_kernel_utilbill
END

CLOSE cursor_kernel_utilbill;
DEALLOCATE cursor_kernel_utilbill;


-- [kernel_utilbill.Cat] -------------


-- [kernel_utilbill.Cat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Cat')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Cat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Cat NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Cat = 'ALTER TABLE kernel_utilbill ADD [Cat] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Cat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillCat')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillCat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillCat')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillCat]
    END

-- [kernel_utilbill.Provider] -------------


-- [kernel_utilbill.Provider] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Provider')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Provider] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Provider NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Provider = 'ALTER TABLE kernel_utilbill ADD [Provider] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Provider
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillProvider')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillProvider]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillProvider')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillProvider]
    END

-- [kernel_utilbill.client] -------------


-- [kernel_utilbill.client] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='client')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [client] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_client NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_client = 'ALTER TABLE kernel_utilbill ADD [client] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_client
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillclient')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillclient]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillclient')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillclient]
    END

-- [kernel_utilbill.Unit] -------------


-- [kernel_utilbill.Unit] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Unit')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Unit] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Unit NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Unit = 'ALTER TABLE kernel_utilbill ADD [Unit] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Unit
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillUnit')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillUnit]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillUnit')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillUnit]
    END

-- [kernel_utilbill.Amout] -------------


-- [kernel_utilbill.Amout] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Amout')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Amout] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Amout NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Amout = 'ALTER TABLE kernel_utilbill ADD [Amout] FLOAT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Amout
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillAmout')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillAmout]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillAmout')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillAmout]
    END
-- [kernel_utilcat] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_utilcat' AND xtype='U')

BEGIN

    CREATE TABLE kernel_utilcat ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
, CONSTRAINT [PK_kernel_utilcat] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_utilcat NVARCHAR(64)
DECLARE cursor_kernel_utilcat CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_utilcat') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption'))

OPEN cursor_kernel_utilcat
FETCH NEXT FROM cursor_kernel_utilcat INTO @name_kernel_utilcat

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_utilcat.' + @name_kernel_utilcat;
    
    DECLARE @sql_kernel_utilcat NVARCHAR(MAX);
    SET @sql_kernel_utilcat = 'ALTER TABLE kernel_utilcat DROP COLUMN ' + QUOTENAME(@name_kernel_utilcat)
    EXEC sp_executesql @sql_kernel_utilcat
    
    
    FETCH NEXT FROM cursor_kernel_utilcat INTO @name_kernel_utilcat
END

CLOSE cursor_kernel_utilcat;
DEALLOCATE cursor_kernel_utilcat;


-- [kernel_utilcat.Caption] -------------


-- [kernel_utilcat.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilcat') AND name='Caption')
    BEGIN
     ALTER TABLE kernel_utilcat ALTER COLUMN [Caption] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilcat_Caption NVARCHAR(MAX);
    SET @sql_add_kernel_utilcat_Caption = 'ALTER TABLE kernel_utilcat ADD [Caption] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_utilcat_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilcatCaption')
    BEGIN
    ALTER TABLE kernel_utilcat DROP  CONSTRAINT [Constraint_kernel_utilcatCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilcatCaption')
    BEGIN
    ALTER TABLE kernel_utilcat DROP  CONSTRAINT [UniqueNonclustered_kernel_utilcatCaption]
    END
-- [kernel_utilprovider] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_utilprovider' AND xtype='U')

BEGIN

    CREATE TABLE kernel_utilprovider ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
        ,[Cat] BIGINT
, CONSTRAINT [PK_kernel_utilprovider] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_utilprovider NVARCHAR(64)
DECLARE cursor_kernel_utilprovider CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_utilprovider') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Cat'))

OPEN cursor_kernel_utilprovider
FETCH NEXT FROM cursor_kernel_utilprovider INTO @name_kernel_utilprovider

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_utilprovider.' + @name_kernel_utilprovider;
    
    DECLARE @sql_kernel_utilprovider NVARCHAR(MAX);
    SET @sql_kernel_utilprovider = 'ALTER TABLE kernel_utilprovider DROP COLUMN ' + QUOTENAME(@name_kernel_utilprovider)
    EXEC sp_executesql @sql_kernel_utilprovider
    
    
    FETCH NEXT FROM cursor_kernel_utilprovider INTO @name_kernel_utilprovider
END

CLOSE cursor_kernel_utilprovider;
DEALLOCATE cursor_kernel_utilprovider;


-- [kernel_utilprovider.Caption] -------------


-- [kernel_utilprovider.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilprovider') AND name='Caption')
    BEGIN
     ALTER TABLE kernel_utilprovider ALTER COLUMN [Caption] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilprovider_Caption NVARCHAR(MAX);
    SET @sql_add_kernel_utilprovider_Caption = 'ALTER TABLE kernel_utilprovider ADD [Caption] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_utilprovider_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilproviderCaption')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [Constraint_kernel_utilproviderCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilproviderCaption')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [UniqueNonclustered_kernel_utilproviderCaption]
    END

-- [kernel_utilprovider.Cat] -------------


-- [kernel_utilprovider.Cat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilprovider') AND name='Cat')
    BEGIN
     ALTER TABLE kernel_utilprovider ALTER COLUMN [Cat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilprovider_Cat NVARCHAR(MAX);
    SET @sql_add_kernel_utilprovider_Cat = 'ALTER TABLE kernel_utilprovider ADD [Cat] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilprovider_Cat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilproviderCat')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [Constraint_kernel_utilproviderCat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilproviderCat')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [UniqueNonclustered_kernel_utilproviderCat]
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
-- [sys_config] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='sys_config' AND xtype='U')

BEGIN

    CREATE TABLE sys_config ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Key] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Val] NVARCHAR(MAX)
, CONSTRAINT [PK_sys_config] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_sys_config NVARCHAR(64)
DECLARE cursor_sys_config CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('sys_config') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Key','Val'))

OPEN cursor_sys_config
FETCH NEXT FROM cursor_sys_config INTO @name_sys_config

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping sys_config.' + @name_sys_config;
    
    DECLARE @sql_sys_config NVARCHAR(MAX);
    SET @sql_sys_config = 'ALTER TABLE sys_config DROP COLUMN ' + QUOTENAME(@name_sys_config)
    EXEC sp_executesql @sql_sys_config
    
    
    FETCH NEXT FROM cursor_sys_config INTO @name_sys_config
END

CLOSE cursor_sys_config;
DEALLOCATE cursor_sys_config;


-- [sys_config.Key] -------------


-- [sys_config.Key] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('sys_config') AND name='Key')
    BEGIN
     ALTER TABLE sys_config ALTER COLUMN [Key] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_sys_config_Key NVARCHAR(MAX);
    SET @sql_add_sys_config_Key = 'ALTER TABLE sys_config ADD [Key] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_sys_config_Key
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_sys_configKey')
    BEGIN
    ALTER TABLE sys_config DROP  CONSTRAINT [Constraint_sys_configKey]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_sys_configKey')
    BEGIN
    ALTER TABLE sys_config DROP  CONSTRAINT [UniqueNonclustered_sys_configKey]
    END

-- [sys_config.Val] -------------


-- [sys_config.Val] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('sys_config') AND name='Val')
    BEGIN
     ALTER TABLE sys_config ALTER COLUMN [Val] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_sys_config_Val NVARCHAR(MAX);
    SET @sql_add_sys_config_Val = 'ALTER TABLE sys_config ADD [Val] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_sys_config_Val
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_sys_configVal')
    BEGIN
    ALTER TABLE sys_config DROP  CONSTRAINT [Constraint_sys_configVal]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_sys_configVal')
    BEGIN
    ALTER TABLE sys_config DROP  CONSTRAINT [UniqueNonclustered_sys_configVal]
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