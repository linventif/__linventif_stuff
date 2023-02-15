local function LinvLibVerif(LinvLibWeb)
    LinvLib.LoadStr("Linventif Library", LinvLib.version, LinvLib.license)
    if LinvLibWeb["linventif-library"].version != LinvLib.version then
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