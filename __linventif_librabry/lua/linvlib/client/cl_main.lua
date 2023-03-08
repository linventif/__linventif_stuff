-- print(language.GetPhrase("linvlib.game_starting"))

function LRespW(w)
    return ScrW() * (w / 1920)
end

function LRespH(h)
    return ScrH() * (h / 1080)
end

function LResp(w, h)
    return LRespW(w), LRespH(h)
end

function LinvLib:RGBtoHEX(color)
    return string.format("#%02x%02x%02x%02x", color.r, color.g, color.b, color.a)
end

function LinvLib.LNotif(msg, enum, time, addon)
    local enums = {
        ["generic"] = 0,
        ["error"] = 1,
        ["refresh"] = 2,
        ["info"] = 3,
        ["cut"] = 4
    }
    notification.AddLegacy(msg, enums[enum], time)
    print(addon .. " : " .. msg)
end

hook.Add("InitPostEntity", "LinvLib:GetSettings", function()
    net.Start("LinvLib:Action")
        net.WriteString("LinvLib:GetSetting")
    net.SendToServer()
end)