local order = {
    [1] = "linventif",
    [2] = "light",
    [3] = "grey",
    [4] = "dark",
    [5] = "dark-green",
    [6] = "dark-blue",
    [7] = "dark-purple",
    [8] = "flash-bang",
}

local themes = {
    ["linventif"] = {
        ["background"] = Color(41, 44, 54),
        ["border"] = Color(118, 126, 148),
        ["element"] = Color(58, 62, 73),
        ["accent"] = Color(79, 84, 98),
        ["hover"] = Color(190, 132, 50),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["grey"] = Color(124, 124, 124),
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
    ["dark-green"] = {
        ["background"] = Color(18, 24, 15),
        ["border"] = Color(47, 73, 44),
        ["element"] = Color(34, 51, 32),
        ["accent"] = Color(56, 90, 59),
        ["hover"] = Color(44, 73, 50),
        ["text"] = Color(220, 220, 220),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["dark-green"] = {
        ["background"] = Color(18, 24, 15),
        ["border"] = Color(47, 73, 44),
        ["element"] = Color(34, 51, 32),
        ["accent"] = Color(56, 90, 59),
        ["hover"] = Color(44, 73, 50),
        ["text"] = Color(220, 220, 220),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["dark-blue"] = {
        ["background"] = Color(15, 16, 24),
        ["border"] = Color(44, 48, 73),
        ["element"] = Color(32, 35, 51),
        ["accent"] = Color(56, 60, 90),
        ["hover"] = Color(44, 48, 73),
        ["text"] = Color(220, 220, 220),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["dark-purple"] = {
        ["background"] = Color(24, 15, 20),
        ["border"] = Color(73, 44, 71),
        ["element"] = Color(51, 32, 50),
        ["accent"] = Color(82, 56, 90),
        ["hover"] = Color(73, 44, 71),
        ["text"] = Color(220, 220, 220),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["grey"] = {
        ["background"] = Color(50, 50, 50),
        ["border"] = Color(115, 115, 115),
        ["element"] = Color(75, 75, 75),
        ["accent"] = Color(90, 90, 90),
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
        ["accent"] = Color(59, 59, 59),
        ["hover"] = Color(90, 90, 90),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
        ["red"] = Color(221, 93, 76),
        ["green"] = Color(76, 221, 76),
        ["orange"] = Color(255, 140, 0),
    },
    ["light"] = {
        ["background"] = Color(207, 207, 207),
        ["border"] = Color(200, 200, 200),
        ["element"] = Color(175, 175, 175),
        ["accent"] = Color(155, 155, 155),
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
    for k, v in SortedPairs(order) do
        table.insert(tbl, v)
    end
    for k, v in SortedPairs(themes) do
        if !table.HasValue(tbl, k) then
            table.insert(tbl, k)
        end
    end
    return tbl
end

function LinvLib:AddTheme(id, tbl)
    themes[id] = tbl
    print("| Linventif Library | Theme Added | " .. id)
end