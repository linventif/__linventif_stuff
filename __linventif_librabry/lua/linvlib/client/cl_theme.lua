-- LinvLib.CustomTheme = {
--     [1] = "background",
--     [2] = "border",
--     [3] = "element",
--     [4] = "accent",
--     [5] = "hover",
--     [6] = "text",
--     [7] = "icon",
--     [8] = "red"
-- }

local themes = {
    ["linventif"] = {
        ["background"] = Color(41, 44, 54),
        ["border"] = Color(118, 126, 148),
        ["element"] = Color(58, 62, 73),
        ["accent"] = Color(79, 84, 98),
        ["hover"] = Color(190, 132, 50),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
    },
    ["dark"] = {
        ["background"] = Color(30, 30, 30),
        ["element"] = Color(50, 50, 50),
        ["accent"] = Color(75, 75, 75),
        ["hover"] = Color(100, 100, 100),
        ["text"] = Color(230, 230, 230),
        ["icon"] = Color(230, 230, 230),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
    },
    ["grey"] = {
        ["background"] = Color(55, 55, 55),
        ["element"] = Color(80, 80, 80),
        ["accent"] = Color(115, 115, 115),
        ["hover"] = Color(135, 135, 135),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
    },
    ["light"] = {
        ["background"] = Color(85, 85, 85),
        ["element"] = Color(110, 110, 110),
        ["accent"] = Color(140, 140, 140),
        ["hover"] = Color(165, 165, 165),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
    }
}

-- file.Write("themes.txt", util.TableToJSON(themes, true))

// -- // -- // -- // -- // -- // -- // -- //
// DO NOT EDIT BELOW THIS LINE
// -- // -- // -- // -- // -- // -- // -- //

function LinvLib:GetColorTheme(id)
    if themes[LinvLib.Config.Theme] && themes[LinvLib.Config.Theme][id] then
        return themes[LinvLib.Config.Theme][id]
    else
        return themes["linventif"][id]
    end
end

function LinvLib:GetThemesId()
    local tbl = {}
    for k, v in pairs(themes) do
        table.insert(tbl, k)
    end
    return tbl
end

function LinvLib:AddTheme(id, tbl)
    themes[id] = tbl
end

-- function LinvLib:SetColorTheme(id, color)
--     if themes[LinvLib.Config.Theme] && themes[LinvLib.Config.Theme][id] then
--         themes[LinvLib.Config.Theme][id] = color
--     else
--         themes["linventif"][id] = color
--     end
-- end

-- LinvLib.Config.CustomTheme = {
--     ["background"] = LinvLib:GetColorTheme("background"),
--     ["border"] = LinvLib:GetColorTheme("border"),
--     ["element"] = LinvLib:GetColorTheme("element"),
--     ["accent"] = LinvLib:GetColorTheme("accent"),
--     ["hover"] = LinvLib:GetColorTheme("hover"),
--     ["text"] = LinvLib:GetColorTheme("text"),
--     ["icon"] = LinvLib:GetColorTheme("icon"),
--     ["red"] = LinvLib:GetColorTheme("red"),
-- }

-- function LinvLib:RefreshCustomTheme()
--     LinvLib.Config.CustomTheme = {
--         ["background"] = LinvLib:GetColorTheme("background"),
--         ["border"] = LinvLib:GetColorTheme("border"),
--         ["element"] = LinvLib:GetColorTheme("element"),
--         ["accent"] = LinvLib:GetColorTheme("accent"),
--         ["hover"] = LinvLib:GetColorTheme("hover"),
--         ["text"] = LinvLib:GetColorTheme("text"),
--         ["icon"] = LinvLib:GetColorTheme("icon"),
--         ["red"] = LinvLib:GetColorTheme("red"),
--     }
-- end