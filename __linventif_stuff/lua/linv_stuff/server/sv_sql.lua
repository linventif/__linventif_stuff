if LinvLib.ConfigSQL_UseExternalDatabase then
    require("mysqloo")
    local info = LinvLib.ConfigSQL
    local db = mysqloo.connect(info.host, info.username, info.password, info.database, info.port)
    db.onConnected = function()
        print("| Linventif Stuff | MySQL | Database Connected")
    end
    db.onConnectionFailed = function(_, err)
        print("| Linventif Stuff | MySQL | Database Connection Failed | " .. err)
    end
    db:connect()
    function LinvLib.SQL.Query(query)
        local query = db:query(query)
        local data
        query.onSuccess = function(_, data)
            data = data
        end
        query.onError = function(_, err)
            print("| Linventif Stuff | MySQL | Query Error | " .. err)
        end
        query:start()
        return data
    end
else
    function LinvLib.SQL.Query(query)
        return sql.Query(query)
    end
end

-- local sql_func = {
--     show = function(ply, cmd, args)
--         if !args[1] then return end
--         local sql_data = sql.Query("SELECT * FROM " .. args[1])
--         if sql_data then
--             PrintTable(sql_data)
--         else
--             print("No data found in table " .. args[1])
--         end
--     end,
--     clear = function(ply, cmd, args)
--         if !args[1] then return end
--         sql.Query("DELETE FROM " .. args[1])
--         print("Table " .. args[1].." cleared")
--     end,
--     delete = function(ply, cmd, args)
--         if !args[1] then return end
--         sql.Query("DROP TABLE " .. args[1])
--         print("Table " .. args[1].." deleted")
--     end,
--     exist = function(ply, cmd, args)
--         if !args[1] then return end
--         local sql_data = sql.Query("SELECT * FROM " .. args[1])
--         if sql_data then
--             print("Table " .. args[1].." exist")
--         else
--             print("Table " .. args[1].." doesn't exist")
--         end
--     end,
-- }

-- concommand.Add("linvlib_sql", function(ply, cmd, args)
--     if !args[1] || !args[2] then return end
--     if !sql_func[args[1]] then return end
--     sql_func[args[1]](ply, cmd, args)
-- end)