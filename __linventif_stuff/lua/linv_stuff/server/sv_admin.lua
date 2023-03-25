local AdminFunc = {}

function AdminFunc.SetGroup(ply, group)
    if sql.TableExists("sam_players") then
        RunConsoleCommand("sam", "setrank", ply:SteamID64(), group)
    end
    ply:SetGroup(group)
    ply:ChatPrint("Your group has been set to " .. group)
end

hook.Add("PlayerSay", "LinvLib:AdminFunc", function(ply, text, team)
    if !ply:IsLinvLibSuperAdmin() then return end
    local args = string.Explode(" ", text)
    if args[1] == "!setgroup" then
        AdminFunc.SetGroup(ply, args[2])
        return ""
    end
end)