local ImageCache = {}

function LinvLib.CreateImgurMaterials(materials, addon_var, folder, name)
    if !file.Exists(folder, "DATA") then
        file.CreateDir(folder)
    end

    local function getMatFromUrl(url, id)
        materials[id] = Material("nil")

        if file.Exists(folder .. "/" .. id .. ".png", "DATA") && !LinvLib.Config.ForceMaterial then
            addon_var[id] = Material("../data/" .. folder .. "/" .. id .. ".png", "noclamp smooth")
            print("| " .. name .. " | Image Loaded | " .. id .. ".png")
            return
        end

        http.Fetch(url, function(body)
            file.Write(folder .. "/" .. id .. ".png", body)
            addon_var[id] = Material("../data/" .. folder .. "/" .. id .. ".png", "noclamp smooth")
            ImageCache[table.Count(ImageCache) + 1] = {
                ["folder"] = folder,
                ["addon_var"] = addon_var,
                ["id"] = id
            }
            print("| " .. name .. " | Image Downloaded | " .. id .. ".png")
        end)
    end

    for k, v in pairs(materials) do
        getMatFromUrl("https://i.imgur.com/" .. v .. ".png", k)
    end
end

function LinvLib:RedowloadMaterials()
    for k, v in pairs(ImageCache) do
        v.addon_var[v.id] = Material("../data/" .. v.folder .. "/" .. v.id .. ".png", "noclamp smooth")
        print("| " .. "v.name" .. " | Image Redownloaded | " .. v.id .. ".png")
    end
end

concommand.Add("linvlib_redownload_materials", function()
    LinvLib:RedowloadMaterials()
end)

concommand.Add("linvlib_show_materials", function()
    PrintTable(ImageCache)
end)

// -- // -- // -- // -- // -- // -- // -- //

LinvLib.Materials = {}

local imgurID = {
    ["edit"] = "4AbS7pt",
    ["valid"] = "bXNeR1o",
    ["cancel"] = "RhVuiv3",
    ["doc"] = "0oBmKXM",
    ["color-mode"] = "USBYYTc",
    ["npc-medic"] = "bArOqXU",
    ["one-hud"] = "tru08vx",
    ["friends-system"] = "ODwqkTL",
    ["new-gen-reroll"] = "6l6D2j0",
    ["unknow"] = "Y1vYS2L",
    ["linventif-library"] = "TrKSTE3",
    ["close_test"] = "hb7oCvK",
    ["check"] = "FAmDUm7",
    ["cross"] = "cQ0mMqv",
    ["invite"] = "q7rzNKH",
    ["earth"] = "xwJM5KZ",
    ["map5"] = "ggtZgtZ",
    ["cursor2"] = "dnna6rx"
}

LinvLib.CreateImgurMaterials(imgurID, LinvLib.Materials, "linventif/linvlib/material", "Linventif Library")