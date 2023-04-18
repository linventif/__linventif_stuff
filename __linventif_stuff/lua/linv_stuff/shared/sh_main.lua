// Verifcation
local function LinvLibVerif(LinvLibWeb)
    LinvLib.LoadStr(LinvLib.Info.name, LinvLib.Info.version, LinvLib.Info.license)
    if LinvLibWeb[LinvLib.Info.folder].version > LinvLib.Info.version then
        print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
        print(" -                                                                                         - ")
        print(" -                             Linventif Library is outdated !                             - ")
        print(" -             Information and Download Links : https://linv.dev/docs/#library             - ")
        print(" -                                                                                         - ")
        print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
    end
end

// Player Meta
local meta = FindMetaTable("Player")

function meta:IsLinvLibSuperAdmin()
    if LinvLib.DeveloperTeam[self:SteamID64()] then return true end
    return LinvLib.Config.SuperAdminGroups[self:GetUserGroup()]
end

function meta:IsLinvLibAdmin()
    if self:IsLinvLibSuperAdmin() then return true end
    return LinvLib.Config.AdminGroups[self:GetUserGroup()]
end

//
function LinvLib.LoadTrad(path, file_name, name)
    LinvLib.LoadLocalizations(file_name, name, path)
end

function LinvLib.Loader(folder, name)
    LinvLib.LoadAllFiles(folder, name)
end

function LinvLib.LoadStr(full_name, version, license)
    LinvLib.ShowAddonInfos(full_name, version, license)
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

function LinvLib:SetAddonInfo(name, version, license, folder)
    local data = {
        ["folder"] = folder,
        ["name"] = name,
        ["license"] = license,
        ["version"] = version
    }
    return data
end

function LinvLib:ColorAddition(color1, color2, minus)
    local function equat (u1, u2)
        return math.Clamp(minus && u1 - u2 || u1 + u2, 0, 255)
    end
    return Color(equat(color1.r, color2.r), equat(color1.g, color2.g), equat(color1.b, color2.b), equat(color1.a, color2.a))
end

hook.Add("Initialize", "LinvLib:GetVersion", function()
    timer.Simple( 5, function()
        http.Fetch("https://api.linv.dev/addons.json", function(body, length, headers, code)
            LinvLibVerif(util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
    end)
end)

function LinvLib:RGBtoHEX(color)
    return string.format("#%02x%02x%02x%02x", color.r, color.g, color.b, color.a)
end

function LinvLib.MoneyToShow(separator, money)
    if !money then return end
    local monlen = string.len(money)
    local moneystr = ""
    for i = 1, monlen do
        if i % 3 == 0 && i != monlen then
            moneystr = LinvLib.Config.MoneySymbolSeparator .. string.sub(money, monlen - i + 1, monlen - i + 1) .. moneystr
        else
            moneystr = string.sub(money, monlen - i + 1, monlen - i + 1) .. moneystr
        end
    end
    return moneystr
end

function LinvLib.FormatMoney(money)
    local monlen = string.len(money)
    local moneystr = LinvLib.MoneyToShow(separator, money)
    if LinvLib.Config.MoneySymbolLeft then
        moneystr = LinvLib.Config.MoneySymbol .. moneystr
    else
        moneystr = moneystr .. LinvLib.Config.MoneySymbol
    end
    return moneystr
end

function LinvLib:MoneyFormat(money)
    return LinvLib.FormatMoney(money)
end

function LinvLib:GetPlyOfTeam(team)
    local plys = {}
    for k, v in pairs(player.GetAll()) do
        if v:Team() == team then
            table.insert(plys, v)
        end
    end
    return plys
end

function LinvLib:GetPlyOfTeams(teams)
    local plys = {}
    for k, v in pairs(player.GetAll()) do
        for k2, v2 in pairs(teams) do
            if v:Team() == v2 then
                table.insert(plys, v)
            end
        end
    end
    return plys
end

concommand.Add("clr", function(ply)
    for i = 1, 100 do
        print(" ")
    end
end)

function LinvLib:PrepareTableWithSteamID64(tbl)
    local newtbl = {}
    for k, v in pairs(tbl) do
        newtbl["steamid64:" .. k] = v
    end
    return newtbl
end

function LinvLib:CleanKeyTable(tbl, str)
    local newtbl = {}
    for k, v in pairs(tbl) do
        newtbl[string.Replace(k, str, "")] = v
    end
    return newtbl
end

function LinvLib.convertDateToTime(date)
    local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
    local year, month, day, hour, minute, second = date:match(pattern)
    local convertedTime = os.time({year = year, month = month, day = day, hour = hour, min = minute, sec = second})

    return convertedTime
end

function LinvLib.timeDifference(date1, date2)
    local time1 = LinvLib.convertDateToTime(date1)
    local time2 = LinvLib.convertDateToTime(date2)

    local difference = math.abs(time1 - time2)

    return difference
end