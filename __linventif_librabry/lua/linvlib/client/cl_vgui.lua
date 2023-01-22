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


function LinvLib:Hover(element, round, color, hovercolor)
    element.OnCursorEntered = function()
        element.Paint = function(self, w, h)
            draw.RoundedBox(round, 0, 0, w, h, hovercolor)
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            draw.RoundedBox(round, 0, 0, w, h, color)
        end
    end
end

// -- // -- // --

function LinvLib:Frame(weight, height)
    local frame = vgui.Create("DFrame")
    frame:SetSize(RespW(weight), RespH(height))
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(LinvLib.Config.DebugMode)
    frame:SetDraggable(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(RespW(14), 0, 0, w, h, LinvLib:GetColorTheme("background"))
    end
    return frame
end

function LinvLib:Panel(frame, weight, height)
    local panel = vgui.Create("DPanel", frame)
    panel:SetSize(RespW(weight), RespH(height))
    panel.Paint = function(self, w, h)
        draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
    end
    return panel
end

function LinvLib:Button(frame, text, weight, height, hover, func)
    local but = vgui.Create("DButton", frame)
    but:SetSize(RespW(weight), RespH(height))
    but:SetText(text)
    but:SetTextColor(LinvLib:GetColorTheme("text"))
    but:SetFont("LinvFontRobo20")
    but.Paint = function(self, w, h)
        draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
    end
    if hover then
        LinvLib:Hover(but, RespW(8), LinvLib:GetColorTheme("element"), LinvLib:GetColorTheme("hover"))
    end
    but.DoClick = func
    return but
end

function LinvLib:Scroll(frame, weight, height)
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:SetSize(RespW(weight), RespH(height))
    scroll.Paint = function() return end
    scroll.VBar:SetHideButtons(true)
    scroll.VBar.Paint = function()
        draw.RoundedBox(RespW(4), 0, 0, 10, scroll.VBar:GetTall(), LinvLib:GetColorTheme("element"))
    end
    scroll.VBar:SetWide(10)
    scroll.VBar.btnGrip.Paint = function(self, w, h)
        draw.RoundedBox(RespW(4), 0, 0, w, h, LinvLib:GetColorTheme("accent"))
    end
    return scroll
end

function LinvLib:Notif(text)
    local frame = vgui.Create("DPanel")
    frame:SetSize(RespW(600), RespH(40))
    frame:SetPos(ScrW()/2-RespW(300), RespH(-100))
    frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, LinvLib:GetColorTheme("background"))
        draw.SimpleText(text, "LinvFontRobo20", RespW(600)/2, RespH(20), LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    print(text)
    frame:MoveTo(ScrW()/2-RespW(300), RespH(10), 0.5, 0, 1)
    timer.Simple(4, function()
        frame:MoveTo(ScrW()/2-RespW(300), -RespH(100), 0.5, 0, 1)
        timer.Simple(0.5, function()
            frame:Remove()
        end)
    end)
end

function LinvLib:Blur(color, force)
    local blur = Material("pp/blurscreen")
    local x, y = 0, 0
    local scrW, scrH = ScrW(), ScrH()
    local function drawBlur(panel, amount)
        local x, y = panel:LocalToScreen(0, 0)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(blur)
        for i = 1, 3 do
            blur:SetFloat("$blur", (i / 3) * (amount or 6))
            blur:Recompute()
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
        end
    end
    local blur = vgui.Create("DPanel")
    blur:SetSize(scrW, scrH)
    blur:SetPos(x, y)
    blur.Paint = function(self, w, h)
        drawBlur(self, force)
        draw.RoundedBox(0, 0, 0, w, h, color)
    end
    return blur
end

net.Receive("LinvLib:Notification", function()
    local text = net.ReadString()
    LinvLib:Notif(text)
end)