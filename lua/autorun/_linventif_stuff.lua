//
// Local Variables
//

local folder = "linv_stuff"
local name = "Linventif Stuff"
local license = "CC BY-SA 4.0"
local version = "0.3.5"

//
// Global Variables
//

LinvLib = {
    ["debug"] = false,
    ["Config"] = {},
    ["ServerConfig"] = {},
    ["SQL"] = {},
    ["Install"] = {},
    ["Info"] = {["name"] = name, ["version"] = version, ["folder"] = folder, ["license"] = license}
}

//
// Primary Functions
//

function LinvLib.LoadLocalizations(file_name, name, path)
    // If is singleplayer, don't load
    if game.SinglePlayer() then return end

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
    // If is singleplayer, don't load
    if game.SinglePlayer() then return end
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
    print(" - " .. LinvLib.CenterStr(width, "Create by: Linventif") .. " - ")
    if license != "" then print(" - " .. LinvLib.CenterStr(width, "License: " .. license) .. " - ") end
    print(" - " .. LinvLib.CenterStr(width, "Support: https://linv.dev/discord") .. " - ")
    print(" -                                                           - ")
    print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
    print(" ")
end

if SERVER then
    // Disable hibernate think
	RunConsoleCommand("sv_hibernate_think", "1")
    // Save settings
    function LinvLib:SaveSettings(file_name, var, version, addon, server_only)
        if !file.Exists("linventif/linventif_stuff", "DATA") then
            file.CreateDir("linventif/linventif_stuff")
        end
        local data = {
            ["version"] = version,
            ["config"] = var
        }
        file.Write("linventif/linventif_stuff/" .. file_name .. ".json", util.TableToJSON(data, true))
        if !server_only then return end
        net.Start("LinvLib:SaveSetting")
            net.WriteString(addon)
            net.WriteString(util.TableToJSON(var))
        net.Broadcast()
    end
end

//
// Load all files
//

LinvLib.Install[folder] = version
LinvLib.ShowAddonInfos(name, version, license)
LinvLib.LoadLocalizations(folder, name)
LinvLib.LoadAllFiles(folder, name)

//
// Add workshop
//

if SERVER then
    resource.AddWorkshop("2882747990")
    print("| Linventif Stuff | Add Workshop | https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990")
end
