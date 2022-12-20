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

function LinvLib.HideVBar(vbar)
    vbar:SetWide(0)
    vbar.btnUp:SetWide(0)
    vbar.btnDown:SetWide(0)
    vbar.btnGrip:SetWide(0)
end