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
    },
    ["string"] = {
        ["Language"] = true,
        ["Theme"] = true
    },
    ["table"] = {
        ["CompatibleAddon"] = true
    },
    ["color"] = {
        ["background"] = true
    },
    ["number"] = {
        ["Border"] = true,
        ["Rounded"] = true
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

-- local function ColorPanel(msg, defaut_color, func)
--     if !defaut_color then defaut_color = Color(255, 255, 255) end

--     local frame = LinvLib:Frame(400, 475, 8)
--     frame:DockPadding(RespW(30), RespW(30), RespW(30), RespW(30))

--     local title = LinvLib:LabelPanel(frame, msg, "LinvFontRobo25", 0, 0, 400, 60)
--     title:Dock(TOP)
--     title:DockMargin(0, 0, 0, RespW(15))

--     local color_mixer = vgui.Create("DColorMixer", frame)
--     color_mixer:Dock(FILL)
--     color_mixer:SetPalette(true)
--     color_mixer:SetAlphaBar(true)
--     color_mixer:SetWangs(true)
--     color_mixer:SetColor(defaut_color)

--     local panel_but = LinvLib:Panel(frame, 400, 50)
--     panel_but:Dock(BOTTOM)
--     panel_but:DockMargin(0, RespW(30), 0, 0)
--     panel_but.Paint = function(self, w, h) end

--     local but_reset = LinvLib:Button(panel_but, LinvLib:GetTrad("reset"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
--         color_mixer:SetColor(defaut_color)
--     end)
--     but_reset:Dock(LEFT)

--     local but_continue = LinvLib:Button(panel_but, LinvLib:GetTrad("continue"), 155, 50, LinvLib:GetColorTheme("element"), true, function()
--         func(color_mixer:GetColor())
--         frame:Remove()
--     end)
--     but_continue:Dock(RIGHT)
--     frame.OnRemove = function()
--         RunConsoleCommand("linvlib_settings")
--     end
-- end

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
    -- scroll.Paint = function(self, w, h)
    --     draw.RoundedBox(RespW(8), 0, 0, w, h, LinvLib:GetColorTheme("element"))
    -- end
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

local function OpenSettings()
    local settings_list = {
        [1] = {
            ["name"] = LinvLib:GetTrad("general"),
            ["settings"] = {
                [1] = {
                    ["icon"] = LinvLib.Materials["edit"],
                    ["function"] = function()
                        local data_table = {
                            ["title"] = LinvLib:GetTrad("language"),
                            ["data"] = LinvLib:GetLanguageId(),
                            ["type"] = "simple",
                            ["callback"] = function(data)
                                if data == "Add Language" then
                                    LinvLib:Notif(LinvLib:GetTrad("language_add"))
                                else
                                    LinvLib.Config.Language = data
                                    SaveSetting("Language", LinvLib.Config.Language)
                                end
                            end
                        }
                        data_table.data[#data_table.data + 1] = "Add Language"
                        OpenSelect(data_table)
                    end,
                    ["name"] = LinvLib:GetTrad("language") .. " : " .. LinvLib.Config.Language
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
                -- [3] = {
                --     ["icon"] = LinvLib.Materials["edit"],
                --     ["function"] = function()
                --         OpenSelect({
                --             ["title"] = LinvLib:GetTrad("compatible_addon"),
                --             ["data"] = LinvLib.Config.Compatibility,
                --             ["type"] = "addon",
                --             ["callback"] = function(id, state)
                --                 LinvLib.Config.Compatibility[id] = state
                --                 -- SaveSetting("CompatibleAddon", LinvLib.Config.Compatibility)
                --                 PrintTable(LinvLib.Config.Compatibility)
                --             end
                --         })
                --     end,
                --     ["name"] = LinvLib:GetTrad("compatible_addon")
                -- },
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
                        if LinvLib.Config.MonitorShowEveryJoin then
                            LinvLib.Config.MonitorShowEveryJoin = false
                        else
                            LinvLib.Config.MonitorShowEveryJoin = true
                        end
                        SaveSetting("MonitorShowEveryJoin", LinvLib.Config.MonitorShowEveryJoin)
                    end,
                    ["name"] = LinvLib:GetTrad("show_at_every_join")
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
                    ["name"] = LinvLib:GetTrad("show_if_need_update")
                },
                -- [3] = {
                --     ["checkbox"] = true,
                --     ["state"] = LinvLib.Config.MonitorShowIfNewAddon,
                --     ["icon"] = LinvLib.Materials["valid"],
                --     ["function"] = function()
                --         if LinvLib.Config.MonitorShowIfNewAddon then
                --             LinvLib.Config.MonitorShowIfNewAddon = false
                --         else
                --             LinvLib.Config.MonitorShowIfNewAddon = true
                --         end
                --         SaveSetting("MonitorShowNewAddon", LinvLib.Config.MonitorShowIfNewAddon)
                --     end,
                --     ["name"] = LinvLib:GetTrad("show_if_new_addon")
                -- },
            }
        },
        -- [3] = {
        --     ["name"] = LinvLib:GetTrad("admin_suite"),
        --     ["settings"] = {
        --         [1] = {
        --             ["checkbox"] = true,
        --             ["state"] = LinvLib.Config.AdminMenu,
        --             ["icon"] = LinvLib.Materials["valid"],
        --             ["function"] = function()
        --                 if LinvLib.Config.AdminMenu then
        --                     LinvLib.Config.AdminMenu = false
        --                 else
        --                     LinvLib.Config.AdminMenu = true
        --                 end
        --                 SaveSetting("AdminMenu", LinvLib.Config.AdminMenu)
        --             end,
        --             ["name"] = LinvLib:GetTrad("admin_menu")
        --         },
        --         [2] = {
        --             ["checkbox"] = true,
        --             ["state"] = LinvLib.Config.AdminMenuExtended,
        --             ["icon"] = LinvLib.Materials["valid"],
        --             ["function"] = function()
        --                 if LinvLib.Config.AdminMenuExtended then
        --                     LinvLib.Config.AdminMenuExtended = false
        --                 else
        --                     LinvLib.Config.AdminMenuExtended = true
        --                 end
        --                 SaveSetting("AdminMenuExtend", LinvLib.Config.AdminMenuExtended)
        --             end,
        --             ["name"] = LinvLib:GetTrad("admin_menu_extend")
        --         },
        --         [3] = {
        --             ["checkbox"] = true,
        --             ["state"] = LinvLib.Config.AdminTicket,
        --             ["icon"] = LinvLib.Materials["valid"],
        --             ["function"] = function()
        --                 if LinvLib.Config.AdminTicket then
        --                     LinvLib.Config.AdminTicket = false
        --                 else
        --                     LinvLib.Config.AdminTicket = true
        --                 end
        --                 SaveSetting("AdminTicket", LinvLib.Config.AdminTicket)
        --             end,
        --             ["name"] = LinvLib:GetTrad("admin_ticket")
        --         },
        --         [4] = {
        --             ["icon"] = LinvLib.Materials["edit"],
        --             ["function"] = function()
        --                 LinvLib:Notif(LinvLib:GetTrad("in_dev"))
        --             end,
        --             ["name"] = LinvLib:GetTrad("admin_group")
        --         },
        --     }
        -- },
        [3] = {
        -- [4] = {
            ["name"] = LinvLib:GetTrad("linventif_security"),
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
                    ["name"] = LinvLib:GetTrad("global_ban")
                },
                -- [2] = {
                --     ["checkbox"] = true,
                --     ["state"] = LinvLib.Config.PlayerTrustFactor,
                --     ["icon"] = LinvLib.Materials["valid"],
                --     ["function"] = function()
                --         if LinvLib.Config.PlayerTrustFactor then
                --             LinvLib.Config.PlayerTrustFactor = false
                --         else
                --             LinvLib.Config.PlayerTrustFactor = true
                --         end
                --         SaveSetting("PlayerTrustFactor", LinvLib.Config.PlayerTrustFactor)
                --     end,
                --     ["name"] = LinvLib:GetTrad("ply_trust_factor")
                -- },
                -- [3] = {
                --     ["icon"] = LinvLib.Materials["edit"],
                --     ["function"] = function()
                --         LinvLib:NumberPanel(LinvLib:GetTrad("ply_trust_factor_min"), LinvLib.Config.MinPlayerTrustFactor, 0, 100, function(value)
                --             LinvLib.Config.MinPlayerTrustFactor = value
                --             SaveSetting("MinPlayerTrustFactor", LinvLib.Config.MinPlayerTrustFactor)
                --         end)
                --     end,
                --     ["name"] = LinvLib:GetTrad("ply_trust_factor_min")
                -- },
            }
        },
        [4] = {
        -- [5] = {
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
                        LinvLib:NumberPanel("Rounded", LinvLib.Config.Rounded, 0, 100000, function(value)
                            LinvLib.Config.Rounded = value
                            SaveSetting("Rounded", LinvLib.Config.Rounded)
                        end, function()
                            RunConsoleCommand("linvlib_settings")
                        end)
                    end,
                    ["name"] = LinvLib:GetTrad("rounded")
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
                        if LinvLib.Config.DebugMode then
                            LinvLib.Config.DebugMode = false
                        else
                            LinvLib.Config.DebugMode = true
                        end
                        SaveSetting("DebugMode", LinvLib.Config.DebugMode)
                    end,
                    ["name"] = LinvLib:GetTrad("debug_mode")
                },
            }
        },
    }

    -- for k, v in pairs(LinvLib.CustomTheme) do
    --     settings_list[5]["settings"][#settings_list[5]["settings"] + 1] = {
    --         ["icon"] = LinvLib.Materials["edit"],
    --         ["function"] = function()
    --             ColorPanel(LinvLib:GetTrad(v), LinvLib:GetColorTheme(v), function(color)
    --                 LinvLib:SetColorTheme(v, color)
    --                 SaveSetting("color", color)
    --             end)
    --         end,
    --         ["name"] = LinvLib:GetTrad(v) .. " : " .. LinvLib:RGBtoHEX(LinvLib:GetColorTheme(v))
    --     }
    -- end

    local frame = LinvLib:Frame(910, 720)
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(0, RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(frame, LinvLib:GetTrad("linventif_lib") .. " - " .. LinvLib.version .. " - " .. LinvLib:GetTrad("settings"), "LinvFontRobo30", 400, 40)
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

    -- local doc = LinvLib:Button(frame, " ", 29, 36, LinvLib:GetColorTheme("element"), false, function()
    --     LinvLib:Notif(LinvLib:GetTrad("in_dev"))
    -- end)
    -- doc:SetPos(RespW(910 - 109), RespH(20))
    -- doc.Paint = function(self, w, h)
    --     surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
    --     surface.SetMaterial(LinvLib.Materials["doc"])
    --     surface.DrawTexturedRect(0, 0, RespW(29), RespH(36))
    -- end

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

local function OpenMonitor(data)
    if !data then
        http.Fetch("https://api.linventif.fr/addons.json", function(body, length, headers, code)
            OpenMonitor(util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
        return
    end

    local nb_needupdate, nb_addon = 0, 0

    for k, v in pairs(data) do
        if !LinvLib.Install[k] then continue end
        nb_addon = nb_addon + 1
        if LinvLib.Install[k] < v.version then
            nb_needupdate = nb_needupdate + 1
        end
    end

    local frame = LinvLib:Frame(720, 795)
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(0, RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(frame, "Linventif's Stuff - " .. LinvLib.version .. " - " .. LinvLib:GetTrad("monitor"), "LinvFontRobo25", 400, 60)
    title:Dock(TOP)
    title:DockMargin(0, 0, 0, RespW(15))

    local info = LinvLib:Panel(frame, 720, 40, false, false, LinvLib:GetColorTheme("element"))
    info:Dock(TOP)
    info:DockMargin(RespW(30), 0, RespW(30), RespH(15))

    local nb_addons = LinvLib:LabelPanel(info, LinvLib:GetTrad("install_addon") .. nb_addon, "LinvFontRobo20", 305, 50)
    nb_addons:Dock(LEFT)
    nb_addons:DockMargin(RespW(30), 0, 0, 0)

    local nb_addon_need = LinvLib:LabelPanel(info, LinvLib:GetTrad("addon_need_update") .. nb_needupdate, "LinvFontRobo20", 305, 50)
    nb_addon_need:Dock(RIGHT)
    nb_addon_need:DockMargin(RespW(30), 0, 0, 0)

    local scroll_info = LinvLib:Panel(frame, 720, 40, false, false, LinvLib:GetColorTheme("element"))
    scroll_info:Dock(TOP)
    scroll_info:DockMargin(RespW(30), 0, RespW(30), RespH(15))

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("icon"), "LinvFontRobo20", 84, 50)
    label_icon:Dock(LEFT)
    label_icon:DockMargin(0, 0, 0, 0)

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("name"), "LinvFontRobo20", 100, 50)
    label_icon:Dock(FILL)
    label_icon:DockMargin(RespW(30), 0, 0, 0)

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("link"), "LinvFontRobo20", 100, 50)
    label_icon:Dock(RIGHT)
    label_icon:DockMargin(RespW(30), 0, RespW(10), 0)

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("last_version"), "LinvFontRobo20", 100, 50)
    label_icon:Dock(RIGHT)
    label_icon:DockMargin(RespW(30), 0, 0, 0)

    local label_icon = LinvLib:LabelPanel(scroll_info, LinvLib:GetTrad("your_version"), "LinvFontRobo20", 100, 50)
    label_icon:Dock(RIGHT)
    label_icon:DockMargin(RespW(30), 0, 0, 0)

    local scroll = LinvLib:Scroll(frame, 720, 480)
    scroll:Dock(FILL)
    if nb_addon > 5 then
        scroll:DockMargin(RespW(30), 0, RespW(10), RespH(30))
    else
        scroll:DockMargin(RespW(30), 0, RespW(20), RespH(30))
    end
    for k, v in pairs(data) do
        if !LinvLib.Install[k] then continue end
        local need_update = LinvLib.Install[k] < v.version
        local addon = LinvLib:Panel(scroll, 720, 84)
        addon.Paint = function(self, w, h)
            LinvLib:NewPaint(frame, w, h, LinvLib:GetColorTheme("border"), LinvLib:GetColorTheme("element"))
        end
        addon:Dock(TOP)
        addon:DockMargin(0, 0, RespW(10), RespH(15))
        addon:DockPadding(RespW(10), RespH(10), RespW(10), RespH(10))
        local icon_panel = LinvLib:Panel(addon, 64, 64)
        icon_panel.Paint = function(self, w, h)
            surface.SetDrawColor(LinvLib:GetColorTheme("icon"))
            surface.SetMaterial(LinvLib.Materials[k] || LinvLib.Materials["unknow"])
            surface.DrawTexturedRect(0, 0, w, h)
        end
        icon_panel:Dock(LEFT)
        icon_panel:DockMargin(0, 0, RespW(15), 0)
        local name = LinvLib:LabelPanel(addon, v.title, "LinvFontRobo20", 100, 50)
        name:Dock(FILL)
        name:DockMargin(RespW(30), 0, 0, 0)
        local but = LinvLib:Button(addon, need_update && LinvLib:GetTrad("update") || LinvLib:GetTrad("open"), 100, 50, LinvLib:GetColorTheme("accent"), true, function()
            LinvLib:WebPage(v.repository)
        end)
        but:Dock(RIGHT)
        but:DockMargin(RespW(30), 0, 0, 0)
        local last_version = LinvLib:LabelPanel(addon, v.version, "LinvFontRobo20", 100, 50)
        last_version:Dock(RIGHT)
        last_version:DockMargin(RespW(30), 0, 0, 0)
        local your_version = LinvLib:LabelPanel(addon, LinvLib.Install[k], "LinvFontRobo20", 100, 50)
        your_version:Dock(RIGHT)
        your_version:DockMargin(RespW(30), 0, 0, 0)
        if need_update then
            your_version.Paint = function(self, w, h)
                draw.SimpleText(LinvLib.Install[k], "LinvFontRobo25", w/2, h/2, LinvLib:GetColorTheme("red"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            your_version.Paint = function(self, w, h)
                draw.SimpleText(LinvLib.Install[k], "LinvFontRobo20", w/2, h/2, LinvLib:GetColorTheme("green"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
        LinvLib:WebPage("https://linventif.fr/discord")
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

local function AddonNeedUpdate(data)
    if !data then
        http.Fetch("https://api.linventif.fr/addons.json", function(body, length, headers, code)
            AddonNeedUpdate(util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
        return
    end
    local addon_need_update = 0
    for k, v in pairs(data) do
        if LinvLib.Install[k] && (LinvLib.Install[k]["version"] < v["version"])then
            addon_need_update = addon_need_update + 1
        end
    end
    if addon_need_update > 0 then
        LinvLib:Notif(LinvLib:GetTrad("addon_need_update") .. addon_need_update)
        CanOpenMonitor()
    end
end

local function NewAddonPanel(data, data_ext)
    if !data_ext then
        http.Fetch("https://api.linventif.fr/addons.json", function(body, length, headers, code)
            NewAddonPanel(data, util.JSONToTable(body))
        end, function(message)
            print(message)
        end)
        return
    end

    local frame = LinvLib:Frame(720, 780)
    frame:DockMargin(0, 0, 0, 0)
    frame:DockPadding(0, RespH(20), 0, 0)

    local title = LinvLib:LabelPanel(frame, "Linventif's Stuff - " .. LinvLib.version .. " - " .. LinvLib:GetTrad("new_addon"), "LinvFontRobo25", 400, 60)
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
    timer.Simple(2, function()
        net.Start("LinvLib:Action")
            net.WriteString("LinvLib:GetSettings")
        net.SendToServer()
        if LinvLib.Config.AdminGroups[LocalPlayer():GetUserGroup()] then
            timer.Simple(2, function()
                if LinvLib.Config.MonitorGroup[LocalPlayer():GetUserGroup()] && LinvLib.Config.MonitorShowEveryJoin then
                    OpenMonitor()
                elseif LinvLib.Config.MonitorShowIfNewUpdate then
                    AddonNeedUpdate()
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

net.Receive("LinvLib:Action", function(len, ply)
    local action = net.ReadString()
    if action == "LinvLib:SaveSetting" then
        LinvLib.Config = util.JSONToTable(net.ReadString())
        LinvLib:Notif(LinvLib:GetTrad("new_setting_received"))
    elseif action == "LinvLib:Installed" then
        NewAddonsDetected(util.JSONToTable(net.ReadString()))
    end
end)