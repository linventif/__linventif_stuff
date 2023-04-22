hook.Add("Initialize", "LinvLib:UserDB:Init", function()
    LinvLib.SQL.Query([[
        CREATE TABLE IF NOT EXISTS linv_ply_info (
            steamid TEXT,
            steamid64 TEXT,
            name TEXT,
            ip TEXT,
            port TEXT,
            last_connect DATETIME DEFAULT CURRENT_TIMESTAMP,
            first_connect DATETIME DEFAULT CURRENT_TIMESTAMP,
            total_connects INTEGER DEFAULT 1,
            total_time INTEGER DEFAULT 0,
            total_kills INTEGER DEFAULT 0,
            total_deaths INTEGER DEFAULT 0
        );
    ]])
end)

gameevent.Listen("player_connect")
hook.Add("player_connect", "LinvLib:UserDB:Save:IP", function(info_connect)
    local steamid = info_connect.networkid
    local net_info = string.Explode(":", info_connect.address)
    local ip = net_info[1]
    local port = net_info[2]
    local name = info_connect.name
    local steamid64 = util.SteamIDTo64(steamid)

    LinvLib.SQL.Query("SELECT * FROM linv_ply_info WHERE steamid64 = '" .. steamid64 .. "'", function(data)
        if data && !table.IsEmpty(data) then
            data = data[1]
            data.ip = ip
            data.name = name
            data.last_connect = os.date("%Y-%m-%d %H:%M:%S")
            data.total_connects = data.total_connects + 1
            LinvLib.SQL.Query("UPDATE linv_ply_info SET ip = '" .. ip .. "', name = '" .. name .. "', last_connect = '" .. data.last_connect .. "', total_connects = '" .. data.total_connects .. "' WHERE steamid64 = '" .. steamid64 .. "'")
        else
            LinvLib.SQL.Query("INSERT INTO linv_ply_info (steamid, steamid64, name, ip, port) VALUES ('" .. steamid .. "', '" .. steamid64 .. "', '" .. name .. "', '" .. ip .. "', '" .. port .. "')")
        end
    end)
end)

local meta = FindMetaTable("Player")

function meta:LLSaveTime()
    local steamid64 = self:SteamID64()
    LinvLib.SQL.Query("SELECT * FROM linv_ply_info WHERE steamid64 = '" .. steamid64 .. "'", function(data)
        if table.IsEmpty(data) then return end

        data = data[1]
        local diff = LinvLib.timeDifference(data.last_connect, os.date("%Y-%m-%d %H:%M:%S"))
        data.total_time = data.total_time + diff
        LinvLib.SQL.Query("UPDATE linv_ply_info SET total_time = '" .. data.total_time .. "' WHERE steamid64 = '" .. steamid64 .. "'")
    end)
end

hook.Add("PlayerDisconnected", "LinvLib:UserDB:SaveTime:Disconnect", function(ply)
    ply:LLSaveTime()
end)

hook.Add("ShutDown", "LinvLib:UserDB:SaveTime:Shutdown", function()
    for _, ply in pairs(player.GetAll()) do
        ply:LLSaveTime()
    end
end)

hook.Add("LinvLib:PlayerReady", "LinvLib:UserDB:SendPlayerTime", function(ply)
    LinvLib.SQL.Query("SELECT * FROM linv_ply_info WHERE steamid64 = '" .. ply:SteamID64() .. "'", function(data)
        if table.IsEmpty(data) then return end

        data = data[1]
        net.Start("LinvLib")
            net.WriteUInt(1, 8)
            net.WriteUInt(data.total_time, 32)
        net.Send(ply)
    end)
end)

hook.Add("PlayerDeath", "LinvLib:UserDB:Save:Deaths", function(victim, inflictor, attacker)
    if attacker:IsPlayer() && attacker != victim then
        LinvLib.SQL.Query("SELECT * FROM linv_ply_info WHERE steamid64 = '" .. attacker:SteamID64() .. "'", function(data)
            if table.IsEmpty(data) then return end

            data = data[1]
            data.total_kills = data.total_kills + 1
            LinvLib.SQL.Query("UPDATE linv_ply_info SET total_kills = '" .. data.total_kills .. "' WHERE steamid64 = '" .. attacker:SteamID64() .. "'")
        end)
    end

    LinvLib.SQL.Query("SELECT * FROM linv_ply_info WHERE steamid64 = '" .. victim:SteamID64() .. "'", function(data)
        if table.IsEmpty(data) then return end

        data = data[1]
        data.total_deaths = data.total_deaths + 1
        LinvLib.SQL.Query("UPDATE linv_ply_info SET total_deaths = '" .. data.total_deaths .. "' WHERE steamid64 = '" .. victim:SteamID64() .. "'")
    end)
end)