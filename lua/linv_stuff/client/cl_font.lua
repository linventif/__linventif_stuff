local function RespW(x)
    return ScrW() * (x / 1920)
end

surface.CreateFont("LinvFontRobo100", {
    font = "Roboto",
    size = RespW(100),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontRobo50", {
    font = "Roboto",
    size = RespW(50),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontRobo40", {
    font = "Roboto",
    size = RespW(40),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontRobo35", {
    font = "Roboto",
    size = RespW(35),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontRobo30", {
    font = "Roboto",
    size = RespW(30),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontRobo25", {
    font = "Roboto",
    size = RespW(25),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontRobo20", {
    font = "Roboto",
    size = RespW(20),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontRobo15", {
    font = "Roboto",
    size = RespW(15),
    weight = 500,
    antialias = true,
    shadow = false
})

surface.CreateFont("LinvFontResp01", {
    font = "Roboto",
    extended = false,
    size = ScrH()*0.12,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})