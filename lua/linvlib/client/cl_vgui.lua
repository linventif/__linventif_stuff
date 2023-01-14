local function RespW(x)
    return ScrW() / 1920 * x
end

local function RespH(y)
    return ScrH() / 1080 * y
end

function LinvLib.Hover(element, round, border, color, hovercolor, bordercolor, bordercolorhover)
    local borderx2 = 0
    if border then
        borderx2 = border * 2
    end
    element.OnCursorEntered = function()
        element.Paint = function(self, w, h)
            if border > 0 then
                draw.RoundedBox(round, 0, 0, w, h, bordercolorhover)
                draw.RoundedBox(round, border, border, w-borderx2, h-borderx2, hovercolor)
            else
                draw.RoundedBox(round, 0, 0, w, h, hovercolor)
            end
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            if border > 0 then
                draw.RoundedBox(round, 0, 0, w, h, bordercolor)
                draw.RoundedBox(round, border, border, w-borderx2, h-borderx2, color)
            else
                draw.RoundedBox(round, 0, 0, w, h, color)
            end
        end
    end
end

function LinvLib.Hover2(element, round, roundborder, border, color, hovercolor, bordercolor, bordercolorhover)
    local borderx2 = 0
    if border then
        borderx2 = border * 2
    end
    element.OnCursorEntered = function()
        element.Paint = function(self, w, h)
            if border > 0 then
                draw.RoundedBox(round, 0, 0, w, h, bordercolorhover)
                draw.RoundedBox(roundborder, border, border, w-borderx2, h-borderx2, hovercolor)
            else
                draw.RoundedBox(round, 0, 0, w, h, hovercolor)
            end
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            if border > 0 then
                draw.RoundedBox(round, 0, 0, w, h, bordercolor)
                draw.RoundedBox(roundborder, border, border, w-borderx2, h-borderx2, color)
            else
                draw.RoundedBox(round, 0, 0, w, h, color)
            end
        end
    end
end

function LinvLib.HideVBar(element)
    element.VBar:SetHideButtons(true)
    element.VBar.Paint = function() end
    element.VBar:SetWide(0)
    element.VBar.btnUp.Paint = function(self, w, h) end
    element.VBar.btnDown.Paint = function(self, w, h) end
    element.VBar.btnGrip.Paint = function(self, w, h) end
end

function LinvLib.UIButton(element, color, border, radius1, radius2)
    element:SetTextColor(color["text"])
    element.Paint = function(self, w, h)
        draw.RoundedBox(radius1, 0, 0, w, h, color["border"])
        draw.RoundedBox(radius2, RespW(radius2/2), RespH(radius2/2), w-RespW(radius2), h-RespH(radius2), color["background"])
    end
    element.OnCursorEntered = function()
        element.Paint = function(self, w, h)
            draw.RoundedBox(radius1, 0, 0, w, h, color["hover_border"])
            draw.RoundedBox(radius2, RespW(radius2/2), RespH(radius2/2), w-RespW(radius2), h-RespH(radius2), color["hover"])
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            draw.RoundedBox(radius1, 0, 0, w, h, color["border"])
            draw.RoundedBox(radius2, RespW(radius2/2), RespH(radius2/2), w-RespW(radius2), h-RespH(radius2), color["background"])
        end
    end
end