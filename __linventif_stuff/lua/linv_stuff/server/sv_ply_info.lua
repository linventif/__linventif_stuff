-- -- if !LinvLib.Config.UserDataBase then return end

-- sql.Query("DROP TABLE IF EXISTS linv_ply_info")
-- sql.Query([[
--     CREATE TABLE IF NOT EXISTS 'linv_ply_info' (
--         'steamid' TEXT NOT NULL,
--         'steamid64' TEXT NOT NULL,
--         'name' TEXT NOT NULL,
--         'ip' TEXT NOT NULL,
--         'last_connect' TEXT NOT NULL,
--         'first_connect' TEXT NOT NULL,
--         'total_connects' INTEGER NOT NULL,
--         'total_time' INTEGER NOT NULL,
--         'total_kills' INTEGER NOT NULL,
--         'total_deaths' INTEGER NOT NULL,
--     );
-- ]])

-- // made connection to database

-- local db_info = {
--     ["host"] = "db_exemple",
--     ["username"] = "username",
--     ["password"] = "password",
--     ["database"] = "database",
--     ["port"] = 3306
-- }
-- local db = mysqloo.connect(db_info.host, db_info.username, db_info.password, db_info.database, db_info.port)

-- db.onConnected = function()
--     print("Connected to database!")
-- end

-- db.onConnectionFailed = function(err)
--     print("Connection to database failed! Error: " .. err)
-- end

-- db:connect()



-- function LinvLib:PlayerIsRegistered(steamid)
--     local query = db:query("SELECT * FROM linv_ply_info WHERE steamid = '" .. steamid .. "'")
--     query.onSuccess = function(q, data)
--         if data[1] then
--             return true
--         else
--             return false
--         end
--     end
--     query:start()
-- end

-- gameevent.Listen("player_connect")
-- hook.Add("player_connect", "LinvLib:UserDB:Save:IP", function(data)
--     local ply = player.GetBySteamID(data.networkid)
--     if !ply then return end

--     local ip = data.address
--     local steamid = ply:SteamID()
--     local name = ply:Nick()

--     local query = db:query("SELECT * FROM linv_ply_info WHERE steamid = '" .. steamid .. "'")
--     query.onSuccess = function(q, data)
--         if data[1] then
--             local query = db:query("UPDATE linv_ply_info SET ip = '" .. ip .. "' WHERE steamid = '" .. steamid .. "'")
--             query:start()
--         else
--             local query = db:query("INSERT INTO linv_ply_info (steamid, name, ip, last_connect, first_connect, total_connects, total_time, total_kills, total_deaths) VALUES ('" .. steamid .. "', '" .. name .. "', '" .. ip .. "', '" .. os.time() .. "', '" .. os.time() .. "', '1', '0', '0', '0')")
--             query:start()
--         end
--     end
--     query:start()
-- end)
