function LinvLib.sendStat()
    LinvLib.post(
        'server/stat/upload',
        false,
        {
            serverName = GetConVar("hostname"):GetString(),
            serverIP = game.GetIPAddress(),
            nbPlayers = #player.GetAll(),
        }
    )
end

timer.Create("LinvLib:SendStats", 60, 0, function()
    LinvLib.sendStat()
end)