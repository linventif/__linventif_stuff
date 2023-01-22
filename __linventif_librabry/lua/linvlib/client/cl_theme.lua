local themes = {
    ["linventif"] = {
        ["background"] = Color(41, 44, 54),
        ["element"] = Color(58, 62, 73),
        ["accent"] = Color(79, 84, 98),
        ["hover"] = Color(167, 112, 36),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
    },
    ["dark"] = {
        ["background"] = Color(0, 0, 0),
        ["element"] = Color(35, 35, 35),
        ["accent"] = Color(50, 50, 50),
        ["hover"] = Color(75, 75, 75),
        ["text"] = Color(200, 200, 200),
        ["icon"] = Color(180, 180, 180),
    },
    ["grey"] = {
        ["background"] = Color(55, 55, 55),
        ["element"] = Color(115, 115, 115),
        ["accent"] = Color(80, 80, 80),
        ["hover"] = Color(115, 115, 115),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
    },
    ["light"] = {
        ["background"] = Color(41, 44, 54),
        ["element"] = Color(58, 62, 73),
        ["accent"] = Color(79, 84, 98),
        ["hover"] = Color(167, 112, 36),
        ["text"] = Color(255, 255, 255),
        ["icon"] = Color(255, 255, 255),
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