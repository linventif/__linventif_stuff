function LRespW(w)
    return ScrW() * (w / 1920)
end

function LRespH(h)
    return ScrH() * (h / 1080)
end

function LResp(w, h)
    return LRespW(w), LRespH(h)
end

function LinvLib.LNotif(msg, enum, time, addon)
    local enums = {
        ["generic"] = 0,
        ["error"] = 1,
        ["refresh"] = 2,
        ["info"] = 3,
        ["cut"] = 4
    }
    notification.AddLegacy(msg, enums[enum], time)
    print(addon .. " : " .. msg)
end

function LinvLib.CreateImgurMaterials(materials, addon_var, folder, name)
    if !file.Exists(folder, "DATA") then
        file.CreateDir(folder)
    end

    local function getMatFromUrl(url, id)
        materials[id] = Material("nil")

        if file.Exists(folder .. "/" .. id .. ".png", "DATA") then
            addon_var[id] = Material("../data/" .. folder .. "/" .. id .. ".png", "noclamp smooth")
            return
        end

        http.Fetch(url, function(body)
            file.Write(folder .. "/" .. id .. ".png", body)
            addon_var[id] = Material("../data/" .. folder .. "/" .. id .. ".png", "noclamp smooth")
            print("| " .. name .. " | Image Downloaded | " .. id .. ".png")
        end)
    end

    for k, v in pairs(materials) do
        getMatFromUrl("https://i.imgur.com/" .. v .. ".png", k)
    end
end