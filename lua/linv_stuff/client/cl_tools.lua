-- RunConsoleCommand("spawnmenu_reload")

-- hook.Add("AddToolMenuTabs", "LinvLib:ToolsTabAdd", function()
-- 	spawnmenu.AddToolTab("Linventif", "Linventif", "icon16/wrench.png")
-- end)

-- hook.Add("AddToolMenuCategories", "LinvLib:ToolsCategorysAdd", function()
--     spawnmenu.AddToolCategory("Linventif", "Linventif", "Linventif's Stuff" )
-- end)

-- local nettype = {
--     ["boolean"] = function(data)
--         return net.WriteBool(data)
--     end,
--     ["string"] = function(data)
--         return net.WriteString(data)
--     end,
--     ["table"] = function(data)
--         return net.WriteString(util.TableToJSON(data))
--     end,
--     ["int"] = function(data)
--         return net.WriteInt(data, 32)
--     end,
--     ["double"] = function(data)
--         return net.WriteDouble(data)
--     end
-- }

-- local function SaveSetting(id, net_type, data)
--     print(id, net_type, data)
--     -- net.Start("LinvLib:SaveSetting")
--     --     net.WriteString(id)
--     --     nettype[net_type](data)
--     -- net.SendToServer()
-- end

-- hook.Add("PopulateToolMenu", "LinvLib:ToolsMenuAdd", function()
--     spawnmenu.AddToolMenuOption("Linventif", "Linventif", "LinvLib:ToolsMenuAdd", "Customization", "", "", function(panel)
--         panel:ClearControls()

--         // Theme
--         local ThemeColors = panel:ComboBox(LinvLib:GetTrad("theme") .. " : ", "LinvLibThemeColors")
--         ThemeColors:SetSortItems(false)
--         for k, v in SortedPairs(LinvLib.GetThemesColorsList(), false) do
--             ThemeColors:AddChoice(v)
--         end
--         ThemeColors.OnSelect = function(panel, index, value)
--             -- SaveSetting("LinvLib:Theme", "string", value)
--             print("1", value)
--         end

--         // Show Slider
--         local ShowSlider = panel:ComboBox(LinvLib:GetTrad("show_slider") .. " : ", "LinvLibThemeColors")
--         ShowSlider:AddChoice("false")
--         ShowSlider:AddChoice("true")
--         ShowSlider.OnSelect = function(panel, index, value)
--             SaveSetting("LinvLib:ShowSlider", "boolean", tobool(value))
--         end

--         // Show NPC Name
--         local ShowNPCName = panel:ComboBox(LinvLib:GetTrad("show_npc_name") .. " : ", "LinvLibThemeColors")
--         ShowNPCName:AddChoice("false")
--         ShowNPCName:AddChoice("true")
--         ShowNPCName.OnSelect = function(panel, index, value)
--             SaveSetting("LinvLib:ShowNPCName", "boolean", tobool(value))
--         end

--         // Border Radius
--         local BorderRadius = panel:NumSlider(LinvLib:GetTrad("border_radius") .. " : ", "LinvLibThemeColors", 0, 100, 0)
--         BorderRadius:SetDecimals(0)
--         BorderRadius.OnValueChanged = function(panel, value)
--             SaveSetting("LinvLib:Border", "int", value)
--         end

--         // On panel open set the value
--         panel.OnOpen = function()
--             ThemeColors:SetValue(LinvLib.Config.Theme)
--             ShowSlider:SetValue(LinvLib.Config.ShowSlider)
--             ShowNPCName:SetValue(LinvLib.Config.ShowName)
--             BorderRadius:SetValue(LinvLib.Config.Border)
--         end
--     end)
-- end)