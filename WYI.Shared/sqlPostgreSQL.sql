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
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'caption', 'username', 'email', 'avatar', 'clerkuserid', 'pwd', 'authtype'])
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
            ,"desc" TEXT
            ,"suffix" VARCHAR(4)
            ,"size" BIGINT
            ,"thumbnail" BYTEA
            ,"owner" BIGINT
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
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'caption', 'desc', 'suffix', 'size', 'thumbnail', 'owner'])
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

-- [ca_file.Desc] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='desc'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "desc" text;
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