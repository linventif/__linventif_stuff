local function SendStat()
    local url = "http://stat.linv.dev:3000/upload"
    local serverName = GetConVar("hostname"):GetString() || "unknow"
    local serverIP = game.GetIPAddress() || "unknow"
    local nbPlayers = #player.GetAll() || "unknow"

    local dataToSend = {
        serverName = serverName,
        serverIP = serverIP,
        nbPlayers = tostring(nbPlayers),
    }

    http.Post(url, dataToSend, nil, nil)
end

timer.Create("LinvLib:SendStats", 60, 0, function()
    SendStat()
end)