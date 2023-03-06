-- local inventory = {
--     [1] = {
--         ["name"] = "SMG",
--         ["cmd"] = "weapon_smg1",
--         ["type"] = "Primary Weapon",
--     },
--     [2] = {
--         ["name"] = "RPG",
--         ["cmd"] = "weapon_rpg",
--         ["type"] = "Primary Weapon",
--     },
--     [3] = {
--         ["name"] = "Pistol",
--         ["cmd"] = "weapon_pistol",
--         ["type"] = "Secondary Weapon",
--     },
--     [4] = {
--         ["name"] = "Magnum",
--         ["cmd"] = "weapon_357",
--         ["type"] = "Secondary Weapon",
--     },
--     [5] = {
--         ["name"] = "Pistol Ammo",
--         ["cmd"] = "item_ammo_pistol",
--         ["type"] = "Ammo",
--     },
--     [6] = {
--         ["name"] = "SMG Ammo",
--         ["cmd"] = "item_ammo_smg1",
--         ["type"] = "Ammo",
--     },
--     [7] = {
--         ["name"] = "Crowbar",
--         ["cmd"] = "weapon_crowbar",
--         ["type"] = "Melee Weapon",
--     },
--     [8] = {
--         ["name"] = "Suit",
--         ["cmd"] = "item_suit",
--         ["type"] = "Armor",
--     }
-- }

-- local function DoDrop(self, panels, bDoDrop, Command, x, y)
-- 	if (bDoDrop) then
-- 		for k, v in pairs(panels) do
-- 			self:AddItem(v)
-- 		end
-- 	end
-- end

-- local frame = LinvLib:Frame(950, 350)
-- frame:ShowCloseButton(true)
-- frame:SetDraggable(true)

-- local function DoDrop(self, panels, bDoDrop, Command, x, y)
--     local children = self:GetCanvas():GetChildren()
--     local count = 0
--     for k, v in pairs(children) do
--         count = count + 1
--     end
--     if (bDoDrop) then
--         if count != 0 then
--             LinvLib:Notif("Emplacement déjà Occupé !")
--             return
--         end
--         for k, v in pairs(panels) do
--             if v.info then
--                 if v.info["type"] != self.receiver_type && self.receiver_type != "All" then
--                     LinvLib:Notif("Equipement non Compatible !")
--                     return
--                 end
--                 self:AddItem(v)
--                 net.Start("LinvLib:Equip")
--                     net.WriteBool(self.equip)
--                     net.WriteString(util.TableToJSON(v.info || {}))
--                 net.SendToServer()
--             end
--         end
--     end
-- end

-- local primary_weapon = vgui.Create("DScrollPanel", frame)
-- primary_weapon:SetSize(100, 100)
-- primary_weapon:SetPos(50, 50)
-- primary_weapon:SetPaintBackground(true)
-- primary_weapon:DockMargin(0, 0, 4, 0)
-- primary_weapon.receiver_type = "Primary Weapon"
-- primary_weapon.equip = true
-- primary_weapon:Receiver("myDNDname", DoDrop)

-- local primary_weapon_label = LinvLib:LabelPanel(frame, "Primary Weapon", "LinvFontRobo20", 150, 30)
-- primary_weapon_label:SetPos(25, 15)

-- local secondary_weapon = vgui.Create("DScrollPanel", frame)
-- secondary_weapon:SetSize(100, 100)
-- secondary_weapon:SetPos(200, 50)
-- secondary_weapon:SetPaintBackground(true)
-- secondary_weapon.receiver_type = "Secondary Weapon"
-- secondary_weapon.equip = true
-- secondary_weapon:Receiver("myDNDname", DoDrop)

-- local secondary_weapon_label = LinvLib:LabelPanel(frame, "Secondary Weapon", "LinvFontRobo20", 150, 30)
-- secondary_weapon_label:SetPos(175, 15)

-- local melee_weapon = vgui.Create("DScrollPanel", frame)
-- melee_weapon:SetSize(100, 100)
-- melee_weapon:SetPos(50, 200)
-- melee_weapon:SetPaintBackground(true)
-- melee_weapon:DockMargin(0, 0, 4, 0)
-- melee_weapon.receiver_type = "Melee Weapon"
-- melee_weapon.equip = true
-- melee_weapon:Receiver("myDNDname", DoDrop)

-- local melee_weapon_label = LinvLib:LabelPanel(frame, "Melee Weapon", "LinvFontRobo20", 150, 30)
-- melee_weapon_label:SetPos(25, 165)

-- local kevlar = vgui.Create("DScrollPanel", frame)
-- kevlar:SetSize(100, 100)
-- kevlar:SetPos(200, 200)
-- kevlar:SetPaintBackground(true)
-- kevlar.receiver_type = "Armor"
-- kevlar.equip = true
-- kevlar:Receiver("myDNDname", DoDrop)

-- local kevlar_label = LinvLib:LabelPanel(frame, "Armor", "LinvFontRobo20", 150, 30)
-- kevlar_label:SetPos(175, 165)

-- local grid = vgui.Create( "DGrid", frame )
-- grid:SetPos( 350, 50 )
-- grid:SetCols( 4 )
-- grid:SetColWide( 150 )
-- grid:SetRowHeight( 150 )

-- local spacingh = 0
-- local spacingw = 0
-- local count = 1
-- for k, v in pairs(inventory) do
--     local label_num = LinvLib:LabelPanel(frame, count, "LinvFontRobo20", 150, 30)
--     label_num:SetPos(325 + spacingh, 15 + spacingw)
--     spacingh = spacingh + 150
--     count = count + 1
--     if count == 5 then
--         spacingw = spacingw + 150
--         spacingh = 0
--     end
-- end

-- local count = 0
-- for l, m in pairs(inventory) do
--     local right = vgui.Create("DScrollPanel", frame)
--     right:SetSize(100, 100)
--     right:SetPaintBackground(true)
--     right.receiver_type = "All"
--     right:Receiver("myDNDname", DoDrop)
--     grid:AddItem(right)

--     local count2 = 0
--     for k, v in pairs(inventory) do
--         if count == count2 then
--             local but = vgui.Create("DButton")
--             but:SetText(v["name"])
--             but.info = v
--             but:SetSize(100, 100)
--             but:Droppable("myDNDname")
--             right:AddItem(but)
--             count2 = count2 + 1
--         else
--             count2 = count2 + 1
--         end
--     end
--     count = count + 1
-- end

-- local frame = LinvLib:Frame(400, 400)
-- frame.Paint = function(self, w, h)
--     surface.SetDrawColor(255, 255, 255, 255)
--     surface.SetMaterial(LinvLib.Materials["earth"])
--     surface.DrawTexturedRect(0, 20, w, h-20)
-- end


-- local entity

-- concommand.Add( "test_csent", function( ply )

-- 	local trace = ply:GetEyeTrace()

-- 	entity = ClientsideModel( "models/props_c17/oildrum001_explosive.mdl" )
-- 	entity:SetPos( trace.HitPos + trace.HitNormal * 24 )
-- 	entity:Spawn()

-- end )

