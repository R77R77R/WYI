-- [ca_enduser] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'ca_enduser'));

    IF not condition THEN
    CREATE TABLE ca_enduser (id BIGINT NOT NULL
        ,createdat BIGINT NOT NULL
        ,updatedat BIGINT NOT NULL
        ,sort BIGINT NOT NULL
        ,"caption" VARCHAR(64)
        ,"username" VARCHAR(64)
        ,"email" VARCHAR(255)
        ,"avatar" TEXT
        ,"clerkuserid" VARCHAR(100)
        ,"pwd" VARCHAR(64)
        ,"authtype" INT);

   END IF;
END $$;

-- PostgreSQL: Dropping obsolete fields (Safety Guard Active) -----------
DO $$ 
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'ca_enduser' 
          AND table_schema = 'public' 
          -- 核心过滤：排除保留字段及传入的业务字段
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ID', 'Createdat', 'Updatedat', 'Sort', 'caption', 'username', 'email', 'avatar', 'clerkuserid', 'pwd', 'authtype'])
    LOOP
        RAISE NOTICE 'Dropping column %% from table %%', row.column_name, 'ca_enduser';
        EXECUTE format('ALTER TABLE %%I DROP COLUMN IF EXISTS %%I CASCADE', 'ca_enduser', row.column_name);
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

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'ca_file'));

    IF not condition THEN
    CREATE TABLE ca_file (id BIGINT NOT NULL
        ,createdat BIGINT NOT NULL
        ,updatedat BIGINT NOT NULL
        ,sort BIGINT NOT NULL
        ,"caption" TEXT
        ,"desc" TEXT
        ,"suffix" VARCHAR(4)
        ,"size" BIGINT
        ,"thumbnail" BYTEA
        ,"owner" BIGINT);

   END IF;
END $$;

-- PostgreSQL: Dropping obsolete fields (Safety Guard Active) -----------
DO $$ 
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'ca_file' 
          AND table_schema = 'public' 
          -- 核心过滤：排除保留字段及传入的业务字段
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ID', 'Createdat', 'Updatedat', 'Sort', 'caption', 'desc', 'suffix', 'size', 'thumbnail', 'owner'])
    LOOP
        RAISE NOTICE 'Dropping column %% from table %%', row.column_name, 'ca_file';
        EXECUTE format('ALTER TABLE %%I DROP COLUMN IF EXISTS %%I CASCADE', 'ca_file', row.column_name);
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

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'social_filebind'));

    IF not condition THEN
    CREATE TABLE social_filebind (id BIGINT NOT NULL
        ,createdat BIGINT NOT NULL
        ,updatedat BIGINT NOT NULL
        ,sort BIGINT NOT NULL
        ,"file" BIGINT
        ,"moment" BIGINT
        ,"desc" TEXT);

   END IF;
END $$;

-- PostgreSQL: Dropping obsolete fields (Safety Guard Active) -----------
DO $$ 
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'social_filebind' 
          AND table_schema = 'public' 
          -- 核心过滤：排除保留字段及传入的业务字段
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ID', 'Createdat', 'Updatedat', 'Sort', 'file', 'moment', 'desc'])
    LOOP
        RAISE NOTICE 'Dropping column %% from table %%', row.column_name, 'social_filebind';
        EXECUTE format('ALTER TABLE %%I DROP COLUMN IF EXISTS %%I CASCADE', 'social_filebind', row.column_name);
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

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'social_moment'));

    IF not condition THEN
    CREATE TABLE social_moment (id BIGINT NOT NULL
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
        ,"mediatype" INT);

   END IF;
END $$;

-- PostgreSQL: Dropping obsolete fields (Safety Guard Active) -----------
DO $$ 
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'social_moment' 
          AND table_schema = 'public' 
          -- 核心过滤：排除保留字段及传入的业务字段
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ID', 'Createdat', 'Updatedat', 'Sort', 'title', 'summary', 'fulltext', 'previewimgurl', 'link', 'type', 'state', 'mediatype'])
    LOOP
        RAISE NOTICE 'Dropping column %% from table %%', row.column_name, 'social_moment';
        EXECUTE format('ALTER TABLE %%I DROP COLUMN IF EXISTS %%I CASCADE', 'social_moment', row.column_name);
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

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'sys_config'));

    IF not condition THEN
    CREATE TABLE sys_config (id BIGINT NOT NULL
        ,createdat BIGINT NOT NULL
        ,updatedat BIGINT NOT NULL
        ,sort BIGINT NOT NULL
        ,"key" VARCHAR(64)
        ,"val" TEXT);

   END IF;
END $$;

-- PostgreSQL: Dropping obsolete fields (Safety Guard Active) -----------
DO $$ 
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'sys_config' 
          AND table_schema = 'public' 
          -- 核心过滤：排除保留字段及传入的业务字段
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ID', 'Createdat', 'Updatedat', 'Sort', 'key', 'val'])
    LOOP
        RAISE NOTICE 'Dropping column %% from table %%', row.column_name, 'sys_config';
        EXECUTE format('ALTER TABLE %%I DROP COLUMN IF EXISTS %%I CASCADE', 'sys_config', row.column_name);
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

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'sys_log'));

    IF not condition THEN
    CREATE TABLE sys_log (id BIGINT NOT NULL
        ,createdat BIGINT NOT NULL
        ,updatedat BIGINT NOT NULL
        ,sort BIGINT NOT NULL
        ,"location" TEXT
        ,"content" TEXT
        ,"sql" TEXT);

   END IF;
END $$;

-- PostgreSQL: Dropping obsolete fields (Safety Guard Active) -----------
DO $$ 
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'sys_log' 
          AND table_schema = 'public' 
          -- 核心过滤：排除保留字段及传入的业务字段
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ID', 'Createdat', 'Updatedat', 'Sort', 'location', 'content', 'sql'])
    LOOP
        RAISE NOTICE 'Dropping column %% from table %%', row.column_name, 'sys_log';
        EXECUTE format('ALTER TABLE %%I DROP COLUMN IF EXISTS %%I CASCADE', 'sys_log', row.column_name);
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

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'sys_pagelog'));

    IF not condition THEN
    CREATE TABLE sys_pagelog (id BIGINT NOT NULL
        ,createdat BIGINT NOT NULL
        ,updatedat BIGINT NOT NULL
        ,sort BIGINT NOT NULL
        ,"ip" VARCHAR(64)
        ,"request" TEXT);

   END IF;
END $$;

-- PostgreSQL: Dropping obsolete fields (Safety Guard Active) -----------
DO $$ 
DECLARE
    row record;
BEGIN
    FOR row IN 
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'sys_pagelog' 
          AND table_schema = 'public' 
          -- 核心过滤：排除保留字段及传入的业务字段
          AND column_name <> ALL(ARRAY['id', 'createdat', 'updatedat', 'sort', 'ID', 'Createdat', 'Updatedat', 'Sort', 'ip', 'request'])
    LOOP
        RAISE NOTICE 'Dropping column %% from table %%', row.column_name, 'sys_pagelog';
        EXECUTE format('ALTER TABLE %%I DROP COLUMN IF EXISTS %%I CASCADE', 'sys_pagelog', row.column_name);
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