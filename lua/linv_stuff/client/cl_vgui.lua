function LinvLib:RespW(x)
    if string.sub(tostring(x), -1) == "%" then
        return ScrW() / 100 * tonumber(string.sub(x, 1, -2))
    else
        return ScrW() / 1920 * x
    end
end

function LinvLib:RespH(y)
    if string.sub(tostring(y), -1) == "%" then
        return ScrH() / 100 * tonumber(string.sub(y, 1, -2))
    else
        return ScrH() / 1080 * y
    end
end

local txt_cooldown = 0
function LinvLib:DrawNPCText(self, text, height_pos)
    if text == "" || !LinvLib.Config.ShowName then return end
    if !height_pos then height_pos = 3200 end
    local pos = self:GetPos()
	local ang = self:GetAngles()
    local width_text = string.len(text)*59 + 150
    if string.len(text) < 10 then
        width_text = 800
    end

	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 85)

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) < 40000 then
		cam.Start3D2D(pos + ang:Up() * 0, Angle(0,LocalPlayer():EyeAngles().y-90, 90), 0.025)
			draw.RoundedBox(LinvLib.Config.Rounded * 4, width_text / -2, -125 -height_pos, width_text, 260, LinvLib:GetColorTheme("background"))
			draw.SimpleText(text, "LinvFontResp01", 0, -height_pos, LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
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

function LinvLib:NewPaint(element, w, h, border, background, noborder)
    local round = LinvLib.Config.Rounded
    if LinvLib.Config.Border != 0 && !noborder then
        if LinvLib.Config.CrossBorder != 0 then
            local BorderY, BorderX = 0, 0
            if LinvLib.Config.CrossBorder < 1 then
                BorderY, BorderX = h*LinvLib.Config.CrossBorder, w*LinvLib.Config.CrossBorder
            else
                BorderY, BorderX = LinvLib:RespH(LinvLib.Config.CrossBorder), LinvLib:RespW(LinvLib.Config.CrossBorder)
            end
            draw.RoundedBox(LinvLib:RespW(round), w-BorderX, 0, BorderX, BorderY, border)
            draw.RoundedBox(LinvLib:RespW(round), 0, 0, BorderX, BorderY, border)
            draw.RoundedBox(LinvLib:RespW(round), w-BorderX, h-BorderY, BorderX, BorderY, border)
            draw.RoundedBox(LinvLib:RespW(round), 0, h-BorderY, BorderX, BorderY, border)
            local BorderY, BorderX = LinvLib:RespH(LinvLib.Config.Border), LinvLib:RespW(LinvLib.Config.Border)
            draw.RoundedBox(LinvLib:RespW(math.Clamp(round-2, 0, 100)), BorderX, BorderY, w-BorderX*2, h-BorderY*2, background)
        else
            local BorderY, BorderX = LinvLib:RespH(LinvLib.Config.Border), LinvLib:RespW(LinvLib.Config.Border)
            draw.RoundedBox(LinvLib:RespW(round), 0, 0, w, h, border)
            draw.RoundedBox(LinvLib:RespW(math.Clamp(round-2, 0, 100)), BorderX, BorderY, w-BorderX*2, h-BorderY*2, background)
        end
    else
        draw.RoundedBox(LinvLib:RespW(round), 0, 0, w, h, background)
    end
end

function LinvLib:PaintElement(element, w, h, color, hovercolor)
    LinvLib:NewPaint(element, w, h, color, hovercolor)
end

function LinvLib:Hover(element, round, color, hovercolor)
    if isnumber(element) then return end
    element.OnCursorEntered = function()
        element.Paint = function(self, w, h)
            LinvLib:PaintElement(frame, w, h, LinvLib:GetColorTheme("border"), hovercolor)
        end
    end
    element.OnCursorExited = function()
        element.Paint = function(self, w, h)
            LinvLib:PaintElement(frame, w, h, LinvLib:GetColorTheme("border"), color)
        end
    end
end

// -- // -- // --

function LinvLib.BlurPanel()
    if !LinvLib.Config.Blur then return end
    local blur_panel = vgui.Create("DPanel")
    blur_panel:SetSize(ScrW(), ScrH())
    blur_panel:Center()
    blur_panel.Paint = function(self, w, h)
        if !no_blur then LinvLib:DrawBlur(self, 4, Color(LinvLib:GetColorTheme("background").r, LinvLib:GetColorTheme("background").g, LinvLib:GetColorTheme("background").b, 80)) end
    end
    return blur_panel
end

function LinvLib:Frame(weight, height, args)
    if !args || !istable(args) then args = {} end
    local frame = vgui.Create("DFrame")
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(0, 0, 0, 0)
    frame:SetSize(LinvLib:RespW(weight), LinvLib:RespH(height))
    frame:Center()
    frame:SetTitle("")
    if !args["no_popup"] then frame:MakePopup() end
    frame:ShowCloseButton(LinvLib.Config.DebugMode)
    frame:SetDraggable(false)
    frame.Paint = function(self, w, h)
        LinvLib:NewPaint(frame, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("background"))
    end
    -- function frame:SetBackground(color)
    --     frame.Paint = function(self, w, h)
    --         LinvLib:NewPaint(frame, w, h, LinvLib:GetColorTheme("border"), color)
    --     end
    -- end
    return frame
end

function LinvLib:Panel(frame, weight, height, noborder, bord_color, back_color)
    local panel = vgui.Create("DPanel", frame)
    panel:SetSize(LinvLib:RespW(weight), LinvLib:RespH(height))
    panel.Paint = function(self, w, h)
        LinvLib:NewPaint(frame, w, h, bord_color || LinvLib:GetColorTheme("border"), back_color || LinvLib:GetColorTheme("background"), noborder)
    end
    function panel:SetBackground(color)
        panel.Paint = function(self, w, h)
            LinvLib:NewPaint(frame, w, h, LinvLib:GetColorTheme("border"), color)
        end
    end
    return panel
end

function LinvLib:Button(frame, text, weight, height, color, hover, func)
    local but = vgui.Create("DButton", frame)
    but:SetSize(LinvLib:RespW(weight), LinvLib:RespH(height))
    but:SetText(text)
    but:SetTextColor(LinvLib:GetColorTheme("text"))
    but:SetFont("LinvFontRobo20")
    but.Paint = function(self, w, h)
        LinvLib:NewPaint(frame, w, h, LinvLib:GetColorTheme("border"), color)
    end
    if hover then
        LinvLib:Hover(but, LinvLib:RespW(8), color, LinvLib:GetColorTheme("hover"))
    end
    but.DoClick = func
    return but
end

function LinvLib:Scroll(frame, weight, height, round)
    if !round then round = 4 end
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:SetSize(LinvLib:RespW(weight), LinvLib:RespH(height))
    scroll.Paint = function() return end
    scroll.VBar:SetHideButtons(true)
    scroll.VBar.Paint = function()
        draw.RoundedBox(LinvLib:RespW(round), 0, 0, 10, scroll.VBar:GetTall(), LinvLib:GetColorTheme("element"))
    end
    scroll.VBar:SetWide(10)
    scroll.VBar.btnGrip.Paint = function(self, w, h)
        draw.RoundedBox(LinvLib:RespW(round), 0, 0, w, h, LinvLib:GetColorTheme("accent"))
    end
    if !LinvLib.Config.ShowSlider then scroll.VBar:SetWide(0) end
    return scroll
end

function LinvLib.ScrollBarAjust(boll, true_val, false_val)
    if !LinvLib.Config.ShowSlider then return false_val end
    if boll then
        return true_val + LinvLib.Config.Border / 2
    else
        return false_val
    end
end

local cooldown = 0
function LinvLib:Notif(text)
    if cooldown > CurTime() then return end
    cooldown = CurTime() + 2
    local frame = vgui.Create("DPanel")
    frame:SetSize(LinvLib:RespW(600), LinvLib:RespH(40))
    frame:SetPos(ScrW()/2-LinvLib:RespW(300), LinvLib:RespH(-100))
    frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, LinvLib:GetColorTheme("background"))
        draw.SimpleText(text, "LinvFontRobo20", LinvLib:RespW(600)/2, LinvLib:RespH(20), LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    print(text)
    frame:MoveTo(ScrW()/2-LinvLib:RespW(300), LinvLib:RespH(10), 0.5, 0, 1)
    timer.Simple(4, function()
        frame:MoveTo(ScrW()/2-LinvLib:RespW(300), -LinvLib:RespH(100), 0.5, 0, 1)
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

function LinvLib:Label(parent, text)
    local label = vgui.Create("DLabel", parent)
    label:SetText(text)
    label:SetAutoStretchVertical(true)
    label:SetTextColor(LinvLib:GetColorTheme("text"))
    label:SetFont("LinvFontRobo20")
    label:SizeToContents()
    label:SetContentAlignment(5)
    return label
end

function LinvLib:RichText(parent, text, w, h)
    local scroll = LinvLib:Scroll(parent, w, h)
    scroll:Dock(FILL)

    function AddLine(line)
        local label = vgui.Create("DLabel", scroll)
        label:SetWrap(true)
        label:SetAutoStretchVertical(true)
        label:SetText(line)
        label:SetWidth(w - 20) -- Laisser de l'espace pour la barre de défilement
        label:SetTextColor(LinvLib:GetColorTheme("text"))
        label:SetFont("LinvFontRobo20")
        label:Dock(TOP)
    end

    -- Séparation du texte en lignes individuelles
    local lines = string.Explode("\n", text)

    -- Ajout des lignes de texte individuelles
    for _, line in ipairs(lines) do
        AddLine(line)
    end

    return scroll
end

function LinvLib:LabelPanel(frame, text, font, weight, height)
    local panel = LinvLib:Panel(frame, weight, height)
    local background = nil
    local function RePaint(new_text)
        panel.Paint = function(self, w, h)
            if background then LinvLib:NewPaint(frame, w, h, LinvLib:GetColorTheme("border"), background) end
            draw.SimpleText(new_text || text, font, w/2, h/2, LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
    RePaint()
    function panel:SetText(text)
        RePaint(text)
    end
    function panel:SetBackground(color)
        background = color
        RePaint()
    end
    return panel
end

function LinvLib:TextEntry(frame, weight, height, text)
    local entry = vgui.Create("DTextEntry", frame)
    entry:SetSize(LinvLib:RespW(weight), LinvLib:RespH(height))
    entry:SetValue(text)
    entry:SetFont("LinvFontRobo20")
    entry:SetTextColor(LinvLib:GetColorTheme("text"))
    entry.Paint = function(self, w, h)
        LinvLib:NewPaint(entry, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("element"))
        self:DrawTextEntryText(LinvLib:GetColorTheme("text"), LinvLib:GetColorTheme("background"), LinvLib:GetColorTheme("text"))
    end
    return entry
end

net.Receive("LinvLib:Notification", function()
    local text = net.ReadString()
    LinvLib:Notif(text)
end)


function LinvLib:ColorPanel(msg, defaut_color, func)
    if !defaut_color then defaut_color = Color(255, 255, 255) end

    local frame = LinvLib:Frame(400, 475, 8)
    frame:DockPadding(LinvLib:RespW(30), LinvLib:RespW(30), LinvLib:RespW(30), LinvLib:RespW(30))

    local title = LinvLib:LabelPanel(frame, msg, "LinvFontRobo30", 400, 60)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, LinvLib:RespW(15))

    local color_mixer = vgui.Create("DColorMixer", frame)
    color_mixer:Dock(FILL)
    color_mixer:SetPalette(true)
    color_mixer:SetAlphaBar(true)
    color_mixer:SetWangs(true)
    color_mixer:SetColor(defaut_color)

    local panel_but = LinvLib:Panel(frame, 400, 50)
    panel_but:Dock(BOTTOM)
    panel_but:DockMargin(0, LinvLib:RespW(30), 0, 0)
    panel_but.Paint = function(self, w, h) end

    local but_close = LinvLib:Button(panel_but, LinvLib:GetTrad("close"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        frame:Remove()
    end)
    but_close:Dock(LEFT)

    local but_continue = LinvLib:Button(panel_but, LinvLib:GetTrad("continue"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        func(color_mixer:GetColor())
        frame:Remove()
    end)
    but_continue:Dock(RIGHT)

    return frame
end

function LinvLib:NumSlidePanel(msg, default, min, max, deci, func)
    if !defaut_color then defaut_color = Color(255, 255, 255) end

    local frame = LinvLib:Frame(400, 475, 8)
    frame:DockPadding(LinvLib:RespW(30), LinvLib:RespW(30), LinvLib:RespW(30), LinvLib:RespW(30))

    local title = LinvLib:LabelPanel(frame, msg, "LinvFontRobo25", 400, 60)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, LinvLib:RespW(15))

    local DermaNumSlider = vgui.Create( "DNumSlider", frame )
    DermaNumSlider:SetSize( 400, 100 )
    DermaNumSlider:SetMin(min)
    DermaNumSlider:SetMax(max)
    DermaNumSlider:SetValue(default)
    DermaNumSlider:SetDecimals(deci)
    DermaNumSlider:Dock(FILL)

    local panel_but = LinvLib:Panel(frame, 400, 50)
    panel_but:Dock(BOTTOM)
    panel_but:DockMargin(0, LinvLib:RespW(30), 0, 0)
    panel_but.Paint = function(self, w, h) end

    local but_close = LinvLib:Button(panel_but, LinvLib:GetTrad("close"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        frame:Remove()
    end)
    but_close:Dock(LEFT)

    local but_continue = LinvLib:Button(panel_but, LinvLib:GetTrad("continue"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        func(DermaNumSlider:GetValue())
        frame:Remove()
    end)
    but_continue:Dock(RIGHT)
end

-- LinvLib:NumSlidePanel("MSG", 0, 0, 10, 0, function(result)
--     print(result)
-- end)

function LinvLib:NumberPanel(msg, value, min, max, func, remove_func, description)
    local frame = LinvLib:Frame(400, 290, 8)
    frame:DockPadding(LinvLib:RespW(30), LinvLib:RespH(30), LinvLib:RespW(30), LinvLib:RespH(30))

    local title = LinvLib:LabelPanel(frame, msg, "LinvFontRobo25", 400, 40)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, LinvLib:RespW(10))

    if description then
        local desc = LinvLib:LabelPanel(frame, description, "LinvFontRobo20", 400, 35)
        desc:Dock(TOP)
        desc:DockMargin(0, 0, 0, LinvLib:RespW(15))
    end

    local entry = LinvLib:TextEntry(frame, 400, 50, value, true)
    entry:SetNumeric(true)
    entry.Paint = function(self, w, h)
        LinvLib:NewPaint(entry, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("element"))
        if !tonumber(self:GetValue()) || tonumber(self:GetValue()) < min || tonumber(self:GetValue()) > max then
            LinvLib:NewPaint(entry, w, h, LinvLib:GetColorTheme("red"), LinvLib:GetColorTheme("element"))
            self:DrawTextEntryText(LinvLib:GetColorTheme("red"), LinvLib:GetColorTheme("background"), LinvLib:GetColorTheme("red"))
        else
            LinvLib:NewPaint(entry, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("element"))
            self:DrawTextEntryText(LinvLib:GetColorTheme("text"), LinvLib:GetColorTheme("background"), LinvLib:GetColorTheme("text"))
        end
    end
    entry:Dock(TOP)
    entry:DockMargin(0, 0, 0, LinvLib:RespW(15))

    local panel_but = LinvLib:Panel(frame, 400, 50)
    panel_but:Dock(BOTTOM)
    panel_but:DockMargin(0, LinvLib:RespW(15), 0, 0)
    panel_but.Paint = function(self, w, h) end

    local but_close = LinvLib:Button(panel_but, LinvLib:GetTrad("close"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        if remove_func then remove_func() end
        frame:Remove()
    end)
    but_close:Dock(LEFT)

    local but_continue = LinvLib:Button(panel_but, LinvLib:GetTrad("continue"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        if !tonumber(entry:GetValue()) || tonumber(entry:GetValue()) < min || tonumber(entry:GetValue()) > max then
            LinvLib:Notif(LinvLib:GetTrad("invalid_value"))
        else
            func(tonumber(entry:GetValue()))
            if remove_func then remove_func() end
            frame:Remove()
        end
    end)
    but_continue:Dock(RIGHT)
end

function LinvLib:TextPanel(msg, value, func, remove_func, description)
    local frame = LinvLib:Frame(400, 290, 8)
    frame:DockPadding(LinvLib:RespW(30), LinvLib:RespH(30), LinvLib:RespW(30), LinvLib:RespH(30))

    local title = LinvLib:LabelPanel(frame, msg, "LinvFontRobo25", 400, 40)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, LinvLib:RespW(10))

    if description then
        local desc = LinvLib:LabelPanel(frame, description, "LinvFontRobo20", 400, 35)
        desc:Dock(TOP)
        desc:DockMargin(0, 0, 0, LinvLib:RespW(15))
    end

    local entry = LinvLib:TextEntry(frame, 400, 50, value, true)
    entry:Dock(TOP)
    entry:DockMargin(0, 0, 0, LinvLib:RespW(15))

    local panel_but = LinvLib:Panel(frame, 400, 50)
    panel_but:Dock(BOTTOM)
    panel_but:DockMargin(0, LinvLib:RespW(15), 0, 0)
    panel_but.Paint = function(self, w, h) end

    local but_close = LinvLib:Button(panel_but, LinvLib:GetTrad("close"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        if remove_func then remove_func() end
        frame:Remove()
    end)
    but_close:Dock(LEFT)

    local but_continue = LinvLib:Button(panel_but, LinvLib:GetTrad("continue"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
        func(entry:GetValue())
        if remove_func then remove_func() end
        frame:Remove()
    end)
    but_continue:Dock(RIGHT)
end

function LinvLib:CloseButton(parent, w, h, x, y, func)
    local close = LinvLib:Button(parent, " ", w, h, LinvLib:GetColorTheme("element"), false, function()
        func()
    end)
    close:SetPos(x, y)
    close.Paint = function(self, w, h)
        surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
        surface.SetMaterial(LinvLib.Materials["cancel"])
        surface.DrawTexturedRect(0, 0, LinvLib:RespW(w), LinvLib:RespH(h))
    end
    return close
end

function LinvLib:Icon(element, mat, hover)
    element.Paint = function(self, w, h)
        surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(0, 0, LinvLib:RespW(w), LinvLib:RespH(h))
    end
    if hover then
        element.OnCursorEntered = function(self)
            self.Paint = function(self, w, h)
                surface.SetDrawColor(LinvLib:GetColorTheme("hover"))
                surface.SetMaterial(mat)
                surface.DrawTexturedRect(0, 0, LinvLib:RespW(w), LinvLib:RespH(h))
            end
        end
        element.OnCursorExited = function(self)
            self.Paint = function(self, w, h)
                surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
                surface.SetMaterial(mat)
                surface.DrawTexturedRect(0, 0, LinvLib:RespW(w), LinvLib:RespH(h))
            end
        end
    end
end

function LinvLib:WebPage(url, args)
    if (jit.version != "LuaJIT 2.1.0-beta3") then
        gui.OpenURL(url)
        return
    end
    if !args || !istable(args) then args = {} end
    local frame = LinvLib:Frame(1920*0.8+90, 1080*0.8+90)
    local url_label = LinvLib:Label(frame, url)
    url_label:SetPos(LinvLib:RespW((1920*0.8+120)/2)-url_label:GetWide()/2, LinvLib:RespH(15))
    local web = vgui.Create("DHTML", frame)
    web:SetSize(LinvLib:RespW(1920*0.8), LinvLib:RespH(1080*0.8))
    web:OpenURL(url)
    web:Center()
    local close = LinvLib:CloseButton(frame, LinvLib:RespW(30), LinvLib:RespH(30), LinvLib:RespW(1920*0.8+50), LinvLib:RespH(10), function()
        frame:Remove()
        if args.on_close then args.on_close() end
    end)
end

function LinvLib:CheckBox(parent, w, h, func)
    -- local panel = LinvLib:Panel(parent, w, h)
    -- panel:SetPos(x, y)
    -- panel.IsChecked = false
    -- LinvLib:Icon(panel, LinvLib.Materials["check"], true)
    -- panel.OnMousePressed = function(self)
    --     if self.IsChecked then
    --         self.IsChecked = false
    --         self.Paint = function(self, w, h)
    --             surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
    --             surface.SetMaterial(LinvLib.Materials["check"])
    --             surface.DrawTexturedRect(0, 0, LinvLib:RespW(w), LinvLib:RespH(h))
    --         end
    --         func(self.IsChecked)
    --     else
    --         self.IsChecked = true
    --         self.Paint = function(self, w, h)
    --             surface.SetDrawColor(LinvLib:GetColorTheme("hover"))
    --             surface.SetMaterial(LinvLib.Materials["check"])
    --             surface.DrawTexturedRect(0, 0, LinvLib:RespW(w), LinvLib:RespH(h))
    --         end
    --     end
    --     func(self.IsChecked)
    -- end
    local but = LinvLib:Button(parent, " ", w, h, LinvLib:GetColorTheme("element"), false, function()
        if but.IsChecked then
            but.IsChecked = false
            LinvLib:Icon(panel, LinvLib.Materials["check"], true)
            func(but.IsChecked)
        else
            LinvLib:Icon(panel, LinvLib.Materials["cross"], true)
            but.IsChecked = true
        end
        func(but.IsChecked)
    end)
end

// New VGUI

LinvLib.VGUI = {}

function LinvLib.VGUI.CreatePrefabFrame()
    local title = "Title"
    local func_on_close = function() end

    local frame = LinvLib:Frame(850, 550)

    local function Rebuild()
        frame:Remove()
        frame = LinvLib:Frame(850, 550)

        local panel_info = vgui.Create("DPanel", frame)
        panel_info:SetSize(LinvLib:RespW(850), LinvLib:RespH(40))
        panel_info.Paint = function(self, w, h)
            draw.RoundedBoxEx(LinvLib.Config.Rounded, 0, 0, w, h, LinvLib.GetThemeColor("element"), true, true, false, false)
        end
        panel_info:Dock(TOP)

        local dlabel_title = vgui.Create("DLabel", panel_info)
        dlabel_title:SetText(title)
        dlabel_title:SetFont(LinvLib.GetThemeFont("title"))
        dlabel_title:SetTextColor(LinvLib.GetThemeColor("text"))
        dlabel_title:SizeToContents()
        dlabel_title:Dock(LEFT)
        dlabel_title:DockMargin(LinvLib:RespW(5), 0, 0, 0)

        local but_close = LinvLib:CloseButton(panel_info, 30, 30, 810, 10, function()
            frame:Remove()
            func_on_close()
        end)
        but_close:Dock(RIGHT)
        but_close:DockMargin(LinvLib:RespW(5), LinvLib:RespH(5), LinvLib:RespW(5), LinvLib:RespH(5))
    end

    // Setters
    function frame.LinvLibSetTitle(new_title)
        print("Set title" .. new_title)
        -- title = new_title
        -- Rebuild()
    end

    // create function how say banana

    function frame.SetOnClose(new_func)
        func_on_close = new_func
    end

    // Getters
    function frame.GetAll()
        return {
            ["title"] = title,
        }
    end

    function frame.Banan()
        print("Banan")
    end

    function frame.GetTitle()
        return title
    end

    // Rebuild
    Rebuild()

    // Return frame
    return frame
end

LinvLib.VGUI.SetTitle = function(frame, new_title)
    frame.LinvLibSetTitle(new_title)
end

function LinvLib.SelectMenu(data)
    local select_menu = LinvLib:Frame(410, 415)
    select_menu:DockMargin(0, 0, 0, 0)
    select_menu:DockPadding(0, LinvLib:RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(select_menu, data["title"], "LinvFontRobo25", 400, 60)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, LinvLib:RespW(15))

    local scroll = LinvLib:Scroll(select_menu, 365, 225)
    scroll:SetPos(30, 80)
    for k, v in pairs(data["data"]) do
        local button = LinvLib:Button(scroll, v, 365, 40, LinvLib:GetColorTheme("element"), true, function()
            select_menu:Close()
            data["callback"](v)
        end)
        button:Dock(TOP)
        button:DockMargin(0, 15, 15, 0)
    end

    local but_close = LinvLib:Button(select_menu, LinvLib:GetTrad("close"), 200, 50, LinvLib:GetColorTheme("element"), true, function()
        select_menu:Close()
    end)
    but_close:SetPos(105, 330)
    select_menu.OnRemove = function()
        RunConsoleCommand("linvlib_settings")
    end
end