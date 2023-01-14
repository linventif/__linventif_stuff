LinvLib = {}

LinvLib.name = "Linventif Library"
LinvLib.version = "0.1.6"
LinvLib.author = "Linventif"
LinvLib.license = "CC BY-SA 4.0"
LinvLib.description = "A library for Linventif's scripts."
LinvLib.Install = {
    ["linventif-library"] = "0.1.6"
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
        loadFiles(folder .. "/" .. v)
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

LinvLib.LoadStr(LinvLib.name, LinvLib.version, LinvLib.license)
LinvLib.Loader("linvlib/server", LinvLib.name)
LinvLib.Loader("linvlib/client", LinvLib.name)
LinvLib.Loader("linvlib/shared", LinvLib.name)

print("| " .. LinvLib.name .. " | Add Workshop | https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990")
print(" ")
print(" ")