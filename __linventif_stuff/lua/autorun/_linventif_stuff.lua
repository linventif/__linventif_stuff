// -- // -- // -- // -- // -- // -- // -- // -- // -- //
// Please don't use a static version of this addon
// Please use the workshop version : https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990
// If you don't use the workshop version, you will not receive any update and you will not be able to use new features or addons I will create.
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

if SERVER then
    if !file.Exists("steam_cache/content/4000/2882747990", "BASE_PATH") && !file.Exists("linv_stuff_config", "LUA") then return end
end

// -- // -- // -- // -- // -- // -- // -- // -- // -- //

local folder = "linv_stuff"
local name = "Linventif Stuff"
local license = "CC BY-SA 4.0"
local version = "0.3.1"

LinvLib = {
    ["Config"] = {},
    ["ServerConfig"] = {},
    ["SQL"] = {},
    ["Install"] = {},
    ["Info"] = {["name"] = name, ["version"] = version, ["folder"] = folder, ["license"] = license},
    ["DeveloperTeam"] = {
        ["76561198219049673"] = true, // Linventif (creator)
        ["STEAM_0:1:129391972"] = true, // Linventif (creator)
        ["76561197972686060"] = true, // Akinitawa (helper and tester)
        ["STEAM_0:0:6210166"] = true, // Akinitawa (helper and tester)
    }
}

// -- // -- // -- // -- // -- // -- // -- // -- // -- //

function LinvLib.LoadLocalizations(file_name, name, path)
    if !path then path = "resource/localization/en/" end

    local files, dirs = file.Find(path .. "*", "GAME")

    for _, v in pairs(files) do
        if (v == file_name .. ".properties") then
            resource.AddFile(path .. v)
            print("| " .. name .. " | Resource Load | " .. path .. v)
        end
    end

    for _, v in pairs(dirs) do
        LinvLib.LoadLocalizations(path .. v .. "/", file_name, name)
    end
end

function LinvLib.LoadAllFiles(folder, name)
    local files, folders = file.Find(folder .. "/*", "LUA")
    for k, v in SortedPairs(files) do
        local path = folder .. "/" .. v
        if string.StartWith(v, "cl_") then
            print("| " .. name .. " | File Load | " .. path)
            if SERVER then
                AddCSLuaFile(path)
            else
                include(path)
            end
        elseif string.StartWith(v, "sv_") then
            print("| " .. name .. " | File Load | " .. path)
            if SERVER then
                include(path)
            end
        elseif string.StartWith(v, "sh_") then
            print("| " .. name .. " | File Load | " .. path)
            if SERVER then
                AddCSLuaFile(path)
            end
            include(path)
        else
            print("| " .. name .. " | - Error - | File Name Invalid : " .. path)
        end
    end
    for k, v in SortedPairs(folders, true) do
        LinvLib.LoadAllFiles(folder .. "/" .. v, name)
    end
end

function LinvLib.CenterStr(with, text)
    local rtn_str = ""
    local padding = math.floor((with - text:len()) / 2)
    local paddingText = string.rep(" ", padding)
    if text:len() % 2 == 0 then
        rtn_str = rtn_str .. " "
    end
    rtn_str = rtn_str .. paddingText .. text .. paddingText
    return rtn_str
end

function LinvLib.ShowAddonInfos(full_name, version, license)
    local width = 57
    print(" ")
    print(" ")
    print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
    print(" -                                                           - ")
    print(" - " .. LinvLib.CenterStr(width, full_name .. " v" .. version) .. " - ")
    print(" -                                                           - ")
    print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
    print(" -                                                           - ")
    print(" - " .. LinvLib.CenterStr(width, "Create by : Linventif") .. " - ")
    print(" - " .. LinvLib.CenterStr(width, "Join my discord : https://linv.dev/discord") .. " - ")
    if license != "" then print(" - " .. LinvLib.CenterStr(width, "License : " .. license) .. " - ") end
    print(" -                                                           - ")
    print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
    print(" ")
end

if SERVER then
    function LinvLib:SaveSettings(file_name, var, version, addon, server_only)
        if !file.Exists("linventif/linventif_stuff", "DATA") then
            file.CreateDir("linventif/linventif_stuff")
        end
        local data = {
            ["version"] = version,
            ["config"] = var
        }
        file.Write("linventif/linventif_stuff/" .. file_name .. ".json", util.TableToJSON(data, true))
        if server_only then return end
        net.Start("LinvLib:SaveSetting")
            net.WriteString(addon)
            net.WriteString(util.TableToJSON(var))
        net.Broadcast()
    end

    function LinvLib:LoadSettings(path, new_data, version, addon, server_only)
        if file.Exists("linventif/linventif_stuff/" .. path .. ".json", "DATA") then
            local data = util.JSONToTable(file.Read("linventif/linventif_stuff/" .. path .. ".json", "DATA"))
            if data.version < version then
                data.config = table.Merge(new_data, data.config)
                data.version = version
                LinvLib:SaveSettings(path, new_data, version, addon, server_only)
            end
            return data.config
        else
            LinvLib:SaveSettings(path, new_data, version, addon, server_only)
            return new_data
        end
    end
end

// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.Install[folder] = version
LinvLib.ShowAddonInfos(name, version, license)
LinvLib.LoadLocalizations(folder, name)
LinvLib.LoadAllFiles(folder, name)

// -- // -- // -- // -- // -- // -- // -- // -- // -- //

if SERVER then
    resource.AddWorkshop("2882747990")
end

print("| Linventif Library | Add Workshop | https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990")
