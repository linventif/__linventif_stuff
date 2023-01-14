function LinvLib.AddRessource(nam, folder, addon_folder)
    if SERVER then
        local files, folders = file.Find(folder.."*", "GAME")
        for k, v in pairs(folders) do
            LinvLib.LoadMaterials(folder..v.."/")
        end
        for k, v in pairs(files) do
            resource.AddFile(folder..v)
            print("| " .. name .. " | Resource Add | " .. addon_folder .. "/"..v)
        end
    end
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

*/