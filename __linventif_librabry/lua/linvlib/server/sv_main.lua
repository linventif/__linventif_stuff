util.AddNetworkString("LinvLib:Compatibility")
util.AddNetworkString("LinvLib:SaveSetting")
util.AddNetworkString("LinvLib:Notification")

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

/*

function LinvLib.ServerName()
    local f = file.Open("cfg/server.cfg", "r", "MOD" )
    while true do
        local line = f:ReadLine()
        if not line then break end
        if string.find(line, "hostname") then
            return line
        end
    end
    f:Close()
end

function LinvLib.ValidLang(folder, lang)
    if file.Exists(folder .. "/languages/" .. lang .. ".lua", "LUA") then
        return true
    else
        return false
    end
end

function LinvLib.GetValidLang(folder)
    local serverName = LinvLib.ServerName()
    if string.find(serverName, "[FR]") && LinvLib.ValidLang(folder, "french") then
        lang = "french"
    elseif string.find(serverName, "[EN]") && LinvLib.ValidLang(folder, "english") then
        lang = "english"
    elseif string.find(serverName, "[ES]") && LinvLib.ValidLang(folder, "spanish") then
        lang = "spanish"
    elseif string.find(serverName, "[DE]") && LinvLib.ValidLang(folder, "german") then
        lang = "german"
    elseif string.find(serverName, "[IT]") && LinvLib.ValidLang(folder, "italian") then
        lang = "italian"
    elseif string.find(serverName, "[RU]") && LinvLib.ValidLang(folder, "russian") then
        lang = "russian"
    elseif string.find(serverName, "[PT]") && LinvLib.ValidLang(folder, "portuguese") then
        lang = "portuguese"
    elseif string.find(serverName, "[NL]") && LinvLib.ValidLang(folder, "dutch") then
        lang = "dutch"
    elseif string.find(serverName, "[PL]") && LinvLib.ValidLang(folder, "polish") then
        lang = "polish"
    elseif string.find(serverName, "[TR]") && LinvLib.ValidLang(folder, "turkish") then
        lang = "turkish"
    elseif string.find(serverName, "[CN]") && LinvLib.ValidLang(folder, "chinese") then
        lang = "chinese"
    elseif string.find(serverName, "[JP]") && LinvLib.ValidLang(folder, "japanese") then
        lang = "japanese"
    elseif string.find(serverName, "[KR]") && LinvLib.ValidLang(folder, "korean") then
        lang = "korean"
    elseif string.find(serverName, "[AR]") && LinvLib.ValidLang(folder, "arabic") then
        lang = "arabic"
    else
        lang = "english"
    end
    return lang
end

if file.Exists("linventif/liventif_library/settings.json", "DATA") then
    local data = util.JSONToTable(file.Read("linventif/liventif_library/settings.json", "DATA"))
    if data.version < LinvLib.version then
        data.config = table.Merge(LinvLib.Config, data.config)
        data.version = LinvLib.version
        file.Write("linventif/liventif_library/settings.json", util.TableToJSON(data, true))
    end
    LinvLib.Config = data.config
    PrintTable(data)
else
    if !file.Exists("linventif/liventif_library", "DATA") then
        file.CreateDir("linventif/liventif_library")
    end
    local data = {
        ["version"] = LinvLib.version,
        ["config"] = LinvLib.Config
    }
    file.Write("linventif/liventif_library/settings.json", util.TableToJSON(data, true))
end

*/

function LinvLib:Notif(ply, text)
    net.Start("LinvLib:Notification")
        net.WriteString(text)
    net.Send(ply)
end

local function SaveSettings()
    if !file.Exists("linventif/liventif_library", "DATA") then
        file.CreateDir("linventif/liventif_library")
    end
    local data = {
        ["version"] = LinvLib.version,
        ["config"] = LinvLib.Config
    }
    file.Write("linventif/liventif_library/settings.json", util.TableToJSON(data, true))
end

net.Receive("LinvLib:SaveSetting", function(len, ply)
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
        end
        SaveSettings()
        net.Start("LinvLib:SaveSetting")
            net.WriteString(util.TableToJSON(LinvLib.Config))
        net.Broadcast()
    else
        LinvLib:Notif(ply, LinvLib:GetTrad("not_perm"))
    end
end)

hook.Add("Initialize", "LinvLib:LoadSettings", function()
    if file.Exists("linventif/liventif_library/settings.json", "DATA") then
        local data = util.JSONToTable(file.Read("linventif/liventif_library/settings.json", "DATA"))
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

hook.Add("PlayerInitialSpawn", "LinvLib:SendSettings", function(ply)
    net.Start("LinvLib:SaveSetting")
        net.WriteString(util.TableToJSON(LinvLib.Config))
    net.Send(ply)
end)