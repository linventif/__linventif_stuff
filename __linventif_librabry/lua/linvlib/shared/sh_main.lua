local function LinvLibVerif(LinvLibWeb)
    LinvLib.LoadStr(LinvLib.Info.name, LinvLib.Info.version, LinvLib.Info.license)
    if LinvLibWeb[LinvLib.Info.folder].version != LinvLib.Info.version then
        print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
        print(" -                                                                                         - ")
        print(" -                             Linventif Library is outdated !                             - ")
        print(" -             Information and Download Links : https://linv.dev/docs/#library             - ")
        print(" -                                                                                         - ")
        print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ")
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

hook.Add("Initialize", "LinvLib:GetVersion", function()
    timer.Simple( 5, function()
        http.Fetch("https://api.linventif.fr/addons.json", function(body, length, headers, code)
            LinvLibVerif(util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
    end)
end)

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