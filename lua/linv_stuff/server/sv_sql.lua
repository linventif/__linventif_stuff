if LinvLib.ServerConfig.UseExternalDatabase then
    require("mysqloo")
    local info = LinvLib.ServerConfig.SQL
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