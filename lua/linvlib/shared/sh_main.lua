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