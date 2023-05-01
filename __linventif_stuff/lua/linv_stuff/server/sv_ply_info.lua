hook.Add("Initialize", "LinvLib:UserDB:Init", function()
    LinvLib.SQL.Query([[
        CREATE TABLE IF NOT EXISTS linv_ply_info (
            steamid TEXT,
            steamid64 CHAR(17) NOT NULL PRIMARY KEY,
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

    LinvLib.SQL.Query([[
        INSERT INTO linv_ply_info (steamid, steamid64, name, ip, port, last_connect, total_connects)
        VALUES (']] .. steamid .. [[', ']] .. steamid64 .. [[', ']] .. name .. [[', ']] .. ip .. [[', ']] .. port .. [[', NOW(), 1)
        ON DUPLICATE KEY UPDATE ip = VALUES(ip), name = VALUES(name), last_connect = NOW(), total_connects = total_connects + 1
    ]])
end)

local function SaveTime(ply)
    if !IsValid(ply) || !ply:IsPlayer() then return end
    local steamid64 = ply:SteamID64()
    LinvLib.SQL.Query("UPDATE linv_ply_info SET total_time = total_time + TIMESTAMPDIFF(SECOND, last_connect, NOW()) WHERE steamid64 = '" .. steamid64 .. "'")
end

hook.Add("PlayerDisconnected", "LinvLib:UserDB:SaveTime:Disconnect", function(ply)
    SaveTime(ply)
end)

hook.Add("ShutDown", "LinvLib:UserDB:SaveTime:ShutDown", function()
    for _, ply in pairs(player.GetAll()) do
        SaveTime(ply)
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
        LinvLib.SQL.Query("UPDATE linv_ply_info SET total_kills = total_kills + 1 WHERE steamid64 = '" .. attacker:SteamID64() .. "'")
    end

    LinvLib.SQL.Query("UPDATE linv_ply_info SET total_deaths = total_deaths + 1 WHERE steamid64 = '" .. victim:SteamID64() .. "'")
end)