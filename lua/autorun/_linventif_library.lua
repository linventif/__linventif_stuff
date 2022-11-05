LinvLib = {}

LinvLib.name = "Linventif Library"
LinvLib.version = "0.0.6"
LinvLib.author = "Linventif"
LinvLib.license = "CC BY-SA 4.0"
LinvLib.description = "A library for Linventif's scripts."


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

LinvLib.Loader("linvlib/server", LinvLib.name)
LinvLib.Loader("linvlib/client", LinvLib.name)
LinvLib.Loader("linvlib/shared", LinvLib.name)

LinvLib.LoadStr(LinvLib.name, LinvLib.version, LinvLib.license)
print("| " .. LinvLib.name .. " | Add Workshop | https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990")
print(" ")
print(" ")