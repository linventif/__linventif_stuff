LinvLib = {}
linvlib = {}
LinvLib.Config = {}

LinvLib.name = "Linventif Library"
LinvLib.folder = "linvlib"
LinvLib.version = "0.2.0"
LinvLib.author = "Linventif"
LinvLib.license = "CC BY-SA 4.0"
LinvLib.description = "A library for Linventif's scripts."
LinvLib.Install = {
    ["linventif-library"] = LinvLib.version
}

function LinvLib.Loader(folder, name)
    local files, folders = file.Find(folder .. "/*", "LUA")
    for k, v in pairs(files) do
        local path = folder .. "/" .. v
        local cantLoad = false
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
    for k, v in pairs(folders) do
        LinvLib.Loader(folder .. "/" .. v, name)
    end
end

function LinvLib.Load(name, folder, files)
    for k, v in pairs(files) do
        if SERVER then
            AddCSLuaFile(folder .. "/" .. v)
        end
        include(folder .. "/" .. v)
        print("| " .. name .. " | File Load | " .. folder .. "/" .. v)
    end
end

if SERVER then
    resource.AddWorkshop("2882747990")
end

function LinvLib.LoadStr(full_name, version, license)
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
    print(" - " .. LinvLib.CenterStr(width, "Join my discord : https://linventif.fr/discord") .. " - ")
    if license != "" then
        print(" - " .. LinvLib.CenterStr(width, "License : " .. license) .. " - ")
    end
    print(" -                                                           - ")
    print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
    print(" ")
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

function LinvLib.LoadTrad(folder, name)
    if !SERVER then return end
    local files, folders = file.Find(folder .. "/*", "GAME")
    for k, v in pairs(files) do
        local path = folder .. "/" .. v
        if string.EndsWith(v, ".properties") then
            resource.AddFile(path)
            resource.AddSingleFile(path)
            print("| " .. name .. " | File Load | " .. path)
        else
            print("| " .. name .. " | - Error - | File Name Invalid : " .. path)
        end
    end
    for k, v in pairs(folders) do
        LinvLib.LoadTrad(folder .. "/" .. v, name)
    end
end

function LinvLib.LoadResources(name)
    local path = "addons/" .. string.Split(debug.getinfo(1)["short_src"], "/")[2] .. "/resource/"
    local files, folders = file.Find(path .. "*", "GAME")
    for k, v in pairs(folders) do
        if v == "localization" then
            print("| " .. name .. " | Folder Load | " .. path .. v)
            LinvLib.LoadTrad(path .. v, name)
        else
            print("| " .. name .. " | - Error - | Folder Name Invalid : " .. path .. v)
        end
    end
end

-- print(language.GetPhrase("new_setting_received"))
-- print(GetConVar("gmod_language"):GetString())
-- LinvLib:GetActualFolder()


-- local files, folders = file.Find("" .. "*", "GAME")
-- PrintTable(files)
-- PrintTable(folders)

-- function LinvLib:LoadTrans(name)
--     print(GetConVar("gmod_language"):GetString())
-- end

-- LinvLib:LoadTrans("name")

-- function LinvLib:GetActualFolder()
--     -- print(string.Split(debug.getinfo(1)["short_src"], "/")[2])
--     print(debug.getinfo(2)["short_src"], "/")
--     resource.AddFile(path .. v)
-- end


-- LinvLib:GetActualFolder()

LinvLib.LoadStr(LinvLib.name, LinvLib.version, LinvLib.license)
LinvLib.Load(LinvLib.name, LinvLib.folder, {"sh_config.lua", "sh_language.lua"})
LinvLib.Loader(LinvLib.folder .. "/server", LinvLib.name)
LinvLib.Loader(LinvLib.folder .. "/client", LinvLib.name)
LinvLib.Loader(LinvLib.folder .. "/shared", LinvLib.name)
LinvLib.LoadResources(LinvLib.name)

-- print("| " .. LinvLib.name .. " | Add Workshop | https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990")
print(" ")
print(" ")