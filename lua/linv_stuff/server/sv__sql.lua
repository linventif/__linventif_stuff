//
// SQL
//

// By default use SQLite
function LinvLib.SQL.Query(query, callback)
    if LinvLib.DebugMode() then
        print("| Linventif Debug | MySQL | Query | " .. query)
    end

    local result = sql.Query(query)
    if callback then
        callback(result)
        if LinvLib.DebugMode() then
            print("| Linventif Debug | MySQL | Query Result | ")
            PrintTable(result || {})
        end
    end
end

function LinvLib.SQL.TableExists(tableName, callback)
    LinvLib.SQL.Query("SELECT * FROM sqlite_master WHERE type='table' AND name='" .. tableName .. "'", function(data)
        if callback then
            callback(data)
        end
    end)
end

// Load external database if enabled
timer.Simple(0.1, function()
    if LinvLib.ServerConfig.UseExternalDatabase then
        require("mysqloo")

        local info = LinvLib.ServerConfig.SQL
        local db = mysqloo.connect(info.host, info.username, info.password, info.database, info.port)

        db.onConnected = function()
            print("| Linventif Debug | MySQL | Database Connected")
            hook.Call("LinvLib.SQL.Init")
        end
        db.onConnectionFailed = function(_, err)
            print("| Linventif Debug | MySQL | Database Connection Failed | " .. err)
        end

        db:connect()

        // Override SQLite functions
        function LinvLib.SQL.Query(query, callback)
            if LinvLib.DebugMode() then print("| Linventif Debug | MySQL | Query | " .. query) end
            
            local dbQuery = db:query(query)
            dbQuery.onSuccess = function(_, data)
                if callback then
                    callback(data)
                    if LinvLib.DebugMode() then
                        print("| Linventif Debug | MySQL | Query Result | ")
                        PrintTable(data || {})
                    end
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
        hook.Call("LinvLib.SQL.Init")
    end
end)