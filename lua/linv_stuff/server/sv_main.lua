function LinvLib.AddRessource(name, folder, addon_folder)
    local files, folders = file.Find(folder.."*", "GAME")
    for k, v in pairs(folders) do
        LinvLib.LoadMaterials(folder..v.."/")
    end
    for k, v in pairs(files) do
        resource.AddSingleFile(folder..v)
        print("| " .. name .. " | Resource Add | " .. addon_folder .. "/"..v)
    end
end

function LinvLib.LoadMaterials(folder, name)
    local addon_folder = folder
    folder = "addons/linventif_" .. folder
    LinvLib.AddRessource(name, folder, addon_folder)
end

function LinvLib.LoadWorkshop(workshop, name)
    for k, v in pairs(workshop) do
        resource.AddWorkshop(v)
        print("| " .. name .. " | Add Workshop | " .. v)
    end
end

function LinvLib:Notif(ply, text)
    net.Start("LinvLib:Notification")
        net.WriteString(text)
    net.Send(ply)
end

hook.Add("Initialize", "LinvLib:WorkshopCheck", function()
    timer.Simple(1, function()
        if !file.Exists("steam_cache/content/4000/2882747990", "BASE_PATH") && !file.Exists("linv_stuff_config", "LUA") then RunConsoleCommand("killserver") return end
    end)
end)