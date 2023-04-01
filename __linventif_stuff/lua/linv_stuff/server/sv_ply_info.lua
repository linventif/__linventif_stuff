sql.Query([[
    CREATE TABLE IF NOT EXISTS 'linv_ply_info' (
        'steamid' TEXT NOT NULL,
        'name' TEXT NOT NULL,
        'ip' TEXT NOT NULL,
        'last_connect' TEXT NOT NULL,
        'first_connect' TEXT NOT NULL,
        'total_connects' INTEGER NOT NULL,
        'total_time' INTEGER NOT NULL,
        'total_kills' INTEGER NOT NULL,
        'total_deaths' INTEGER NOT NULL,
    );
]])

// made connection to database

local db_info = {
    ["host"] = "db_exemple",
    ["username"] = "username",
    ["password"] = "password",
    ["database"] = "database",
    ["port"] = 3306
}

-- local db = mysqloo.connect(db_info.host, db_info.username, db_info.password, db_info.database, db_info.port)