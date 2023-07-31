local function BanMessage(data)
    local Message = {
        [1] = "",
        [2] = "",
        [3] = "You are banned of Linventif Security !",
        [4] = "",
        [5] = "Your Informations: ",
        [6] = "Name: " .. (data.name || "Unknown"),
        [7] = "SteamID64: " .. (data.steamID64 || "Unknown"),
        [8] = "Discord ID: " .. (data.discordID || "Unknown"),
        [9] = "IP: " .. (data.address || "Unknown"),
        [10] = "",
        [11] = "Ban Informations: ",
        [12] = "Reason: " .. (data.reason || "Unknown"),
        [13] = "Admin: " .. (data.admin || "Unknown"),
        [14] = "Ban Date: " .. (data.banDate || "Unknown"),
        [15] = "Ban Time: " .. (data.banTime || "Unknown"),
        [16] = "End Date: " .. (data.debanDate || "Unknown"),
        [17] = "",
        [18] = "If you think this is a mistake or you want to appeal,",
        [19] = "open a ticket on our discord server : ",
        [20] = "https://discord.linv.dev"
    }
    for k, v in pairs(Message) do
        Message[k] = v .. "\n"
    end
    return table.concat(Message)
end

gameevent.Listen("player_connect")
hook.Add("player_connect", "LinvLib:Player:Connect", function(data)
    data.steam = util.SteamIDTo64(data.networkid)
    LinvLib.post(
        'user/isBan/netInfo',
        false,
        data,
        function(body, length, headers, code)
            body = util.JSONToTable(body)
            table.Merge(body, data)
            if body.ban then
                game.KickID(data.networkid, BanMessage(body))
            end
        end
    )
end)