util.AddNetworkString("LinvLib:Compatibility")
util.AddNetworkString("LinvLib:Notification")
util.AddNetworkString("LinvLib:SaveSetting")
util.AddNetworkString("LinvLib:GetSettings")
util.AddNetworkString("LinvLib")

net.Receive("LinvLib:GetSettings", function(len, ply)
    local addon = net.ReadString()
    hook.Call(addon .. ":SendSettings", nil, ply)
end)

// NET RECEIVE
/*
    1 - PlayerReady
*/

local netfunc = {
    [1] = function(ply)
        hook.Call("LinvLib:PlayerReady", nil, ply)
        ply:GetIfIsDeveloper()
    end
}

net.Receive("LinvLib", function(len, ply)
    local func = netfunc[net.ReadUInt(8)]
    if func then
        func(ply)
    end
end)