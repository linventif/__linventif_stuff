local function SendStat()
    local url = "http://api2.linv.dev:3000/upload-stat"
    local serverName = GetConVar("hostname"):GetString()
    local serverIP = game.GetIPAddress()
    local nbPlayers = #player.GetAll()

    local dataToSend = {
        serverName = serverName,
        serverIP = serverIP,
        nbPlayers = tostring(nbPlayers),
    }

    http.Post(url, dataToSend, nil ,nil)
end

timer.Create("LinvLib:SendStats", 60, 0, function()
    SendStat()
end)