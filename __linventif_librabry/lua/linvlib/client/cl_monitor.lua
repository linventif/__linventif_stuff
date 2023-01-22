local function RespW(x)
    return ScrW() / 1920 * x
end

local function RespH(y)
    return ScrH() / 1080 * y
end

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

// -- // -- // --

local id_type = {
    ["boolean"] = {
        ["AdminMenu"] = true,
        ["AdminMenuExtend"] = true,
        ["AdminTicket"] = true,
        ["GlobalBan"] = true,
        ["PlayerTrustFactor"] = true,
        ["DebugMode"] = true,
        ["MonitorShowEveryJoin"] = true,
        ["MonitorShowNewUpadte"] = true,
        ["MonitorShowNewAddon"] = true,
    },
    ["string"] = {
        ["Language"] = true
    }
}

local function SaveSetting(id, data)
    net.Start("LinvLib:SaveSetting")
        net.WriteString(id)
        if id_type["boolean"][id] then
            net.WriteBool(data)
        else
            net.WriteString(data)
        end
    net.SendToServer()
end

local function RefreshIcon(element, v2)
    element.Paint = function(self, w, h)
        draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("accent"))
        surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
        if v2["checkbox"] && !v2["state"] then
            surface.SetMaterial(Material("Models/effects/vol_light001"))
        else
            surface.SetMaterial(v2["icon"])
        end
        surface.DrawTexturedRect(RespW(5), RespH(5), RespW(30), RespH(30))
    end
end

local function OpenSelect(data)
    -- local blur = LinvLib:Blur(Color(255, 180, 60, 60), 1)
    local select_menu = LinvLib:Frame(410, 415)
    select_menu.Paint = function(self, w, h)
        draw.RoundedBox(RespW(14), 0, 0, w, h, LinvLib:GetColorTheme("background"))
        draw.SimpleText(data["title"], "LinvFontRobo25", w/2, RespH(40), LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    local scroll = LinvLib:Scroll(select_menu, 365, 245)
    scroll:SetPos(30, 80)
    for k, v in pairs(data["data"]) do
        if data["type"] == ["simple"] then
            local button = LinvLib:Button(scroll, v, 365, 40, true, function()
                select_menu:Close()
                data["callback"](v)
            end)
        end
        button:Dock(TOP)
        button:DockMargin(0, 15, 15, 0)
    end
    local but_close = LinvLib:Button(select_menu, "Close", 200, 50, true, function()
        select_menu:Close()
    end)
    but_close:SetPos(105, 345)
    select_menu.OnRemove = function()
        -- blur:Remove()
        RunConsoleCommand("linvlib_settings")
    end
end

local function OpenSettings()
    local settings_list = {
        [1] = {
            ["name"] = "General",
            ["settings"] = {
                [1] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        OpenSelect({
                            ["title"] = "Language",
                            ["data"] = {
                                [1] = "english",
                                [2] = "french"
                            },
                            ["type"] = "simple",
                            ["callback"] = function(data)
                                LinvLib.Config.Language = data
                                SaveSetting("Language", LinvLib.Config.Language)
                            end
                        })
                    end,
                    ["name"] = "Language : " .. LinvLib.Config.Language
                },
                [2] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        OpenSelect({
                            ["title"] = "Language",
                            ["data"] = LinvLib.Install,
                            ["type"] = "checkbox",
                            ["callback"] = function(data)
                                LinvLib.Config.Language = data
                                SaveSetting("Language", LinvLib.Config.Language)
                            end
                        })
                    end,
                    ["name"] = "Compatible Addon"
                },
                [3] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        OpenSelect({
                            ["title"] = "Theme",
                            ["data"] = {
                                [1] = "linventif",
                                [2] = "dark",
                                [3] = "grey",
                                [4] = "light"
                            },
                            ["type"] = "simple",
                            ["callback"] = function(data)
                                LinvLib.Config.Theme = data
                                SaveSetting("Theme", LinvLib.Config.Theme)
                            end
                        })
                    end,
                    ["name"] = "Theme : " .. LinvLib.Config.Theme
                },
            }
        },
        [2] = {
            ["name"] = "Monitor",
            ["settings"] = {
                [1] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.MonitorShowEveryJoin,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.MonitorShowEveryJoin then
                            LinvLib.Config.MonitorShowEveryJoin = false
                        else
                            LinvLib.Config.MonitorShowEveryJoin = true
                        end
                        SaveSetting("MonitorShowEveryJoin", LinvLib.Config.MonitorShowEveryJoin)
                    end,
                    ["name"] = "Show at every join"
                },
                [2] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.MonitorShowIfNewUpdate,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.MonitorShowIfNewUpdate then
                            LinvLib.Config.MonitorShowIfNewUpdate = false
                        else
                            LinvLib.Config.MonitorShowIfNewUpdate = true
                        end
                        SaveSetting("MonitorShowNewUpadte", LinvLib.Config.MonitorShowIfNewUpdate)
                    end,
                    ["name"] = "Show if addon need update"
                },
                [3] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.MonitorShowIfNewAddon,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.MonitorShowIfNewAddon then
                            LinvLib.Config.MonitorShowIfNewAddon = false
                        else
                            LinvLib.Config.MonitorShowIfNewAddon = true
                        end
                        SaveSetting("MonitorShowNewAddon", LinvLib.Config.MonitorShowIfNewAddon)
                    end,
                    ["name"] = "Show if new addon is detected"
                },
            }
        },
        [3] = {
            ["name"] = "Admin Suite (-In Dev-)",
            ["settings"] = {
                [1] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.AdminMenu,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.AdminMenu then
                            LinvLib.Config.AdminMenu = false
                        else
                            LinvLib.Config.AdminMenu = true
                        end
                        SaveSetting("AdminMenu", LinvLib.Config.AdminMenu)
                    end,
                    ["name"] = "Admin Menu"
                },
                [2] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.AdminMenuExtended,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.AdminMenuExtended then
                            LinvLib.Config.AdminMenuExtended = false
                        else
                            LinvLib.Config.AdminMenuExtended = true
                        end
                        SaveSetting("AdminMenuExtend", LinvLib.Config.AdminMenuExtended)
                    end,
                    ["name"] = "Admin Menu Extended"
                },
                [3] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.AdminTicket,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.AdminTicket then
                            LinvLib.Config.AdminTicket = false
                        else
                            LinvLib.Config.AdminTicket = true
                        end
                        SaveSetting("AdminTicket", LinvLib.Config.AdminTicket)
                    end,
                    ["name"] = "Ticket Admin"
                },
                [4] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        LinvLib:Notif("in_dev")
                    end,
                    ["name"] = "Admin Groups"
                },
            }
        },
        [4] = {
            ["name"] = "Linventif Security (-In Dev-))",
            ["settings"] = {
                [1] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.GlobalBan,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.GlobalBan then
                            LinvLib.Config.GlobalBan = false
                        else
                            LinvLib.Config.GlobalBan = true
                        end
                        SaveSetting("GlobalBan", LinvLib.Config.GlobalBan)
                    end,
                    ["name"] = "Global Ban"
                },
                [2] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.PlayerTrustFactor,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.PlayerTrustFactor then
                            LinvLib.Config.PlayerTrustFactor = false
                        else
                            LinvLib.Config.PlayerTrustFactor = true
                        end
                        SaveSetting("PlayerTrustFactor", LinvLib.Config.PlayerTrustFactor)
                    end,
                    ["name"] = "Player Trust Factor"
                },
            }
        },
        [5] = {
            ["name"] = "Others",
            ["settings"] = {
                [1] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.DebugMode,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        if LinvLib.Config.DebugMode then
                            LinvLib.Config.DebugMode = false
                        else
                            LinvLib.Config.DebugMode = true
                        end
                        SaveSetting("DebugMode", LinvLib.Config.DebugMode)
                    end,
                    ["name"] = "Debug Mode"
                },
            }
        },
    }

    local frame = LinvLib:Frame(910, 720)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("background"))
        draw.SimpleText("Linventif Library - " .. LinvLib.version .. " - Settings", "LinvFontRobo25", RespW(910/2), RespH(40), LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    local scroll = LinvLib:Scroll(frame, 895, 610)
    scroll:SetPos(RespW(0), RespH(80))
    for k, v in SortedPairs(settings_list) do
        local panel = vgui.Create("DPanel", scroll)
        panel:SetSize(RespW(840), RespH(math.Round(#v["settings"]/2)*60 + (math.Round(#v["settings"]/2) - 1)*30) + 50)
        panel.Paint = function(self, w, h)
            draw.RoundedBox(RespW(8), 0, 0, w, h, Color(0, 0, 0, 0))
            draw.SimpleText(v["name"], "LinvFontRobo25", RespW(840/2), RespH(20), LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        local dplist = vgui.Create("DPanelList", panel)
        dplist:SetSize(RespW(840), RespH(math.Round(#v["settings"]/2)*60 + (math.Round(#v["settings"]/2) - 1)*30))
        // math.Round(#v["settings"]/2)*60 + (math.Round(#v["settings"]/2) - 1)*30) = total height (60 = height of panel, 30 = spacing)
        dplist:SetPos(RespW(0), RespH(50))
        dplist:EnableVerticalScrollbar(true)
        dplist:EnableHorizontal(true)
        dplist:SetSpacing(RespW(30))
        dplist:SetPadding(RespW(0))
        dplist.Paint = function(self, w, h)
            draw.RoundedBox(RespW(8), 0, 0, w, h, Color(0, 0, 0, 0))
        end
        for k2, v2 in SortedPairs(v["settings"]) do
            local panel = vgui.Create("DPanel")
            panel:SetSize(RespW(405), RespH(60))
            panel.Paint = function(self, w, h)
                draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
                -- draw.RoundedBox(RespW(8), 355, 10, 40, 40, LinvLib:GetColorTheme("accent"))
                draw.SimpleText(v2["name"], "LinvFontRobo20", RespW(177.5), RespH(30), LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            local but_act = LinvLib:Button(panel, "", 40, 40, false, v2["function"])
            but_act:SetPos(RespW(355), RespH(10))
            RefreshIcon(but_act, v2)
            but_act.DoClick = function()
                if v2["checkbox"] then
                    if v2["state"] then
                        v2["state"] = false
                    else
                        v2["state"] = true
                    end
                else
                    frame:Remove()
                end
                v2["function"]()
                RefreshIcon(but_act, v2)
            end
            dplist:AddItem(panel)
        end
        panel:Dock(TOP)
        panel:DockMargin(30, 0, 0, 30)
    end
end

net.Receive("LinvLib:SaveSetting", function()
    LinvLib.Config = util.JSONToTable(net.ReadString())
    LinvLib:Notif(LinvLib:GetTrad("new_setting_received"))
end)

concommand.Add("linvlib_settings", function()
    if LinvLib.Config.AdminGroups[LocalPlayer():GetUserGroup()] then
        OpenSettings()
    else
        LinvLib:Notif(LinvLib:GetTrad("not_perm"))
    end
end)