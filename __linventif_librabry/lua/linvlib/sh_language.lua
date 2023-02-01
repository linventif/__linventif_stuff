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
    }
}

// -- // -- // -- // -- // -- // -- // -- //
// DO NOT EDIT BELOW THIS LINE
// -- // -- // -- // -- // -- // -- // -- //

function LinvLib:GetTrad(id)
    if languages[LinvLib.Config.Language] && languages[LinvLib.Config.Language][id] then
        return languages[LinvLib.Config.Language][id]
    else
        return id
    end
end