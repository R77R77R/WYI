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
, CONSTRAINT [PK_Ca_EndUser] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_EndUser NVARCHAR(64)
DECLARE cursor_Ca_EndUser CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption'))

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