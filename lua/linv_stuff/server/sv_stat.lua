function LinvLib.sendStat()
    LinvLib.post(
        'server/stat/upload',
        false,
        {
            serverName = GetConVar("hostname"):GetString(),
            serverIP = game.GetIPAddress(),
            nbPlayers = #player.GetAll(),
            version = LinvLib.getInfo("version"),
        }
    )
end

timer.Create("LinvLib:SendStats", 300, 0, function()
    LinvLib.sendStat()
end)