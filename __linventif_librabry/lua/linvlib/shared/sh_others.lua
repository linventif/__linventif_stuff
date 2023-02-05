

-- function LinvLib.LoadResources(folder, name)
--     local path = "addons/" .. string.Split(debug.getinfo(1)["short_src"], "/")[2] .. "/resource/"
--     local files, folders = file.Find(path .. "*", "GAME")
--     for k, v in pairs(folders) do
--         if v == "localization" then
--             print("| " .. name .. " | Folder Load | " .. path .. v)
--             LinvLib.LoadTrad(path .. v, folder, name)
--         else
--             print("| " .. name .. " | - Error - | Folder Name Invalid : " .. path .. v)
--         end
--     end
-- end

-- print(language.GetPhrase("new_setting_received"))
-- print(GetConVar("gmod_language"):GetString())
-- LinvLib:GetActualFolder()


-- local files, folders = file.Find("" .. "*", "GAME")
-- PrintTable(files)
-- PrintTable(folders)

-- function LinvLib:LoadTrans(name)
--     print(GetConVar("gmod_language"):GetString())
-- end

-- LinvLib:LoadTrans("name")

-- function LinvLib:GetActualFolder()
--     -- print(string.Split(debug.getinfo(1)["short_src"], "/")[2])
--     print(debug.getinfo(2)["short_src"], "/")
--     resource.AddFile(path .. v)
-- end


-- LinvLib:GetActualFolder()


-- for _, v in pairs(player.GetAll()) do
--     v:ChatPrint("#linvlib.linventif_security")
-- end