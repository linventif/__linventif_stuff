function LinvLib.UseExtDB()
    return LinvLib.ServerConfig.UseExternalDatabase
end

if LinvLib.UseExtDB() then
    require("mysqloo")
    local info = LinvLib.ServerConfig.SQL
    local db = mysqloo.connect(info.host, info.username, info.password, info.database, info.port)
    db.onConnected = function()
        print("| Linventif Debug | MySQL | Database Connected")
    end
    db.onConnectionFailed = function(_, err)
        print("| Linventif Debug | MySQL | Database Connection Failed | " .. err)
    end
    db:connect()

    function LinvLib.SQL.Query(query, callback)
        if LinvLib.Config.DebugMode then print("| Linventif Debug | MySQL | Query | " .. query) end
        local dbQuery = db:query(query)
        dbQuery.onSuccess = function(_, data)
            if callback then
                callback(data)
            end
        end
        dbQuery.onError = function(_, err)
            print("| Linventif Debug | MySQL | Query Error | " .. err)
            if callback then
                callback(false)
            end
        end
        dbQuery:start()
    end

    function LinvLib.SQL.TableExists(tableName, callback)
        LinvLib.SQL.Query("SHOW TABLES LIKE '" .. tableName .. "'", function(data)
            if callback then
                callback(data)
            end
        end)
    end
else
    function LinvLib.SQL.Query(query, callback)
        if LinvLib.Config.DebugMode then print("| Linventif Debug | SQLite | Query | " .. query) end
        local result = sql.Query(query)
        if callback then
            callback(result)
        end
    end

    function LinvLib.SQL.TableExists(tableName, callback)
        LinvLib.SQL.Query("SELECT * FROM sqlite_master WHERE type='table' AND name='" .. tableName .. "'", function(data)
            if callback then
                callback(data)
            end
        end)
    end
end

/*
LinvLib.SQL.Query([[
    DROP TABLE linvlib_test2;
]])
LinvLib.SQL.Query([[
    CREATE TABLE IF NOT EXISTS linvlib_test2 (
        id INTEGER PRIMARY KEY ]] .. (LinvLib.UseExtDB() && "AUTO_INCREMENT" || "AUTOINCREMENT") .. [[,
        steamid64 TEXT
    );
]])

-- sql.Query( "CREATE TABLE IF NOT EXISTS linvlib_test ( SteamID TEXT, Money INTEGER )" )
sql.Query("DROP TABLE linvlib_test")
sql.Query([[
    CREATE TABLE IF NOT EXISTS linvlib_test (
        id INT PRIMARY KEY AUTOINCREMENT,
        name TEXT,
    );
]])
print(" ")
-- sql.Query("DROP TABLE linvlib_test2")
sql.Query([[
    CREATE TABLE linvlib_test2 (
        id INT PRIMARY KEY AUTOINCREMENT,
        steamid64 TEXT
    );
]])
print(" ")

// Check if table exist
print(sql.Query("SELECT * FROM sqlite_master WHERE type='table' AND name='linvlib_test'") and "Table exist" or "Table doesn't exist")
print(sql.Query("SELECT * FROM sqlite_master WHERE type='table' AND name='linvlib_test2'") and "Table exist" or "Table doesn't exist")


*/
local sql_func = {
    show = function(ply, cmd, args)
        if !args[1] then return end
        local sql_data = sql.Query("SELECT * FROM " .. args[1])
        if sql_data then
            PrintTable(sql_data)
        else
            print("No data found in table " .. args[1])
        end
    end,
    clear = function(ply, cmd, args)
        if !args[1] then return end
        sql.Query("DELETE FROM " .. args[1])
        print("Table " .. args[1].." cleared")
    end,
    delete = function(ply, cmd, args)
        if !args[1] then return end
        sql.Query("DROP TABLE " .. args[1])
        print("Table " .. args[1].." deleted")
    end,
    exist = function(ply, cmd, args)
        if !args[1] then return end
        local sql_data = sql.Query("SELECT * FROM " .. args[1])
        if sql_data then
            print("Table " .. args[1].." exist")
        else
            print("Table " .. args[1].." doesn't exist")
        end
    end,
    showall = function(ply, cmd, args)
        local sql_data = sql.Query("SELECT * FROM sqlite_master WHERE type='table'")
        if sql_data then
            PrintTable(sql_data)
        end
    end,
}

concommand.Add("linvlib_sql", function(ply, cmd, args)
    if !args[1] || !args[2] then return end
    if !sql_func[args[1]] then return end
    sql_func[args[1]](ply, cmd, args)
end)