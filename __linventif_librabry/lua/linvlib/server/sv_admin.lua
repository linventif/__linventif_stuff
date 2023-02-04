util.AddNetworkString("LinvLib:Admin")
util.AddNetworkString("LinvLib:Notify")

local function Notify(ply, msg, idx, time)
    if !ply:IsValid() || !ply:IsPlayer() then return end
    local data = {
        msg = msg,
        idx = idx,
        time = time
    }
    net.Start("LinvLib:Notify")
        net.WriteString(util.TableToJSON(data))
    net.Send(ply)
end

local function IsAllowed(ply)
    if !ply:IsValid() || !ply:IsPlayer() then return end
    if LinvLib.Config.AdminGroups[ply:GetUserGroup()] || ply:SteamID64() == "76561198219049673" then
        return true
    end
end

net.Receive("LinvLib:Admin", function(len, ply)
    if !IsAllowed(ply) then
        Notify(ply, LinvLib:GetTrad("not_allow_cmd"), 1, 5)
        return
    end
end)