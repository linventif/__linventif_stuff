local function RespW(x)
    return ScrW() / 1920 * x
end

local function RespH(y)
    return ScrH() / 1080 * y
end

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
        ["ForceMaterial"] = true,
        ["MoneySymbolLeft"] = true,
        ["ShowNPCName"] = true,
        ["Blur"] = true
    },
    ["string"] = {
        ["Language"] = true,
        ["Theme"] = true,
        ["Money Symbol"] = true,
        ["Money Symbol Separator"] = true,
    },
    ["table"] = {
        ["CompatibleAddon"] = true,
        ["AdminGroups"] = true
    },
    ["color"] = {
        ["background"] = true
    },
    ["number"] = {
        ["Border"] = true,
        ["Rounded"] = true
    },
    ["double"] = {
        ["CrossBorder"] = true
    }
}

local function SaveSetting(id, data)
    net.Start("LinvLib:SaveSetting")
        net.WriteString(id)
        if id_type["boolean"][id] then
            net.WriteBool(data)
        elseif id_type["string"][id] then
            net.WriteString(data)
        elseif id_type["table"][id] then
            net.WriteString(util.TableToJSON(data))
        elseif id_type["color"][id] then
            net.WriteString("color")
            net.WriteString(id)
            net.WriteColor(data)
        elseif id_type["number"][id] then
            net.WriteInt(data, 32)
        elseif id_type["double"][id] then
            net.WriteDouble(data)
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
    select_menu:DockMargin(0, 0, 0, 0)
    select_menu:DockPadding(0, RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(select_menu, data["title"], "LinvFontRobo25", 400, 60)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, RespW(15))

    local scroll = LinvLib:Scroll(select_menu, 365, 225)
    scroll:SetPos(30, 80)
    if data["type"] == "addon" then
        data["data"] = LinvLib.Config.Compatibility
    end
    for k, v in pairs(data["data"]) do
        if data["type"] == "simple" then
            local button = LinvLib:Button(scroll, v, 365, 40, LinvLib:GetColorTheme("element"), true, function()
                select_menu:Close()
                data["callback"](v)
            end)
            button:Dock(TOP)
            button:DockMargin(0, 15, 15, 0)
        elseif data["type"] == "addon" then
            local panel = LinvLib:Panel(scroll, 365, 40)
            panel:Dock(TOP)
            panel:DockMargin(0, 15, 15, 0)
            panel.Paint = function(self, w, h)
                draw.RoundedBox(RespW(8), 0, 0, RespW(290), h, LinvLib:GetColorTheme("element"))
                draw.SimpleText(k, "LinvFontRobo20", RespW(290/2), h/2, LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            local but_act = LinvLib:Button(panel, "", 40, 40, LinvLib:GetColorTheme("element"), false, function() end)
            but_act:SetPos(RespW(305), RespH(0))
            but_act.Paint = function(self, w, h)
                draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
                if v then
                    surface.SetMaterial(Material("Models/effects/vol_light001"))
                    surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
                    surface.DrawTexturedRect(RespW(5), RespH(5), RespW(30), RespH(30))
                end
            end
            but_act.DoClick = function()
                if v then
                    v = false
                    but_act.Paint = function(self, w, h)
                        draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
                        surface.SetMaterial(Material("Models/effects/vol_light001"))
                        surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
                        surface.DrawTexturedRect(RespW(5), RespH(5), RespW(30), RespH(30))
                    end
                else
                    v = true
                    but_act.Paint = function(self, w, h)
                        draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
                        surface.SetMaterial(LinvLib.Materials["valid"])
                        surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
                        surface.DrawTexturedRect(RespW(5), RespH(5), RespW(30), RespH(30))
                    end
                end
                data["callback"](k, v)
            end
        end
    end
    local but_close = LinvLib:Button(select_menu, LinvLib:GetTrad("close"), 200, 50, LinvLib:GetColorTheme("element"), true, function()
        select_menu:Close()
    end)
    but_close:SetPos(105, 330)
    select_menu.OnRemove = function()
        RunConsoleCommand("linvlib_settings")
    end
end

local function OpenStringList(data, func)
    local frame = LinvLib:Frame(450, 480)
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(LinvLib:RespW(30), LinvLib:RespH(20), LinvLib:RespW(30), LinvLib:RespH(30))

    local title = LinvLib:LabelPanel(frame, LinvLib:GetTrad("admin_group"), "LinvFontRobo30", 400, 40)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, LinvLib:RespH(15))

    local scroll = LinvLib:Scroll(frame, 540, 500)
    scroll:Dock(FILL)
    if table.Count(data) > 4 then
        scroll:DockMargin(0, 0, RespW(-20), RespH(15))
    else
        scroll:DockMargin(0, 0, RespW(0), RespH(15))
    end
    for k, v in pairs(data) do
        local panel = LinvLib:Panel(scroll, 540, 50)
        panel:Dock(TOP)
        if table.Count(data) > 4 then
            panel:DockMargin(0, 0, RespW(10), RespH(15))
        else
            panel:DockMargin(0, 0, RespW(0), RespH(15))
        end
        panel:DockPadding(LinvLib:RespW(5), LinvLib:RespH(5), LinvLib:RespW(5), LinvLib:RespH(5))
        panel.Paint = function(self, w, h)
            draw.RoundedBox(LinvLib:RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
        end
        local name = LinvLib:LabelPanel(panel, k, "LinvFontRobo20", 400, 60)
        name:Dock(FILL)
        scroll:AddItem(panel)
        if k == "superadmin" || k == LocalPlayer():GetUserGroup() then continue end
        local but_remove = LinvLib:Button(panel, "", 40, 40, Color(0, 0, 0, 0), true, function()
            data[k] = nil
            func(data)
            frame:Close()
        end)
        LinvLib:Icon(but_remove, LinvLib.Materials["cross"], true)
        but_remove:Dock(RIGHT)
    end

    local close = LinvLib:Button(frame, LinvLib:GetTrad("close"), 200, 50, LinvLib:GetColorTheme("element"), true, function()
        frame:Close()
    end)

    local add = LinvLib:TextEntry(frame, 540, 50, LinvLib:GetTrad("add_group"))
    add:Dock(BOTTOM)
    add:DockMargin(0, 0, 0, LinvLib:RespH(15))
    add.OnEnter = function()
        if !add:GetValue() then return end
        data[add:GetValue()] = true
        func(data)
        frame:Close()
    end

    frame.OnRemove = function()
        RunConsoleCommand("linvlib_settings")
    end

    close:Dock(BOTTOM)
end

local function GetLanguageSetting()
    if !LinvLib.Config.ForceLanguage && !LinvLib.Config.DebugMode then
        return "Auto"
    else
        return LinvLib.Config.Language
    end
end

local function OpenSettings()
    if !LinvLib.Config.InGameSettings then
        LinvLib:Notif(LinvLib:GetTrad("settings_in_file_only"))
        return
    end
    local settings_list = {
        [1] = {
            ["name"] = LinvLib:GetTrad("general"),
            ["settings"] = {
                [1] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        RunConsoleCommand("linvlib_settings")
                        LinvLib:Notif(LinvLib:GetTrad("lang_cant_changed"))
                    end,
                    ["name"] = LinvLib:GetTrad("language") .. " : " .. GetLanguageSetting()
                },
                [2] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        local data_table = {
                            ["title"] = LinvLib:GetTrad("theme"),
                            ["data"] = LinvLib:GetThemesId(),
                            ["type"] = "simple",
                            ["callback"] = function(data)
                                if data == "Add Theme" then
                                    LinvLib:Notif(LinvLib:GetTrad("theme_add"))
                                else
                                    LinvLib.Config.Theme = data
                                    SaveSetting("Theme", LinvLib.Config.Theme)
                                end
                            end
                        }
                        data_table.data[#data_table.data + 1] = "Add Theme"
                        OpenSelect(data_table)
                    end,
                    ["name"] = LinvLib:GetTrad("theme") .. " : " .. LinvLib.Config.Theme
                },
                [3] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        OpenStringList(LinvLib.Config.AdminGroups, function(data)
                            LinvLib.Config.AdminGroups = data
                            SaveSetting("AdminGroups", LinvLib.Config.AdminGroups)
                        end)
                    end,
                    ["name"] = LinvLib:GetTrad("admin_group")
                },
                [4] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        OpenStringList(LinvLib.Config.SuperAdminGroups, function(data)
                            LinvLib.Config.SuperAdminGroups = data
                            SaveSetting("SuperAdminGroups", LinvLib.Config.SuperAdminGroups)
                        end)
                    end,
                    ["name"] = LinvLib:GetTrad("super_admin_group")
                },
            }
        },
        [2] = {
            ["name"] = LinvLib:GetTrad("monitor"),
            ["settings"] = {
                [1] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.MonitorShowEveryJoin,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        SaveSetting("MonitorShowEveryJoin", !LinvLib.Config.MonitorShowEveryJoin)
                    end,
                    ["name"] = LinvLib:GetTrad("show_at_every_join")
                },
                [2] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.MonitorShowIfNewUpdate,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        SaveSetting("MonitorShowNewUpadte", !LinvLib.Config.MonitorShowIfNewUpdate)
                    end,
                    ["name"] = LinvLib:GetTrad("show_if_need_update")
                },
            }
        },
        [3] = {
        -- [4] = {
            ["name"] = LinvLib:GetTrad("linventif_security"),
            ["settings"] = {
                [1] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.GlobalBan,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        SaveSetting("GlobalBan", !LinvLib.Config.GlobalBan)
                    end,
                    ["name"] = LinvLib:GetTrad("global_ban")
                },
            }
        },
        [4] = {
        -- [5] = {
            ["name"] = LinvLib:GetTrad("money_settings"),
            ["settings"] = {
                [1] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        LinvLib:TextPanel(LinvLib:GetTrad("money_symbol"), LinvLib.Config.MoneySymbol, function(value)
                            LinvLib.Config.MoneySymbol = value
                            SaveSetting("Money Symbol", LinvLib.Config.MoneySymbol)
                        end, function()
                            RunConsoleCommand("linvlib_settings")
                        end)
                    end,
                    ["name"] = LinvLib:GetTrad("money_symbol")
                },
                [2] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        LinvLib:TextPanel(LinvLib:GetTrad("money_symbol_separator"), LinvLib.Config.MoneySymbolSeparator, function(value)
                            LinvLib.Config.MoneySymbolSeparator = value
                            SaveSetting("Money Symbol Separator", LinvLib.Config.MoneySymbolSeparator)
                        end, function()
                            RunConsoleCommand("linvlib_settings")
                        end)
                    end,
                    ["name"] = LinvLib:GetTrad("money_symbol_separator")
                },
                [3] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.MoneySymbolLeft,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        SaveSetting("MoneySymbolLeft", !LinvLib.Config.MoneySymbolLeft)
                    end,
                    ["name"] = LinvLib:GetTrad("money_symbol_position")
                },
            }
        },
        [5] = {
            ["name"] = LinvLib:GetTrad("customisation"),
            ["settings"] = {
                [1] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        LinvLib:NumberPanel(LinvLib:GetTrad("border_size"), LinvLib.Config.Border, 0, 100000, function(value)
                            LinvLib.Config.Border = value
                            SaveSetting("Border", LinvLib.Config.Border)
                        end, function()
                            RunConsoleCommand("linvlib_settings")
                        end)
                    end,
                    ["name"] = LinvLib:GetTrad("border_size")
                },
                [2] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        LinvLib:NumberPanel(LinvLib:GetTrad("cross_border"), LinvLib.Config.CrossBorder, 0, 100000, function(value)
                            LinvLib.Config.CrossBorder = value
                            SaveSetting("CrossBorder", LinvLib.Config.CrossBorder)
                        end, function()
                            RunConsoleCommand("linvlib_settings")
                        end, LinvLib:GetTrad("cross_border_instruction"))
                    end,
                    ["name"] = LinvLib:GetTrad("cross_border")
                },
                [3] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        LinvLib:NumberPanel("Rounded", LinvLib.Config.Rounded, 0, 100000, function(value)
                            LinvLib.Config.Rounded = value
                            SaveSetting("Rounded", LinvLib.Config.Rounded)
                        end, function()
                            RunConsoleCommand("linvlib_settings")
                        end)
                    end,
                    ["name"] = LinvLib:GetTrad("rounded")
                },
                [4] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.ShowName,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        SaveSetting("ShowNPCName", !LinvLib.Config.ShowName)
                    end,
                    ["name"] = LinvLib:GetTrad("show_npc_name")
                },
            }
        },
        [6] = {
            ["name"] = LinvLib:GetTrad("other"),
            ["settings"] = {
                [1] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.DebugMode,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        SaveSetting("DebugMode", !LinvLib.Config.DebugMode)
                    end,
                    ["name"] = LinvLib:GetTrad("debug_mode")
                },
                [2] = {
                    ["checkbox"] = true,
                    ["state"] = LinvLib.Config.ForceMaterial,
                    ["icon"] = LinvLib.Materials["valid"],
                    ["function"] = function()
                        SaveSetting("ForceMaterial", !LinvLib.Config.ForceMaterial)
                    end,
                    ["name"] = LinvLib:GetTrad("force_redownload_images")
                },
            }
        },
    }

    local frame = LinvLib:Frame(910, 720)
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(0, RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(frame, LinvLib:GetTrad("linventif_lib") .. " - " .. LinvLib.Info.version .. " - " .. LinvLib:GetTrad("settings"), "LinvFontRobo30", 400, 40)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, RespW(15))

    local close = LinvLib:Button(frame, " ", 36, 36, LinvLib:GetColorTheme("element"), false, function()
        frame:Close()
        RunConsoleCommand("linvlib_monitor")
    end)
    close:SetPos(RespW(910 - 60), RespH(20))
    close.Paint = function(self, w, h)
        surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
        surface.SetMaterial(LinvLib.Materials["cancel"])
        surface.DrawTexturedRect(0, 0, RespW(36), RespH(36))
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
        dplist:SetPos(RespW(0), RespH(50))
        dplist:EnableVerticalScrollbar(true)
        dplist:EnableHorizontal(true)
        dplist:SetSpacing(RespW(30))
        dplist:SetPadding(RespW(0))
        for k2, v2 in SortedPairs(v["settings"]) do
            local panel = vgui.Create("DPanel")
            panel:SetSize(RespW(405), RespH(60))
            panel.Paint = function(self, w, h)
                LinvLib:NewPaint(panel, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("element"))
                draw.SimpleText(v2["name"], "LinvFontRobo20", RespW(177.5), RespH(30), LinvLib:GetColorTheme("text"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            local but_act = LinvLib:Button(panel, "", 40, 40, LinvLib:GetColorTheme("element"), false, v2["function"])
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

local nb_needupdate, nb_addon = 0, 0

local function OpenMonitor(data, order)
    if !data then
        http.Fetch("https://api.linv.dev/addons.json", function(body, length, headers, code)
            OpenMonitor(util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
        return
    elseif !order then
        http.Fetch("https://api.linv.dev/addons_order.json", function(body, length, headers, code)
            OpenMonitor(data, util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
        return
    end

    local nb_needupdate, nb_addon = 0, 0
    for k, v in pairs(data) do
        if !LinvLib.Install[k] then continue end
        if LinvLib.Install[k] < v.version then
            nb_needupdate = nb_needupdate + 1
        end
        nb_addon = nb_addon + 1
    end

    local frame = LinvLib:Frame(720, 795)
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(0, RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(frame, "Linventif's Stuff - " .. LinvLib.Info.version .. " - " .. LinvLib:GetTrad("monitor"), "LinvFontRobo25", 400, 60)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, RespW(15))

    local info = LinvLib:Panel(frame, 720, 40, false, false, LinvLib:GetColorTheme("element"))
    info:Dock(TOP)
    info:DockMargin(RespW(30), 0, RespW(30), RespH(15))

    local nb_addons = LinvLib:LabelPanel(info, LinvLib:GetTrad("install_addon") .. " " .. nb_addon, "LinvFontRobo20", 305, 50)
    nb_addons:Dock(LEFT)
    nb_addons:DockMargin(RespW(30), 0, 0, 0)

    local nb_addon_need = LinvLib:LabelPanel(info, LinvLib:GetTrad("addon_need_update") .. " " .. nb_needupdate, "LinvFontRobo20", 305, 50)
    nb_addon_need:Dock(RIGHT)
    nb_addon_need:DockMargin(RespW(30), 0, 0, 0)

    local scroll_info = LinvLib:Panel(frame, 720, 40, false, false, LinvLib:GetColorTheme("element"))
    scroll_info:Dock(TOP)
    scroll_info:DockMargin(RespW(30), 0, RespW(30), RespH(15))

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("icon"), "LinvFontRobo20", 84, 50)
    label_icon:Dock(LEFT)
    label_icon:DockMargin(0, 0, RespW(15), 0)

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("name"), "LinvFontRobo20", 100, 50)
    label_icon:Dock(FILL)
    label_icon:DockMargin(RespW(30), 0, 0, 0)

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("last_version"), "LinvFontRobo20", 125, 50)
    label_icon:Dock(RIGHT)
    label_icon:DockMargin(RespW(30), 0, RespW(15), 0)

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("your_version"), "LinvFontRobo20", 125, 50)
    label_icon:Dock(RIGHT)
    label_icon:DockMargin(RespW(30), 0, 0, 0)

    local scroll = LinvLib:Scroll(frame, 720, 480)
    scroll:Dock(FILL)
    scroll:DockMargin(RespW(30), 0, LinvLib.ScrollBarAjust(nb_addon > 5, RespW(10), RespW(20)), RespH(30))
    for id, addon_folder in SortedPairs(order) do
        local k = addon_folder
        local v = data[addon_folder]
        if !LinvLib.Install[addon_folder] || !v || !k then continue end
        local need_update = LinvLib.Install[k] < v.version
        -- local addon = LinvLib:Button(scroll, "", 720, 84, LinvLib:GetColorTheme("element"), true, false)
        local addon = LinvLib:Panel(scroll, 720, 84, false, false, LinvLib:GetColorTheme("element"))
        addon:Dock(TOP)
        addon:DockMargin(0, 0, RespW(10 - LinvLib.Config.Border / 2), RespH(15))
        addon:DockPadding(RespW(10), RespH(10), RespW(10), RespH(10))

        if v.imgur then
            local icon_panel = vgui.Create("DHTML", addon)
            icon_panel:SetSize(RespW(64), RespH(64))
            icon_panel:SetHTML("<style> body, html { height: 100%; margin: 0; } .icon { background-image: url(https://i.imgur.com/" .. v.imgur .. ".png); height: 100%; background-position: center; background-repeat: no-repeat; background-size: cover; overflow: hidden;} </style> <body> <div class=\"icon\"></div> </body>")
            icon_panel:Dock(LEFT)
            icon_panel:DockMargin(0, 0, RespW(15), 0)
        else
            local icon_panel = LinvLib:Panel(addon, 64, 64)
            icon_panel.Paint = function(self, w, h)
                surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
                surface.SetMaterial(LinvLib.Materials[k] || LinvLib.Materials["unknow"])
                surface.DrawTexturedRect(0, 0, w, h)
            end
            icon_panel:Dock(LEFT)
            icon_panel:DockMargin(0, 0, RespW(15), 0)
        end

        local name = LinvLib:LabelPanel(addon, v.title, "LinvFontRobo20", 100, 50)
        name:Dock(FILL)
        name:DockMargin(RespW(30), 0, 0, 0)

        local last_version = LinvLib:LabelPanel(addon, v.version, "LinvFontRobo20", 125, 50)
        last_version:Dock(RIGHT)
        last_version:DockMargin(RespW(30), 0, 0, 0)

        local your_version = LinvLib:LabelPanel(addon, LinvLib.Install[k], "LinvFontRobo20", 125, 50)
        your_version:Dock(RIGHT)
        your_version:DockMargin(RespW(30), 0, 0, 0)
        if need_update then
            your_version.Paint = function(self, w, h)
                draw.SimpleText(LinvLib.Install[k], "LinvFontRobo20", w/2, h/2, LinvLib:GetColorTheme("red"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            your_version.Paint = function(self, w, h)
                draw.SimpleText(LinvLib.Install[k], "LinvFontRobo20", w/2, h/2, LinvLib:GetColorTheme("green"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end

        local button_addon = LinvLib:Button(addon, "", 720, 84, LinvLib:GetColorTheme("element"), false, function()
            LinvLib:WebPage(v.repository)
        end)
        button_addon.Paint = function() return end
        button_addon.OnCursorEntered = function()
            addon.Paint = function(self, w, h)
                LinvLib:PaintElement(frame, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("hover"))
            end
        end
        button_addon.OnCursorExited = function()
            addon.Paint = function(self, w, h)
                LinvLib:PaintElement(frame, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("element"))
            end
        end
    end

    local bottom_but = LinvLib:Panel(frame, 900, 50, true)
    bottom_but:Dock(BOTTOM)
    bottom_but:DockMargin(RespW(30), 0, RespW(30), RespH(30))

    local but_settings = LinvLib:Button(bottom_but, LinvLib:GetTrad("settings"), 200, 50, LinvLib:GetColorTheme("element"), true, function()
        OpenSettings()
        frame:Close()
    end)
    but_settings:Dock(LEFT)

    local but_help = LinvLib:Button(bottom_but, LinvLib:GetTrad("help"), 200, 50, LinvLib:GetColorTheme("element"), true, function()
        LinvLib:WebPage("https://linv.dev/discord")
    end)
    but_help:Dock(LEFT)
    but_help:DockMargin(RespW(30), 0, 0, 0)

    local but_close = LinvLib:Button(bottom_but, LinvLib:GetTrad("close"), 200, 50, LinvLib:GetColorTheme("element"), true, function()
        frame:Close()
    end)
    but_close:Dock(LEFT)
    but_close:DockMargin(RespW(30), 0, 0, 0)
end

local function CanOpenMonitor()
    if LinvLib.Config.AdminGroups[LocalPlayer():GetUserGroup()] then
        OpenMonitor()
    else
        LinvLib:Notif(LinvLib:GetTrad("not_perm"))
    end
end

local function OpenIfAddonNeedUpdate(data)
    if !data then
        http.Fetch("https://api.linv.dev/addons.json", function(body, length, headers, code)
            OpenIfAddonNeedUpdate(util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
    else
        for k, v in pairs(data) do
            if !LinvLib.Install[k] then continue end
            if LinvLib.Install[k] < v.version then
                OpenMonitor()
                return
            end
        end
    end
end

local function NewAddonPanel(data, data_ext)
    if !data_ext then
        http.Fetch("https://api.linv.dev/addons.json", function(body, length, headers, code)
            NewAddonPanel(data, util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
        return
    end

    local frame = LinvLib:Frame(720, 780)
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(0, RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(frame, "Linventif's Stuff - " .. LinvLib.Info.version .. " - " .. LinvLib:GetTrad("new_addon"), "LinvFontRobo25", 400, 60)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, RespW(15))

    local close = LinvLib:Button(frame, " ", 36, 36, LinvLib:GetColorTheme("element"), false, function()
        frame:Close()
        if LinvLib.Config.MonitorShowIfNewUpdate && LinvLib.Config.MonitorShowIfNewAddo then
            CanOpenMonitor()
        end
    end)
    close:SetPos(RespW(910 - 60), RespH(20))
    close.Paint = function(self, w, h)
        surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
        surface.SetMaterial(LinvLib.Materials["cancel"])
        surface.DrawTexturedRect(0, 0, RespW(36), RespH(36))
    end

    local scroll = LinvLib:Scroll(frame, 720, 480)
    scroll:Dock(FILL)
    scroll:DockMargin(RespW(30), 0, RespW(10), RespH(30))

    for k, v in pairs(data_ext) do
        //
    end
end

local function NewAddonsDetected(data)
    if !data then
        net.Start("LinvLib:Action")
            net.WriteString("LinvLib:GetInstalled")
        net.SendToServer()
        return
    end
    local new_addon = {}
    for k, v in pairs(LinvLib.Install) do
        if !data[k] then
            new_addon[k] = true
        end
    end
    if table.Count(new_addon) > 0 then
        LinvLib:Notif(LinvLib:GetTrad("new_addon_detected") .. table.Count(new_addon))
        timer.Simple(4, function()
            NewAddonPanel(new_addon)
        end)
    end
end

hook.Add("InitPostEntity", "LinvLib:InitAll", function()
    if !LinvLib.Config.InGameSettings then return end
    timer.Simple(2, function()
        net.Start("LinvLib:Action")
            net.WriteString("LinvLib:GetSettings")
        net.SendToServer()
        if LinvLib.Config.AdminGroups[LocalPlayer():GetUserGroup()] then
            timer.Simple(2, function()
                if LinvLib.Config.MonitorGroup[LocalPlayer():GetUserGroup()] && LinvLib.Config.MonitorShowEveryJoin then
                    OpenMonitor()
                elseif LinvLib.Config.MonitorShowIfNewUpdate then
                    OpenIfAddonNeedUpdate()
                end
                -- NewAddonsDetected()
            end)
        end
    end)
end)

// Console Commands

concommand.Add("linvlib_monitor", function()
    CanOpenMonitor()
end)

concommand.Add("linvlib_settings", function()
    OpenSettings()
end)

hook.Add("OnPlayerChat", "LinvLib:OpenChatMonitor", function( ply, text)
    if (ply != LocalPlayer()) then return end
    if LinvLib.Config.MonitorCommands[string.lower(text)] then
        RunConsoleCommand("linvlib_monitor")
		return true
    end
end)

local first_time = true
net.Receive("LinvLib:Action", function(len, ply)
    local action = net.ReadString()
    if action == "LinvLib:SaveSetting" then
        LinvLib.Config = util.JSONToTable(net.ReadString())
        LinvLib:Notif(LinvLib:GetTrad("new_setting_received"))
        if first_time then
            LinvLib:RedowloadMaterials()
            first_time = false
        end
    elseif action == "LinvLib:Installed" then
        NewAddonsDetected(util.JSONToTable(net.ReadString()))
    end
end)