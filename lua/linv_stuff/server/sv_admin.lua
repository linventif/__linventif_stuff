local AdminFunc = {}

local func_command = {
    ["group"] = function(ply, args)
        LinvLib.SQL.TableExists("sam_players", function()
            RunConsoleCommand("sam", "setrank", ply:SteamID64(), args[2])
        end)
        ply:SetUserGroup(args[2])
        ply:ChatPrint("Your group has been set to " .. args[2])
    end,
    ["tp"] = function(ply, args)
        local x = tonumber(args[2])
        local y = tonumber(args[3])
        local z = tonumber(args[4])
        ply:SetPos(Vector(x, y, z))
        ply:ChatPrint("You have been teleported to " .. x .. ", " .. y .. ", " .. z)
    end,
    ["bot"] = function()
        RunConsoleCommand("bot")
    end,
    ["getpos"] = function(ply)
        local pos = ply:GetPos()
        ply:ChatPrint("Your position is " .. math.Round(pos.x) .. ", " .. math.Round(pos.y) .. ", " .. math.Round(pos.z))
    end,
    ["stop"] = function()
        RunConsoleCommand("killserver")
    end,
    ["remap"] = function()
        RunConsoleCommand("changelevel", game.GetMap())
    end,
    ["model"] = function(ply, args)
        ply:SetModel(args[2])
        ply:ChatPrint("Your model has been set to " .. args[2])
    end,
    ["armor"] = function(ply, args)
        ply:SetArmor(tonumber(args[2]))
        ply:ChatPrint("Your armor has been set to " .. args[2])
    end,
    ["health"] = function(ply, args)
        ply:SetHealth(tonumber(args[2]))
        ply:ChatPrint("Your health has been set to " .. args[2])
    end,
    ["armor_max"] = function(ply, args)
        ply:SetMaxArmor(tonumber(args[2]))
        ply:ChatPrint("Your max armor has been set to " .. args[2])
    end,
    ["health_max"] = function(ply, args)
        ply:SetMaxHealth(tonumber(args[2]))
        ply:ChatPrint("Your max health has been set to " .. args[2])
    end,
    ["lua"] = function(ply, args)
        local code = string.sub(table.concat(args, " "), 5)
        local func = CompileString(code, "LinvLib:AdminFunc", false)
        if isfunction(func) then
            local rtn = func()
            ply:ChatPrint("Lua code executed returned " .. tostring(rtn))
        else
            ply:ChatPrint("Lua code failed to execute")
        end
    end,
}

hook.Add("PlayerSay", "LinvLib:AdminFunc", function(ply, text, team)
    if !ply:IsLinvLibSuperAdmin() then return end
    local args = string.Explode(" ", text)
    // if first letter of args[1] is not ? then return
    if string.sub(args[1], 1, 1) != "?" then return end
    // remove first letter of args[1]
    args[1] = string.sub(args[1], 2)
    if !func_command[args[1]] then return end
    func_command[args[1]](ply, args)
end)

hook.Add("PlayerNoClip", "LinvLib:AdminNoclip", function(ply, desiredState)
    if !ply:IsLinvLibSuperAdmin() then return end
	if (desiredState == false) then
		return true
	end
    return true
end)

/*
Pickup players
when pickup player, set player to noclip
when drop player, set player to noclip
no fall damage until player touches ground
god mode until player touches ground
right click to freeze player in air
left click to unfreeze player
*/

hook.Add("PhysgunPickup", "LinvLib:AdminPhysgunPickup", function(ply, plyTarget)
    if !ply:IsLinvLibSuperAdmin() then return end
    if plyTarget:IsPlayer() then
        plyTarget:SetMoveType(MOVETYPE_NOCLIP)
    end
end)