util.AddNetworkString("LinvLib:Compatibility")
util.AddNetworkString("LinvLib:SaveSetting")
util.AddNetworkString("LinvLib:Notification")
util.AddNetworkString("LinvLib:Action")

-- for k, v in pairs(player.GetAll()) do
--     v:ChatPrint("#linvlib.not_perm")
-- end

if !file.Exists("linventif/linventif_library/installed.json", "DATA") then
    local data = {
        ["linventif-library"] = LinvLib.version
    }
    file.Write("linventif/linventif_library/installed.json", util.TableToJSON(data, true))
end

function LinvLib.AddRessource(name, folder, addon_folder)
    local files, folders = file.Find(folder.."*", "GAME")
    for k, v in pairs(folders) do
        LinvLib.LoadMaterials(folder..v.."/")
    end
    for k, v in pairs(files) do
        resource.AddSingleFile(folder..v)
        print("| " .. name .. " | Resource Add | " .. addon_folder .. "/"..v)
    end
end

function LinvLib.LoadMaterials(folder, name)
    local addon_folder = folder
    folder = "addons/linventif_" .. folder
    LinvLib.AddRessource(name, folder, addon_folder)
end

function LinvLib.LoadWorkshop(workshop, name)
    for k, v in pairs(workshop) do
        resource.AddWorkshop(v)
        print("| " .. name .. " | Add Workshop | " .. v)
    end
end

function LinvLib:Notif(ply, text)
    net.Start("LinvLib:Notification")
        net.WriteString(text)
    net.Send(ply)
end

local function SaveSettings()
    // Save the config in a file
    if !file.Exists("linventif/linventif_library", "DATA") then
        file.CreateDir("linventif/linventif_library")
    end
    local data = {
        ["version"] = LinvLib.version,
        ["config"] = LinvLib.Config
    }
    file.Write("linventif/linventif_library/settings.json", util.TableToJSON(data, true))
    // Send the config to all players
    net.Start("LinvLib:Action")
        net.WriteString("LinvLib:SaveSetting")
        net.WriteString(util.TableToJSON(LinvLib.Config))
    net.Broadcast()
end

net.Receive("LinvLib:SaveSetting", function(len, ply)
    if !LinvLib.Config.InGameSettings then
        LinvLib:Notif(ply, LinvLib:GetTrad("settings_in_file_only"))
        return
    end
    if LinvLib.Config.AdminGroups[ply:GetUserGroup()] then
        local id = net.ReadString()
        if id == "AdminMenu" then
            LinvLib.Config.AdminMenu = net.ReadBool()
        elseif id == "AdminMenuExtend" then
            LinvLib.Config.AdminMenuExtended = net.ReadBool()
        elseif id == "AdminTicket" then
            LinvLib.Config.AdminTicket = net.ReadBool()
        elseif id == "GlobalBan" then
            LinvLib.Config.GlobalBan = net.ReadBool()
        elseif id == "PlayerTrustFactor" then
            LinvLib.Config.PlayerTrustFactor = net.ReadBool()
        elseif id == "DebugMode" then
            LinvLib.Config.DebugMode = net.ReadBool()
        elseif id == "MonitorShowEveryJoin" then
            LinvLib.Config.MonitorShowEveryJoin = net.ReadBool()
        elseif id == "MonitorShowNewUpadte" then
            LinvLib.Config.MonitorShowIfNewUpdate = net.ReadBool()
        elseif id == "MonitorShowNewAddon" then
            LinvLib.Config.MonitorShowIfNewAddon = net.ReadBool()
        elseif id == "Language" then
            LinvLib.Config.Language = net.ReadString()
        elseif id == "Theme" then
            LinvLib.Config.Theme = net.ReadString()
        elseif id == "CompatibleAddon" then
            LinvLib.Config.Compatibility = util.JSONToTable(net.ReadString())
        elseif id == "color" then
            local id = net.ReadString()
            LinvLib.Config.CustomTheme[id] = net.ReadColor()
        elseif id == "Border" then
            LinvLib.Config.Border = net.ReadInt(32)
        elseif id == "Rounded" then
            LinvLib.Config.Rounded = net.ReadInt(32)
        elseif id == "ForceMaterial" then
            LinvLib.Config.ForceMaterial = net.ReadBool()
        elseif id == "CrossBorder" then
            LinvLib.Config.CrossBorder = net.ReadDouble()
        elseif id == "Money Symbol Separator" then
            LinvLib.Config.MoneySymbolSeparator = net.ReadString()
        elseif id == "Money Symbol" then
            LinvLib.Config.MoneySymbol = net.ReadString()
        elseif id == "MoneySymbolLeft" then
            LinvLib.Config.MoneySymbolLeft = net.ReadBool()
        end
        SaveSettings()
    else
        LinvLib:Notif(ply, LinvLib:GetTrad("not_perm"))
    end
end)

hook.Add("Initialize", "LinvLib:LoadSettings", function()
    if file.Exists("linventif/linventif_library/settings.json", "DATA") then
        local data = util.JSONToTable(file.Read("linventif/linventif_library/settings.json", "DATA"))
        if data.version < LinvLib.version then
            data.config = table.Merge(LinvLib.Config, data.config)
            data.version = LinvLib.version
            SaveSettings()
        end
        LinvLib.Config = data.config
    else
        SaveSettings()
    end
end)

local function SendSettings(ply)
    net.Start("LinvLib:Action")
        net.WriteString("LinvLib:SaveSetting")
        net.WriteString(util.TableToJSON(LinvLib.Config))
    net.Send(ply)
end

local function SendInstalled(ply)
    net.Start("LinvLib:Action")
        net.WriteString("LinvLib:Installed")
        net.WriteString(file.Read("linventif/linventif_library/installed.json", "DATA"))
    net.Send(ply)
end

net.Receive("LinvLib:Action", function(len, ply)
    local action = net.ReadString()
    if action == "LinvLib:GetSetting" then
        SendSettings(ply)
    elseif action == "LinvLib:GetInstalled" then
        SendInstalled(ply)
    end
end)