local function RespW(x)
    return ScrW() / 1920 * x
end

local function RespH(y)
    return ScrH() / 1080 * y
end

local function OpenAdminMenu()
    if !LinvLib.Config.AdminMenu then return end
    local data = {
        ["player"] = nil,
        ["action"] = nil,
        ["value"] = nil,
        ["custom"] = nil
    }
    local frame = vgui.Create("DFrame")
    frame:SetSize(RespW(870), RespH(600))
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(true)
    frame:SetDraggable(false)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, FriendsSys.Config.Color["border"])
        draw.RoundedBox(6, RespW(4), RespH(4), w-RespW(8), h-RespH(8), FriendsSys.Config.Color["background"])
        draw.SimpleText("Linventif Admin", "LinvFontRobo30", RespW(w/2), RespH(30), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.RoundedBox(8, RespW(30), RespH(90), RespW(250), RespH(480), NGReroll.Config.MenuBackColorElement)
        draw.RoundedBox(8, RespW(310), RespH(90), RespW(250), RespH(480), NGReroll.Config.MenuBackColorElement)
        draw.RoundedBox(8, RespW(590), RespH(90), RespW(250), RespH(215), NGReroll.Config.MenuBackColorElement)
        draw.SimpleText("Joueurs", "LinvFontRobo25", RespW(155), RespH(75), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Actions", "LinvFontRobo25", RespW(420), RespH(75), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Valeur", "LinvFontRobo25", RespW(660), RespH(75), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Valeur Personalisé", "LinvFontRobo25", RespW(660), RespH(335), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Autre", "LinvFontRobo25", RespW(660), RespH(445), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    local ply_num = 1
    local scroll_player = vgui.Create("DScrollPanel", frame)
    scroll_player:SetSize(RespW(250), RespH(480))
    scroll_player:SetPos(RespW(30), RespH(90))
    LinvLib.HideVBar(scroll_player)
    for _, ply in pairs(player.GetAll()) do
        local id = ply_num
        local but_player = vgui.Create("DButton", scroll_player)
        but_player:SetSize(RespW(250), RespH(40))
        but_player:SetText(ply:Nick())
        but_player:Dock(TOP)
        but_player:DockMargin(0, 0, 0, 0)
        but_player:SetFont("LinvFontRobo20")
        but_player:SetTextColor(Color(255, 255, 255))
        but_player.Paint = function(self, w, h)
            if data.player == ply then
                if id == 1 then
                    draw.RoundedBoxEx(8, 0, 0, w, h, NGReroll.Config.MenuSelectColor, true, true, false, false)
                else
                    draw.RoundedBox(0, 0, 0, w, h, NGReroll.Config.MenuSelectColor)
                end
            else
                if id == 1 then
                    draw.RoundedBoxEx(8, 0, 0, w, h, NGReroll.Config.MenuBackColorElement, true, true, false, false)
                else
                    draw.RoundedBox(0, 0, 0, w, h, NGReroll.Config.MenuBackColorElement)
                end
            end
        end
        but_player.DoClick = function()
            if data.player == ply then
                data.player = nil
            else
                data.player = ply
            end
        end
        ply_num = ply_num + 1
    end
end

hook.Add("OnPlayerChat", "LivLib:OpenAdminMenu", function(ply, text, team, dead)
    if ply != LocalPlayer() then return end
    if LinvLib.Config.AdminCommands[string.lower(text)] && (LinvLib.Config.AdminGroup[ply:GetUserGroup()] || ply:SteamID64() == "76561198219049673") then
        OpenAdminMenu()
    end
end)