LinvLib = {
    ["name"] = "Linventif Library",
    ["version"] = "0.0.6",
    ["author"] = "Linventif",
    ["license"] = "CC BY-SA 4.0",
    ["description"] = "A library for Linventif's scripts."
}

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

local function LinvLibVerif(LinvLibWeb)
    LinvLib.LoadStr(LinvLib.name, LinvLib.version, LinvLib.license)
    if LinvLibWeb.version != LinvLib.version then
        print("Linventif Library is outdated! Please update it!")
        print(" ")
        print("You can download the latest version here : https://linventif.fr/gmod-lib")
        print("Or you can download it directly from the github : https://github.com/linventif/gmod-lib")
        print("Or you can download it directly from the workshop : https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990")
        print("If you don't know how to update it, please read the documentation : https://docs.linventif.fr/gmod-lib")
        print("If you have any questions, you can join my discord : https://linventif.fr/discord")
        print("If you don't update it, some scripts may not work properly.")
    else
        print("Linventif Library is up to date!")
    end
    print(" ")
    print(" ")
end

hook.Add("Initialize", "LinvLibUpdate", function()
    timer.Simple( 5, function()
        http.Fetch("https://api.linventif.fr/gmod-lib/info.json",
        function(body, length, headers, code)
            LinvLibVerif(util.JSONToTable(body))
        end,
        function(message)
            print(message)
        end)
    end)
end)

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

function LinvLib.ValidLang(folder, lang)
    if file.Exists(folder .. "/languages/" .. lang .. ".lua", "LUA") then
        return true
    else
        return false
    end
end

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

LinvLib.LoadStr(LinvLib.name, LinvLib.version, LinvLib.license)