// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                 DON'T TOUCH THIS                   //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //
if CLIENT then return end

function LinvLib:LoadSettings(path, new_data, version, addon, server_only)
    if file.Exists("linventif/linventif_stuff/" .. path .. ".json", "DATA") then
        local data = util.JSONToTable(file.Read("linventif/linventif_stuff/" .. path .. ".json", "DATA"))
        if data.version < version then
            data.config = table.Merge(new_data, data.config)
            data.version = version
            LinvLib:SaveSettings(path, new_data, version, addon, server_only)
        end
        return data.config
    else
        LinvLib:SaveSettings(path, new_data, version, addon, server_only)
        return new_data
    end
end

if LinvLib.ServerConfig.InGameSettings then
    LinvLib.ServerConfig = LinvLib:LoadSettings("linvlib_server_settings", LinvLib.ServerConfig, LinvLib.Info.version, "LinvLib", true)
end

if LinvLib.Config.InGameSettings then
    LinvLib.Config = LinvLib:LoadSettings("linvlib_settings", LinvLib.Config, LinvLib.Info.version, "LinvLib")
end