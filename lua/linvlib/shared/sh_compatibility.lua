local function InitGeneralSettings(Addon_Data)
    Addon_Data.Config.Language = LinvLib.Config.Language
    Addon_Data.Config.Theme = LinvLib.Config.Theme
    Addon_Data.Config.Admin = LinvLib.Config.AdminGroups
end

local function RefreshCompatibility()
    for k, v in pairs(LinvLib.Config.Compatibility) do
        if !v then continue end
        if k == "sentro_context" then
            InitGeneralSettings(SentroContext)
        end
    end
    if SERVER then
        print("Linventif Librairy: Addon Compatibility refreshed")
        net.Start("LinvLib:Compatibility")
        net.Broadcast()
    end
end

hook.Add("Initialize", "LinvLib:Compatibility", function()
    timer.Simple(1, function()
        RefreshCompatibility()
    end)
end)

concommand.Add("linvlib_refresh", function()
    RefreshCompatibility()
end)

net.Receive("LinvLib:Compatibility", function()
    RefreshCompatibility()
end)