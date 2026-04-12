-- [ca_enduser] ----------------------

-- [ca_enduser] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'ca_enduser' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "ca_enduser" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"caption" VARCHAR(64)
            ,"username" VARCHAR(64)
            ,"email" VARCHAR(255)
            ,"avatar" TEXT
            ,"oauthprovider" VARCHAR(64)
            ,"clerkuserid" VARCHAR(100)
            ,"pwd" VARCHAR(64)
            ,"authtype" INT
            ,CONSTRAINT "pk_ca_enduser" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'ca_enduser' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'caption', 'username', 'email', 'avatar', 'oauthprovider', 'clerkuserid', 'pwd', 'authtype'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'ca_enduser', fn);
    END LOOP;
END $$;


-- [ca_enduser.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "caption" varchar(64);
    END IF;
END $$;

-- [ca_enduser.Username] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='username'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "username" varchar(64);
    END IF;
END $$;

-- [ca_enduser.Email] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='email'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "email" varchar(255);
    END IF;
END $$;

-- [ca_enduser.Avatar] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='avatar'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "avatar" text;
    END IF;
END $$;

-- [ca_enduser.OAuthProvider] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='oauthprovider'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "oauthprovider" varchar(64);
    END IF;
END $$;

-- [ca_enduser.ClerkUserID] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='clerkuserid'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "clerkuserid" varchar(100);
    END IF;
END $$;

-- [ca_enduser.Pwd] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='pwd'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "pwd" varchar(64);
    END IF;
END $$;

-- [ca_enduser.AuthType] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='authtype'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "authtype" int;
    END IF;
END $$;
-- [ca_file] ----------------------

-- [ca_file] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'ca_file' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "ca_file" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"caption" TEXT
            ,"path" TEXT
            ,"state" INT
            ,"contenttype" VARCHAR(256)
            ,"suffix" VARCHAR(4)
            ,"size" BIGINT
            ,"thumbnail" BYTEA
            ,"owner" BIGINT
            ,"cat" BIGINT
            ,"provider" BIGINT
            ,"unit" BIGINT
            ,"bill" BIGINT
            ,CONSTRAINT "pk_ca_file" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'ca_file' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'caption', 'path', 'state', 'contenttype', 'suffix', 'size', 'thumbnail', 'owner', 'cat', 'provider', 'unit', 'bill'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'ca_file', fn);
    END LOOP;
END $$;


-- [ca_file.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "caption" text;
    END IF;
END $$;

-- [ca_file.Path] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='path'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "path" text;
    END IF;
END $$;

-- [ca_file.State] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='state'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "state" int;
    END IF;
END $$;

-- [ca_file.ContentType] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='contenttype'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "contenttype" varchar(256);
    END IF;
END $$;

-- [ca_file.Suffix] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='suffix'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "suffix" varchar(4);
    END IF;
END $$;

-- [ca_file.Size] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='size'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "size" bigint;
    END IF;
END $$;

-- [ca_file.Thumbnail] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='thumbnail'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "thumbnail" bytea;
    END IF;
END $$;

-- [ca_file.Owner] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='owner'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "owner" bigint;
    END IF;
END $$;

-- [ca_file.Cat] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='cat'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "cat" bigint;
    END IF;
END $$;

-- [ca_file.Provider] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='provider'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "provider" bigint;
    END IF;
END $$;

-- [ca_file.Unit] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='unit'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "unit" bigint;
    END IF;
END $$;

-- [ca_file.Bill] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='bill'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "bill" bigint;
    END IF;
END $$;
-- [kernel_unit] ----------------------

-- [kernel_unit] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'kernel_unit' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "kernel_unit" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"caption" TEXT
            ,"owner" BIGINT
            ,"unitnum" VARCHAR(5)
            ,"acctnum" TEXT
            ,"address" TEXT
            ,"town" TEXT
            ,"state" VARCHAR(2)
            ,"zip" VARCHAR(10)
            ,CONSTRAINT "pk_kernel_unit" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'kernel_unit' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'caption', 'owner', 'unitnum', 'acctnum', 'address', 'town', 'state', 'zip'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'kernel_unit', fn);
    END LOOP;
END $$;


-- [kernel_unit.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "caption" text;
    END IF;
END $$;

-- [kernel_unit.Owner] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='owner'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "owner" bigint;
    END IF;
END $$;

-- [kernel_unit.UnitNum] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='unitnum'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "unitnum" varchar(5);
    END IF;
END $$;

-- [kernel_unit.AcctNum] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='acctnum'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "acctnum" text;
    END IF;
END $$;

-- [kernel_unit.Address] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='address'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "address" text;
    END IF;
END $$;

-- [kernel_unit.Town] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='town'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "town" text;
    END IF;
END $$;

-- [kernel_unit.State] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='state'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "state" varchar(2);
    END IF;
END $$;

-- [kernel_unit.Zip] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_unit' AND column_name='zip'));

    IF not condition THEN
        ALTER TABLE kernel_unit ADD "zip" varchar(10);
    END IF;
END $$;
-- [kernel_utilacct] ----------------------

-- [kernel_utilacct] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'kernel_utilacct' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "kernel_utilacct" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"cat" BIGINT
            ,"provider" BIGINT
            ,"owner" BIGINT
            ,"unit" BIGINT
            ,"acctname" TEXT
            ,"acctnum" TEXT
            ,CONSTRAINT "pk_kernel_utilacct" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'kernel_utilacct' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'cat', 'provider', 'owner', 'unit', 'acctname', 'acctnum'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'kernel_utilacct', fn);
    END LOOP;
END $$;


-- [kernel_utilacct.Cat] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilacct' AND column_name='cat'));

    IF not condition THEN
        ALTER TABLE kernel_utilacct ADD "cat" bigint;
    END IF;
END $$;

-- [kernel_utilacct.Provider] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilacct' AND column_name='provider'));

    IF not condition THEN
        ALTER TABLE kernel_utilacct ADD "provider" bigint;
    END IF;
END $$;

-- [kernel_utilacct.Owner] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilacct' AND column_name='owner'));

    IF not condition THEN
        ALTER TABLE kernel_utilacct ADD "owner" bigint;
    END IF;
END $$;

-- [kernel_utilacct.Unit] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilacct' AND column_name='unit'));

    IF not condition THEN
        ALTER TABLE kernel_utilacct ADD "unit" bigint;
    END IF;
END $$;

-- [kernel_utilacct.AcctName] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilacct' AND column_name='acctname'));

    IF not condition THEN
        ALTER TABLE kernel_utilacct ADD "acctname" text;
    END IF;
END $$;

-- [kernel_utilacct.AcctNum] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilacct' AND column_name='acctnum'));

    IF not condition THEN
        ALTER TABLE kernel_utilacct ADD "acctnum" text;
    END IF;
END $$;
-- [kernel_utilbill] ----------------------

-- [kernel_utilbill] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'kernel_utilbill' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "kernel_utilbill" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"shownprovider" TEXT
            ,"shownunitnum" VARCHAR(5)
            ,"shownacctnum" TEXT
            ,"shownacctname" TEXT
            ,"shownaddr" TEXT
            ,"showntown" TEXT
            ,"shownstate" VARCHAR(2)
            ,"shownzip" VARCHAR(10)
            ,"cat" BIGINT
            ,"provider" BIGINT
            ,"owner" BIGINT
            ,"unit" BIGINT
            ,"unittext" TEXT
            ,"state" INT
            ,"uacct" BIGINT
            ,"yyyymmdd" VARCHAR(8)
            ,"amt" FLOAT
            ,CONSTRAINT "pk_kernel_utilbill" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'kernel_utilbill' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'shownprovider', 'shownunitnum', 'shownacctnum', 'shownacctname', 'shownaddr', 'showntown', 'shownstate', 'shownzip', 'cat', 'provider', 'owner', 'unit', 'unittext', 'state', 'uacct', 'yyyymmdd', 'amt'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'kernel_utilbill', fn);
    END LOOP;
END $$;


-- [kernel_utilbill.ShownProvider] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='shownprovider'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "shownprovider" text;
    END IF;
END $$;

-- [kernel_utilbill.ShownUnitNum] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='shownunitnum'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "shownunitnum" varchar(5);
    END IF;
END $$;

-- [kernel_utilbill.ShownAcctNum] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='shownacctnum'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "shownacctnum" text;
    END IF;
END $$;

-- [kernel_utilbill.ShownAcctName] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='shownacctname'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "shownacctname" text;
    END IF;
END $$;

-- [kernel_utilbill.ShownAddr] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='shownaddr'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "shownaddr" text;
    END IF;
END $$;

-- [kernel_utilbill.ShownTown] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='showntown'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "showntown" text;
    END IF;
END $$;

-- [kernel_utilbill.ShownState] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='shownstate'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "shownstate" varchar(2);
    END IF;
END $$;

-- [kernel_utilbill.ShownZip] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='shownzip'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "shownzip" varchar(10);
    END IF;
END $$;

-- [kernel_utilbill.Cat] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='cat'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "cat" bigint;
    END IF;
END $$;

-- [kernel_utilbill.Provider] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='provider'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "provider" bigint;
    END IF;
END $$;

-- [kernel_utilbill.Owner] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='owner'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "owner" bigint;
    END IF;
END $$;

-- [kernel_utilbill.Unit] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='unit'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "unit" bigint;
    END IF;
END $$;

-- [kernel_utilbill.UnitText] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='unittext'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "unittext" text;
    END IF;
END $$;

-- [kernel_utilbill.State] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='state'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "state" int;
    END IF;
END $$;

-- [kernel_utilbill.UAcct] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='uacct'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "uacct" bigint;
    END IF;
END $$;

-- [kernel_utilbill.YYYYMMDD] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='yyyymmdd'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "yyyymmdd" varchar(8);
    END IF;
END $$;

-- [kernel_utilbill.Amt] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilbill' AND column_name='amt'));

    IF not condition THEN
        ALTER TABLE kernel_utilbill ADD "amt" float;
    END IF;
END $$;
-- [kernel_utilcat] ----------------------

-- [kernel_utilcat] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'kernel_utilcat' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "kernel_utilcat" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"caption" TEXT
            ,CONSTRAINT "pk_kernel_utilcat" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'kernel_utilcat' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'caption'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'kernel_utilcat', fn);
    END LOOP;
END $$;


-- [kernel_utilcat.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilcat' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE kernel_utilcat ADD "caption" text;
    END IF;
END $$;
-- [kernel_utilcatprovider] ----------------------

-- [kernel_utilcatprovider] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'kernel_utilcatprovider' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "kernel_utilcatprovider" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"cat" BIGINT
            ,"provider" BIGINT
            ,CONSTRAINT "pk_kernel_utilcatprovider" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'kernel_utilcatprovider' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'cat', 'provider'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'kernel_utilcatprovider', fn);
    END LOOP;
END $$;


-- [kernel_utilcatprovider.Cat] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilcatprovider' AND column_name='cat'));

    IF not condition THEN
        ALTER TABLE kernel_utilcatprovider ADD "cat" bigint;
    END IF;
END $$;

-- [kernel_utilcatprovider.Provider] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilcatprovider' AND column_name='provider'));

    IF not condition THEN
        ALTER TABLE kernel_utilcatprovider ADD "provider" bigint;
    END IF;
END $$;
-- [kernel_utilprovider] ----------------------

-- [kernel_utilprovider] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'kernel_utilprovider' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "kernel_utilprovider" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"caption" TEXT
            ,"logo" TEXT
            ,"icon" TEXT
            ,"cat" BIGINT
            ,CONSTRAINT "pk_kernel_utilprovider" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'kernel_utilprovider' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'caption', 'logo', 'icon', 'cat'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'kernel_utilprovider', fn);
    END LOOP;
END $$;


-- [kernel_utilprovider.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilprovider' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE kernel_utilprovider ADD "caption" text;
    END IF;
END $$;

-- [kernel_utilprovider.Logo] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilprovider' AND column_name='logo'));

    IF not condition THEN
        ALTER TABLE kernel_utilprovider ADD "logo" text;
    END IF;
END $$;

-- [kernel_utilprovider.Icon] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilprovider' AND column_name='icon'));

    IF not condition THEN
        ALTER TABLE kernel_utilprovider ADD "icon" text;
    END IF;
END $$;

-- [kernel_utilprovider.Cat] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='kernel_utilprovider' AND column_name='cat'));

    IF not condition THEN
        ALTER TABLE kernel_utilprovider ADD "cat" bigint;
    END IF;
END $$;
-- [social_filebind] ----------------------

-- [social_filebind] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'social_filebind' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "social_filebind" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"file" BIGINT
            ,"moment" BIGINT
            ,"desc" TEXT
            ,CONSTRAINT "pk_social_filebind" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'social_filebind' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'file', 'moment', 'desc'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'social_filebind', fn);
    END LOOP;
END $$;


-- [social_filebind.File] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_filebind' AND column_name='file'));

    IF not condition THEN
        ALTER TABLE social_filebind ADD "file" bigint;
    END IF;
END $$;

-- [social_filebind.Moment] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_filebind' AND column_name='moment'));

    IF not condition THEN
        ALTER TABLE social_filebind ADD "moment" bigint;
    END IF;
END $$;

-- [social_filebind.Desc] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_filebind' AND column_name='desc'));

    IF not condition THEN
        ALTER TABLE social_filebind ADD "desc" text;
    END IF;
END $$;
-- [social_moment] ----------------------

-- [social_moment] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'social_moment' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "social_moment" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"title" TEXT
            ,"summary" TEXT
            ,"fulltext" TEXT
            ,"previewimgurl" TEXT
            ,"link" TEXT
            ,"type" INT
            ,"state" INT
            ,"mediatype" INT
            ,CONSTRAINT "pk_social_moment" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'social_moment' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'title', 'summary', 'fulltext', 'previewimgurl', 'link', 'type', 'state', 'mediatype'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'social_moment', fn);
    END LOOP;
END $$;


-- [social_moment.Title] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='title'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "title" text;
    END IF;
END $$;

-- [social_moment.Summary] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='summary'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "summary" text;
    END IF;
END $$;

-- [social_moment.FullText] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='fulltext'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "fulltext" text;
    END IF;
END $$;

-- [social_moment.PreviewImgUrl] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='previewimgurl'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "previewimgurl" text;
    END IF;
END $$;

-- [social_moment.Link] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='link'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "link" text;
    END IF;
END $$;

-- [social_moment.Type] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='type'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "type" int;
    END IF;
END $$;

-- [social_moment.State] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='state'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "state" int;
    END IF;
END $$;

-- [social_moment.MediaType] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='mediatype'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "mediatype" int;
    END IF;
END $$;
-- [sys_config] ----------------------

-- [sys_config] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'sys_config' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "sys_config" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"key" VARCHAR(64)
            ,"val" TEXT
            ,CONSTRAINT "pk_sys_config" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'sys_config' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'key', 'val'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'sys_config', fn);
    END LOOP;
END $$;


-- [sys_config.Key] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_config' AND column_name='key'));

    IF not condition THEN
        ALTER TABLE sys_config ADD "key" varchar(64);
    END IF;
END $$;

-- [sys_config.Val] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_config' AND column_name='val'));

    IF not condition THEN
        ALTER TABLE sys_config ADD "val" text;
    END IF;
END $$;
-- [sys_log] ----------------------

-- [sys_log] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'sys_log' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "sys_log" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"location" TEXT
            ,"content" TEXT
            ,"sql" TEXT
            ,CONSTRAINT "pk_sys_log" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'sys_log' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'location', 'content', 'sql'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'sys_log', fn);
    END LOOP;
END $$;


-- [sys_log.Location] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_log' AND column_name='location'));

    IF not condition THEN
        ALTER TABLE sys_log ADD "location" text;
    END IF;
END $$;

-- [sys_log.Content] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_log' AND column_name='content'));

    IF not condition THEN
        ALTER TABLE sys_log ADD "content" text;
    END IF;
END $$;

-- [sys_log.Sql] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_log' AND column_name='sql'));

    IF not condition THEN
        ALTER TABLE sys_log ADD "sql" text;
    END IF;
END $$;
-- [sys_pagelog] ----------------------

-- [sys_pagelog] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'sys_pagelog' 
          AND table_schema = 'public'
    ));

    IF not condition THEN
        CREATE TABLE "sys_pagelog" (
            id BIGINT NOT NULL
            ,createdat BIGINT NOT NULL
            ,updatedat BIGINT NOT NULL
            ,sort BIGINT NOT NULL
            ,"ip" VARCHAR(64)
            ,"request" TEXT
            ,CONSTRAINT "pk_sys_pagelog" PRIMARY KEY (id)
        );
    END IF;
END $$;


-- PostgreSQL: Dropping obsolete fields -----------
DO $$ 
DECLARE
    fn TEXT;
BEGIN
    FOR fn IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'sys_pagelog' 
          AND table_schema = 'public' 
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ip', 'request'])
    LOOP
        -- 对应 PRINT 'Dropping ' + @tname + '.' + @fn
        
        -- 对应 EXEC sp_executesql @sql (format %I 对应 QUOTENAME)
        EXECUTE format('ALTER TABLE %I DROP COLUMN %I', 'sys_pagelog', fn);
    END LOOP;
END $$;


-- [sys_pagelog.Ip] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_pagelog' AND column_name='ip'));

    IF not condition THEN
        ALTER TABLE sys_pagelog ADD "ip" varchar(64);
    END IF;
END $$;

-- [sys_pagelog.Request] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_pagelog' AND column_name='request'));

    IF not condition THEN
        ALTER TABLE sys_pagelog ADD "request" text;
    END IF;
END $$;