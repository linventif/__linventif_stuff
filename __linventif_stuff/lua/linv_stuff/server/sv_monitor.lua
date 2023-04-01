util.AddNetworkString("LinvLib:SaveSetting")
util.AddNetworkString("LinvLib:GetSettings")

function LinvLib:SaveSettings(file_name, var, version, addon)
    if !file.Exists("linventif/linventif_stuff", "DATA") then
        file.CreateDir("linventif/linventif_stuff")
    end
    local data = {
        ["version"] = version,
        ["config"] = var
    }
    file.Write("linventif/linventif_stuff/" .. file_name .. ".json", util.TableToJSON(data, true))
    net.Start("LinvLib:SaveSetting")
        net.WriteString(addon)
        net.WriteString(util.TableToJSON(var))
    net.Broadcast()
end

local SaveNewSettings = {
    ["LinvLib:AdminMenu"] = function()
        LinvLib.Config.AdminMenu = net.ReadBool()
    end,
    ["LinvLib:AdminMenuExtend"] = function()
        LinvLib.Config.AdminMenuExtended = net.ReadBool()
    end,
    ["LinvLib:AdminTicket"] = function()
        LinvLib.Config.AdminTicket = net.ReadBool()
    end,
    ["LinvLib:GlobalBan"] = function()
        LinvLib.Config.GlobalBan = net.ReadBool()
    end,
    ["LinvLib:PlayerTrustFactor"] = function()
        LinvLib.Config.PlayerTrustFactor = net.ReadBool()
    end,
    ["LinvLib:DebugMode"] = function()
        LinvLib.Config.DebugMode = net.ReadBool()
    end,
    ["LinvLib:MonitorShowEveryJoin"] = function()
        LinvLib.Config.MonitorShowEveryJoin = net.ReadBool()
    end,
    ["LinvLib:MonitorShowNewUpadte"] = function()
        LinvLib.Config.MonitorShowIfNewUpdate = net.ReadBool()
    end,
    ["LinvLib:MonitorShowNewAddon"] = function()
        LinvLib.Config.MonitorShowIfNewAddon = net.ReadBool()
    end,
    ["LinvLib:Language"] = function()
        LinvLib.Config.Language = net.ReadString()
    end,
    ["LinvLib:Theme"] = function()
        LinvLib.Config.Theme = net.ReadString()
    end,
    ["LinvLib:CompatibleAddon"] = function()
        LinvLib.Config.Compatibility = util.JSONToTable(net.ReadString())
    end,
    ["LinvLib:Border"] = function()
        LinvLib.Config.Border = net.ReadInt(32)
    end,
    ["LinvLib:Rounded"] = function()
        LinvLib.Config.Rounded = net.ReadInt(32)
    end,
    ["LinvLib:ForceMaterial"] = function()
        LinvLib.Config.ForceMaterial = net.ReadBool()
    end,
    ["LinvLib:CrossBorder"] = function()
        LinvLib.Config.CrossBorder = net.ReadDouble()
    end,
    ["LinvLib:Money Symbol Separator"] = function()
        LinvLib.Config.MoneySymbolSeparator = net.ReadString()
    end,
    ["LinvLib:Money Symbol"] = function()
        LinvLib.Config.MoneySymbol = net.ReadString()
    end,
    ["LinvLib:MoneySymbolLeft"] = function()
        LinvLib.Config.MoneySymbolLeft = net.ReadBool()
    end,
    ["LinvLib:ShowNPCName"] = function()
        LinvLib.Config.ShowName = net.ReadBool()
    end,
    ["LinvLib:Blur"] = function()
        LinvLib.Config.Blur = net.ReadBool()
    end,
    ["LinvLib:AdminGroups"] = function()
        LinvLib.Config.AdminGroups = util.JSONToTable(net.ReadString())
    end,
    ["LinvLib:SuperAdminGroups"] = function()
        LinvLib.Config.SuperAdminGroups = util.JSONToTable(net.ReadString())
    end,
    ["LinvLib:ShowSlider"] = function()
        LinvLib.Config.ShowSlider = net.ReadBool()
    end,
    ["LinvLib:LinventifSupervisor"] = function()
        LinvLib.Config.LinventifSupervisor = net.ReadBool()
    end,
    ["LinvLib:SaveSettings"] = function()
        LinvLib:SaveSettings("linvlib_settings", LinvLib.Config, LinvLib.Info.version, "LinvLib")
    end,
}

function LinvLib:MonitorAddSettings(id, AddSettings)
    SaveNewSettings[id] = AddSettings
end
hook.Run("LinvLib:AddSettings")

// Receive the save settings from the client
net.Receive("LinvLib:SaveSetting", function(len, ply)
    // Verify if the settings are in game
    if !LinvLib.Config.InGameSettings then
        LinvLib:Notif(ply, LinvLib:GetTrad("settings_in_file_only"))
        return
    end
    // Verify if the player is an super admin
    if ply:IsLinvLibSuperAdmin() then
        // Execute the function
        local id = net.ReadString()
        if !SaveNewSettings[id] then hook.Run("LinvLib:AddSettings") end
        SaveNewSettings[id]()
        // Save all settings in data
        local addon = string.Explode(":", id)[1]
        SaveNewSettings[addon .. ":SaveSettings"]()
    end
end)

function LinvLib:LoadSettings(path, new_data, version, addon)
    if file.Exists("linventif/linventif_stuff/" .. path .. ".json", "DATA") then
        local data = util.JSONToTable(file.Read("linventif/linventif_stuff/" .. path .. ".json", "DATA"))
        if data.version < version then
            data.config = table.Merge(new_data, data.config)
            data.version = version
            LinvLib:SaveSettings(path, new_data, version, addon)
        end
        return data.config
    else
        LinvLib:SaveSettings(path, new_data, version, addon)
        return new_data
    end
end

hook.Add("Initialize", "LinvLib:LoadSettings", function()
    LinvLib.Config = LinvLib:LoadSettings("linvlib_settings", LinvLib.Config, LinvLib.Info.version, "LinvLib")
end)

hook.Add("LinvLib:SendSettings", "LinvLib:LinvLib:SendSettings", function()
    net.Start("LinvLib:SaveSetting")
        net.WriteString("LinvLib")
        net.WriteString(util.TableToJSON(LinvLib.Config))
    net.Broadcast()
end)

net.Receive("LinvLib:GetSettings", function(len, ply)
    net.Start("LinvLib:SaveSetting")
        net.WriteString("LinvLib")
        net.WriteString(util.TableToJSON(LinvLib.Config))
    net.Send(ply)
end)