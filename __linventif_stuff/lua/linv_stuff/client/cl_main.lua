function LinvLib.LNotif(msg, enum, time, addon)
    local enums = {
        ["generic"] = 0,
        ["error"] = 1,
        ["refresh"] = 2,
        ["info"] = 3,
        ["cut"] = 4
    }
    notification.AddLegacy(msg, enums[enum], time)
    print(addon .. " : " .. msg)
end

hook.Add("InitPostEntity", "LinvLib:GetSettings", function()
    net.Start("LinvLib:Action")
        net.WriteString("LinvLib:GetSetting")
    net.SendToServer()
end)