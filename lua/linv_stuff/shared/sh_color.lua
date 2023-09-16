function LinvLib.HexColor(hex)
    local rhex = hex:sub(1,2)
    local ghex = hex:sub(3,4)
    local bhex = hex:sub(5,6)
    local r = tonumber(rhex, 16) / 255
    local g = tonumber(ghex, 16) / 255
    local b = tonumber(bhex, 16) / 255
    return Color(r,g,b)
end