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
        ,[OAuthProvider] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[ClerkUserID] NVARCHAR(100) COLLATE Chinese_PRC_CI_AS
        ,[Pwd] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[AuthType] INT
, CONSTRAINT [PK_ca_enduser] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_ca_enduser NVARCHAR(64)
DECLARE cursor_ca_enduser CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Username','Email','Avatar','OAuthProvider','ClerkUserID','Pwd','AuthType'))

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

-- [ca_enduser.OAuthProvider] -------------


-- [ca_enduser.OAuthProvider] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_enduser') AND name='OAuthProvider')
    BEGIN
     ALTER TABLE ca_enduser ALTER COLUMN [OAuthProvider] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_enduser_OAuthProvider NVARCHAR(MAX);
    SET @sql_add_ca_enduser_OAuthProvider = 'ALTER TABLE ca_enduser ADD [OAuthProvider] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_ca_enduser_OAuthProvider
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_enduserOAuthProvider')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [Constraint_ca_enduserOAuthProvider]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_enduserOAuthProvider')
    BEGIN
    ALTER TABLE ca_enduser DROP  CONSTRAINT [UniqueNonclustered_ca_enduserOAuthProvider]
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
        ,[Cat] BIGINT
        ,[Provider] BIGINT
        ,[Unit] BIGINT
        ,[Bill] BIGINT
, CONSTRAINT [PK_ca_file] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_ca_file NVARCHAR(64)
DECLARE cursor_ca_file CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Path','State','ContentType','Suffix','Size','Thumbnail','Owner','Cat','Provider','Unit','Bill'))

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

-- [ca_file.Cat] -------------


-- [ca_file.Cat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Cat')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Cat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Cat NVARCHAR(MAX);
    SET @sql_add_ca_file_Cat = 'ALTER TABLE ca_file ADD [Cat] BIGINT'
    EXEC sp_executesql @sql_add_ca_file_Cat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileCat')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileCat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileCat')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileCat]
    END

-- [ca_file.Provider] -------------


-- [ca_file.Provider] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Provider')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Provider] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Provider NVARCHAR(MAX);
    SET @sql_add_ca_file_Provider = 'ALTER TABLE ca_file ADD [Provider] BIGINT'
    EXEC sp_executesql @sql_add_ca_file_Provider
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileProvider')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileProvider]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileProvider')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileProvider]
    END

-- [ca_file.Unit] -------------


-- [ca_file.Unit] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Unit')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Unit] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Unit NVARCHAR(MAX);
    SET @sql_add_ca_file_Unit = 'ALTER TABLE ca_file ADD [Unit] BIGINT'
    EXEC sp_executesql @sql_add_ca_file_Unit
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileUnit')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileUnit]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileUnit')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileUnit]
    END

-- [ca_file.Bill] -------------


-- [ca_file.Bill] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('ca_file') AND name='Bill')
    BEGIN
     ALTER TABLE ca_file ALTER COLUMN [Bill] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_ca_file_Bill NVARCHAR(MAX);
    SET @sql_add_ca_file_Bill = 'ALTER TABLE ca_file ADD [Bill] BIGINT'
    EXEC sp_executesql @sql_add_ca_file_Bill
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_ca_fileBill')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [Constraint_ca_fileBill]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_ca_fileBill')
    BEGIN
    ALTER TABLE ca_file DROP  CONSTRAINT [UniqueNonclustered_ca_fileBill]
    END
-- [kernel_pool] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_pool' AND xtype='U')

BEGIN

    CREATE TABLE kernel_pool ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Cat] BIGINT
        ,[Provider] BIGINT
        ,[Manager] BIGINT
        ,[State] INT
        ,[Notes] NVARCHAR(MAX)
        ,[Amt] FLOAT
        ,[AmtReduction] FLOAT
        ,[AmtReturn] FLOAT
, CONSTRAINT [PK_kernel_pool] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_pool NVARCHAR(64)
DECLARE cursor_kernel_pool CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Cat','Provider','Manager','State','Notes','Amt','AmtReduction','AmtReturn'))

OPEN cursor_kernel_pool
FETCH NEXT FROM cursor_kernel_pool INTO @name_kernel_pool

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_pool.' + @name_kernel_pool;
    
    DECLARE @sql_kernel_pool NVARCHAR(MAX);
    SET @sql_kernel_pool = 'ALTER TABLE kernel_pool DROP COLUMN ' + QUOTENAME(@name_kernel_pool)
    EXEC sp_executesql @sql_kernel_pool
    
    
    FETCH NEXT FROM cursor_kernel_pool INTO @name_kernel_pool
END

CLOSE cursor_kernel_pool;
DEALLOCATE cursor_kernel_pool;


-- [kernel_pool.Cat] -------------


-- [kernel_pool.Cat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='Cat')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [Cat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_Cat NVARCHAR(MAX);
    SET @sql_add_kernel_pool_Cat = 'ALTER TABLE kernel_pool ADD [Cat] BIGINT'
    EXEC sp_executesql @sql_add_kernel_pool_Cat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolCat')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolCat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolCat')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolCat]
    END

-- [kernel_pool.Provider] -------------


-- [kernel_pool.Provider] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='Provider')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [Provider] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_Provider NVARCHAR(MAX);
    SET @sql_add_kernel_pool_Provider = 'ALTER TABLE kernel_pool ADD [Provider] BIGINT'
    EXEC sp_executesql @sql_add_kernel_pool_Provider
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolProvider')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolProvider]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolProvider')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolProvider]
    END

-- [kernel_pool.Manager] -------------


-- [kernel_pool.Manager] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='Manager')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [Manager] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_Manager NVARCHAR(MAX);
    SET @sql_add_kernel_pool_Manager = 'ALTER TABLE kernel_pool ADD [Manager] BIGINT'
    EXEC sp_executesql @sql_add_kernel_pool_Manager
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolManager')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolManager]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolManager')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolManager]
    END

-- [kernel_pool.State] -------------


-- [kernel_pool.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='State')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [State] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_State NVARCHAR(MAX);
    SET @sql_add_kernel_pool_State = 'ALTER TABLE kernel_pool ADD [State] INT'
    EXEC sp_executesql @sql_add_kernel_pool_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolState')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolState')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolState]
    END

-- [kernel_pool.Notes] -------------


-- [kernel_pool.Notes] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='Notes')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [Notes] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_Notes NVARCHAR(MAX);
    SET @sql_add_kernel_pool_Notes = 'ALTER TABLE kernel_pool ADD [Notes] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_pool_Notes
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolNotes')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolNotes]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolNotes')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolNotes]
    END

-- [kernel_pool.Amt] -------------


-- [kernel_pool.Amt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='Amt')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [Amt] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_Amt NVARCHAR(MAX);
    SET @sql_add_kernel_pool_Amt = 'ALTER TABLE kernel_pool ADD [Amt] FLOAT'
    EXEC sp_executesql @sql_add_kernel_pool_Amt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolAmt')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolAmt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolAmt')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolAmt]
    END

-- [kernel_pool.AmtReduction] -------------


-- [kernel_pool.AmtReduction] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='AmtReduction')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [AmtReduction] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_AmtReduction NVARCHAR(MAX);
    SET @sql_add_kernel_pool_AmtReduction = 'ALTER TABLE kernel_pool ADD [AmtReduction] FLOAT'
    EXEC sp_executesql @sql_add_kernel_pool_AmtReduction
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolAmtReduction')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolAmtReduction]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolAmtReduction')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolAmtReduction]
    END

-- [kernel_pool.AmtReturn] -------------


-- [kernel_pool.AmtReturn] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_pool') AND name='AmtReturn')
    BEGIN
     ALTER TABLE kernel_pool ALTER COLUMN [AmtReturn] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_pool_AmtReturn NVARCHAR(MAX);
    SET @sql_add_kernel_pool_AmtReturn = 'ALTER TABLE kernel_pool ADD [AmtReturn] FLOAT'
    EXEC sp_executesql @sql_add_kernel_pool_AmtReturn
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_poolAmtReturn')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [Constraint_kernel_poolAmtReturn]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_poolAmtReturn')
    BEGIN
    ALTER TABLE kernel_pool DROP  CONSTRAINT [UniqueNonclustered_kernel_poolAmtReturn]
    END
-- [kernel_unit] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_unit' AND xtype='U')

BEGIN

    CREATE TABLE kernel_unit ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
        ,[Owner] BIGINT
        ,[UnitNum] NVARCHAR(5) COLLATE Chinese_PRC_CI_AS
        ,[AcctNum] NVARCHAR(MAX)
        ,[Address] NVARCHAR(MAX)
        ,[Town] NVARCHAR(MAX)
        ,[State] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS
        ,[Zip] NVARCHAR(10) COLLATE Chinese_PRC_CI_AS
, CONSTRAINT [PK_kernel_unit] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_unit NVARCHAR(64)
DECLARE cursor_kernel_unit CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Owner','UnitNum','AcctNum','Address','Town','State','Zip'))

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

-- [kernel_unit.Owner] -------------


-- [kernel_unit.Owner] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='Owner')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [Owner] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_Owner NVARCHAR(MAX);
    SET @sql_add_kernel_unit_Owner = 'ALTER TABLE kernel_unit ADD [Owner] BIGINT'
    EXEC sp_executesql @sql_add_kernel_unit_Owner
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitOwner')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitOwner]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitOwner')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitOwner]
    END

-- [kernel_unit.UnitNum] -------------


-- [kernel_unit.UnitNum] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='UnitNum')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [UnitNum] NVARCHAR(5) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_UnitNum NVARCHAR(MAX);
    SET @sql_add_kernel_unit_UnitNum = 'ALTER TABLE kernel_unit ADD [UnitNum] NVARCHAR(5) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_kernel_unit_UnitNum
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitUnitNum')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitUnitNum]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitUnitNum')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitUnitNum]
    END

-- [kernel_unit.AcctNum] -------------


-- [kernel_unit.AcctNum] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='AcctNum')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [AcctNum] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_AcctNum NVARCHAR(MAX);
    SET @sql_add_kernel_unit_AcctNum = 'ALTER TABLE kernel_unit ADD [AcctNum] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_unit_AcctNum
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitAcctNum')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitAcctNum]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitAcctNum')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitAcctNum]
    END

-- [kernel_unit.Address] -------------


-- [kernel_unit.Address] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='Address')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [Address] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_Address NVARCHAR(MAX);
    SET @sql_add_kernel_unit_Address = 'ALTER TABLE kernel_unit ADD [Address] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_unit_Address
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitAddress')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitAddress]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitAddress')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitAddress]
    END

-- [kernel_unit.Town] -------------


-- [kernel_unit.Town] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='Town')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [Town] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_Town NVARCHAR(MAX);
    SET @sql_add_kernel_unit_Town = 'ALTER TABLE kernel_unit ADD [Town] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_unit_Town
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitTown')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitTown]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitTown')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitTown]
    END

-- [kernel_unit.State] -------------


-- [kernel_unit.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='State')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [State] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_State NVARCHAR(MAX);
    SET @sql_add_kernel_unit_State = 'ALTER TABLE kernel_unit ADD [State] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_kernel_unit_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitState')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitState')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitState]
    END

-- [kernel_unit.Zip] -------------


-- [kernel_unit.Zip] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_unit') AND name='Zip')
    BEGIN
     ALTER TABLE kernel_unit ALTER COLUMN [Zip] NVARCHAR(10) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_unit_Zip NVARCHAR(MAX);
    SET @sql_add_kernel_unit_Zip = 'ALTER TABLE kernel_unit ADD [Zip] NVARCHAR(10) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_kernel_unit_Zip
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_unitZip')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [Constraint_kernel_unitZip]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_unitZip')
    BEGIN
    ALTER TABLE kernel_unit DROP  CONSTRAINT [UniqueNonclustered_kernel_unitZip]
    END
-- [kernel_utilacct] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_utilacct' AND xtype='U')

BEGIN

    CREATE TABLE kernel_utilacct ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Cat] BIGINT
        ,[Provider] BIGINT
        ,[Owner] BIGINT
        ,[Unit] BIGINT
        ,[AcctName] NVARCHAR(MAX)
        ,[AcctNum] NVARCHAR(MAX)
, CONSTRAINT [PK_kernel_utilacct] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_utilacct NVARCHAR(64)
DECLARE cursor_kernel_utilacct CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_utilacct') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Cat','Provider','Owner','Unit','AcctName','AcctNum'))

OPEN cursor_kernel_utilacct
FETCH NEXT FROM cursor_kernel_utilacct INTO @name_kernel_utilacct

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_utilacct.' + @name_kernel_utilacct;
    
    DECLARE @sql_kernel_utilacct NVARCHAR(MAX);
    SET @sql_kernel_utilacct = 'ALTER TABLE kernel_utilacct DROP COLUMN ' + QUOTENAME(@name_kernel_utilacct)
    EXEC sp_executesql @sql_kernel_utilacct
    
    
    FETCH NEXT FROM cursor_kernel_utilacct INTO @name_kernel_utilacct
END

CLOSE cursor_kernel_utilacct;
DEALLOCATE cursor_kernel_utilacct;


-- [kernel_utilacct.Cat] -------------


-- [kernel_utilacct.Cat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilacct') AND name='Cat')
    BEGIN
     ALTER TABLE kernel_utilacct ALTER COLUMN [Cat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilacct_Cat NVARCHAR(MAX);
    SET @sql_add_kernel_utilacct_Cat = 'ALTER TABLE kernel_utilacct ADD [Cat] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilacct_Cat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilacctCat')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [Constraint_kernel_utilacctCat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilacctCat')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [UniqueNonclustered_kernel_utilacctCat]
    END

-- [kernel_utilacct.Provider] -------------


-- [kernel_utilacct.Provider] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilacct') AND name='Provider')
    BEGIN
     ALTER TABLE kernel_utilacct ALTER COLUMN [Provider] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilacct_Provider NVARCHAR(MAX);
    SET @sql_add_kernel_utilacct_Provider = 'ALTER TABLE kernel_utilacct ADD [Provider] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilacct_Provider
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilacctProvider')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [Constraint_kernel_utilacctProvider]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilacctProvider')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [UniqueNonclustered_kernel_utilacctProvider]
    END

-- [kernel_utilacct.Owner] -------------


-- [kernel_utilacct.Owner] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilacct') AND name='Owner')
    BEGIN
     ALTER TABLE kernel_utilacct ALTER COLUMN [Owner] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilacct_Owner NVARCHAR(MAX);
    SET @sql_add_kernel_utilacct_Owner = 'ALTER TABLE kernel_utilacct ADD [Owner] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilacct_Owner
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilacctOwner')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [Constraint_kernel_utilacctOwner]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilacctOwner')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [UniqueNonclustered_kernel_utilacctOwner]
    END

-- [kernel_utilacct.Unit] -------------


-- [kernel_utilacct.Unit] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilacct') AND name='Unit')
    BEGIN
     ALTER TABLE kernel_utilacct ALTER COLUMN [Unit] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilacct_Unit NVARCHAR(MAX);
    SET @sql_add_kernel_utilacct_Unit = 'ALTER TABLE kernel_utilacct ADD [Unit] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilacct_Unit
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilacctUnit')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [Constraint_kernel_utilacctUnit]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilacctUnit')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [UniqueNonclustered_kernel_utilacctUnit]
    END

-- [kernel_utilacct.AcctName] -------------


-- [kernel_utilacct.AcctName] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilacct') AND name='AcctName')
    BEGIN
     ALTER TABLE kernel_utilacct ALTER COLUMN [AcctName] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilacct_AcctName NVARCHAR(MAX);
    SET @sql_add_kernel_utilacct_AcctName = 'ALTER TABLE kernel_utilacct ADD [AcctName] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_utilacct_AcctName
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilacctAcctName')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [Constraint_kernel_utilacctAcctName]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilacctAcctName')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [UniqueNonclustered_kernel_utilacctAcctName]
    END

-- [kernel_utilacct.AcctNum] -------------


-- [kernel_utilacct.AcctNum] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilacct') AND name='AcctNum')
    BEGIN
     ALTER TABLE kernel_utilacct ALTER COLUMN [AcctNum] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilacct_AcctNum NVARCHAR(MAX);
    SET @sql_add_kernel_utilacct_AcctNum = 'ALTER TABLE kernel_utilacct ADD [AcctNum] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_utilacct_AcctNum
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilacctAcctNum')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [Constraint_kernel_utilacctAcctNum]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilacctAcctNum')
    BEGIN
    ALTER TABLE kernel_utilacct DROP  CONSTRAINT [UniqueNonclustered_kernel_utilacctAcctNum]
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
        ,[Owner] BIGINT
        ,[Representative] BIGINT
        ,[Unit] BIGINT
        ,[State] INT
        ,[UAcct] BIGINT
        ,[Pool] BIGINT
        ,[YYYYMMDD] NVARCHAR(8) COLLATE Chinese_PRC_CI_AS
        ,[Amt] FLOAT
        ,[AmtReduction] FLOAT
        ,[AmtReturn] FLOAT
, CONSTRAINT [PK_kernel_utilbill] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_utilbill NVARCHAR(64)
DECLARE cursor_kernel_utilbill CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Cat','Provider','Owner','Representative','Unit','State','UAcct','Pool','YYYYMMDD','Amt','AmtReduction','AmtReturn'))

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

-- [kernel_utilbill.Owner] -------------


-- [kernel_utilbill.Owner] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Owner')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Owner] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Owner NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Owner = 'ALTER TABLE kernel_utilbill ADD [Owner] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Owner
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillOwner')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillOwner]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillOwner')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillOwner]
    END

-- [kernel_utilbill.Representative] -------------


-- [kernel_utilbill.Representative] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Representative')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Representative] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Representative NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Representative = 'ALTER TABLE kernel_utilbill ADD [Representative] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Representative
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillRepresentative')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillRepresentative]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillRepresentative')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillRepresentative]
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

-- [kernel_utilbill.State] -------------


-- [kernel_utilbill.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='State')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [State] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_State NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_State = 'ALTER TABLE kernel_utilbill ADD [State] INT'
    EXEC sp_executesql @sql_add_kernel_utilbill_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillState')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillState')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillState]
    END

-- [kernel_utilbill.UAcct] -------------


-- [kernel_utilbill.UAcct] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='UAcct')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [UAcct] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_UAcct NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_UAcct = 'ALTER TABLE kernel_utilbill ADD [UAcct] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_UAcct
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillUAcct')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillUAcct]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillUAcct')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillUAcct]
    END

-- [kernel_utilbill.Pool] -------------


-- [kernel_utilbill.Pool] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Pool')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Pool] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Pool NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Pool = 'ALTER TABLE kernel_utilbill ADD [Pool] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Pool
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillPool')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillPool]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillPool')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillPool]
    END

-- [kernel_utilbill.YYYYMMDD] -------------


-- [kernel_utilbill.YYYYMMDD] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='YYYYMMDD')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [YYYYMMDD] NVARCHAR(8) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_YYYYMMDD NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_YYYYMMDD = 'ALTER TABLE kernel_utilbill ADD [YYYYMMDD] NVARCHAR(8) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_kernel_utilbill_YYYYMMDD
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillYYYYMMDD')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillYYYYMMDD]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillYYYYMMDD')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillYYYYMMDD]
    END

-- [kernel_utilbill.Amt] -------------


-- [kernel_utilbill.Amt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='Amt')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [Amt] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_Amt NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_Amt = 'ALTER TABLE kernel_utilbill ADD [Amt] FLOAT'
    EXEC sp_executesql @sql_add_kernel_utilbill_Amt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillAmt')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillAmt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillAmt')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillAmt]
    END

-- [kernel_utilbill.AmtReduction] -------------


-- [kernel_utilbill.AmtReduction] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='AmtReduction')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [AmtReduction] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_AmtReduction NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_AmtReduction = 'ALTER TABLE kernel_utilbill ADD [AmtReduction] FLOAT'
    EXEC sp_executesql @sql_add_kernel_utilbill_AmtReduction
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillAmtReduction')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillAmtReduction]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillAmtReduction')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillAmtReduction]
    END

-- [kernel_utilbill.AmtReturn] -------------


-- [kernel_utilbill.AmtReturn] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilbill') AND name='AmtReturn')
    BEGIN
     ALTER TABLE kernel_utilbill ALTER COLUMN [AmtReturn] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilbill_AmtReturn NVARCHAR(MAX);
    SET @sql_add_kernel_utilbill_AmtReturn = 'ALTER TABLE kernel_utilbill ADD [AmtReturn] FLOAT'
    EXEC sp_executesql @sql_add_kernel_utilbill_AmtReturn
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilbillAmtReturn')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [Constraint_kernel_utilbillAmtReturn]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilbillAmtReturn')
    BEGIN
    ALTER TABLE kernel_utilbill DROP  CONSTRAINT [UniqueNonclustered_kernel_utilbillAmtReturn]
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
-- [kernel_utilcatprovider] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_utilcatprovider' AND xtype='U')

BEGIN

    CREATE TABLE kernel_utilcatprovider ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Cat] BIGINT
        ,[Provider] BIGINT
, CONSTRAINT [PK_kernel_utilcatprovider] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_utilcatprovider NVARCHAR(64)
DECLARE cursor_kernel_utilcatprovider CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_utilcatprovider') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Cat','Provider'))

OPEN cursor_kernel_utilcatprovider
FETCH NEXT FROM cursor_kernel_utilcatprovider INTO @name_kernel_utilcatprovider

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping kernel_utilcatprovider.' + @name_kernel_utilcatprovider;
    
    DECLARE @sql_kernel_utilcatprovider NVARCHAR(MAX);
    SET @sql_kernel_utilcatprovider = 'ALTER TABLE kernel_utilcatprovider DROP COLUMN ' + QUOTENAME(@name_kernel_utilcatprovider)
    EXEC sp_executesql @sql_kernel_utilcatprovider
    
    
    FETCH NEXT FROM cursor_kernel_utilcatprovider INTO @name_kernel_utilcatprovider
END

CLOSE cursor_kernel_utilcatprovider;
DEALLOCATE cursor_kernel_utilcatprovider;


-- [kernel_utilcatprovider.Cat] -------------


-- [kernel_utilcatprovider.Cat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilcatprovider') AND name='Cat')
    BEGIN
     ALTER TABLE kernel_utilcatprovider ALTER COLUMN [Cat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilcatprovider_Cat NVARCHAR(MAX);
    SET @sql_add_kernel_utilcatprovider_Cat = 'ALTER TABLE kernel_utilcatprovider ADD [Cat] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilcatprovider_Cat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilcatproviderCat')
    BEGIN
    ALTER TABLE kernel_utilcatprovider DROP  CONSTRAINT [Constraint_kernel_utilcatproviderCat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilcatproviderCat')
    BEGIN
    ALTER TABLE kernel_utilcatprovider DROP  CONSTRAINT [UniqueNonclustered_kernel_utilcatproviderCat]
    END

-- [kernel_utilcatprovider.Provider] -------------


-- [kernel_utilcatprovider.Provider] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilcatprovider') AND name='Provider')
    BEGIN
     ALTER TABLE kernel_utilcatprovider ALTER COLUMN [Provider] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilcatprovider_Provider NVARCHAR(MAX);
    SET @sql_add_kernel_utilcatprovider_Provider = 'ALTER TABLE kernel_utilcatprovider ADD [Provider] BIGINT'
    EXEC sp_executesql @sql_add_kernel_utilcatprovider_Provider
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilcatproviderProvider')
    BEGIN
    ALTER TABLE kernel_utilcatprovider DROP  CONSTRAINT [Constraint_kernel_utilcatproviderProvider]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilcatproviderProvider')
    BEGIN
    ALTER TABLE kernel_utilcatprovider DROP  CONSTRAINT [UniqueNonclustered_kernel_utilcatproviderProvider]
    END
-- [kernel_utilprovider] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='kernel_utilprovider' AND xtype='U')

BEGIN

    CREATE TABLE kernel_utilprovider ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(MAX)
        ,[Logo] NVARCHAR(MAX)
        ,[Icon] NVARCHAR(MAX)
        ,[Cat] BIGINT
, CONSTRAINT [PK_kernel_utilprovider] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_kernel_utilprovider NVARCHAR(64)
DECLARE cursor_kernel_utilprovider CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('kernel_utilprovider') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Logo','Icon','Cat'))

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

-- [kernel_utilprovider.Logo] -------------


-- [kernel_utilprovider.Logo] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilprovider') AND name='Logo')
    BEGIN
     ALTER TABLE kernel_utilprovider ALTER COLUMN [Logo] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilprovider_Logo NVARCHAR(MAX);
    SET @sql_add_kernel_utilprovider_Logo = 'ALTER TABLE kernel_utilprovider ADD [Logo] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_utilprovider_Logo
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilproviderLogo')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [Constraint_kernel_utilproviderLogo]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilproviderLogo')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [UniqueNonclustered_kernel_utilproviderLogo]
    END

-- [kernel_utilprovider.Icon] -------------


-- [kernel_utilprovider.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('kernel_utilprovider') AND name='Icon')
    BEGIN
     ALTER TABLE kernel_utilprovider ALTER COLUMN [Icon] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_kernel_utilprovider_Icon NVARCHAR(MAX);
    SET @sql_add_kernel_utilprovider_Icon = 'ALTER TABLE kernel_utilprovider ADD [Icon] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_kernel_utilprovider_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_kernel_utilproviderIcon')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [Constraint_kernel_utilproviderIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_kernel_utilproviderIcon')
    BEGIN
    ALTER TABLE kernel_utilprovider DROP  CONSTRAINT [UniqueNonclustered_kernel_utilproviderIcon]
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