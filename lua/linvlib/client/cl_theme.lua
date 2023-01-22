local themes = {
    ["linventif"] = {
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
        return Color(255, 255, 255)
    end
end

LinvLib.Materials = {}

local imgurID = {
    ["edit"] = "4AbS7pt",
    ["valid"] = "bXNeR1o",
    ["cancel"] = "RhVuiv3",
}

LinvLib.CreateImgurMaterials(imgurID, LinvLib.Materials, "linventif/linvlib/material", "Linventif Librairy")