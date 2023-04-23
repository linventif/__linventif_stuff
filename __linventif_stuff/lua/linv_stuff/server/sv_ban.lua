local BanList = {}

hook.Add("Initialize", "LinvLibBanUpdate", function()
    timer.Simple(5, function()
        http.Fetch("https://api.linv.dev/bans.json", function(body, length, headers, code)
            BanList = util.JSONToTable(body)
        end, function(message)
            print(message)
        end)
    end)
end)

timer.Create("LinvLib:BanUpdate", 300, 0, function()
    http.Fetch("https://api.linv.dev/bans.json", function(body, length, headers, code)
        BanList = util.JSONToTable(body)
    end, function(message)
        print(message)
    end)
end)

local function BanMessage(data)
    local Message = {
        [1] = "Linventif Security",
        [2] = "",
        [3] = "You are banned of Linventif Security !",
        [4] = "",
        [5] = "Your Informations: ",
        [6] = "Pseudo: " .. data.pseudo,
        [7] = "SteamID64: " .. data.steamid64,
        [8] = "Discord ID: " .. data.discord_id,
        [9] = "",
        [10] = "Ban Informations: ",
        [11] = "Reason: " .. data.reason,
        [12] = "Banned By: " .. data.banned_by,
        [13] = "Scope: " .. data.scope,
        [14] = "Date: " .. data.date,
        [15] = "Duration: " .. data.duration,
        [16] = "End Date: " .. data.end_date,
        [17] = "",
        [18] = "If you think this is a mistake or you want to appeal,",
        [19] = "open a ticket on our discord server : ",
        [20] = "https://linv.dev/discord",
        [21] = "",
        [22] = "Linventif Security"
    }
    for k, v in pairs(Message) do
        Message[k] = v .. "\n"
    end
    return table.concat(Message)
end

hook.Add("CheckPassword", "LinvLib:BannedPlayer", function( steamid64 )
    if !LinvLib.Config.GlobalBan then return true end
    for id, data in pairs(BanList) do
        if data.steamid64 == steamid64 then
            if data.duration == "Permanent" then
                return false, BanMessage(data)
            else
                local EndDate = {
                    ["year"] = tonumber(string.sub(data.end_date, 1, 4)),
                    ["month"] = tonumber(string.sub(data.end_date, 6, 7)),
                    ["day"] = tonumber(string.sub(data.end_date, 9, 10))
                }
                local Now = {
                    ["year"] = tonumber(os.date("%Y")),
                    ["month"] = tonumber(os.date("%m")),
                    ["day"] = tonumber(os.date("%d"))
                }
                for k, v in pairs(EndDate) do
                    if v > Now[k] then
                        return false, BanMessage(data)
                    end
                end
            end
        end
    end
    return true
end)