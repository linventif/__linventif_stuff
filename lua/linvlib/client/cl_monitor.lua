local function OpenPanel(data)
    local frame = vgui.Create("DFrame")
    frame:SetSize(650, 750)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(113, 113, 113))
        draw.RoundedBox(6, 4, 4, w-8, h-8, Color(51, 51, 51, 255))
        draw.SimpleText("Linventif's Addon & Script Monitor", "LinvFontRobo30", 650/2, 55, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Icon", "LinvFontRobo20", 66, 116, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Name", "LinvFontRobo20", 200, 116, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Your Version", "LinvFontRobo20", 322, 116, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Last Version", "LinvFontRobo20", 450, 116, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Link", "LinvFontRobo20", 565, 116, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local scroll_panel = vgui.Create("DPanel", frame)
    scroll_panel:SetPos(24, 136)
    scroll_panel:SetSize(605, 528)
    scroll_panel.Paint = function(s, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(0,0,0,0))
    end

    local scroll = vgui.Create("DScrollPanel", scroll_panel)
    scroll:Dock(FILL)

    local vbar = scroll.VBar
	vbar:SetHideButtons( true )
	function vbar.btnUp:Paint( w, h ) end
	function vbar:Paint( w, h ) end
	function vbar.btnGrip:Paint( w, h ) end

    scroll.VBar:SetHideButtons(true)
	scroll.VBar.Paint = function() end

	scroll.VBar:SetWide(0)
	scroll.VBar.btnUp.Paint = scroll.VBar.Paint
	scroll.VBar.btnDown.Paint = scroll.VBar.Paint
	scroll.VBar.btnGrip.Paint = function(self, w, h) end

    for k, v in SortedPairs(data) do
        for k2, v2 in SortedPairs(v) do
            if !LinvLib.Install[k2] then continue end
            local status_name = "Open"
            local status_color = Color(0, 200, 0)
            if v2.version != LinvLib.Install[k2] then
                status_name = "Upgrade"
                status_color = Color(200, 0, 0)
            end
            local addon = scroll:Add("DPanel")
            addon:SetSize(604, 84)
            addon:Dock(TOP)
            addon:DockMargin(0, 0, 0, 15)
            addon.Paint = function(s, w, h)
                draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
                draw.SimpleText(v2.title, "LinvFontRobo20", 200-24, 42, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(LinvLib.Install[k2], "LinvFontRobo20", 322-24, 42, status_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(v2.version, "LinvFontRobo20", 450-24, 42, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            local icon = vgui.Create("DImage", addon)
            icon:SetSize(64, 64)
            icon:SetPos(10, 10)
            if file.Exists("materials/linventif-library/" .. k2 .. ".png", "GAME") then
                icon:SetImage("materials/linventif-library/" .. k2 .. ".png")
            else
                icon:SetImage("materials/linventif-library/unknown.png")
            end
            local ButLink = vgui.Create("DButton", addon)
            ButLink:SetPos(490, 17)
            ButLink:SetSize(100, 50)
            ButLink:SetText(status_name)
            ButLink:SetFont("LinvFontRobo20")
            ButLink:SetTextColor(Color(255, 255, 255, 255))
            ButLink.DoClick = function()
                gui.OpenURL(v2.repository)
            end
            ButLink.Paint = function(self, w, h)
                draw.RoundedBox(6, 0, 0, w, h, status_color)
                draw.RoundedBox(6, 4, 4, w-8, h-8, Color(113, 113, 113))
            end
            ButLink.OnCursorEntered = function()
                ButLink.Paint = function(self, w, h)
                    draw.RoundedBox(6, 0, 0, w, h, status_color)
                    draw.RoundedBox(6, 4, 4, w-8, h-8, Color(100, 100, 100))
                end
            end
            ButLink.OnCursorExited = function()
                ButLink.Paint = function(self, w, h)
                    draw.RoundedBox(6, 0, 0, w, h, status_color)
                    draw.RoundedBox(6, 4, 4, w-8, h-8, Color(113, 113, 113))
                end
            end
        end
    end

    local ButSetting = vgui.Create("DButton", frame)
    ButSetting:SetPos(24, 676)
    ButSetting:SetSize(170, 50)
    ButSetting:SetText("Global Settings")
    ButSetting:SetFont("LinvFontRobo20")
    ButSetting:SetTextColor(Color(255, 255, 255, 255))
    ButSetting.DoClick = function()
        LocalPlayer():ChatPrint("This feature is not available yet.")
        notification.AddLegacy("This feature is not available yet.", 1, 5)
    end
    ButSetting.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
        draw.RoundedBox(6, 4, 4, w-8, h-8, Color(51, 51, 51, 255))
    end
    ButSetting.OnCursorEntered = function()
        ButSetting.Paint = function(self, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
            draw.RoundedBox(6, 4, 4, w-8, h-8, Color(77, 77, 77))
        end
    end
    ButSetting.OnCursorExited = function()
        ButSetting.Paint = function(self, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
            draw.RoundedBox(6, 4, 4, w-8, h-8, Color(51, 51, 51, 255))
        end
    end
    local ButSupport = vgui.Create("DButton", frame)
    ButSupport:SetPos(235, 676)
    ButSupport:SetSize(210, 50)
    ButSupport:SetText("All Addon & Support")
    ButSupport:SetFont("LinvFontRobo20")
    ButSupport:SetTextColor(Color(255, 255, 255, 255))
    ButSupport.DoClick = function()
        gui.OpenURL("https://dsc.gg/linventif")
    end
    ButSupport.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
        draw.RoundedBox(6, 4, 4, w-8, h-8, Color(51, 51, 51, 255))
    end
    ButSupport.OnCursorEntered = function()
        ButSupport.Paint = function(self, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
            draw.RoundedBox(6, 4, 4, w-8, h-8, Color(77, 77, 77))
        end
    end
    ButSupport.OnCursorExited = function()
        ButSupport.Paint = function(self, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
            draw.RoundedBox(6, 4, 4, w-8, h-8, Color(51, 51, 51, 255))
        end
    end
    local ButClose = vgui.Create("DButton", frame)
    ButClose:SetPos(486, 676)
    ButClose:SetSize(140, 50)
    ButClose:SetText("Close")
    ButClose:SetFont("LinvFontRobo20")
    ButClose:SetTextColor(Color(255, 255, 255, 255))
    ButClose.DoClick = function()
        frame:Close()
    end
    ButClose.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
        draw.RoundedBox(6, 4, 4, w-8, h-8, Color(51, 51, 51, 255))
    end
    ButClose.OnCursorEntered = function()
        ButClose.Paint = function(self, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
            draw.RoundedBox(6, 4, 4, w-8, h-8, Color(77, 77, 77))
        end
    end
    ButClose.OnCursorExited = function()
        ButClose.Paint = function(self, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(113, 113, 113))
            draw.RoundedBox(6, 4, 4, w-8, h-8, Color(51, 51, 51, 255))
        end
    end
end

local function GetData()
    http.Fetch("https://api.linventif.fr/addons_and_scripts.json", function(body, length, headers, code)
        OpenPanel(util.JSONToTable(body))
    end, function(message)
        print(message)
    end)
end

concommand.Add("linventif_monitor", function(ply)
    GetData()
end)

local AdminGroup = {
    ["superadmin"] = true,
    ["fondateur"] = true,
    ["fonda"] = true,
    ["owner"] = true,
    ["admin"] = true
}
hook.Add("InitPostEntity", "LinvLibOpenVerif", function()
    if AdminGroup[LocalPlayer():GetUserGroup()] then
        timer.Simple(5, function()
            GetData()
        end)
    end
end)