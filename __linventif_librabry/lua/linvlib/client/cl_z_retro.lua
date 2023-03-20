// -- // -- // -- // -- // -- // -- // -- // -- // -- //
// RETROCOMPATIBILITY
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

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



local blur = Material("pp/blurscreen")
function LinvLib:DrawBlur(panel, amount, color)
    -- local x, y = panel:LocalToScreen(0, 0)
    -- local scrW, scrH = ScrW(), ScrH()
    -- surface.SetDrawColor(255, 255, 255)
    -- surface.SetMaterial(blur)
    -- for i = 1, 3 do
    --     blur:SetFloat("$blur", (i / 3) * (amount or 6))
    --     blur:Recompute()
    --     render.UpdateScreenEffectTexture()
    --     surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    -- end
    -- surface.SetDrawColor(color or Color(255, 255, 255, 255))
    -- surface.DrawRect(x * -1, y * -1, scrW, scrH)
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
                draw.RoundedBox(round, border, border, w-BorderX*22, h-borderx2, hovercolor)
            else
                draw.RoundedBox(round, 0, 0, w, h, hovercolor)
            end
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            if border > 0 then
                draw.RoundedBox(round, 0, 0, w, h, bordercolor)
                draw.RoundedBox(round, border, border, w-BorderX*22, h-borderx2, color)
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
                draw.RoundedBox(roundborder, border, border, w-BorderX*22, h-borderx2, hovercolor)
            else
                draw.RoundedBox(round, 0, 0, w, h, hovercolor)
            end
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            if border > 0 then
                draw.RoundedBox(round, 0, 0, w, h, bordercolor)
                draw.RoundedBox(roundborder, border, border, w-BorderX*22, h-borderx2, color)
            else
                draw.RoundedBox(round, 0, 0, w, h, color)
            end
        end
    end
end

function LinvLib.UIButton(element, color, border, radius1, radius2)
    element:SetTextColor(color["text"])
    element.Paint = function(self, w, h)
        draw.RoundedBox(radius1, 0, 0, w, h, color["border"])
        draw.RoundedBox(radius2, LinvLib:RespW(radius2/2), LinvLib:RespH(radius2/2), w-LinvLib:RespW(radius2), h-LinvLib:RespH(radius2), color["background"])
    end
    element.OnCursorEntered = function()
        element.Paint = function(self, w, h)
            draw.RoundedBox(radius1, 0, 0, w, h, color["hover_border"])
            draw.RoundedBox(radius2, LinvLib:RespW(radius2/2), LinvLib:RespH(radius2/2), w-LinvLib:RespW(radius2), h-LinvLib:RespH(radius2), color["hover"])
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            draw.RoundedBox(radius1, 0, 0, w, h, color["border"])
            draw.RoundedBox(radius2, LinvLib:RespW(radius2/2), LinvLib:RespH(radius2/2), w-LinvLib:RespW(radius2), h-LinvLib:RespH(radius2), color["background"])
        end
    end
end

function LinvLib:PaintElement(element, w, h, color, hovercolor)
    LinvLib:NewPaint(element, w, h, color, hovercolor)
end

-- LinvLib:NumSlidePanel("MSG", 0, 0, 10, 0, function(result)
--     print(result)
-- end)