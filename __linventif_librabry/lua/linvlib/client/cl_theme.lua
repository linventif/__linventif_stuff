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
        ["hover"] = Color(190, 120, 25),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(220, 90, 75),
        ["green"] = Color(75, 220, 90),
    },
    -- ["gang-city"] = {
    --     ["background"] = Color(26, 32, 64),
    --     ["border"] = Color(118, 126, 148),
    --     ["element"] = Color(44, 50, 84),
    --     ["accent"] = Color(35, 71, 165),
    --     ["hover"] = Color(190, 132, 50),
    --     ["text"] = Color(255, 255, 255),
    --     ["icon"] = Color(255, 255, 255),
        -- ["red"] = Color(220, 90, 75),
        -- ["green"] = Color(75, 220, 90),
    -- },
    ["dark"] = {
        ["background"] = Color(25, 25, 25),
        ["border"] = Color(100, 100, 100),
        ["element"] = Color(45, 45, 45),
        ["accent"] = Color(75, 75, 75),
        ["hover"] = Color(100, 100, 100),
        ["text"] = Color(230, 230, 230),
        ["icon"] = Color(230, 230, 230),
        ["red"] = Color(220, 90, 75),
        ["green"] = Color(75, 220, 90),
    },
    ["grey"] = {
        ["background"] = Color(55, 55, 55),
        ["border"] = Color(135, 135, 135),
        ["element"] = Color(65, 65, 65),
        ["accent"] = Color(85, 85, 85),
        ["hover"] = Color(115, 115, 115),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(220, 90, 75),
        ["green"] = Color(75, 220, 90),
    },
    ["light"] = {
        ["background"] = Color(100, 100, 100),
        ["border"] = Color(135, 126, 148),
        ["element"] = Color(130, 130, 130),
        ["accent"] = Color(175, 175, 175),
        ["hover"] = Color(150, 150, 150),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(220, 90, 75),
        ["green"] = Color(75, 220, 90),
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