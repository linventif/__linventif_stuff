hook.Add("InitPostEntity", "LinvLib:PlayerReady", function()
    net.Start("LinvLib")
        net.WriteUInt(1, 8)
    net.SendToServer()
    LocalPlayer():GetIfIsDeveloper()
end)