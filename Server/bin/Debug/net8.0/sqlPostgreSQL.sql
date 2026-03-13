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
        ,"caption" VARCHAR(64));

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