// -- // -- // -- // -- // -- // -- // -- //
// THIS FILE IS FOR DEVELOPER ONLY
// TO ADD CUSTOM LANGUAGE USE RESOURCE LOCALIZATION
// THIS TRANSLATION IS ONLY FOR DEBUG MODE AND FOR FORCED LANGUAGE
// -- // -- // -- // -- // -- // -- // -- //

local languages = {
    ["english"] = {
        ["not_allow_cmd"] = "You are not allowed to use this command!",
        ["not_perm"] = "You don't have the permission to do this!",
        ["save_setting"] = "Settings Sucessfully Saved.",
        ["new_setting_received"] = "LinvLib : New Settings Received.",
        ["in_dev"] = "Fonctionality in development.",
        ["invalid_value"] = "Invalid Value",
        ["background"] = "Background",
        ["border"] = "Border",
        ["element"] = "Element",
        ["accent"] = "Accent",
        ["hover"] = "Hover",
        ["text"] = "Text",
        ["icon"] = "Icon",
        ["red"] = "Red",
        ["close"] = "Close",
        ["continue"] = "Continue",
        ["reset"] = "Reset",
        ["customisation"] = "Customisation",
        ["border_size"] = "Border Size",
        ["rounded"] = "Rounded Value",
        ["other"] = "Others",
        ["debug_mode"] = "Debug Mode",
        ["settings"] = "Settings",
        ["global_ban"] = "Global Ban",
        ["linventif_security"] = "Linventif Security",
        ["admin_group"] = "Admin Groups",
        ["admin_ticket"] = "Ticket Admin",
        ["admin_menu_extend"] = "Admin Menu Extended",
        ["admin_menu"] = "Admin Menu",
        ["admin_suite"] = "Admin Suite",
        ["show_if_new_addon"] = "Show if new addon is detected",
        ["show_if_need_update"] = "Show if addon need update",
        ["show_at_every_join"] = "Show at every join",
        ["monitor"] = "Monitor",
        ["theme"] = "Theme",
        ["compatible_addon"] = "Compatible Addon",
        ["language"] = "Language",
        ["general"] = "General",
        ["ply_trust_factor"] = "Player Trust Factor",
        ["ply_trust_factor_min"] = "Minimum Acceptable Trust Factor",
        ["language_add"] = "To add custom language contact me on discord !",
        ["theme_add"] = "To add custom theme contact me on discord !",
        ["help"] = "Help",
        ["install_addon"] = "Addons Installed : ",
        ["addon_need_update"] = "Addon Need Update : ",
        ["linventif_lib"] = "Linventif's Stuff",
        ["new_addon_detected"] = "New Addon Detected : ",
        ["new_addon"] = "New Addon",
        ["name"] = "Name",
        ["your_version"] = "Your Version",
        ["last_version"] = "Last Version",
        ["link"] = "Link",
        ["update"] = "Update",
        ["open"] = "Open",
        ["force_redownload_images"] = "Force the Download of Image",
        ["lang_cant_changed"] = "Language is Automatic and can't be changed in game.",
        ["cross_border_instruction"] = "If between 0 and 1 = percent else size in pixel !",
        ["cross_border"] = "Cross Border Size",
        ["money_symbol_position"] = "Money Symbol to the Left",
        ["money_symbol_separator"] = "Money Symbol Separator",
        ["money_symbol"] = "Money Symbol",
        ["money_settings"] = "Money Settings"
    }
}

function LinvLib:GetDebugTrad(id)
    return languages["english"][id] || id
end

function LinvLib:GetTrad(id)
    if !LinvLib.Config.DebugMode && !LinvLib.Config.ForceLanguage then
        if CLIENT then
            return language.GetPhrase(LinvLib.folder .. ".".. id)
        else
            return "#" .. id
        end
    else
        return LinvLib:GetDebugTrad(id)
    end
end