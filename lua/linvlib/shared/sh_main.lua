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
        http.Fetch("https://api.linventif.fr/gmod-lib/info.json", function(body, length, headers, code)
            LinvLibVerif(util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
    end)
end)

function LinvLib.FormatMoney(money, symbol, possition, separator)
    local monlen = string.len(money)
    local moneystr = ""
    for i = 1, monlen do
        if i % 3 == 0 then
            moneystr = separator .. string.sub(money, monlen - i + 1, monlen - i + 1) .. moneystr
        else
            moneystr = string.sub(money, monlen - i + 1, monlen - i + 1) .. moneystr
        end
    end
    money = moneystr
    if possition then
        moneystr = symbol .. moneystr
    else
        moneystr = moneystr .. symbol
    end
    return moneystr
end

function LinvLib.MoneyToShow(separator, money)
    local monlen = string.len(money)
    local moneystr = ""
    for i = 1, monlen do
        if i % 3 == 0 then
            moneystr = separator .. string.sub(money, monlen - i + 1, monlen - i + 1) .. moneystr
        else
            moneystr = string.sub(money, monlen - i + 1, monlen - i + 1) .. moneystr
        end
    end
    return moneystr
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