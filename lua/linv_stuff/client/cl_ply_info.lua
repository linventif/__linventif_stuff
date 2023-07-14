local past_time, start_time = 0, 0

hook.Add("HUDPaint", "LinvLib:HUD:PlayerTime", function()
    if !LinvLib.Config.ShowTimer then return end
    local timeLeft = math.Round(past_time + CurTime() - start_time)
    // convert sec to day / hour / min / sec
    timeLeft = {
        day = math.floor(timeLeft / 86400),
        hour = math.floor(timeLeft / 3600 % 24),
        min = math.floor(timeLeft / 60 % 60),
        sec = math.floor(timeLeft % 60)
    }
    // use string.format to add 0 before number
    local str = string.format("%02d Jours - %02d Heures - %02d Minutes - %02d Secondes", timeLeft.day, timeLeft.hour, timeLeft.min, timeLeft.sec)
    draw.SimpleText(str, "LinvFontRobo20", 10, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end)

local netfunc = {
    [1] = function(data)
        past_time = net.ReadInt(32)
        start_time = CurTime()
    end
}

net.Receive("LinvLib", function(data)
    local id = net.ReadUInt(8)
    if netfunc[id] then
        netfunc[id](data)
    end
end)