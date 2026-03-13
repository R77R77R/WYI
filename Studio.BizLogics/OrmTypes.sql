USE [J7]

-- [Ca_Address] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Address' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Address ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Bind] BIGINT
        ,[AddressType] INT
        ,[Line1] NVARCHAR(300) COLLATE Chinese_PRC_CI_AS
        ,[Line2] NVARCHAR(300) COLLATE Chinese_PRC_CI_AS
        ,[State] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
        ,[County] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
        ,[Town] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
        ,[Contact] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Tel] NVARCHAR(20) COLLATE Chinese_PRC_CI_AS
        ,[Email] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Zip] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
        ,[City] BIGINT
        ,[Country] BIGINT
        ,[Remarks] NVARCHAR(MAX)
, CONSTRAINT [PK_Ca_Address] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Address NVARCHAR(64)
DECLARE cursor_Ca_Address CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Bind','AddressType','Line1','Line2','State','County','Town','Contact','Tel','Email','Zip','City','Country','Remarks'))

OPEN cursor_Ca_Address
FETCH NEXT FROM cursor_Ca_Address INTO @name_Ca_Address

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Address.' + @name_Ca_Address;
    
    DECLARE @sql_Ca_Address NVARCHAR(MAX);
    SET @sql_Ca_Address = 'ALTER TABLE Ca_Address DROP COLUMN ' + QUOTENAME(@name_Ca_Address)
    EXEC sp_executesql @sql_Ca_Address
    
    
    FETCH NEXT FROM cursor_Ca_Address INTO @name_Ca_Address
END

CLOSE cursor_Ca_Address;
DEALLOCATE cursor_Ca_Address;


-- [Ca_Address.Caption] -------------


-- [Ca_Address.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Caption = 'ALTER TABLE Ca_Address ADD [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressCaption')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressCaption')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressCaption]
    END

-- [Ca_Address.Bind] -------------


-- [Ca_Address.Bind] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Bind')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Bind] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Bind NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Bind = 'ALTER TABLE Ca_Address ADD [Bind] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Address_Bind
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressBind')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressBind]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressBind')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressBind]
    END

-- [Ca_Address.AddressType] -------------


-- [Ca_Address.AddressType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='AddressType')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [AddressType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_AddressType NVARCHAR(MAX);
    SET @sql_add_Ca_Address_AddressType = 'ALTER TABLE Ca_Address ADD [AddressType] INT'
    EXEC sp_executesql @sql_add_Ca_Address_AddressType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressAddressType')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressAddressType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressAddressType')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressAddressType]
    END

-- [Ca_Address.Line1] -------------


-- [Ca_Address.Line1] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Line1')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Line1] NVARCHAR(300) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Line1 NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Line1 = 'ALTER TABLE Ca_Address ADD [Line1] NVARCHAR(300) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Line1
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressLine1')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressLine1]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressLine1')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressLine1]
    END

-- [Ca_Address.Line2] -------------


-- [Ca_Address.Line2] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Line2')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Line2] NVARCHAR(300) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Line2 NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Line2 = 'ALTER TABLE Ca_Address ADD [Line2] NVARCHAR(300) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Line2
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressLine2')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressLine2]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressLine2')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressLine2]
    END

-- [Ca_Address.State] -------------


-- [Ca_Address.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='State')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [State] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_State NVARCHAR(MAX);
    SET @sql_add_Ca_Address_State = 'ALTER TABLE Ca_Address ADD [State] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressState')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressState')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressState]
    END

-- [Ca_Address.County] -------------


-- [Ca_Address.County] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='County')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [County] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_County NVARCHAR(MAX);
    SET @sql_add_Ca_Address_County = 'ALTER TABLE Ca_Address ADD [County] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_County
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressCounty')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressCounty]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressCounty')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressCounty]
    END

-- [Ca_Address.Town] -------------


-- [Ca_Address.Town] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Town')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Town] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Town NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Town = 'ALTER TABLE Ca_Address ADD [Town] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Town
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressTown')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressTown]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressTown')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressTown]
    END

-- [Ca_Address.Contact] -------------


-- [Ca_Address.Contact] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Contact')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Contact] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Contact NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Contact = 'ALTER TABLE Ca_Address ADD [Contact] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Contact
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressContact')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressContact]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressContact')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressContact]
    END

-- [Ca_Address.Tel] -------------


-- [Ca_Address.Tel] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Tel')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Tel] NVARCHAR(20) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Tel NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Tel = 'ALTER TABLE Ca_Address ADD [Tel] NVARCHAR(20) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Tel
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressTel')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressTel]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressTel')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressTel]
    END

-- [Ca_Address.Email] -------------


-- [Ca_Address.Email] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Email')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Email] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Email NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Email = 'ALTER TABLE Ca_Address ADD [Email] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Email
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressEmail')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressEmail]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressEmail')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressEmail]
    END

-- [Ca_Address.Zip] -------------


-- [Ca_Address.Zip] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Zip')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Zip] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Zip NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Zip = 'ALTER TABLE Ca_Address ADD [Zip] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Address_Zip
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressZip')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressZip]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressZip')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressZip]
    END

-- [Ca_Address.City] -------------


-- [Ca_Address.City] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='City')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [City] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_City NVARCHAR(MAX);
    SET @sql_add_Ca_Address_City = 'ALTER TABLE Ca_Address ADD [City] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Address_City
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressCity')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressCity]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressCity')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressCity]
    END

-- [Ca_Address.Country] -------------


-- [Ca_Address.Country] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Country')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Country] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Country NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Country = 'ALTER TABLE Ca_Address ADD [Country] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Address_Country
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressCountry')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressCountry]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressCountry')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressCountry]
    END

-- [Ca_Address.Remarks] -------------


-- [Ca_Address.Remarks] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Address') AND name='Remarks')
    BEGIN
     ALTER TABLE Ca_Address ALTER COLUMN [Remarks] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Address_Remarks NVARCHAR(MAX);
    SET @sql_add_Ca_Address_Remarks = 'ALTER TABLE Ca_Address ADD [Remarks] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Address_Remarks
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_AddressRemarks')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [Constraint_Ca_AddressRemarks]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_AddressRemarks')
    BEGIN
    ALTER TABLE Ca_Address DROP  CONSTRAINT [UniqueNonclustered_Ca_AddressRemarks]
    END
-- [Ca_Biz] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Biz' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Biz ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Code] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Parent] BIGINT
        ,[BasicAcct] BIGINT
        ,[DescTxt] NVARCHAR(MAX)
        ,[Website] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[City] BIGINT
        ,[Country] BIGINT
        ,[Lang] BIGINT
        ,[IsSocial] BIT
        ,[IsCmsSource] BIT
        ,[IsPay] BIT
        ,[MomentLatest] BIGINT
        ,[CountFollowers] BIGINT
        ,[CountFollows] BIGINT
        ,[CountMoments] BIGINT
        ,[CountViews] BIGINT
        ,[CountComments] BIGINT
        ,[CountThumbUps] BIGINT
        ,[CountThumbDns] BIGINT
        ,[IsCrawling] BIT
        ,[IsGSeries] BIT
        ,[RemarksCentral] NVARCHAR(MAX)
        ,[Agent] BIGINT
        ,[SiteCats] NVARCHAR(MAX)
        ,[ConfiguredCats] NVARCHAR(MAX)
, CONSTRAINT [PK_Ca_Biz] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Biz NVARCHAR(64)
DECLARE cursor_Ca_Biz CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Code','Caption','Parent','BasicAcct','DescTxt','Website','Icon','City','Country','Lang','IsSocial','IsCmsSource','IsPay','MomentLatest','CountFollowers','CountFollows','CountMoments','CountViews','CountComments','CountThumbUps','CountThumbDns','IsCrawling','IsGSeries','RemarksCentral','Agent','SiteCats','ConfiguredCats'))

OPEN cursor_Ca_Biz
FETCH NEXT FROM cursor_Ca_Biz INTO @name_Ca_Biz

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Biz.' + @name_Ca_Biz;
    
    DECLARE @sql_Ca_Biz NVARCHAR(MAX);
    SET @sql_Ca_Biz = 'ALTER TABLE Ca_Biz DROP COLUMN ' + QUOTENAME(@name_Ca_Biz)
    EXEC sp_executesql @sql_Ca_Biz
    
    
    FETCH NEXT FROM cursor_Ca_Biz INTO @name_Ca_Biz
END

CLOSE cursor_Ca_Biz;
DEALLOCATE cursor_Ca_Biz;


-- [Ca_Biz.Code] -------------


-- [Ca_Biz.Code] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Code')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Code] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Code NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Code = 'ALTER TABLE Ca_Biz ADD [Code] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Biz_Code
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCode')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCode')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCode]
    END

-- [Ca_Biz.Caption] -------------


-- [Ca_Biz.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Caption = 'ALTER TABLE Ca_Biz ADD [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Biz_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCaption')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCaption')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCaption]
    END

-- [Ca_Biz.Parent] -------------


-- [Ca_Biz.Parent] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Parent')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Parent] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Parent NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Parent = 'ALTER TABLE Ca_Biz ADD [Parent] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_Parent
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizParent')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizParent]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizParent')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizParent]
    END

-- [Ca_Biz.BasicAcct] -------------


-- [Ca_Biz.BasicAcct] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='BasicAcct')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [BasicAcct] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_BasicAcct NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_BasicAcct = 'ALTER TABLE Ca_Biz ADD [BasicAcct] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_BasicAcct
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizBasicAcct')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizBasicAcct]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizBasicAcct')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizBasicAcct]
    END

-- [Ca_Biz.DescTxt] -------------


-- [Ca_Biz.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='DescTxt')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_DescTxt NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_DescTxt = 'ALTER TABLE Ca_Biz ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Biz_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizDescTxt')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizDescTxt')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizDescTxt]
    END

-- [Ca_Biz.Website] -------------


-- [Ca_Biz.Website] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Website')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Website] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Website NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Website = 'ALTER TABLE Ca_Biz ADD [Website] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Biz_Website
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizWebsite')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizWebsite]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizWebsite')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizWebsite]
    END

-- [Ca_Biz.Icon] -------------


-- [Ca_Biz.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Icon')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Icon NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Icon = 'ALTER TABLE Ca_Biz ADD [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Biz_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizIcon')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizIcon')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizIcon]
    END

-- [Ca_Biz.City] -------------


-- [Ca_Biz.City] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='City')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [City] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_City NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_City = 'ALTER TABLE Ca_Biz ADD [City] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_City
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCity')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCity]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCity')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCity]
    END

-- [Ca_Biz.Country] -------------


-- [Ca_Biz.Country] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Country')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Country] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Country NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Country = 'ALTER TABLE Ca_Biz ADD [Country] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_Country
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountry')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountry]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountry')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountry]
    END

-- [Ca_Biz.Lang] -------------


-- [Ca_Biz.Lang] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Lang')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Lang] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Lang NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Lang = 'ALTER TABLE Ca_Biz ADD [Lang] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_Lang
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizLang')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizLang]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizLang')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizLang]
    END

-- [Ca_Biz.IsSocial] -------------


-- [Ca_Biz.IsSocial] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='IsSocial')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [IsSocial] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_IsSocial NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_IsSocial = 'ALTER TABLE Ca_Biz ADD [IsSocial] BIT'
    EXEC sp_executesql @sql_add_Ca_Biz_IsSocial
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizIsSocial')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizIsSocial]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizIsSocial')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizIsSocial]
    END

-- [Ca_Biz.IsCmsSource] -------------


-- [Ca_Biz.IsCmsSource] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='IsCmsSource')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [IsCmsSource] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_IsCmsSource NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_IsCmsSource = 'ALTER TABLE Ca_Biz ADD [IsCmsSource] BIT'
    EXEC sp_executesql @sql_add_Ca_Biz_IsCmsSource
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizIsCmsSource')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizIsCmsSource]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizIsCmsSource')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizIsCmsSource]
    END

-- [Ca_Biz.IsPay] -------------


-- [Ca_Biz.IsPay] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='IsPay')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [IsPay] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_IsPay NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_IsPay = 'ALTER TABLE Ca_Biz ADD [IsPay] BIT'
    EXEC sp_executesql @sql_add_Ca_Biz_IsPay
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizIsPay')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizIsPay]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizIsPay')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizIsPay]
    END

-- [Ca_Biz.MomentLatest] -------------


-- [Ca_Biz.MomentLatest] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='MomentLatest')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [MomentLatest] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_MomentLatest NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_MomentLatest = 'ALTER TABLE Ca_Biz ADD [MomentLatest] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_MomentLatest
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizMomentLatest')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizMomentLatest]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizMomentLatest')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizMomentLatest]
    END

-- [Ca_Biz.CountFollowers] -------------


-- [Ca_Biz.CountFollowers] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='CountFollowers')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [CountFollowers] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_CountFollowers NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_CountFollowers = 'ALTER TABLE Ca_Biz ADD [CountFollowers] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_CountFollowers
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountFollowers')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountFollowers]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountFollowers')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountFollowers]
    END

-- [Ca_Biz.CountFollows] -------------


-- [Ca_Biz.CountFollows] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='CountFollows')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [CountFollows] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_CountFollows NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_CountFollows = 'ALTER TABLE Ca_Biz ADD [CountFollows] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_CountFollows
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountFollows')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountFollows]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountFollows')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountFollows]
    END

-- [Ca_Biz.CountMoments] -------------


-- [Ca_Biz.CountMoments] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='CountMoments')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [CountMoments] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_CountMoments NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_CountMoments = 'ALTER TABLE Ca_Biz ADD [CountMoments] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_CountMoments
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountMoments')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountMoments]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountMoments')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountMoments]
    END

-- [Ca_Biz.CountViews] -------------


-- [Ca_Biz.CountViews] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='CountViews')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [CountViews] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_CountViews NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_CountViews = 'ALTER TABLE Ca_Biz ADD [CountViews] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_CountViews
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountViews')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountViews]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountViews')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountViews]
    END

-- [Ca_Biz.CountComments] -------------


-- [Ca_Biz.CountComments] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='CountComments')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [CountComments] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_CountComments NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_CountComments = 'ALTER TABLE Ca_Biz ADD [CountComments] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_CountComments
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountComments')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountComments]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountComments')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountComments]
    END

-- [Ca_Biz.CountThumbUps] -------------


-- [Ca_Biz.CountThumbUps] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='CountThumbUps')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [CountThumbUps] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_CountThumbUps NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_CountThumbUps = 'ALTER TABLE Ca_Biz ADD [CountThumbUps] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_CountThumbUps
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountThumbUps')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountThumbUps]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountThumbUps')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountThumbUps]
    END

-- [Ca_Biz.CountThumbDns] -------------


-- [Ca_Biz.CountThumbDns] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='CountThumbDns')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [CountThumbDns] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_CountThumbDns NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_CountThumbDns = 'ALTER TABLE Ca_Biz ADD [CountThumbDns] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_CountThumbDns
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizCountThumbDns')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizCountThumbDns]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizCountThumbDns')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizCountThumbDns]
    END

-- [Ca_Biz.IsCrawling] -------------


-- [Ca_Biz.IsCrawling] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='IsCrawling')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [IsCrawling] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_IsCrawling NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_IsCrawling = 'ALTER TABLE Ca_Biz ADD [IsCrawling] BIT'
    EXEC sp_executesql @sql_add_Ca_Biz_IsCrawling
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizIsCrawling')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizIsCrawling]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizIsCrawling')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizIsCrawling]
    END

-- [Ca_Biz.IsGSeries] -------------


-- [Ca_Biz.IsGSeries] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='IsGSeries')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [IsGSeries] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_IsGSeries NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_IsGSeries = 'ALTER TABLE Ca_Biz ADD [IsGSeries] BIT'
    EXEC sp_executesql @sql_add_Ca_Biz_IsGSeries
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizIsGSeries')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizIsGSeries]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizIsGSeries')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizIsGSeries]
    END

-- [Ca_Biz.RemarksCentral] -------------


-- [Ca_Biz.RemarksCentral] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='RemarksCentral')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [RemarksCentral] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_RemarksCentral NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_RemarksCentral = 'ALTER TABLE Ca_Biz ADD [RemarksCentral] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Biz_RemarksCentral
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizRemarksCentral')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizRemarksCentral]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizRemarksCentral')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizRemarksCentral]
    END

-- [Ca_Biz.Agent] -------------


-- [Ca_Biz.Agent] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='Agent')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [Agent] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_Agent NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_Agent = 'ALTER TABLE Ca_Biz ADD [Agent] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Biz_Agent
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizAgent')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizAgent]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizAgent')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizAgent]
    END

-- [Ca_Biz.SiteCats] -------------


-- [Ca_Biz.SiteCats] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='SiteCats')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [SiteCats] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_SiteCats NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_SiteCats = 'ALTER TABLE Ca_Biz ADD [SiteCats] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Biz_SiteCats
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizSiteCats')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizSiteCats]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizSiteCats')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizSiteCats]
    END

-- [Ca_Biz.ConfiguredCats] -------------


-- [Ca_Biz.ConfiguredCats] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Biz') AND name='ConfiguredCats')
    BEGIN
     ALTER TABLE Ca_Biz ALTER COLUMN [ConfiguredCats] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Biz_ConfiguredCats NVARCHAR(MAX);
    SET @sql_add_Ca_Biz_ConfiguredCats = 'ALTER TABLE Ca_Biz ADD [ConfiguredCats] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Biz_ConfiguredCats
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_BizConfiguredCats')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [Constraint_Ca_BizConfiguredCats]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_BizConfiguredCats')
    BEGIN
    ALTER TABLE Ca_Biz DROP  CONSTRAINT [UniqueNonclustered_Ca_BizConfiguredCats]
    END
-- [Ca_Cat] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Cat' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Cat ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Lang] BIGINT
        ,[Zh] BIGINT
        ,[Parent] BIGINT
        ,[CatState] INT
, CONSTRAINT [PK_Ca_Cat] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Cat NVARCHAR(64)
DECLARE cursor_Ca_Cat CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Cat') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Lang','Zh','Parent','CatState'))

OPEN cursor_Ca_Cat
FETCH NEXT FROM cursor_Ca_Cat INTO @name_Ca_Cat

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Cat.' + @name_Ca_Cat;
    
    DECLARE @sql_Ca_Cat NVARCHAR(MAX);
    SET @sql_Ca_Cat = 'ALTER TABLE Ca_Cat DROP COLUMN ' + QUOTENAME(@name_Ca_Cat)
    EXEC sp_executesql @sql_Ca_Cat
    
    
    FETCH NEXT FROM cursor_Ca_Cat INTO @name_Ca_Cat
END

CLOSE cursor_Ca_Cat;
DEALLOCATE cursor_Ca_Cat;


-- [Ca_Cat.Caption] -------------


-- [Ca_Cat.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cat') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Cat ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cat_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Cat_Caption = 'ALTER TABLE Ca_Cat ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cat_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CatCaption')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [Constraint_Ca_CatCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CatCaption')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [UniqueNonclustered_Ca_CatCaption]
    END

-- [Ca_Cat.Lang] -------------


-- [Ca_Cat.Lang] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cat') AND name='Lang')
    BEGIN
     ALTER TABLE Ca_Cat ALTER COLUMN [Lang] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cat_Lang NVARCHAR(MAX);
    SET @sql_add_Ca_Cat_Lang = 'ALTER TABLE Ca_Cat ADD [Lang] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Cat_Lang
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CatLang')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [Constraint_Ca_CatLang]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CatLang')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [UniqueNonclustered_Ca_CatLang]
    END

-- [Ca_Cat.Zh] -------------


-- [Ca_Cat.Zh] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cat') AND name='Zh')
    BEGIN
     ALTER TABLE Ca_Cat ALTER COLUMN [Zh] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cat_Zh NVARCHAR(MAX);
    SET @sql_add_Ca_Cat_Zh = 'ALTER TABLE Ca_Cat ADD [Zh] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Cat_Zh
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CatZh')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [Constraint_Ca_CatZh]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CatZh')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [UniqueNonclustered_Ca_CatZh]
    END

-- [Ca_Cat.Parent] -------------


-- [Ca_Cat.Parent] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cat') AND name='Parent')
    BEGIN
     ALTER TABLE Ca_Cat ALTER COLUMN [Parent] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cat_Parent NVARCHAR(MAX);
    SET @sql_add_Ca_Cat_Parent = 'ALTER TABLE Ca_Cat ADD [Parent] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Cat_Parent
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CatParent')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [Constraint_Ca_CatParent]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CatParent')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [UniqueNonclustered_Ca_CatParent]
    END

-- [Ca_Cat.CatState] -------------


-- [Ca_Cat.CatState] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cat') AND name='CatState')
    BEGIN
     ALTER TABLE Ca_Cat ALTER COLUMN [CatState] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cat_CatState NVARCHAR(MAX);
    SET @sql_add_Ca_Cat_CatState = 'ALTER TABLE Ca_Cat ADD [CatState] INT'
    EXEC sp_executesql @sql_add_Ca_Cat_CatState
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CatCatState')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [Constraint_Ca_CatCatState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CatCatState')
    BEGIN
    ALTER TABLE Ca_Cat DROP  CONSTRAINT [UniqueNonclustered_Ca_CatCatState]
    END
-- [Ca_City] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_City' AND xtype='U')

BEGIN

    CREATE TABLE Ca_City ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Fullname] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[MetropolitanCode3IATA] NVARCHAR(3) COLLATE Chinese_PRC_CI_AS
        ,[NameEn] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Country] BIGINT
        ,[Place] BIGINT
        ,[Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Tel] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
, CONSTRAINT [PK_Ca_City] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_City NVARCHAR(64)
DECLARE cursor_Ca_City CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Fullname','MetropolitanCode3IATA','NameEn','Country','Place','Icon','Tel'))

OPEN cursor_Ca_City
FETCH NEXT FROM cursor_Ca_City INTO @name_Ca_City

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_City.' + @name_Ca_City;
    
    DECLARE @sql_Ca_City NVARCHAR(MAX);
    SET @sql_Ca_City = 'ALTER TABLE Ca_City DROP COLUMN ' + QUOTENAME(@name_Ca_City)
    EXEC sp_executesql @sql_Ca_City
    
    
    FETCH NEXT FROM cursor_Ca_City INTO @name_Ca_City
END

CLOSE cursor_Ca_City;
DEALLOCATE cursor_Ca_City;


-- [Ca_City.Fullname] -------------


-- [Ca_City.Fullname] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND name='Fullname')
    BEGIN
     ALTER TABLE Ca_City ALTER COLUMN [Fullname] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_City_Fullname NVARCHAR(MAX);
    SET @sql_add_Ca_City_Fullname = 'ALTER TABLE Ca_City ADD [Fullname] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_City_Fullname
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CityFullname')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [Constraint_Ca_CityFullname]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CityFullname')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [UniqueNonclustered_Ca_CityFullname]
    END

-- [Ca_City.MetropolitanCode3IATA] -------------


-- [Ca_City.MetropolitanCode3IATA] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND name='MetropolitanCode3IATA')
    BEGIN
     ALTER TABLE Ca_City ALTER COLUMN [MetropolitanCode3IATA] NVARCHAR(3) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_City_MetropolitanCode3IATA NVARCHAR(MAX);
    SET @sql_add_Ca_City_MetropolitanCode3IATA = 'ALTER TABLE Ca_City ADD [MetropolitanCode3IATA] NVARCHAR(3) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_City_MetropolitanCode3IATA
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CityMetropolitanCode3IATA')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [Constraint_Ca_CityMetropolitanCode3IATA]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CityMetropolitanCode3IATA')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [UniqueNonclustered_Ca_CityMetropolitanCode3IATA]
    END

-- [Ca_City.NameEn] -------------


-- [Ca_City.NameEn] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND name='NameEn')
    BEGIN
     ALTER TABLE Ca_City ALTER COLUMN [NameEn] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_City_NameEn NVARCHAR(MAX);
    SET @sql_add_Ca_City_NameEn = 'ALTER TABLE Ca_City ADD [NameEn] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_City_NameEn
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CityNameEn')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [Constraint_Ca_CityNameEn]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CityNameEn')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [UniqueNonclustered_Ca_CityNameEn]
    END

-- [Ca_City.Country] -------------


-- [Ca_City.Country] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND name='Country')
    BEGIN
     ALTER TABLE Ca_City ALTER COLUMN [Country] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_City_Country NVARCHAR(MAX);
    SET @sql_add_Ca_City_Country = 'ALTER TABLE Ca_City ADD [Country] BIGINT'
    EXEC sp_executesql @sql_add_Ca_City_Country
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CityCountry')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [Constraint_Ca_CityCountry]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CityCountry')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [UniqueNonclustered_Ca_CityCountry]
    END

-- [Ca_City.Place] -------------


-- [Ca_City.Place] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND name='Place')
    BEGIN
     ALTER TABLE Ca_City ALTER COLUMN [Place] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_City_Place NVARCHAR(MAX);
    SET @sql_add_Ca_City_Place = 'ALTER TABLE Ca_City ADD [Place] BIGINT'
    EXEC sp_executesql @sql_add_Ca_City_Place
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CityPlace')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [Constraint_Ca_CityPlace]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CityPlace')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [UniqueNonclustered_Ca_CityPlace]
    END

-- [Ca_City.Icon] -------------


-- [Ca_City.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND name='Icon')
    BEGIN
     ALTER TABLE Ca_City ALTER COLUMN [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_City_Icon NVARCHAR(MAX);
    SET @sql_add_Ca_City_Icon = 'ALTER TABLE Ca_City ADD [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_City_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CityIcon')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [Constraint_Ca_CityIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CityIcon')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [UniqueNonclustered_Ca_CityIcon]
    END

-- [Ca_City.Tel] -------------


-- [Ca_City.Tel] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_City') AND name='Tel')
    BEGIN
     ALTER TABLE Ca_City ALTER COLUMN [Tel] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_City_Tel NVARCHAR(MAX);
    SET @sql_add_Ca_City_Tel = 'ALTER TABLE Ca_City ADD [Tel] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_City_Tel
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CityTel')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [Constraint_Ca_CityTel]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CityTel')
    BEGIN
    ALTER TABLE Ca_City DROP  CONSTRAINT [UniqueNonclustered_Ca_CityTel]
    END
-- [Ca_Country] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Country' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Country ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Code2] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS
        ,[Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Fullname] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Tel] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
        ,[Cur] BIGINT
        ,[Capital] BIGINT
        ,[Place] BIGINT
        ,[Lang] BIGINT
, CONSTRAINT [PK_Ca_Country] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Country NVARCHAR(64)
DECLARE cursor_Ca_Country CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Code2','Caption','Fullname','Icon','Tel','Cur','Capital','Place','Lang'))

OPEN cursor_Ca_Country
FETCH NEXT FROM cursor_Ca_Country INTO @name_Ca_Country

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Country.' + @name_Ca_Country;
    
    DECLARE @sql_Ca_Country NVARCHAR(MAX);
    SET @sql_Ca_Country = 'ALTER TABLE Ca_Country DROP COLUMN ' + QUOTENAME(@name_Ca_Country)
    EXEC sp_executesql @sql_Ca_Country
    
    
    FETCH NEXT FROM cursor_Ca_Country INTO @name_Ca_Country
END

CLOSE cursor_Ca_Country;
DEALLOCATE cursor_Ca_Country;


-- [Ca_Country.Code2] -------------


-- [Ca_Country.Code2] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Code2')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Code2] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Code2 NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Code2 = 'ALTER TABLE Ca_Country ADD [Code2] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Country_Code2
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryCode2')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryCode2]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryCode2')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryCode2]
    END

-- [Ca_Country.Caption] -------------


-- [Ca_Country.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Caption = 'ALTER TABLE Ca_Country ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Country_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryCaption')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryCaption')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryCaption]
    END

-- [Ca_Country.Fullname] -------------


-- [Ca_Country.Fullname] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Fullname')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Fullname] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Fullname NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Fullname = 'ALTER TABLE Ca_Country ADD [Fullname] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Country_Fullname
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryFullname')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryFullname]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryFullname')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryFullname]
    END

-- [Ca_Country.Icon] -------------


-- [Ca_Country.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Icon')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Icon NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Icon = 'ALTER TABLE Ca_Country ADD [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Country_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryIcon')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryIcon')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryIcon]
    END

-- [Ca_Country.Tel] -------------


-- [Ca_Country.Tel] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Tel')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Tel] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Tel NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Tel = 'ALTER TABLE Ca_Country ADD [Tel] NVARCHAR(4) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Country_Tel
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryTel')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryTel]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryTel')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryTel]
    END

-- [Ca_Country.Cur] -------------


-- [Ca_Country.Cur] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Cur')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Cur] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Cur NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Cur = 'ALTER TABLE Ca_Country ADD [Cur] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Country_Cur
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryCur')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryCur]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryCur')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryCur]
    END

-- [Ca_Country.Capital] -------------


-- [Ca_Country.Capital] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Capital')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Capital] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Capital NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Capital = 'ALTER TABLE Ca_Country ADD [Capital] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Country_Capital
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryCapital')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryCapital]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryCapital')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryCapital]
    END

-- [Ca_Country.Place] -------------


-- [Ca_Country.Place] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Place')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Place] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Place NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Place = 'ALTER TABLE Ca_Country ADD [Place] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Country_Place
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryPlace')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryPlace]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryPlace')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryPlace]
    END

-- [Ca_Country.Lang] -------------


-- [Ca_Country.Lang] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Country') AND name='Lang')
    BEGIN
     ALTER TABLE Ca_Country ALTER COLUMN [Lang] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Country_Lang NVARCHAR(MAX);
    SET @sql_add_Ca_Country_Lang = 'ALTER TABLE Ca_Country ADD [Lang] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Country_Lang
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CountryLang')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [Constraint_Ca_CountryLang]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CountryLang')
    BEGIN
    ALTER TABLE Ca_Country DROP  CONSTRAINT [UniqueNonclustered_Ca_CountryLang]
    END
-- [Ca_Cur] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Cur' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Cur ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Code] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
        ,[Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[IsHidden] BIT
        ,[IsSac] BIT
        ,[IsTransfer] BIT
        ,[IsCash] BIT
        ,[EnableReward] BIT
        ,[EnableOTC] BIT
        ,[Icon] NVARCHAR(512) COLLATE Chinese_PRC_CI_AS
        ,[CurType] INT
        ,[FloatDec] BIGINT
        ,[AnchorRate] FLOAT
        ,[Freezable] BIT
        ,[Authorizable] BIT
        ,[ChaninID] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[ChaninName] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[ContractAddress] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[WalletAddress] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[BaseRate] FLOAT
, CONSTRAINT [PK_Ca_Cur] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Cur NVARCHAR(64)
DECLARE cursor_Ca_Cur CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Code','Caption','IsHidden','IsSac','IsTransfer','IsCash','EnableReward','EnableOTC','Icon','CurType','FloatDec','AnchorRate','Freezable','Authorizable','ChaninID','ChaninName','ContractAddress','WalletAddress','BaseRate'))

OPEN cursor_Ca_Cur
FETCH NEXT FROM cursor_Ca_Cur INTO @name_Ca_Cur

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Cur.' + @name_Ca_Cur;
    
    DECLARE @sql_Ca_Cur NVARCHAR(MAX);
    SET @sql_Ca_Cur = 'ALTER TABLE Ca_Cur DROP COLUMN ' + QUOTENAME(@name_Ca_Cur)
    EXEC sp_executesql @sql_Ca_Cur
    
    
    FETCH NEXT FROM cursor_Ca_Cur INTO @name_Ca_Cur
END

CLOSE cursor_Ca_Cur;
DEALLOCATE cursor_Ca_Cur;


-- [Ca_Cur.Code] -------------


-- [Ca_Cur.Code] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='Code')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [Code] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_Code NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_Code = 'ALTER TABLE Ca_Cur ADD [Code] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cur_Code
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurCode')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurCode')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurCode]
    END

-- [Ca_Cur.Caption] -------------


-- [Ca_Cur.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_Caption = 'ALTER TABLE Ca_Cur ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cur_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurCaption')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurCaption')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurCaption]
    END

-- [Ca_Cur.IsHidden] -------------


-- [Ca_Cur.IsHidden] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='IsHidden')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [IsHidden] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_IsHidden NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_IsHidden = 'ALTER TABLE Ca_Cur ADD [IsHidden] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_IsHidden
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurIsHidden')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurIsHidden]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurIsHidden')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurIsHidden]
    END

-- [Ca_Cur.IsSac] -------------


-- [Ca_Cur.IsSac] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='IsSac')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [IsSac] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_IsSac NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_IsSac = 'ALTER TABLE Ca_Cur ADD [IsSac] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_IsSac
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurIsSac')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurIsSac]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurIsSac')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurIsSac]
    END

-- [Ca_Cur.IsTransfer] -------------


-- [Ca_Cur.IsTransfer] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='IsTransfer')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [IsTransfer] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_IsTransfer NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_IsTransfer = 'ALTER TABLE Ca_Cur ADD [IsTransfer] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_IsTransfer
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurIsTransfer')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurIsTransfer]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurIsTransfer')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurIsTransfer]
    END

-- [Ca_Cur.IsCash] -------------


-- [Ca_Cur.IsCash] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='IsCash')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [IsCash] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_IsCash NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_IsCash = 'ALTER TABLE Ca_Cur ADD [IsCash] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_IsCash
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurIsCash')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurIsCash]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurIsCash')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurIsCash]
    END

-- [Ca_Cur.EnableReward] -------------


-- [Ca_Cur.EnableReward] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='EnableReward')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [EnableReward] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_EnableReward NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_EnableReward = 'ALTER TABLE Ca_Cur ADD [EnableReward] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_EnableReward
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurEnableReward')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurEnableReward]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurEnableReward')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurEnableReward]
    END

-- [Ca_Cur.EnableOTC] -------------


-- [Ca_Cur.EnableOTC] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='EnableOTC')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [EnableOTC] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_EnableOTC NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_EnableOTC = 'ALTER TABLE Ca_Cur ADD [EnableOTC] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_EnableOTC
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurEnableOTC')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurEnableOTC]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurEnableOTC')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurEnableOTC]
    END

-- [Ca_Cur.Icon] -------------


-- [Ca_Cur.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='Icon')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [Icon] NVARCHAR(512) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_Icon NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_Icon = 'ALTER TABLE Ca_Cur ADD [Icon] NVARCHAR(512) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cur_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurIcon')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurIcon')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurIcon]
    END

-- [Ca_Cur.CurType] -------------


-- [Ca_Cur.CurType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='CurType')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [CurType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_CurType NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_CurType = 'ALTER TABLE Ca_Cur ADD [CurType] INT'
    EXEC sp_executesql @sql_add_Ca_Cur_CurType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurCurType')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurCurType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurCurType')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurCurType]
    END

-- [Ca_Cur.FloatDec] -------------


-- [Ca_Cur.FloatDec] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='FloatDec')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [FloatDec] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_FloatDec NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_FloatDec = 'ALTER TABLE Ca_Cur ADD [FloatDec] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Cur_FloatDec
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurFloatDec')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurFloatDec]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurFloatDec')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurFloatDec]
    END

-- [Ca_Cur.AnchorRate] -------------


-- [Ca_Cur.AnchorRate] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='AnchorRate')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [AnchorRate] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_AnchorRate NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_AnchorRate = 'ALTER TABLE Ca_Cur ADD [AnchorRate] FLOAT'
    EXEC sp_executesql @sql_add_Ca_Cur_AnchorRate
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurAnchorRate')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurAnchorRate]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurAnchorRate')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurAnchorRate]
    END

-- [Ca_Cur.Freezable] -------------


-- [Ca_Cur.Freezable] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='Freezable')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [Freezable] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_Freezable NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_Freezable = 'ALTER TABLE Ca_Cur ADD [Freezable] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_Freezable
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurFreezable')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurFreezable]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurFreezable')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurFreezable]
    END

-- [Ca_Cur.Authorizable] -------------


-- [Ca_Cur.Authorizable] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='Authorizable')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [Authorizable] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_Authorizable NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_Authorizable = 'ALTER TABLE Ca_Cur ADD [Authorizable] BIT'
    EXEC sp_executesql @sql_add_Ca_Cur_Authorizable
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurAuthorizable')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurAuthorizable]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurAuthorizable')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurAuthorizable]
    END

-- [Ca_Cur.ChaninID] -------------


-- [Ca_Cur.ChaninID] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='ChaninID')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [ChaninID] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_ChaninID NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_ChaninID = 'ALTER TABLE Ca_Cur ADD [ChaninID] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cur_ChaninID
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurChaninID')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurChaninID]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurChaninID')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurChaninID]
    END

-- [Ca_Cur.ChaninName] -------------


-- [Ca_Cur.ChaninName] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='ChaninName')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [ChaninName] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_ChaninName NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_ChaninName = 'ALTER TABLE Ca_Cur ADD [ChaninName] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cur_ChaninName
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurChaninName')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurChaninName]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurChaninName')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurChaninName]
    END

-- [Ca_Cur.ContractAddress] -------------


-- [Ca_Cur.ContractAddress] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='ContractAddress')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [ContractAddress] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_ContractAddress NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_ContractAddress = 'ALTER TABLE Ca_Cur ADD [ContractAddress] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cur_ContractAddress
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurContractAddress')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurContractAddress]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurContractAddress')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurContractAddress]
    END

-- [Ca_Cur.WalletAddress] -------------


-- [Ca_Cur.WalletAddress] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='WalletAddress')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [WalletAddress] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_WalletAddress NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_WalletAddress = 'ALTER TABLE Ca_Cur ADD [WalletAddress] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Cur_WalletAddress
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurWalletAddress')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurWalletAddress]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurWalletAddress')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurWalletAddress]
    END

-- [Ca_Cur.BaseRate] -------------


-- [Ca_Cur.BaseRate] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Cur') AND name='BaseRate')
    BEGIN
     ALTER TABLE Ca_Cur ALTER COLUMN [BaseRate] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Cur_BaseRate NVARCHAR(MAX);
    SET @sql_add_Ca_Cur_BaseRate = 'ALTER TABLE Ca_Cur ADD [BaseRate] FLOAT'
    EXEC sp_executesql @sql_add_Ca_Cur_BaseRate
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_CurBaseRate')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [Constraint_Ca_CurBaseRate]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_CurBaseRate')
    BEGIN
    ALTER TABLE Ca_Cur DROP  CONSTRAINT [UniqueNonclustered_Ca_CurBaseRate]
    END
-- [Ca_EndUser] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_EndUser' AND xtype='U')

BEGIN

    CREATE TABLE Ca_EndUser ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Username] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[SocialAuthBiz] BIGINT
        ,[SocialAuthId] NVARCHAR(MAX)
        ,[SocialAuthAvatar] NVARCHAR(MAX)
        ,[Email] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Tel] NVARCHAR(32) COLLATE Chinese_PRC_CI_AS
        ,[Gender] INT
        ,[Status] INT
        ,[Admin] INT
        ,[BizPartner] INT
        ,[Privilege] BIGINT
        ,[Verify] INT
        ,[Pwd] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
        ,[Online] BIT
        ,[Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Background] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[BasicAcct] BIGINT
        ,[Citizen] BIGINT
        ,[Refer] NVARCHAR(9) COLLATE Chinese_PRC_CI_AS
        ,[Referer] BIGINT
        ,[Url] NVARCHAR(MAX)
        ,[About] NVARCHAR(MAX)
, CONSTRAINT [PK_Ca_EndUser] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_EndUser NVARCHAR(64)
DECLARE cursor_Ca_EndUser CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Username','SocialAuthBiz','SocialAuthId','SocialAuthAvatar','Email','Tel','Gender','Status','Admin','BizPartner','Privilege','Verify','Pwd','Online','Icon','Background','BasicAcct','Citizen','Refer','Referer','Url','About'))

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

-- [Ca_EndUser.Username] -------------


-- [Ca_EndUser.Username] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Username')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Username] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Username NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Username = 'ALTER TABLE Ca_EndUser ADD [Username] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Username
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserUsername')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserUsername]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserUsername')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserUsername]
    END

-- [Ca_EndUser.SocialAuthBiz] -------------


-- [Ca_EndUser.SocialAuthBiz] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='SocialAuthBiz')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [SocialAuthBiz] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_SocialAuthBiz NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_SocialAuthBiz = 'ALTER TABLE Ca_EndUser ADD [SocialAuthBiz] BIGINT'
    EXEC sp_executesql @sql_add_Ca_EndUser_SocialAuthBiz
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserSocialAuthBiz')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserSocialAuthBiz]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserSocialAuthBiz')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserSocialAuthBiz]
    END

-- [Ca_EndUser.SocialAuthId] -------------


-- [Ca_EndUser.SocialAuthId] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='SocialAuthId')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [SocialAuthId] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_SocialAuthId NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_SocialAuthId = 'ALTER TABLE Ca_EndUser ADD [SocialAuthId] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_EndUser_SocialAuthId
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserSocialAuthId')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserSocialAuthId]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserSocialAuthId')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserSocialAuthId]
    END

-- [Ca_EndUser.SocialAuthAvatar] -------------


-- [Ca_EndUser.SocialAuthAvatar] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='SocialAuthAvatar')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [SocialAuthAvatar] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_SocialAuthAvatar NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_SocialAuthAvatar = 'ALTER TABLE Ca_EndUser ADD [SocialAuthAvatar] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_EndUser_SocialAuthAvatar
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserSocialAuthAvatar')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserSocialAuthAvatar]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserSocialAuthAvatar')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserSocialAuthAvatar]
    END

-- [Ca_EndUser.Email] -------------


-- [Ca_EndUser.Email] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Email')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Email] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Email NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Email = 'ALTER TABLE Ca_EndUser ADD [Email] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Email
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserEmail')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserEmail]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserEmail')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserEmail]
    END

-- [Ca_EndUser.Tel] -------------


-- [Ca_EndUser.Tel] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Tel')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Tel] NVARCHAR(32) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Tel NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Tel = 'ALTER TABLE Ca_EndUser ADD [Tel] NVARCHAR(32) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Tel
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserTel')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserTel]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserTel')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserTel]
    END

-- [Ca_EndUser.Gender] -------------


-- [Ca_EndUser.Gender] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Gender')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Gender] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Gender NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Gender = 'ALTER TABLE Ca_EndUser ADD [Gender] INT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Gender
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserGender')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserGender]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserGender')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserGender]
    END

-- [Ca_EndUser.Status] -------------


-- [Ca_EndUser.Status] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Status')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Status] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Status NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Status = 'ALTER TABLE Ca_EndUser ADD [Status] INT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Status
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserStatus')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserStatus]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserStatus')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserStatus]
    END

-- [Ca_EndUser.Admin] -------------


-- [Ca_EndUser.Admin] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Admin')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Admin] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Admin NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Admin = 'ALTER TABLE Ca_EndUser ADD [Admin] INT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Admin
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserAdmin')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserAdmin]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserAdmin')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserAdmin]
    END

-- [Ca_EndUser.BizPartner] -------------


-- [Ca_EndUser.BizPartner] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='BizPartner')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [BizPartner] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_BizPartner NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_BizPartner = 'ALTER TABLE Ca_EndUser ADD [BizPartner] INT'
    EXEC sp_executesql @sql_add_Ca_EndUser_BizPartner
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserBizPartner')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserBizPartner]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserBizPartner')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserBizPartner]
    END

-- [Ca_EndUser.Privilege] -------------


-- [Ca_EndUser.Privilege] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Privilege')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Privilege] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Privilege NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Privilege = 'ALTER TABLE Ca_EndUser ADD [Privilege] BIGINT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Privilege
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserPrivilege')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserPrivilege]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserPrivilege')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserPrivilege]
    END

-- [Ca_EndUser.Verify] -------------


-- [Ca_EndUser.Verify] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Verify')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Verify] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Verify NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Verify = 'ALTER TABLE Ca_EndUser ADD [Verify] INT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Verify
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserVerify')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserVerify]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserVerify')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserVerify]
    END

-- [Ca_EndUser.Pwd] -------------


-- [Ca_EndUser.Pwd] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Pwd')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Pwd] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Pwd NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Pwd = 'ALTER TABLE Ca_EndUser ADD [Pwd] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Pwd
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserPwd')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserPwd]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserPwd')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserPwd]
    END

-- [Ca_EndUser.Online] -------------


-- [Ca_EndUser.Online] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Online')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Online] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Online NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Online = 'ALTER TABLE Ca_EndUser ADD [Online] BIT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Online
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserOnline')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserOnline]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserOnline')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserOnline]
    END

-- [Ca_EndUser.Icon] -------------


-- [Ca_EndUser.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Icon')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Icon NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Icon = 'ALTER TABLE Ca_EndUser ADD [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserIcon')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserIcon')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserIcon]
    END

-- [Ca_EndUser.Background] -------------


-- [Ca_EndUser.Background] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Background')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Background] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Background NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Background = 'ALTER TABLE Ca_EndUser ADD [Background] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Background
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserBackground')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserBackground]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserBackground')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserBackground]
    END

-- [Ca_EndUser.BasicAcct] -------------


-- [Ca_EndUser.BasicAcct] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='BasicAcct')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [BasicAcct] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_BasicAcct NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_BasicAcct = 'ALTER TABLE Ca_EndUser ADD [BasicAcct] BIGINT'
    EXEC sp_executesql @sql_add_Ca_EndUser_BasicAcct
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserBasicAcct')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserBasicAcct]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserBasicAcct')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserBasicAcct]
    END

-- [Ca_EndUser.Citizen] -------------


-- [Ca_EndUser.Citizen] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Citizen')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Citizen] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Citizen NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Citizen = 'ALTER TABLE Ca_EndUser ADD [Citizen] BIGINT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Citizen
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserCitizen')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserCitizen]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserCitizen')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserCitizen]
    END

-- [Ca_EndUser.Refer] -------------


-- [Ca_EndUser.Refer] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Refer')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Refer] NVARCHAR(9) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Refer NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Refer = 'ALTER TABLE Ca_EndUser ADD [Refer] NVARCHAR(9) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_EndUser_Refer
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserRefer')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserRefer]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserRefer')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserRefer]
    END

-- [Ca_EndUser.Referer] -------------


-- [Ca_EndUser.Referer] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Referer')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Referer] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Referer NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Referer = 'ALTER TABLE Ca_EndUser ADD [Referer] BIGINT'
    EXEC sp_executesql @sql_add_Ca_EndUser_Referer
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserReferer')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserReferer]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserReferer')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserReferer]
    END

-- [Ca_EndUser.Url] -------------


-- [Ca_EndUser.Url] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='Url')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [Url] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_Url NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_Url = 'ALTER TABLE Ca_EndUser ADD [Url] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_EndUser_Url
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserUrl')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserUrl]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserUrl')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserUrl]
    END

-- [Ca_EndUser.About] -------------


-- [Ca_EndUser.About] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_EndUser') AND name='About')
    BEGIN
     ALTER TABLE Ca_EndUser ALTER COLUMN [About] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_EndUser_About NVARCHAR(MAX);
    SET @sql_add_Ca_EndUser_About = 'ALTER TABLE Ca_EndUser ADD [About] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_EndUser_About
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_EndUserAbout')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [Constraint_Ca_EndUserAbout]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_EndUserAbout')
    BEGIN
    ALTER TABLE Ca_EndUser DROP  CONSTRAINT [UniqueNonclustered_Ca_EndUserAbout]
    END
-- [Ca_File] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_File' AND xtype='U')

BEGIN

    CREATE TABLE Ca_File ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Encrypt] INT
        ,[SHA256] NVARCHAR(MAX)
        ,[Size] BIGINT
        ,[Bind] BIGINT
        ,[BindType] INT
        ,[State] INT
        ,[Folder] BIGINT
        ,[FileType] INT
        ,[JSON] NVARCHAR(MAX)
, CONSTRAINT [PK_Ca_File] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_File NVARCHAR(64)
DECLARE cursor_Ca_File CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Encrypt','SHA256','Size','Bind','BindType','State','Folder','FileType','JSON'))

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
     ALTER TABLE Ca_File ALTER COLUMN [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_File_Caption = 'ALTER TABLE Ca_File ADD [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
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

-- [Ca_File.Encrypt] -------------


-- [Ca_File.Encrypt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Encrypt')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Encrypt] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Encrypt NVARCHAR(MAX);
    SET @sql_add_Ca_File_Encrypt = 'ALTER TABLE Ca_File ADD [Encrypt] INT'
    EXEC sp_executesql @sql_add_Ca_File_Encrypt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileEncrypt')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileEncrypt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileEncrypt')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileEncrypt]
    END

-- [Ca_File.SHA256] -------------


-- [Ca_File.SHA256] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='SHA256')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [SHA256] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_SHA256 NVARCHAR(MAX);
    SET @sql_add_Ca_File_SHA256 = 'ALTER TABLE Ca_File ADD [SHA256] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_File_SHA256
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileSHA256')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileSHA256]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileSHA256')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileSHA256]
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

-- [Ca_File.Bind] -------------


-- [Ca_File.Bind] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Bind')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Bind] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Bind NVARCHAR(MAX);
    SET @sql_add_Ca_File_Bind = 'ALTER TABLE Ca_File ADD [Bind] BIGINT'
    EXEC sp_executesql @sql_add_Ca_File_Bind
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileBind')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileBind]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileBind')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileBind]
    END

-- [Ca_File.BindType] -------------


-- [Ca_File.BindType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='BindType')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [BindType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_BindType NVARCHAR(MAX);
    SET @sql_add_Ca_File_BindType = 'ALTER TABLE Ca_File ADD [BindType] INT'
    EXEC sp_executesql @sql_add_Ca_File_BindType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileBindType')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileBindType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileBindType')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileBindType]
    END

-- [Ca_File.State] -------------


-- [Ca_File.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='State')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [State] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_State NVARCHAR(MAX);
    SET @sql_add_Ca_File_State = 'ALTER TABLE Ca_File ADD [State] INT'
    EXEC sp_executesql @sql_add_Ca_File_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileState')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileState')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileState]
    END

-- [Ca_File.Folder] -------------


-- [Ca_File.Folder] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='Folder')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [Folder] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_Folder NVARCHAR(MAX);
    SET @sql_add_Ca_File_Folder = 'ALTER TABLE Ca_File ADD [Folder] BIGINT'
    EXEC sp_executesql @sql_add_Ca_File_Folder
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileFolder')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileFolder]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileFolder')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileFolder]
    END

-- [Ca_File.FileType] -------------


-- [Ca_File.FileType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='FileType')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [FileType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_FileType NVARCHAR(MAX);
    SET @sql_add_Ca_File_FileType = 'ALTER TABLE Ca_File ADD [FileType] INT'
    EXEC sp_executesql @sql_add_Ca_File_FileType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileFileType')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileFileType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileFileType')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileFileType]
    END

-- [Ca_File.JSON] -------------


-- [Ca_File.JSON] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_File') AND name='JSON')
    BEGIN
     ALTER TABLE Ca_File ALTER COLUMN [JSON] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_File_JSON NVARCHAR(MAX);
    SET @sql_add_Ca_File_JSON = 'ALTER TABLE Ca_File ADD [JSON] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_File_JSON
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FileJSON')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [Constraint_Ca_FileJSON]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FileJSON')
    BEGIN
    ALTER TABLE Ca_File DROP  CONSTRAINT [UniqueNonclustered_Ca_FileJSON]
    END
-- [Ca_Folder] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Folder' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Folder ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[Encrypt] INT
        ,[Bind] BIGINT
        ,[BindType] INT
        ,[Parent] BIGINT
, CONSTRAINT [PK_Ca_Folder] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Folder NVARCHAR(64)
DECLARE cursor_Ca_Folder CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Folder') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Encrypt','Bind','BindType','Parent'))

OPEN cursor_Ca_Folder
FETCH NEXT FROM cursor_Ca_Folder INTO @name_Ca_Folder

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Folder.' + @name_Ca_Folder;
    
    DECLARE @sql_Ca_Folder NVARCHAR(MAX);
    SET @sql_Ca_Folder = 'ALTER TABLE Ca_Folder DROP COLUMN ' + QUOTENAME(@name_Ca_Folder)
    EXEC sp_executesql @sql_Ca_Folder
    
    
    FETCH NEXT FROM cursor_Ca_Folder INTO @name_Ca_Folder
END

CLOSE cursor_Ca_Folder;
DEALLOCATE cursor_Ca_Folder;


-- [Ca_Folder.Caption] -------------


-- [Ca_Folder.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Folder') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Folder ALTER COLUMN [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Folder_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Folder_Caption = 'ALTER TABLE Ca_Folder ADD [Caption] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Folder_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FolderCaption')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [Constraint_Ca_FolderCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FolderCaption')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [UniqueNonclustered_Ca_FolderCaption]
    END

-- [Ca_Folder.Encrypt] -------------


-- [Ca_Folder.Encrypt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Folder') AND name='Encrypt')
    BEGIN
     ALTER TABLE Ca_Folder ALTER COLUMN [Encrypt] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Folder_Encrypt NVARCHAR(MAX);
    SET @sql_add_Ca_Folder_Encrypt = 'ALTER TABLE Ca_Folder ADD [Encrypt] INT'
    EXEC sp_executesql @sql_add_Ca_Folder_Encrypt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FolderEncrypt')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [Constraint_Ca_FolderEncrypt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FolderEncrypt')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [UniqueNonclustered_Ca_FolderEncrypt]
    END

-- [Ca_Folder.Bind] -------------


-- [Ca_Folder.Bind] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Folder') AND name='Bind')
    BEGIN
     ALTER TABLE Ca_Folder ALTER COLUMN [Bind] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Folder_Bind NVARCHAR(MAX);
    SET @sql_add_Ca_Folder_Bind = 'ALTER TABLE Ca_Folder ADD [Bind] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Folder_Bind
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FolderBind')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [Constraint_Ca_FolderBind]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FolderBind')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [UniqueNonclustered_Ca_FolderBind]
    END

-- [Ca_Folder.BindType] -------------


-- [Ca_Folder.BindType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Folder') AND name='BindType')
    BEGIN
     ALTER TABLE Ca_Folder ALTER COLUMN [BindType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Folder_BindType NVARCHAR(MAX);
    SET @sql_add_Ca_Folder_BindType = 'ALTER TABLE Ca_Folder ADD [BindType] INT'
    EXEC sp_executesql @sql_add_Ca_Folder_BindType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FolderBindType')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [Constraint_Ca_FolderBindType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FolderBindType')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [UniqueNonclustered_Ca_FolderBindType]
    END

-- [Ca_Folder.Parent] -------------


-- [Ca_Folder.Parent] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Folder') AND name='Parent')
    BEGIN
     ALTER TABLE Ca_Folder ALTER COLUMN [Parent] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Folder_Parent NVARCHAR(MAX);
    SET @sql_add_Ca_Folder_Parent = 'ALTER TABLE Ca_Folder ADD [Parent] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Folder_Parent
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_FolderParent')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [Constraint_Ca_FolderParent]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_FolderParent')
    BEGIN
    ALTER TABLE Ca_Folder DROP  CONSTRAINT [UniqueNonclustered_Ca_FolderParent]
    END
-- [Ca_Lang] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Lang' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Lang ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Code2] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS
        ,[Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Native] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[IsBlank] BIT
        ,[IsLocale] BIT
        ,[IsContent] BIT
        ,[IsAutoTranslate] BIT
        ,[IsMiles] BIT
        ,[TextDirection] INT
, CONSTRAINT [PK_Ca_Lang] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Lang NVARCHAR(64)
DECLARE cursor_Ca_Lang CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Code2','Caption','Native','Icon','IsBlank','IsLocale','IsContent','IsAutoTranslate','IsMiles','TextDirection'))

OPEN cursor_Ca_Lang
FETCH NEXT FROM cursor_Ca_Lang INTO @name_Ca_Lang

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Lang.' + @name_Ca_Lang;
    
    DECLARE @sql_Ca_Lang NVARCHAR(MAX);
    SET @sql_Ca_Lang = 'ALTER TABLE Ca_Lang DROP COLUMN ' + QUOTENAME(@name_Ca_Lang)
    EXEC sp_executesql @sql_Ca_Lang
    
    
    FETCH NEXT FROM cursor_Ca_Lang INTO @name_Ca_Lang
END

CLOSE cursor_Ca_Lang;
DEALLOCATE cursor_Ca_Lang;


-- [Ca_Lang.Code2] -------------


-- [Ca_Lang.Code2] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='Code2')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [Code2] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_Code2 NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_Code2 = 'ALTER TABLE Ca_Lang ADD [Code2] NVARCHAR(2) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Lang_Code2
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangCode2')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangCode2]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangCode2')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangCode2]
    END

-- [Ca_Lang.Caption] -------------


-- [Ca_Lang.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_Caption = 'ALTER TABLE Ca_Lang ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Lang_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangCaption')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangCaption')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangCaption]
    END

-- [Ca_Lang.Native] -------------


-- [Ca_Lang.Native] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='Native')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [Native] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_Native NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_Native = 'ALTER TABLE Ca_Lang ADD [Native] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Lang_Native
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangNative')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangNative]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangNative')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangNative]
    END

-- [Ca_Lang.Icon] -------------


-- [Ca_Lang.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='Icon')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_Icon NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_Icon = 'ALTER TABLE Ca_Lang ADD [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Lang_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangIcon')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangIcon')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangIcon]
    END

-- [Ca_Lang.IsBlank] -------------


-- [Ca_Lang.IsBlank] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='IsBlank')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [IsBlank] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_IsBlank NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_IsBlank = 'ALTER TABLE Ca_Lang ADD [IsBlank] BIT'
    EXEC sp_executesql @sql_add_Ca_Lang_IsBlank
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangIsBlank')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangIsBlank]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangIsBlank')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangIsBlank]
    END

-- [Ca_Lang.IsLocale] -------------


-- [Ca_Lang.IsLocale] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='IsLocale')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [IsLocale] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_IsLocale NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_IsLocale = 'ALTER TABLE Ca_Lang ADD [IsLocale] BIT'
    EXEC sp_executesql @sql_add_Ca_Lang_IsLocale
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangIsLocale')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangIsLocale]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangIsLocale')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangIsLocale]
    END

-- [Ca_Lang.IsContent] -------------


-- [Ca_Lang.IsContent] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='IsContent')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [IsContent] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_IsContent NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_IsContent = 'ALTER TABLE Ca_Lang ADD [IsContent] BIT'
    EXEC sp_executesql @sql_add_Ca_Lang_IsContent
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangIsContent')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangIsContent]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangIsContent')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangIsContent]
    END

-- [Ca_Lang.IsAutoTranslate] -------------


-- [Ca_Lang.IsAutoTranslate] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='IsAutoTranslate')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [IsAutoTranslate] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_IsAutoTranslate NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_IsAutoTranslate = 'ALTER TABLE Ca_Lang ADD [IsAutoTranslate] BIT'
    EXEC sp_executesql @sql_add_Ca_Lang_IsAutoTranslate
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangIsAutoTranslate')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangIsAutoTranslate]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangIsAutoTranslate')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangIsAutoTranslate]
    END

-- [Ca_Lang.IsMiles] -------------


-- [Ca_Lang.IsMiles] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='IsMiles')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [IsMiles] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_IsMiles NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_IsMiles = 'ALTER TABLE Ca_Lang ADD [IsMiles] BIT'
    EXEC sp_executesql @sql_add_Ca_Lang_IsMiles
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangIsMiles')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangIsMiles]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangIsMiles')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangIsMiles]
    END

-- [Ca_Lang.TextDirection] -------------


-- [Ca_Lang.TextDirection] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Lang') AND name='TextDirection')
    BEGIN
     ALTER TABLE Ca_Lang ALTER COLUMN [TextDirection] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Lang_TextDirection NVARCHAR(MAX);
    SET @sql_add_Ca_Lang_TextDirection = 'ALTER TABLE Ca_Lang ADD [TextDirection] INT'
    EXEC sp_executesql @sql_add_Ca_Lang_TextDirection
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LangTextDirection')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [Constraint_Ca_LangTextDirection]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LangTextDirection')
    BEGIN
    ALTER TABLE Ca_Lang DROP  CONSTRAINT [UniqueNonclustered_Ca_LangTextDirection]
    END
-- [Ca_Locale] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_Locale' AND xtype='U')

BEGIN

    CREATE TABLE Ca_Locale ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Lang] BIGINT
        ,[Zh] NVARCHAR(MAX)
        ,[Text] NVARCHAR(MAX)
, CONSTRAINT [PK_Ca_Locale] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_Locale NVARCHAR(64)
DECLARE cursor_Ca_Locale CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_Locale') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Code','Lang','Zh','Text'))

OPEN cursor_Ca_Locale
FETCH NEXT FROM cursor_Ca_Locale INTO @name_Ca_Locale

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_Locale.' + @name_Ca_Locale;
    
    DECLARE @sql_Ca_Locale NVARCHAR(MAX);
    SET @sql_Ca_Locale = 'ALTER TABLE Ca_Locale DROP COLUMN ' + QUOTENAME(@name_Ca_Locale)
    EXEC sp_executesql @sql_Ca_Locale
    
    
    FETCH NEXT FROM cursor_Ca_Locale INTO @name_Ca_Locale
END

CLOSE cursor_Ca_Locale;
DEALLOCATE cursor_Ca_Locale;


-- [Ca_Locale.Code] -------------


-- [Ca_Locale.Code] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Locale') AND name='Code')
    BEGIN
     ALTER TABLE Ca_Locale ALTER COLUMN [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Locale_Code NVARCHAR(MAX);
    SET @sql_add_Ca_Locale_Code = 'ALTER TABLE Ca_Locale ADD [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_Locale_Code
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LocaleCode')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [Constraint_Ca_LocaleCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LocaleCode')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [UniqueNonclustered_Ca_LocaleCode]
    END

-- [Ca_Locale.Lang] -------------


-- [Ca_Locale.Lang] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Locale') AND name='Lang')
    BEGIN
     ALTER TABLE Ca_Locale ALTER COLUMN [Lang] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Locale_Lang NVARCHAR(MAX);
    SET @sql_add_Ca_Locale_Lang = 'ALTER TABLE Ca_Locale ADD [Lang] BIGINT'
    EXEC sp_executesql @sql_add_Ca_Locale_Lang
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LocaleLang')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [Constraint_Ca_LocaleLang]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LocaleLang')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [UniqueNonclustered_Ca_LocaleLang]
    END

-- [Ca_Locale.Zh] -------------


-- [Ca_Locale.Zh] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Locale') AND name='Zh')
    BEGIN
     ALTER TABLE Ca_Locale ALTER COLUMN [Zh] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Locale_Zh NVARCHAR(MAX);
    SET @sql_add_Ca_Locale_Zh = 'ALTER TABLE Ca_Locale ADD [Zh] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Locale_Zh
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LocaleZh')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [Constraint_Ca_LocaleZh]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LocaleZh')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [UniqueNonclustered_Ca_LocaleZh]
    END

-- [Ca_Locale.Text] -------------


-- [Ca_Locale.Text] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_Locale') AND name='Text')
    BEGIN
     ALTER TABLE Ca_Locale ALTER COLUMN [Text] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_Locale_Text NVARCHAR(MAX);
    SET @sql_add_Ca_Locale_Text = 'ALTER TABLE Ca_Locale ADD [Text] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_Locale_Text
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_LocaleText')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [Constraint_Ca_LocaleText]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_LocaleText')
    BEGIN
    ALTER TABLE Ca_Locale DROP  CONSTRAINT [UniqueNonclustered_Ca_LocaleText]
    END
-- [Ca_SpecialItem] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_SpecialItem' AND xtype='U')

BEGIN

    CREATE TABLE Ca_SpecialItem ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Type] INT
        ,[Lang] BIGINT
        ,[Bind] BIGINT
, CONSTRAINT [PK_Ca_SpecialItem] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_SpecialItem NVARCHAR(64)
DECLARE cursor_Ca_SpecialItem CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_SpecialItem') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Type','Lang','Bind'))

OPEN cursor_Ca_SpecialItem
FETCH NEXT FROM cursor_Ca_SpecialItem INTO @name_Ca_SpecialItem

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_SpecialItem.' + @name_Ca_SpecialItem;
    
    DECLARE @sql_Ca_SpecialItem NVARCHAR(MAX);
    SET @sql_Ca_SpecialItem = 'ALTER TABLE Ca_SpecialItem DROP COLUMN ' + QUOTENAME(@name_Ca_SpecialItem)
    EXEC sp_executesql @sql_Ca_SpecialItem
    
    
    FETCH NEXT FROM cursor_Ca_SpecialItem INTO @name_Ca_SpecialItem
END

CLOSE cursor_Ca_SpecialItem;
DEALLOCATE cursor_Ca_SpecialItem;


-- [Ca_SpecialItem.Type] -------------


-- [Ca_SpecialItem.Type] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_SpecialItem') AND name='Type')
    BEGIN
     ALTER TABLE Ca_SpecialItem ALTER COLUMN [Type] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_SpecialItem_Type NVARCHAR(MAX);
    SET @sql_add_Ca_SpecialItem_Type = 'ALTER TABLE Ca_SpecialItem ADD [Type] INT'
    EXEC sp_executesql @sql_add_Ca_SpecialItem_Type
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_SpecialItemType')
    BEGIN
    ALTER TABLE Ca_SpecialItem DROP  CONSTRAINT [Constraint_Ca_SpecialItemType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_SpecialItemType')
    BEGIN
    ALTER TABLE Ca_SpecialItem DROP  CONSTRAINT [UniqueNonclustered_Ca_SpecialItemType]
    END

-- [Ca_SpecialItem.Lang] -------------


-- [Ca_SpecialItem.Lang] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_SpecialItem') AND name='Lang')
    BEGIN
     ALTER TABLE Ca_SpecialItem ALTER COLUMN [Lang] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_SpecialItem_Lang NVARCHAR(MAX);
    SET @sql_add_Ca_SpecialItem_Lang = 'ALTER TABLE Ca_SpecialItem ADD [Lang] BIGINT'
    EXEC sp_executesql @sql_add_Ca_SpecialItem_Lang
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_SpecialItemLang')
    BEGIN
    ALTER TABLE Ca_SpecialItem DROP  CONSTRAINT [Constraint_Ca_SpecialItemLang]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_SpecialItemLang')
    BEGIN
    ALTER TABLE Ca_SpecialItem DROP  CONSTRAINT [UniqueNonclustered_Ca_SpecialItemLang]
    END

-- [Ca_SpecialItem.Bind] -------------


-- [Ca_SpecialItem.Bind] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_SpecialItem') AND name='Bind')
    BEGIN
     ALTER TABLE Ca_SpecialItem ALTER COLUMN [Bind] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_SpecialItem_Bind NVARCHAR(MAX);
    SET @sql_add_Ca_SpecialItem_Bind = 'ALTER TABLE Ca_SpecialItem ADD [Bind] BIGINT'
    EXEC sp_executesql @sql_add_Ca_SpecialItem_Bind
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_SpecialItemBind')
    BEGIN
    ALTER TABLE Ca_SpecialItem DROP  CONSTRAINT [Constraint_Ca_SpecialItemBind]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_SpecialItemBind')
    BEGIN
    ALTER TABLE Ca_SpecialItem DROP  CONSTRAINT [UniqueNonclustered_Ca_SpecialItemBind]
    END
-- [Ca_WebCredential] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Ca_WebCredential' AND xtype='U')

BEGIN

    CREATE TABLE Ca_WebCredential ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[ExternalId] BIGINT
        ,[Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
        ,[EU] BIGINT
        ,[Biz] BIGINT
        ,[Json] NVARCHAR(MAX)
, CONSTRAINT [PK_Ca_WebCredential] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Ca_WebCredential NVARCHAR(64)
DECLARE cursor_Ca_WebCredential CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Ca_WebCredential') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','ExternalId','Icon','EU','Biz','Json'))

OPEN cursor_Ca_WebCredential
FETCH NEXT FROM cursor_Ca_WebCredential INTO @name_Ca_WebCredential

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Ca_WebCredential.' + @name_Ca_WebCredential;
    
    DECLARE @sql_Ca_WebCredential NVARCHAR(MAX);
    SET @sql_Ca_WebCredential = 'ALTER TABLE Ca_WebCredential DROP COLUMN ' + QUOTENAME(@name_Ca_WebCredential)
    EXEC sp_executesql @sql_Ca_WebCredential
    
    
    FETCH NEXT FROM cursor_Ca_WebCredential INTO @name_Ca_WebCredential
END

CLOSE cursor_Ca_WebCredential;
DEALLOCATE cursor_Ca_WebCredential;


-- [Ca_WebCredential.Caption] -------------


-- [Ca_WebCredential.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_WebCredential') AND name='Caption')
    BEGIN
     ALTER TABLE Ca_WebCredential ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_WebCredential_Caption NVARCHAR(MAX);
    SET @sql_add_Ca_WebCredential_Caption = 'ALTER TABLE Ca_WebCredential ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_WebCredential_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_WebCredentialCaption')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [Constraint_Ca_WebCredentialCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_WebCredentialCaption')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [UniqueNonclustered_Ca_WebCredentialCaption]
    END

-- [Ca_WebCredential.ExternalId] -------------


-- [Ca_WebCredential.ExternalId] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_WebCredential') AND name='ExternalId')
    BEGIN
     ALTER TABLE Ca_WebCredential ALTER COLUMN [ExternalId] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_WebCredential_ExternalId NVARCHAR(MAX);
    SET @sql_add_Ca_WebCredential_ExternalId = 'ALTER TABLE Ca_WebCredential ADD [ExternalId] BIGINT'
    EXEC sp_executesql @sql_add_Ca_WebCredential_ExternalId
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_WebCredentialExternalId')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [Constraint_Ca_WebCredentialExternalId]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_WebCredentialExternalId')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [UniqueNonclustered_Ca_WebCredentialExternalId]
    END

-- [Ca_WebCredential.Icon] -------------


-- [Ca_WebCredential.Icon] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_WebCredential') AND name='Icon')
    BEGIN
     ALTER TABLE Ca_WebCredential ALTER COLUMN [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_WebCredential_Icon NVARCHAR(MAX);
    SET @sql_add_Ca_WebCredential_Icon = 'ALTER TABLE Ca_WebCredential ADD [Icon] NVARCHAR(256) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Ca_WebCredential_Icon
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_WebCredentialIcon')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [Constraint_Ca_WebCredentialIcon]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_WebCredentialIcon')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [UniqueNonclustered_Ca_WebCredentialIcon]
    END

-- [Ca_WebCredential.EU] -------------


-- [Ca_WebCredential.EU] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_WebCredential') AND name='EU')
    BEGIN
     ALTER TABLE Ca_WebCredential ALTER COLUMN [EU] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_WebCredential_EU NVARCHAR(MAX);
    SET @sql_add_Ca_WebCredential_EU = 'ALTER TABLE Ca_WebCredential ADD [EU] BIGINT'
    EXEC sp_executesql @sql_add_Ca_WebCredential_EU
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_WebCredentialEU')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [Constraint_Ca_WebCredentialEU]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_WebCredentialEU')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [UniqueNonclustered_Ca_WebCredentialEU]
    END

-- [Ca_WebCredential.Biz] -------------


-- [Ca_WebCredential.Biz] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_WebCredential') AND name='Biz')
    BEGIN
     ALTER TABLE Ca_WebCredential ALTER COLUMN [Biz] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_WebCredential_Biz NVARCHAR(MAX);
    SET @sql_add_Ca_WebCredential_Biz = 'ALTER TABLE Ca_WebCredential ADD [Biz] BIGINT'
    EXEC sp_executesql @sql_add_Ca_WebCredential_Biz
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_WebCredentialBiz')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [Constraint_Ca_WebCredentialBiz]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_WebCredentialBiz')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [UniqueNonclustered_Ca_WebCredentialBiz]
    END

-- [Ca_WebCredential.Json] -------------


-- [Ca_WebCredential.Json] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Ca_WebCredential') AND name='Json')
    BEGIN
     ALTER TABLE Ca_WebCredential ALTER COLUMN [Json] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Ca_WebCredential_Json NVARCHAR(MAX);
    SET @sql_add_Ca_WebCredential_Json = 'ALTER TABLE Ca_WebCredential ADD [Json] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Ca_WebCredential_Json
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Ca_WebCredentialJson')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [Constraint_Ca_WebCredentialJson]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Ca_WebCredentialJson')
    BEGIN
    ALTER TABLE Ca_WebCredential DROP  CONSTRAINT [UniqueNonclustered_Ca_WebCredentialJson]
    END
-- [Market_Instrument] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Market_Instrument' AND xtype='U')

BEGIN

    CREATE TABLE Market_Instrument ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [DescTxt] NVARCHAR(MAX)
        ,[Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Long] BIGINT
        ,[LongCode] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
        ,[Short] BIGINT
        ,[ShortCode] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
, CONSTRAINT [PK_Market_Instrument] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Market_Instrument NVARCHAR(64)
DECLARE cursor_Market_Instrument CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','DescTxt','Code','Caption','Long','LongCode','Short','ShortCode'))

OPEN cursor_Market_Instrument
FETCH NEXT FROM cursor_Market_Instrument INTO @name_Market_Instrument

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Market_Instrument.' + @name_Market_Instrument;
    
    DECLARE @sql_Market_Instrument NVARCHAR(MAX);
    SET @sql_Market_Instrument = 'ALTER TABLE Market_Instrument DROP COLUMN ' + QUOTENAME(@name_Market_Instrument)
    EXEC sp_executesql @sql_Market_Instrument
    
    
    FETCH NEXT FROM cursor_Market_Instrument INTO @name_Market_Instrument
END

CLOSE cursor_Market_Instrument;
DEALLOCATE cursor_Market_Instrument;


-- [Market_Instrument.DescTxt] -------------


-- [Market_Instrument.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND name='DescTxt')
    BEGIN
     ALTER TABLE Market_Instrument ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Instrument_DescTxt NVARCHAR(MAX);
    SET @sql_add_Market_Instrument_DescTxt = 'ALTER TABLE Market_Instrument ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Market_Instrument_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_InstrumentDescTxt')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [Constraint_Market_InstrumentDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_InstrumentDescTxt')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [UniqueNonclustered_Market_InstrumentDescTxt]
    END

-- [Market_Instrument.Code] -------------


-- [Market_Instrument.Code] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND name='Code')
    BEGIN
     ALTER TABLE Market_Instrument ALTER COLUMN [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Instrument_Code NVARCHAR(MAX);
    SET @sql_add_Market_Instrument_Code = 'ALTER TABLE Market_Instrument ADD [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_Instrument_Code
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_InstrumentCode')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [Constraint_Market_InstrumentCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_InstrumentCode')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [UniqueNonclustered_Market_InstrumentCode]
    END

-- [Market_Instrument.Caption] -------------


-- [Market_Instrument.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND name='Caption')
    BEGIN
     ALTER TABLE Market_Instrument ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Instrument_Caption NVARCHAR(MAX);
    SET @sql_add_Market_Instrument_Caption = 'ALTER TABLE Market_Instrument ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_Instrument_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_InstrumentCaption')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [Constraint_Market_InstrumentCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_InstrumentCaption')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [UniqueNonclustered_Market_InstrumentCaption]
    END

-- [Market_Instrument.Long] -------------


-- [Market_Instrument.Long] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND name='Long')
    BEGIN
     ALTER TABLE Market_Instrument ALTER COLUMN [Long] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Instrument_Long NVARCHAR(MAX);
    SET @sql_add_Market_Instrument_Long = 'ALTER TABLE Market_Instrument ADD [Long] BIGINT'
    EXEC sp_executesql @sql_add_Market_Instrument_Long
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_InstrumentLong')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [Constraint_Market_InstrumentLong]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_InstrumentLong')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [UniqueNonclustered_Market_InstrumentLong]
    END

-- [Market_Instrument.LongCode] -------------


-- [Market_Instrument.LongCode] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND name='LongCode')
    BEGIN
     ALTER TABLE Market_Instrument ALTER COLUMN [LongCode] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Instrument_LongCode NVARCHAR(MAX);
    SET @sql_add_Market_Instrument_LongCode = 'ALTER TABLE Market_Instrument ADD [LongCode] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_Instrument_LongCode
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_InstrumentLongCode')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [Constraint_Market_InstrumentLongCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_InstrumentLongCode')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [UniqueNonclustered_Market_InstrumentLongCode]
    END

-- [Market_Instrument.Short] -------------


-- [Market_Instrument.Short] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND name='Short')
    BEGIN
     ALTER TABLE Market_Instrument ALTER COLUMN [Short] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Instrument_Short NVARCHAR(MAX);
    SET @sql_add_Market_Instrument_Short = 'ALTER TABLE Market_Instrument ADD [Short] BIGINT'
    EXEC sp_executesql @sql_add_Market_Instrument_Short
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_InstrumentShort')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [Constraint_Market_InstrumentShort]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_InstrumentShort')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [UniqueNonclustered_Market_InstrumentShort]
    END

-- [Market_Instrument.ShortCode] -------------


-- [Market_Instrument.ShortCode] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Instrument') AND name='ShortCode')
    BEGIN
     ALTER TABLE Market_Instrument ALTER COLUMN [ShortCode] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Instrument_ShortCode NVARCHAR(MAX);
    SET @sql_add_Market_Instrument_ShortCode = 'ALTER TABLE Market_Instrument ADD [ShortCode] NVARCHAR(16) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_Instrument_ShortCode
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_InstrumentShortCode')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [Constraint_Market_InstrumentShortCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_InstrumentShortCode')
    BEGIN
    ALTER TABLE Market_Instrument DROP  CONSTRAINT [UniqueNonclustered_Market_InstrumentShortCode]
    END
-- [Market_Ticket] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Market_Ticket' AND xtype='U')

BEGIN

    CREATE TABLE Market_Ticket ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [EndUser] BIGINT
        ,[TradeAcct] BIGINT
        ,[Ins] BIGINT
        ,[Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[TradeMode] INT
        ,[Lot] BIGINT
        ,[PriceOpened] BIGINT
        ,[PriceOpen] BIGINT
        ,[PriceSL] BIGINT
        ,[PriceTP] BIGINT
        ,[PriceClose] BIGINT
        ,[Status] INT
        ,[CP] BIGINT
        ,[CptAcct] BIGINT
        ,[Ref] BIGINT
        ,[OpenRef] BIGINT
        ,[CloseRef] BIGINT
        ,[Origin] BIGINT
        ,[PnL] FLOAT
        ,[PnLSpread] FLOAT
        ,[Margin] FLOAT
        ,[RO] FLOAT
        ,[Tax] FLOAT
        ,[CloseType] INT
        ,[CommitType] INT
        ,[Cmt] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Opendat] BIGINT
        ,[Closedat] BIGINT
        ,[CaStrategyAmt] FLOAT
        ,[CaRo] BIT
        ,[CaAsa] BIT
        ,[CaCmphsvCharge] FLOAT
        ,[RoCheckedat] BIGINT
        ,[Expiry] BIGINT
        ,[HedgetCP] BIGINT
        ,[PendingPrice] BIGINT
        ,[ClosedLot] BIGINT
        ,[ClosedAmt] FLOAT
        ,[PendingAmt] FLOAT
        ,[DrvPreminum] FLOAT
        ,[DrvExpiry] BIGINT
        ,[DrvPeriod] BIGINT
        ,[DrvDirection] INT
        ,[DrvPrice] FLOAT
        ,[DoubleCp] BIGINT
        ,[ClearStatus] INT
        ,[FollowTicket] BIGINT
        ,[Config] NVARCHAR(MAX)
        ,[OptionStatus] INT
        ,[NotionalPrincipal] FLOAT
        ,[ExercisedPrincipal] FLOAT
        ,[ExerciseMode] FLOAT
        ,[ExercisePrice] FLOAT
        ,[ExternalTicketOpen] BIGINT
        ,[ExternalTicketClose] BIGINT
        ,[ExternalTicketPending] BIGINT
        ,[ExternalTicketCancel] BIGINT
        ,[DescTxt] NVARCHAR(MAX)
, CONSTRAINT [PK_Market_Ticket] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Market_Ticket NVARCHAR(64)
DECLARE cursor_Market_Ticket CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','EndUser','TradeAcct','Ins','Code','Caption','TradeMode','Lot','PriceOpened','PriceOpen','PriceSL','PriceTP','PriceClose','Status','CP','CptAcct','Ref','OpenRef','CloseRef','Origin','PnL','PnLSpread','Margin','RO','Tax','CloseType','CommitType','Cmt','Opendat','Closedat','CaStrategyAmt','CaRo','CaAsa','CaCmphsvCharge','RoCheckedat','Expiry','HedgetCP','PendingPrice','ClosedLot','ClosedAmt','PendingAmt','DrvPreminum','DrvExpiry','DrvPeriod','DrvDirection','DrvPrice','DoubleCp','ClearStatus','FollowTicket','Config','OptionStatus','NotionalPrincipal','ExercisedPrincipal','ExerciseMode','ExercisePrice','ExternalTicketOpen','ExternalTicketClose','ExternalTicketPending','ExternalTicketCancel','DescTxt'))

OPEN cursor_Market_Ticket
FETCH NEXT FROM cursor_Market_Ticket INTO @name_Market_Ticket

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Market_Ticket.' + @name_Market_Ticket;
    
    DECLARE @sql_Market_Ticket NVARCHAR(MAX);
    SET @sql_Market_Ticket = 'ALTER TABLE Market_Ticket DROP COLUMN ' + QUOTENAME(@name_Market_Ticket)
    EXEC sp_executesql @sql_Market_Ticket
    
    
    FETCH NEXT FROM cursor_Market_Ticket INTO @name_Market_Ticket
END

CLOSE cursor_Market_Ticket;
DEALLOCATE cursor_Market_Ticket;


-- [Market_Ticket.EndUser] -------------


-- [Market_Ticket.EndUser] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='EndUser')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [EndUser] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_EndUser NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_EndUser = 'ALTER TABLE Market_Ticket ADD [EndUser] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_EndUser
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketEndUser')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketEndUser]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketEndUser')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketEndUser]
    END

-- [Market_Ticket.TradeAcct] -------------


-- [Market_Ticket.TradeAcct] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='TradeAcct')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [TradeAcct] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_TradeAcct NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_TradeAcct = 'ALTER TABLE Market_Ticket ADD [TradeAcct] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_TradeAcct
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketTradeAcct')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketTradeAcct]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketTradeAcct')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketTradeAcct]
    END

-- [Market_Ticket.Ins] -------------


-- [Market_Ticket.Ins] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Ins')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Ins] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Ins NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Ins = 'ALTER TABLE Market_Ticket ADD [Ins] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_Ins
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketIns')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketIns]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketIns')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketIns]
    END

-- [Market_Ticket.Code] -------------


-- [Market_Ticket.Code] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Code')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Code NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Code = 'ALTER TABLE Market_Ticket ADD [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_Ticket_Code
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCode')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCode')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCode]
    END

-- [Market_Ticket.Caption] -------------


-- [Market_Ticket.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Caption')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Caption NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Caption = 'ALTER TABLE Market_Ticket ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_Ticket_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCaption')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCaption')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCaption]
    END

-- [Market_Ticket.TradeMode] -------------


-- [Market_Ticket.TradeMode] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='TradeMode')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [TradeMode] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_TradeMode NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_TradeMode = 'ALTER TABLE Market_Ticket ADD [TradeMode] INT'
    EXEC sp_executesql @sql_add_Market_Ticket_TradeMode
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketTradeMode')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketTradeMode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketTradeMode')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketTradeMode]
    END

-- [Market_Ticket.Lot] -------------


-- [Market_Ticket.Lot] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Lot')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Lot] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Lot NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Lot = 'ALTER TABLE Market_Ticket ADD [Lot] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_Lot
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketLot')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketLot]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketLot')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketLot]
    END

-- [Market_Ticket.PriceOpened] -------------


-- [Market_Ticket.PriceOpened] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PriceOpened')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PriceOpened] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PriceOpened NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PriceOpened = 'ALTER TABLE Market_Ticket ADD [PriceOpened] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_PriceOpened
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPriceOpened')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPriceOpened]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPriceOpened')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPriceOpened]
    END

-- [Market_Ticket.PriceOpen] -------------


-- [Market_Ticket.PriceOpen] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PriceOpen')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PriceOpen] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PriceOpen NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PriceOpen = 'ALTER TABLE Market_Ticket ADD [PriceOpen] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_PriceOpen
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPriceOpen')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPriceOpen]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPriceOpen')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPriceOpen]
    END

-- [Market_Ticket.PriceSL] -------------


-- [Market_Ticket.PriceSL] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PriceSL')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PriceSL] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PriceSL NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PriceSL = 'ALTER TABLE Market_Ticket ADD [PriceSL] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_PriceSL
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPriceSL')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPriceSL]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPriceSL')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPriceSL]
    END

-- [Market_Ticket.PriceTP] -------------


-- [Market_Ticket.PriceTP] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PriceTP')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PriceTP] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PriceTP NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PriceTP = 'ALTER TABLE Market_Ticket ADD [PriceTP] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_PriceTP
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPriceTP')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPriceTP]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPriceTP')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPriceTP]
    END

-- [Market_Ticket.PriceClose] -------------


-- [Market_Ticket.PriceClose] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PriceClose')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PriceClose] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PriceClose NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PriceClose = 'ALTER TABLE Market_Ticket ADD [PriceClose] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_PriceClose
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPriceClose')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPriceClose]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPriceClose')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPriceClose]
    END

-- [Market_Ticket.Status] -------------


-- [Market_Ticket.Status] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Status')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Status] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Status NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Status = 'ALTER TABLE Market_Ticket ADD [Status] INT'
    EXEC sp_executesql @sql_add_Market_Ticket_Status
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketStatus')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketStatus]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketStatus')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketStatus]
    END

-- [Market_Ticket.CP] -------------


-- [Market_Ticket.CP] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CP')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CP] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CP NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CP = 'ALTER TABLE Market_Ticket ADD [CP] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_CP
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCP')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCP]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCP')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCP]
    END

-- [Market_Ticket.CptAcct] -------------


-- [Market_Ticket.CptAcct] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CptAcct')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CptAcct] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CptAcct NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CptAcct = 'ALTER TABLE Market_Ticket ADD [CptAcct] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_CptAcct
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCptAcct')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCptAcct]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCptAcct')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCptAcct]
    END

-- [Market_Ticket.Ref] -------------


-- [Market_Ticket.Ref] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Ref')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Ref] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Ref NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Ref = 'ALTER TABLE Market_Ticket ADD [Ref] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_Ref
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketRef')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketRef]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketRef')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketRef]
    END

-- [Market_Ticket.OpenRef] -------------


-- [Market_Ticket.OpenRef] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='OpenRef')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [OpenRef] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_OpenRef NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_OpenRef = 'ALTER TABLE Market_Ticket ADD [OpenRef] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_OpenRef
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketOpenRef')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketOpenRef]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketOpenRef')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketOpenRef]
    END

-- [Market_Ticket.CloseRef] -------------


-- [Market_Ticket.CloseRef] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CloseRef')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CloseRef] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CloseRef NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CloseRef = 'ALTER TABLE Market_Ticket ADD [CloseRef] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_CloseRef
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCloseRef')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCloseRef]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCloseRef')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCloseRef]
    END

-- [Market_Ticket.Origin] -------------


-- [Market_Ticket.Origin] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Origin')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Origin] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Origin NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Origin = 'ALTER TABLE Market_Ticket ADD [Origin] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_Origin
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketOrigin')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketOrigin]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketOrigin')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketOrigin]
    END

-- [Market_Ticket.PnL] -------------


-- [Market_Ticket.PnL] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PnL')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PnL] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PnL NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PnL = 'ALTER TABLE Market_Ticket ADD [PnL] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_PnL
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPnL')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPnL]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPnL')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPnL]
    END

-- [Market_Ticket.PnLSpread] -------------


-- [Market_Ticket.PnLSpread] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PnLSpread')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PnLSpread] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PnLSpread NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PnLSpread = 'ALTER TABLE Market_Ticket ADD [PnLSpread] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_PnLSpread
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPnLSpread')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPnLSpread]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPnLSpread')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPnLSpread]
    END

-- [Market_Ticket.Margin] -------------


-- [Market_Ticket.Margin] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Margin')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Margin] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Margin NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Margin = 'ALTER TABLE Market_Ticket ADD [Margin] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_Margin
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketMargin')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketMargin]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketMargin')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketMargin]
    END

-- [Market_Ticket.RO] -------------


-- [Market_Ticket.RO] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='RO')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [RO] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_RO NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_RO = 'ALTER TABLE Market_Ticket ADD [RO] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_RO
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketRO')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketRO]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketRO')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketRO]
    END

-- [Market_Ticket.Tax] -------------


-- [Market_Ticket.Tax] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Tax')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Tax] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Tax NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Tax = 'ALTER TABLE Market_Ticket ADD [Tax] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_Tax
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketTax')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketTax]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketTax')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketTax]
    END

-- [Market_Ticket.CloseType] -------------


-- [Market_Ticket.CloseType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CloseType')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CloseType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CloseType NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CloseType = 'ALTER TABLE Market_Ticket ADD [CloseType] INT'
    EXEC sp_executesql @sql_add_Market_Ticket_CloseType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCloseType')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCloseType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCloseType')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCloseType]
    END

-- [Market_Ticket.CommitType] -------------


-- [Market_Ticket.CommitType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CommitType')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CommitType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CommitType NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CommitType = 'ALTER TABLE Market_Ticket ADD [CommitType] INT'
    EXEC sp_executesql @sql_add_Market_Ticket_CommitType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCommitType')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCommitType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCommitType')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCommitType]
    END

-- [Market_Ticket.Cmt] -------------


-- [Market_Ticket.Cmt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Cmt')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Cmt] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Cmt NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Cmt = 'ALTER TABLE Market_Ticket ADD [Cmt] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_Ticket_Cmt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCmt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCmt]
    END

-- [Market_Ticket.Opendat] -------------


-- [Market_Ticket.Opendat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Opendat')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Opendat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Opendat NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Opendat = 'ALTER TABLE Market_Ticket ADD [Opendat] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_Opendat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketOpendat')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketOpendat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketOpendat')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketOpendat]
    END

-- [Market_Ticket.Closedat] -------------


-- [Market_Ticket.Closedat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Closedat')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Closedat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Closedat NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Closedat = 'ALTER TABLE Market_Ticket ADD [Closedat] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_Closedat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketClosedat')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketClosedat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketClosedat')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketClosedat]
    END

-- [Market_Ticket.CaStrategyAmt] -------------


-- [Market_Ticket.CaStrategyAmt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CaStrategyAmt')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CaStrategyAmt] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CaStrategyAmt NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CaStrategyAmt = 'ALTER TABLE Market_Ticket ADD [CaStrategyAmt] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_CaStrategyAmt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCaStrategyAmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCaStrategyAmt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCaStrategyAmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCaStrategyAmt]
    END

-- [Market_Ticket.CaRo] -------------


-- [Market_Ticket.CaRo] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CaRo')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CaRo] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CaRo NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CaRo = 'ALTER TABLE Market_Ticket ADD [CaRo] BIT'
    EXEC sp_executesql @sql_add_Market_Ticket_CaRo
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCaRo')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCaRo]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCaRo')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCaRo]
    END

-- [Market_Ticket.CaAsa] -------------


-- [Market_Ticket.CaAsa] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CaAsa')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CaAsa] BIT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CaAsa NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CaAsa = 'ALTER TABLE Market_Ticket ADD [CaAsa] BIT'
    EXEC sp_executesql @sql_add_Market_Ticket_CaAsa
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCaAsa')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCaAsa]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCaAsa')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCaAsa]
    END

-- [Market_Ticket.CaCmphsvCharge] -------------


-- [Market_Ticket.CaCmphsvCharge] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='CaCmphsvCharge')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [CaCmphsvCharge] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_CaCmphsvCharge NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_CaCmphsvCharge = 'ALTER TABLE Market_Ticket ADD [CaCmphsvCharge] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_CaCmphsvCharge
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketCaCmphsvCharge')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketCaCmphsvCharge]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketCaCmphsvCharge')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketCaCmphsvCharge]
    END

-- [Market_Ticket.RoCheckedat] -------------


-- [Market_Ticket.RoCheckedat] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='RoCheckedat')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [RoCheckedat] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_RoCheckedat NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_RoCheckedat = 'ALTER TABLE Market_Ticket ADD [RoCheckedat] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_RoCheckedat
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketRoCheckedat')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketRoCheckedat]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketRoCheckedat')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketRoCheckedat]
    END

-- [Market_Ticket.Expiry] -------------


-- [Market_Ticket.Expiry] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Expiry')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Expiry] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Expiry NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Expiry = 'ALTER TABLE Market_Ticket ADD [Expiry] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_Expiry
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExpiry')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExpiry]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExpiry')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExpiry]
    END

-- [Market_Ticket.HedgetCP] -------------


-- [Market_Ticket.HedgetCP] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='HedgetCP')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [HedgetCP] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_HedgetCP NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_HedgetCP = 'ALTER TABLE Market_Ticket ADD [HedgetCP] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_HedgetCP
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketHedgetCP')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketHedgetCP]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketHedgetCP')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketHedgetCP]
    END

-- [Market_Ticket.PendingPrice] -------------


-- [Market_Ticket.PendingPrice] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PendingPrice')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PendingPrice] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PendingPrice NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PendingPrice = 'ALTER TABLE Market_Ticket ADD [PendingPrice] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_PendingPrice
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPendingPrice')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPendingPrice]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPendingPrice')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPendingPrice]
    END

-- [Market_Ticket.ClosedLot] -------------


-- [Market_Ticket.ClosedLot] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ClosedLot')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ClosedLot] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ClosedLot NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ClosedLot = 'ALTER TABLE Market_Ticket ADD [ClosedLot] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_ClosedLot
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketClosedLot')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketClosedLot]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketClosedLot')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketClosedLot]
    END

-- [Market_Ticket.ClosedAmt] -------------


-- [Market_Ticket.ClosedAmt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ClosedAmt')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ClosedAmt] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ClosedAmt NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ClosedAmt = 'ALTER TABLE Market_Ticket ADD [ClosedAmt] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_ClosedAmt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketClosedAmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketClosedAmt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketClosedAmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketClosedAmt]
    END

-- [Market_Ticket.PendingAmt] -------------


-- [Market_Ticket.PendingAmt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='PendingAmt')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [PendingAmt] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_PendingAmt NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_PendingAmt = 'ALTER TABLE Market_Ticket ADD [PendingAmt] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_PendingAmt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketPendingAmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketPendingAmt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketPendingAmt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketPendingAmt]
    END

-- [Market_Ticket.DrvPreminum] -------------


-- [Market_Ticket.DrvPreminum] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='DrvPreminum')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [DrvPreminum] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_DrvPreminum NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_DrvPreminum = 'ALTER TABLE Market_Ticket ADD [DrvPreminum] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_DrvPreminum
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketDrvPreminum')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketDrvPreminum]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketDrvPreminum')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketDrvPreminum]
    END

-- [Market_Ticket.DrvExpiry] -------------


-- [Market_Ticket.DrvExpiry] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='DrvExpiry')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [DrvExpiry] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_DrvExpiry NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_DrvExpiry = 'ALTER TABLE Market_Ticket ADD [DrvExpiry] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_DrvExpiry
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketDrvExpiry')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketDrvExpiry]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketDrvExpiry')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketDrvExpiry]
    END

-- [Market_Ticket.DrvPeriod] -------------


-- [Market_Ticket.DrvPeriod] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='DrvPeriod')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [DrvPeriod] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_DrvPeriod NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_DrvPeriod = 'ALTER TABLE Market_Ticket ADD [DrvPeriod] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_DrvPeriod
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketDrvPeriod')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketDrvPeriod]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketDrvPeriod')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketDrvPeriod]
    END

-- [Market_Ticket.DrvDirection] -------------


-- [Market_Ticket.DrvDirection] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='DrvDirection')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [DrvDirection] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_DrvDirection NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_DrvDirection = 'ALTER TABLE Market_Ticket ADD [DrvDirection] INT'
    EXEC sp_executesql @sql_add_Market_Ticket_DrvDirection
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketDrvDirection')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketDrvDirection]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketDrvDirection')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketDrvDirection]
    END

-- [Market_Ticket.DrvPrice] -------------


-- [Market_Ticket.DrvPrice] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='DrvPrice')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [DrvPrice] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_DrvPrice NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_DrvPrice = 'ALTER TABLE Market_Ticket ADD [DrvPrice] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_DrvPrice
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketDrvPrice')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketDrvPrice]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketDrvPrice')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketDrvPrice]
    END

-- [Market_Ticket.DoubleCp] -------------


-- [Market_Ticket.DoubleCp] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='DoubleCp')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [DoubleCp] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_DoubleCp NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_DoubleCp = 'ALTER TABLE Market_Ticket ADD [DoubleCp] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_DoubleCp
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketDoubleCp')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketDoubleCp]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketDoubleCp')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketDoubleCp]
    END

-- [Market_Ticket.ClearStatus] -------------


-- [Market_Ticket.ClearStatus] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ClearStatus')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ClearStatus] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ClearStatus NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ClearStatus = 'ALTER TABLE Market_Ticket ADD [ClearStatus] INT'
    EXEC sp_executesql @sql_add_Market_Ticket_ClearStatus
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketClearStatus')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketClearStatus]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketClearStatus')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketClearStatus]
    END

-- [Market_Ticket.FollowTicket] -------------


-- [Market_Ticket.FollowTicket] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='FollowTicket')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [FollowTicket] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_FollowTicket NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_FollowTicket = 'ALTER TABLE Market_Ticket ADD [FollowTicket] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_FollowTicket
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketFollowTicket')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketFollowTicket]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketFollowTicket')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketFollowTicket]
    END

-- [Market_Ticket.Config] -------------


-- [Market_Ticket.Config] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='Config')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [Config] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_Config NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_Config = 'ALTER TABLE Market_Ticket ADD [Config] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Market_Ticket_Config
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketConfig')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketConfig]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketConfig')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketConfig]
    END

-- [Market_Ticket.OptionStatus] -------------


-- [Market_Ticket.OptionStatus] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='OptionStatus')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [OptionStatus] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_OptionStatus NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_OptionStatus = 'ALTER TABLE Market_Ticket ADD [OptionStatus] INT'
    EXEC sp_executesql @sql_add_Market_Ticket_OptionStatus
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketOptionStatus')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketOptionStatus]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketOptionStatus')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketOptionStatus]
    END

-- [Market_Ticket.NotionalPrincipal] -------------


-- [Market_Ticket.NotionalPrincipal] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='NotionalPrincipal')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [NotionalPrincipal] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_NotionalPrincipal NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_NotionalPrincipal = 'ALTER TABLE Market_Ticket ADD [NotionalPrincipal] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_NotionalPrincipal
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketNotionalPrincipal')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketNotionalPrincipal]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketNotionalPrincipal')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketNotionalPrincipal]
    END

-- [Market_Ticket.ExercisedPrincipal] -------------


-- [Market_Ticket.ExercisedPrincipal] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ExercisedPrincipal')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ExercisedPrincipal] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ExercisedPrincipal NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ExercisedPrincipal = 'ALTER TABLE Market_Ticket ADD [ExercisedPrincipal] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_ExercisedPrincipal
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExercisedPrincipal')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExercisedPrincipal]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExercisedPrincipal')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExercisedPrincipal]
    END

-- [Market_Ticket.ExerciseMode] -------------


-- [Market_Ticket.ExerciseMode] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ExerciseMode')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ExerciseMode] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ExerciseMode NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ExerciseMode = 'ALTER TABLE Market_Ticket ADD [ExerciseMode] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_ExerciseMode
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExerciseMode')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExerciseMode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExerciseMode')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExerciseMode]
    END

-- [Market_Ticket.ExercisePrice] -------------


-- [Market_Ticket.ExercisePrice] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ExercisePrice')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ExercisePrice] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ExercisePrice NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ExercisePrice = 'ALTER TABLE Market_Ticket ADD [ExercisePrice] FLOAT'
    EXEC sp_executesql @sql_add_Market_Ticket_ExercisePrice
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExercisePrice')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExercisePrice]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExercisePrice')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExercisePrice]
    END

-- [Market_Ticket.ExternalTicketOpen] -------------


-- [Market_Ticket.ExternalTicketOpen] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ExternalTicketOpen')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ExternalTicketOpen] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ExternalTicketOpen NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ExternalTicketOpen = 'ALTER TABLE Market_Ticket ADD [ExternalTicketOpen] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_ExternalTicketOpen
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExternalTicketOpen')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExternalTicketOpen]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExternalTicketOpen')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExternalTicketOpen]
    END

-- [Market_Ticket.ExternalTicketClose] -------------


-- [Market_Ticket.ExternalTicketClose] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ExternalTicketClose')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ExternalTicketClose] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ExternalTicketClose NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ExternalTicketClose = 'ALTER TABLE Market_Ticket ADD [ExternalTicketClose] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_ExternalTicketClose
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExternalTicketClose')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExternalTicketClose]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExternalTicketClose')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExternalTicketClose]
    END

-- [Market_Ticket.ExternalTicketPending] -------------


-- [Market_Ticket.ExternalTicketPending] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ExternalTicketPending')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ExternalTicketPending] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ExternalTicketPending NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ExternalTicketPending = 'ALTER TABLE Market_Ticket ADD [ExternalTicketPending] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_ExternalTicketPending
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExternalTicketPending')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExternalTicketPending]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExternalTicketPending')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExternalTicketPending]
    END

-- [Market_Ticket.ExternalTicketCancel] -------------


-- [Market_Ticket.ExternalTicketCancel] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='ExternalTicketCancel')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [ExternalTicketCancel] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_ExternalTicketCancel NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_ExternalTicketCancel = 'ALTER TABLE Market_Ticket ADD [ExternalTicketCancel] BIGINT'
    EXEC sp_executesql @sql_add_Market_Ticket_ExternalTicketCancel
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketExternalTicketCancel')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketExternalTicketCancel]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketExternalTicketCancel')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketExternalTicketCancel]
    END

-- [Market_Ticket.DescTxt] -------------


-- [Market_Ticket.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_Ticket') AND name='DescTxt')
    BEGIN
     ALTER TABLE Market_Ticket ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_Ticket_DescTxt NVARCHAR(MAX);
    SET @sql_add_Market_Ticket_DescTxt = 'ALTER TABLE Market_Ticket ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Market_Ticket_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TicketDescTxt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [Constraint_Market_TicketDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TicketDescTxt')
    BEGIN
    ALTER TABLE Market_Ticket DROP  CONSTRAINT [UniqueNonclustered_Market_TicketDescTxt]
    END
-- [Market_TradeAcct] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Market_TradeAcct' AND xtype='U')

BEGIN

    CREATE TABLE Market_TradeAcct ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [SAC] BIGINT
        ,[State] INT
        ,[TradeType] INT
        ,[RealDemo] INT
        ,[PnL] FLOAT
        ,[Frozen] FLOAT
        ,[Leverage] FLOAT
        ,[Margin] FLOAT
        ,[MarginCallRateWarning] FLOAT
        ,[MarginCallRateWarningII] FLOAT
        ,[MarginCallRateLiq] FLOAT
        ,[PwdTrade] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[PwdReadonly] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[DescTxt] NVARCHAR(MAX)
, CONSTRAINT [PK_Market_TradeAcct] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Market_TradeAcct NVARCHAR(64)
DECLARE cursor_Market_TradeAcct CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','SAC','State','TradeType','RealDemo','PnL','Frozen','Leverage','Margin','MarginCallRateWarning','MarginCallRateWarningII','MarginCallRateLiq','PwdTrade','PwdReadonly','DescTxt'))

OPEN cursor_Market_TradeAcct
FETCH NEXT FROM cursor_Market_TradeAcct INTO @name_Market_TradeAcct

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Market_TradeAcct.' + @name_Market_TradeAcct;
    
    DECLARE @sql_Market_TradeAcct NVARCHAR(MAX);
    SET @sql_Market_TradeAcct = 'ALTER TABLE Market_TradeAcct DROP COLUMN ' + QUOTENAME(@name_Market_TradeAcct)
    EXEC sp_executesql @sql_Market_TradeAcct
    
    
    FETCH NEXT FROM cursor_Market_TradeAcct INTO @name_Market_TradeAcct
END

CLOSE cursor_Market_TradeAcct;
DEALLOCATE cursor_Market_TradeAcct;


-- [Market_TradeAcct.SAC] -------------


-- [Market_TradeAcct.SAC] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='SAC')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [SAC] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_SAC NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_SAC = 'ALTER TABLE Market_TradeAcct ADD [SAC] BIGINT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_SAC
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctSAC')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctSAC]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctSAC')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctSAC]
    END

-- [Market_TradeAcct.State] -------------


-- [Market_TradeAcct.State] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='State')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [State] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_State NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_State = 'ALTER TABLE Market_TradeAcct ADD [State] INT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_State
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctState')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctState]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctState')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctState]
    END

-- [Market_TradeAcct.TradeType] -------------


-- [Market_TradeAcct.TradeType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='TradeType')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [TradeType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_TradeType NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_TradeType = 'ALTER TABLE Market_TradeAcct ADD [TradeType] INT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_TradeType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctTradeType')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctTradeType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctTradeType')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctTradeType]
    END

-- [Market_TradeAcct.RealDemo] -------------


-- [Market_TradeAcct.RealDemo] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='RealDemo')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [RealDemo] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_RealDemo NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_RealDemo = 'ALTER TABLE Market_TradeAcct ADD [RealDemo] INT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_RealDemo
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctRealDemo')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctRealDemo]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctRealDemo')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctRealDemo]
    END

-- [Market_TradeAcct.PnL] -------------


-- [Market_TradeAcct.PnL] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='PnL')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [PnL] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_PnL NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_PnL = 'ALTER TABLE Market_TradeAcct ADD [PnL] FLOAT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_PnL
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctPnL')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctPnL]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctPnL')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctPnL]
    END

-- [Market_TradeAcct.Frozen] -------------


-- [Market_TradeAcct.Frozen] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='Frozen')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [Frozen] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_Frozen NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_Frozen = 'ALTER TABLE Market_TradeAcct ADD [Frozen] FLOAT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_Frozen
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctFrozen')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctFrozen]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctFrozen')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctFrozen]
    END

-- [Market_TradeAcct.Leverage] -------------


-- [Market_TradeAcct.Leverage] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='Leverage')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [Leverage] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_Leverage NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_Leverage = 'ALTER TABLE Market_TradeAcct ADD [Leverage] FLOAT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_Leverage
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctLeverage')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctLeverage]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctLeverage')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctLeverage]
    END

-- [Market_TradeAcct.Margin] -------------


-- [Market_TradeAcct.Margin] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='Margin')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [Margin] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_Margin NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_Margin = 'ALTER TABLE Market_TradeAcct ADD [Margin] FLOAT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_Margin
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctMargin')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctMargin]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctMargin')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctMargin]
    END

-- [Market_TradeAcct.MarginCallRateWarning] -------------


-- [Market_TradeAcct.MarginCallRateWarning] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='MarginCallRateWarning')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [MarginCallRateWarning] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_MarginCallRateWarning NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_MarginCallRateWarning = 'ALTER TABLE Market_TradeAcct ADD [MarginCallRateWarning] FLOAT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_MarginCallRateWarning
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctMarginCallRateWarning')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctMarginCallRateWarning]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctMarginCallRateWarning')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctMarginCallRateWarning]
    END

-- [Market_TradeAcct.MarginCallRateWarningII] -------------


-- [Market_TradeAcct.MarginCallRateWarningII] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='MarginCallRateWarningII')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [MarginCallRateWarningII] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_MarginCallRateWarningII NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_MarginCallRateWarningII = 'ALTER TABLE Market_TradeAcct ADD [MarginCallRateWarningII] FLOAT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_MarginCallRateWarningII
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctMarginCallRateWarningII')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctMarginCallRateWarningII]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctMarginCallRateWarningII')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctMarginCallRateWarningII]
    END

-- [Market_TradeAcct.MarginCallRateLiq] -------------


-- [Market_TradeAcct.MarginCallRateLiq] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='MarginCallRateLiq')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [MarginCallRateLiq] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_MarginCallRateLiq NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_MarginCallRateLiq = 'ALTER TABLE Market_TradeAcct ADD [MarginCallRateLiq] FLOAT'
    EXEC sp_executesql @sql_add_Market_TradeAcct_MarginCallRateLiq
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctMarginCallRateLiq')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctMarginCallRateLiq]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctMarginCallRateLiq')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctMarginCallRateLiq]
    END

-- [Market_TradeAcct.PwdTrade] -------------


-- [Market_TradeAcct.PwdTrade] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='PwdTrade')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [PwdTrade] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_PwdTrade NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_PwdTrade = 'ALTER TABLE Market_TradeAcct ADD [PwdTrade] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_TradeAcct_PwdTrade
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctPwdTrade')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctPwdTrade]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctPwdTrade')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctPwdTrade]
    END

-- [Market_TradeAcct.PwdReadonly] -------------


-- [Market_TradeAcct.PwdReadonly] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='PwdReadonly')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [PwdReadonly] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_PwdReadonly NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_PwdReadonly = 'ALTER TABLE Market_TradeAcct ADD [PwdReadonly] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Market_TradeAcct_PwdReadonly
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctPwdReadonly')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctPwdReadonly]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctPwdReadonly')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctPwdReadonly]
    END

-- [Market_TradeAcct.DescTxt] -------------


-- [Market_TradeAcct.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Market_TradeAcct') AND name='DescTxt')
    BEGIN
     ALTER TABLE Market_TradeAcct ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Market_TradeAcct_DescTxt NVARCHAR(MAX);
    SET @sql_add_Market_TradeAcct_DescTxt = 'ALTER TABLE Market_TradeAcct ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Market_TradeAcct_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Market_TradeAcctDescTxt')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [Constraint_Market_TradeAcctDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Market_TradeAcctDescTxt')
    BEGIN
    ALTER TABLE Market_TradeAcct DROP  CONSTRAINT [UniqueNonclustered_Market_TradeAcctDescTxt]
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
-- [Trade_Arbitrage] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Trade_Arbitrage' AND xtype='U')

BEGIN

    CREATE TABLE Trade_Arbitrage ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[DescTxt] NVARCHAR(MAX)
        ,[Ins] BIGINT
        ,[Stake] FLOAT
        ,[Entry] FLOAT
        ,[Exit] FLOAT
        ,[Fund] BIGINT
        ,[EndUser] BIGINT
, CONSTRAINT [PK_Trade_Arbitrage] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Trade_Arbitrage NVARCHAR(64)
DECLARE cursor_Trade_Arbitrage CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','Code','DescTxt','Ins','Stake','Entry','Exit','Fund','EndUser'))

OPEN cursor_Trade_Arbitrage
FETCH NEXT FROM cursor_Trade_Arbitrage INTO @name_Trade_Arbitrage

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Trade_Arbitrage.' + @name_Trade_Arbitrage;
    
    DECLARE @sql_Trade_Arbitrage NVARCHAR(MAX);
    SET @sql_Trade_Arbitrage = 'ALTER TABLE Trade_Arbitrage DROP COLUMN ' + QUOTENAME(@name_Trade_Arbitrage)
    EXEC sp_executesql @sql_Trade_Arbitrage
    
    
    FETCH NEXT FROM cursor_Trade_Arbitrage INTO @name_Trade_Arbitrage
END

CLOSE cursor_Trade_Arbitrage;
DEALLOCATE cursor_Trade_Arbitrage;


-- [Trade_Arbitrage.Caption] -------------


-- [Trade_Arbitrage.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='Caption')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_Caption NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_Caption = 'ALTER TABLE Trade_Arbitrage ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageCaption')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageCaption')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageCaption]
    END

-- [Trade_Arbitrage.Code] -------------


-- [Trade_Arbitrage.Code] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='Code')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_Code NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_Code = 'ALTER TABLE Trade_Arbitrage ADD [Code] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_Code
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageCode')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageCode]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageCode')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageCode]
    END

-- [Trade_Arbitrage.DescTxt] -------------


-- [Trade_Arbitrage.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='DescTxt')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_DescTxt NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_DescTxt = 'ALTER TABLE Trade_Arbitrage ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageDescTxt')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageDescTxt')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageDescTxt]
    END

-- [Trade_Arbitrage.Ins] -------------


-- [Trade_Arbitrage.Ins] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='Ins')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [Ins] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_Ins NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_Ins = 'ALTER TABLE Trade_Arbitrage ADD [Ins] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_Ins
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageIns')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageIns]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageIns')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageIns]
    END

-- [Trade_Arbitrage.Stake] -------------


-- [Trade_Arbitrage.Stake] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='Stake')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [Stake] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_Stake NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_Stake = 'ALTER TABLE Trade_Arbitrage ADD [Stake] FLOAT'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_Stake
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageStake')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageStake]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageStake')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageStake]
    END

-- [Trade_Arbitrage.Entry] -------------


-- [Trade_Arbitrage.Entry] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='Entry')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [Entry] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_Entry NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_Entry = 'ALTER TABLE Trade_Arbitrage ADD [Entry] FLOAT'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_Entry
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageEntry')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageEntry]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageEntry')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageEntry]
    END

-- [Trade_Arbitrage.Exit] -------------


-- [Trade_Arbitrage.Exit] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='Exit')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [Exit] FLOAT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_Exit NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_Exit = 'ALTER TABLE Trade_Arbitrage ADD [Exit] FLOAT'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_Exit
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageExit')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageExit]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageExit')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageExit]
    END

-- [Trade_Arbitrage.Fund] -------------


-- [Trade_Arbitrage.Fund] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='Fund')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [Fund] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_Fund NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_Fund = 'ALTER TABLE Trade_Arbitrage ADD [Fund] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_Fund
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageFund')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageFund]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageFund')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageFund]
    END

-- [Trade_Arbitrage.EndUser] -------------


-- [Trade_Arbitrage.EndUser] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Arbitrage') AND name='EndUser')
    BEGIN
     ALTER TABLE Trade_Arbitrage ALTER COLUMN [EndUser] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Arbitrage_EndUser NVARCHAR(MAX);
    SET @sql_add_Trade_Arbitrage_EndUser = 'ALTER TABLE Trade_Arbitrage ADD [EndUser] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Arbitrage_EndUser
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_ArbitrageEndUser')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [Constraint_Trade_ArbitrageEndUser]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_ArbitrageEndUser')
    BEGIN
    ALTER TABLE Trade_Arbitrage DROP  CONSTRAINT [UniqueNonclustered_Trade_ArbitrageEndUser]
    END
-- [Trade_Fund] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Trade_Fund' AND xtype='U')

BEGIN

    CREATE TABLE Trade_Fund ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[DescTxt] NVARCHAR(MAX)
        ,[Bind] BIGINT
        ,[BindType] INT
, CONSTRAINT [PK_Trade_Fund] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Trade_Fund NVARCHAR(64)
DECLARE cursor_Trade_Fund CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Trade_Fund') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','DescTxt','Bind','BindType'))

OPEN cursor_Trade_Fund
FETCH NEXT FROM cursor_Trade_Fund INTO @name_Trade_Fund

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Trade_Fund.' + @name_Trade_Fund;
    
    DECLARE @sql_Trade_Fund NVARCHAR(MAX);
    SET @sql_Trade_Fund = 'ALTER TABLE Trade_Fund DROP COLUMN ' + QUOTENAME(@name_Trade_Fund)
    EXEC sp_executesql @sql_Trade_Fund
    
    
    FETCH NEXT FROM cursor_Trade_Fund INTO @name_Trade_Fund
END

CLOSE cursor_Trade_Fund;
DEALLOCATE cursor_Trade_Fund;


-- [Trade_Fund.Caption] -------------


-- [Trade_Fund.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Fund') AND name='Caption')
    BEGIN
     ALTER TABLE Trade_Fund ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Fund_Caption NVARCHAR(MAX);
    SET @sql_add_Trade_Fund_Caption = 'ALTER TABLE Trade_Fund ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Trade_Fund_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_FundCaption')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [Constraint_Trade_FundCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_FundCaption')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [UniqueNonclustered_Trade_FundCaption]
    END

-- [Trade_Fund.DescTxt] -------------


-- [Trade_Fund.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Fund') AND name='DescTxt')
    BEGIN
     ALTER TABLE Trade_Fund ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Fund_DescTxt NVARCHAR(MAX);
    SET @sql_add_Trade_Fund_DescTxt = 'ALTER TABLE Trade_Fund ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Trade_Fund_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_FundDescTxt')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [Constraint_Trade_FundDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_FundDescTxt')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [UniqueNonclustered_Trade_FundDescTxt]
    END

-- [Trade_Fund.Bind] -------------


-- [Trade_Fund.Bind] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Fund') AND name='Bind')
    BEGIN
     ALTER TABLE Trade_Fund ALTER COLUMN [Bind] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Fund_Bind NVARCHAR(MAX);
    SET @sql_add_Trade_Fund_Bind = 'ALTER TABLE Trade_Fund ADD [Bind] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Fund_Bind
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_FundBind')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [Constraint_Trade_FundBind]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_FundBind')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [UniqueNonclustered_Trade_FundBind]
    END

-- [Trade_Fund.BindType] -------------


-- [Trade_Fund.BindType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Fund') AND name='BindType')
    BEGIN
     ALTER TABLE Trade_Fund ALTER COLUMN [BindType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Fund_BindType NVARCHAR(MAX);
    SET @sql_add_Trade_Fund_BindType = 'ALTER TABLE Trade_Fund ADD [BindType] INT'
    EXEC sp_executesql @sql_add_Trade_Fund_BindType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_FundBindType')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [Constraint_Trade_FundBindType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_FundBindType')
    BEGIN
    ALTER TABLE Trade_Fund DROP  CONSTRAINT [UniqueNonclustered_Trade_FundBindType]
    END
-- [Trade_Porfolio] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Trade_Porfolio' AND xtype='U')

BEGIN

    CREATE TABLE Trade_Porfolio ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[DescTxt] NVARCHAR(MAX)
        ,[Fund] BIGINT
        ,[Bind] BIGINT
        ,[BindType] INT
, CONSTRAINT [PK_Trade_Porfolio] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Trade_Porfolio NVARCHAR(64)
DECLARE cursor_Trade_Porfolio CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Trade_Porfolio') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','DescTxt','Fund','Bind','BindType'))

OPEN cursor_Trade_Porfolio
FETCH NEXT FROM cursor_Trade_Porfolio INTO @name_Trade_Porfolio

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Trade_Porfolio.' + @name_Trade_Porfolio;
    
    DECLARE @sql_Trade_Porfolio NVARCHAR(MAX);
    SET @sql_Trade_Porfolio = 'ALTER TABLE Trade_Porfolio DROP COLUMN ' + QUOTENAME(@name_Trade_Porfolio)
    EXEC sp_executesql @sql_Trade_Porfolio
    
    
    FETCH NEXT FROM cursor_Trade_Porfolio INTO @name_Trade_Porfolio
END

CLOSE cursor_Trade_Porfolio;
DEALLOCATE cursor_Trade_Porfolio;


-- [Trade_Porfolio.Caption] -------------


-- [Trade_Porfolio.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Porfolio') AND name='Caption')
    BEGIN
     ALTER TABLE Trade_Porfolio ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Porfolio_Caption NVARCHAR(MAX);
    SET @sql_add_Trade_Porfolio_Caption = 'ALTER TABLE Trade_Porfolio ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Trade_Porfolio_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_PorfolioCaption')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [Constraint_Trade_PorfolioCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_PorfolioCaption')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [UniqueNonclustered_Trade_PorfolioCaption]
    END

-- [Trade_Porfolio.DescTxt] -------------


-- [Trade_Porfolio.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Porfolio') AND name='DescTxt')
    BEGIN
     ALTER TABLE Trade_Porfolio ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Porfolio_DescTxt NVARCHAR(MAX);
    SET @sql_add_Trade_Porfolio_DescTxt = 'ALTER TABLE Trade_Porfolio ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Trade_Porfolio_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_PorfolioDescTxt')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [Constraint_Trade_PorfolioDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_PorfolioDescTxt')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [UniqueNonclustered_Trade_PorfolioDescTxt]
    END

-- [Trade_Porfolio.Fund] -------------


-- [Trade_Porfolio.Fund] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Porfolio') AND name='Fund')
    BEGIN
     ALTER TABLE Trade_Porfolio ALTER COLUMN [Fund] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Porfolio_Fund NVARCHAR(MAX);
    SET @sql_add_Trade_Porfolio_Fund = 'ALTER TABLE Trade_Porfolio ADD [Fund] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Porfolio_Fund
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_PorfolioFund')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [Constraint_Trade_PorfolioFund]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_PorfolioFund')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [UniqueNonclustered_Trade_PorfolioFund]
    END

-- [Trade_Porfolio.Bind] -------------


-- [Trade_Porfolio.Bind] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Porfolio') AND name='Bind')
    BEGIN
     ALTER TABLE Trade_Porfolio ALTER COLUMN [Bind] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Porfolio_Bind NVARCHAR(MAX);
    SET @sql_add_Trade_Porfolio_Bind = 'ALTER TABLE Trade_Porfolio ADD [Bind] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Porfolio_Bind
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_PorfolioBind')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [Constraint_Trade_PorfolioBind]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_PorfolioBind')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [UniqueNonclustered_Trade_PorfolioBind]
    END

-- [Trade_Porfolio.BindType] -------------


-- [Trade_Porfolio.BindType] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Porfolio') AND name='BindType')
    BEGIN
     ALTER TABLE Trade_Porfolio ALTER COLUMN [BindType] INT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Porfolio_BindType NVARCHAR(MAX);
    SET @sql_add_Trade_Porfolio_BindType = 'ALTER TABLE Trade_Porfolio ADD [BindType] INT'
    EXEC sp_executesql @sql_add_Trade_Porfolio_BindType
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_PorfolioBindType')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [Constraint_Trade_PorfolioBindType]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_PorfolioBindType')
    BEGIN
    ALTER TABLE Trade_Porfolio DROP  CONSTRAINT [UniqueNonclustered_Trade_PorfolioBindType]
    END
-- [Trade_Trader] ----------------------

IF NOT EXISTS(SELECT * FROM sysobjects WHERE [name]='Trade_Trader' AND xtype='U')

BEGIN

    CREATE TABLE Trade_Trader ([ID] BIGINT NOT NULL
        ,[Createdat] BIGINT NOT NULL
        ,[Updatedat] BIGINT NOT NULL
        ,[Sort] BIGINT NOT NULL,
        [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
        ,[DescTxt] NVARCHAR(MAX)
        ,[Fund] BIGINT
        ,[Portfolio] BIGINT
        ,[EndUser] BIGINT
, CONSTRAINT [PK_Trade_Trader] PRIMARY KEY CLUSTERED ([ID] ASC)) ON [PRIMARY]
END


-- Dropping obsolete fields -----------
DECLARE @name_Trade_Trader NVARCHAR(64)
DECLARE cursor_Trade_Trader CURSOR FOR 
    SELECT name FROM SYSCOLUMNS WHERE id=object_id('Trade_Trader') AND (name NOT IN ('ID','Createdat','Updatedat','Sort','Caption','DescTxt','Fund','Portfolio','EndUser'))

OPEN cursor_Trade_Trader
FETCH NEXT FROM cursor_Trade_Trader INTO @name_Trade_Trader

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping Trade_Trader.' + @name_Trade_Trader;
    
    DECLARE @sql_Trade_Trader NVARCHAR(MAX);
    SET @sql_Trade_Trader = 'ALTER TABLE Trade_Trader DROP COLUMN ' + QUOTENAME(@name_Trade_Trader)
    EXEC sp_executesql @sql_Trade_Trader
    
    
    FETCH NEXT FROM cursor_Trade_Trader INTO @name_Trade_Trader
END

CLOSE cursor_Trade_Trader;
DEALLOCATE cursor_Trade_Trader;


-- [Trade_Trader.Caption] -------------


-- [Trade_Trader.Caption] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Trader') AND name='Caption')
    BEGIN
     ALTER TABLE Trade_Trader ALTER COLUMN [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Trader_Caption NVARCHAR(MAX);
    SET @sql_add_Trade_Trader_Caption = 'ALTER TABLE Trade_Trader ADD [Caption] NVARCHAR(64) COLLATE Chinese_PRC_CI_AS'
    EXEC sp_executesql @sql_add_Trade_Trader_Caption
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_TraderCaption')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [Constraint_Trade_TraderCaption]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_TraderCaption')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [UniqueNonclustered_Trade_TraderCaption]
    END

-- [Trade_Trader.DescTxt] -------------


-- [Trade_Trader.DescTxt] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Trader') AND name='DescTxt')
    BEGIN
     ALTER TABLE Trade_Trader ALTER COLUMN [DescTxt] NVARCHAR(MAX)
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Trader_DescTxt NVARCHAR(MAX);
    SET @sql_add_Trade_Trader_DescTxt = 'ALTER TABLE Trade_Trader ADD [DescTxt] NVARCHAR(MAX)'
    EXEC sp_executesql @sql_add_Trade_Trader_DescTxt
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_TraderDescTxt')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [Constraint_Trade_TraderDescTxt]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_TraderDescTxt')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [UniqueNonclustered_Trade_TraderDescTxt]
    END

-- [Trade_Trader.Fund] -------------


-- [Trade_Trader.Fund] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Trader') AND name='Fund')
    BEGIN
     ALTER TABLE Trade_Trader ALTER COLUMN [Fund] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Trader_Fund NVARCHAR(MAX);
    SET @sql_add_Trade_Trader_Fund = 'ALTER TABLE Trade_Trader ADD [Fund] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Trader_Fund
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_TraderFund')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [Constraint_Trade_TraderFund]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_TraderFund')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [UniqueNonclustered_Trade_TraderFund]
    END

-- [Trade_Trader.Portfolio] -------------


-- [Trade_Trader.Portfolio] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Trader') AND name='Portfolio')
    BEGIN
     ALTER TABLE Trade_Trader ALTER COLUMN [Portfolio] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Trader_Portfolio NVARCHAR(MAX);
    SET @sql_add_Trade_Trader_Portfolio = 'ALTER TABLE Trade_Trader ADD [Portfolio] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Trader_Portfolio
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_TraderPortfolio')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [Constraint_Trade_TraderPortfolio]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_TraderPortfolio')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [UniqueNonclustered_Trade_TraderPortfolio]
    END

-- [Trade_Trader.EndUser] -------------


-- [Trade_Trader.EndUser] -------------

IF EXISTS(SELECT * FROM SYSCOLUMNS WHERE id=object_id('Trade_Trader') AND name='EndUser')
    BEGIN
     ALTER TABLE Trade_Trader ALTER COLUMN [EndUser] BIGINT
    END
ELSE
    BEGIN
    DECLARE @sql_add_Trade_Trader_EndUser NVARCHAR(MAX);
    SET @sql_add_Trade_Trader_EndUser = 'ALTER TABLE Trade_Trader ADD [EndUser] BIGINT'
    EXEC sp_executesql @sql_add_Trade_Trader_EndUser
    END


IF EXISTS(SELECT object_id FROM [sys].[objects] WHERE name='Constraint_Trade_TraderEndUser')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [Constraint_Trade_TraderEndUser]
    END

IF EXISTS(SELECT * FROM SYSINDEXES WHERE name='UniqueNonclustered_Trade_TraderEndUser')
    BEGIN
    ALTER TABLE Trade_Trader DROP  CONSTRAINT [UniqueNonclustered_Trade_TraderEndUser]
    END