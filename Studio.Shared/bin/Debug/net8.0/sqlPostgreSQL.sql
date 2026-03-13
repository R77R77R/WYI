-- [Ca_Book] ----------------------

DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'ca_book'));

    IF not condition THEN
    CREATE TABLE ca_book (id BIGINT NOT NULL
        ,createdat BIGINT NOT NULL
        ,updatedat BIGINT NOT NULL
        ,sort BIGINT NOT NULL
        ,"caption" VARCHAR(64)
        ,"email" VARCHAR(64)
        ,"message" TEXT);

   END IF;
END $$;


-- [Ca_Book.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_book' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE ca_book ADD "caption" varchar(64);
    END IF;
END $$;

-- [Ca_Book.Email] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_book' AND column_name='email'));

    IF not condition THEN
        ALTER TABLE ca_book ADD "email" varchar(64);
    END IF;
END $$;

-- [Ca_Book.Message] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_book' AND column_name='message'));

    IF not condition THEN
        ALTER TABLE ca_book ADD "message" text;
    END IF;
END $$;
-- [Ca_EndUser] ----------------------

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
        ,"authtype" INT);

   END IF;
END $$;


-- [Ca_EndUser.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "caption" varchar(64);
    END IF;
END $$;

-- [Ca_EndUser.AuthType] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_enduser' AND column_name='authtype'));

    IF not condition THEN
        ALTER TABLE ca_enduser ADD "authtype" int;
    END IF;
END $$;
-- [Ca_File] ----------------------

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
        ,"thumbnail" 
        ,"owner" BIGINT);

   END IF;
END $$;


-- [Ca_File.Caption] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='caption'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "caption" text;
    END IF;
END $$;

-- [Ca_File.Desc] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='desc'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "desc" text;
    END IF;
END $$;

-- [Ca_File.Suffix] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='suffix'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "suffix" varchar(4);
    END IF;
END $$;

-- [Ca_File.Size] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='size'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "size" bigint;
    END IF;
END $$;

-- [Ca_File.Thumbnail] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='thumbnail'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "thumbnail" ;
    END IF;
END $$;

-- [Ca_File.Owner] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='ca_file' AND column_name='owner'));

    IF not condition THEN
        ALTER TABLE ca_file ADD "owner" bigint;
    END IF;
END $$;
-- [Social_FileBind] ----------------------

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


-- [Social_FileBind.File] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_filebind' AND column_name='file'));

    IF not condition THEN
        ALTER TABLE social_filebind ADD "file" bigint;
    END IF;
END $$;

-- [Social_FileBind.Moment] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_filebind' AND column_name='moment'));

    IF not condition THEN
        ALTER TABLE social_filebind ADD "moment" bigint;
    END IF;
END $$;

-- [Social_FileBind.Desc] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_filebind' AND column_name='desc'));

    IF not condition THEN
        ALTER TABLE social_filebind ADD "desc" text;
    END IF;
END $$;
-- [Social_Moment] ----------------------

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


-- [Social_Moment.Title] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='title'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "title" text;
    END IF;
END $$;

-- [Social_Moment.Summary] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='summary'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "summary" text;
    END IF;
END $$;

-- [Social_Moment.FullText] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='fulltext'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "fulltext" text;
    END IF;
END $$;

-- [Social_Moment.PreviewImgUrl] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='previewimgurl'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "previewimgurl" text;
    END IF;
END $$;

-- [Social_Moment.Link] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='link'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "link" text;
    END IF;
END $$;

-- [Social_Moment.Type] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='type'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "type" int;
    END IF;
END $$;

-- [Social_Moment.State] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='state'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "state" int;
    END IF;
END $$;

-- [Social_Moment.MediaType] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='social_moment' AND column_name='mediatype'));

    IF not condition THEN
        ALTER TABLE social_moment ADD "mediatype" int;
    END IF;
END $$;
-- [Sys_Log] ----------------------

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


-- [Sys_Log.Location] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_log' AND column_name='location'));

    IF not condition THEN
        ALTER TABLE sys_log ADD "location" text;
    END IF;
END $$;

-- [Sys_Log.Content] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_log' AND column_name='content'));

    IF not condition THEN
        ALTER TABLE sys_log ADD "content" text;
    END IF;
END $$;

-- [Sys_Log.Sql] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_log' AND column_name='sql'));

    IF not condition THEN
        ALTER TABLE sys_log ADD "sql" text;
    END IF;
END $$;
-- [Sys_PageLog] ----------------------

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


-- [Sys_PageLog.Ip] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_pagelog' AND column_name='ip'));

    IF not condition THEN
        ALTER TABLE sys_pagelog ADD "ip" varchar(64);
    END IF;
END $$;

-- [Sys_PageLog.Request] -------------


DO $$
DECLARE
    condition boolean;
BEGIN
    condition := (SELECT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name='sys_pagelog' AND column_name='request'));

    IF not condition THEN
        ALTER TABLE sys_pagelog ADD "request" text;
    END IF;
END $$;