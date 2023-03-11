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
        ["orange"] = Color(255, 140, 0),
    },
    ["flash-bang"] = {
        ["background"] = Color(255, 255, 255),
        ["border"] = Color(170, 170, 170),
        ["element"] = Color(220, 220, 220),
        ["accent"] = Color(170, 170, 170),
        ["hover"] = Color(150, 150, 150),
        ["text"] = Color(0, 0, 0),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["dark-blue"] = {
        ["background"] = Color(15, 16, 24),
        ["border"] = Color(44, 48, 73),
        ["element"] = Color(26, 28, 40),
        ["accent"] = Color(32, 34, 51),
        ["hover"] = Color(44, 48, 73),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["grey"] = {
        ["background"] = Color(53, 53, 53),
        ["border"] = Color(135, 135, 135),
        ["element"] = Color(50, 50, 50),
        ["accent"] = Color(75, 75, 75),
        ["hover"] = Color(114, 114, 114),
        ["text"] = Color(230, 230, 230),
        ["icon"] = Color(230, 230, 230),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["dark"] = {
        ["background"] = Color(0, 0, 0),
        ["border"] = Color(95, 95, 95),
        ["element"] = Color(33, 33, 33),
        ["accent"] = Color(105, 105, 105),
        ["hover"] = Color(90, 90, 90),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["light"] = {
        ["background"] = Color(100, 100, 100),
        ["border"] = Color(200, 200, 200),
        ["element"] = Color(130, 130, 130),
        ["accent"] = Color(110, 110, 110),
        ["hover"] = Color(150, 150, 150),
        ["text"] = Color(0, 0, 0),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(0, 255, 0),
        ["orange"] = Color(255, 140, 0),
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

function LinvLib:GetThemesId()
    local tbl = {}
    for k, v in pairs(themes) do
        table.insert(tbl, k)
    end
    return tbl
end

function LinvLib:AddTheme(id, tbl)
    themes[id] = tbl
    print("| Linventif Library | Theme Added | " .. id)
end