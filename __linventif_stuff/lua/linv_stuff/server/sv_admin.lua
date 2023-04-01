local AdminFunc = {}

local func_command = {
    ["!setgroup"] = function(ply, args)
        if sql.TableExists("sam_players") then
            RunConsoleCommand("sam", "setrank", ply:SteamID64(), args[2])
        end
        ply:SetUserGroup(args[2])
        ply:ChatPrint("Your group has been set to " .. args[2])
    end,
    ["!tp"] = function(ply, args)
        local x = tonumber(args[2])
        local y = tonumber(args[3])
        local z = tonumber(args[4])
        ply:SetPos(Vector(x, y, z))
        ply:ChatPrint("You have been teleported to " .. x .. ", " .. y .. ", " .. z)
    end,
    ["!bot"] = function()
        RunConsoleCommand("bot")
    end,
}

hook.Add("PlayerSay", "LinvLib:AdminFunc", function(ply, text, team)
    if !ply:IsLinvLibSuperAdmin() then return end
    local args = string.Explode(" ", text)
    if !func_command[args[1]] then return end
    func_command[args[1]](ply, args)
end)