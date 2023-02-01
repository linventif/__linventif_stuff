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
    },
    ["dark"] = {
        ["background"] = Color(0, 0, 0),
        ["element"] = Color(35, 35, 35),
        ["accent"] = Color(50, 50, 50),
        ["hover"] = Color(75, 75, 75),
        ["text"] = Color(200, 200, 200),
        ["icon"] = Color(180, 180, 180),
        ["red"] = Color(221, 93, 76),
    },
    ["grey"] = {
        ["background"] = Color(55, 55, 55),
        ["element"] = Color(115, 115, 115),
        ["accent"] = Color(80, 80, 80),
        ["hover"] = Color(115, 115, 115),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
    },
    ["light"] = {
        ["background"] = Color(41, 44, 54),
        ["element"] = Color(58, 62, 73),
        ["accent"] = Color(79, 84, 98),
        ["hover"] = Color(167, 112, 36),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
    }
}

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