// -- // -- // -- // -- // -- // -- // -- //
//                                        //
//          Informations & Help           //
//                                        //
// -- // -- // -- // -- // -- // -- // -- //
//
// ## Before editing this file
// If you want to change the configuration of the library in this file
// you need to put the variable LinvLib.Config.InGameSettings to false
//
// ## Language
// Language are auto detected, if you want to force the language you can
// put the variable LinvLib.Config.ForceLanguage to true and change the
// variable LinvLib.Config.Language to the language you want the
// language are in the file sh_language.lua
//
// ## Need Help ?
// Join our discord : https://discord.gg/EkVPk9y
//
// -- // -- // -- // -- // -- // -- // -- //

LinvLib.Config.InGameSettings = true // Put to false if you want to change the configuration in this file

// -- // -- // -- // -- // -- // -- // -- //
//                                        //
//            Global Settings             //
//                                        //
// -- // -- // -- // -- // -- // -- // -- //

// Customization / Appearance Settings
LinvLib.Config.Theme = "linventif" // Theme (linventif - dark - grey - light) you can add your own theme in cl_theme.lua
LinvLib.Config.Rounded = 8 // Rounded (px 0 to disable)
LinvLib.Config.Border = 0 // Border (px 0 to disable)
LinvLib.Config.CrossBorder = 0 // Cross Length (px) (0 to disable) (if < 1 it will be a percentage of the screen)

// Admin Settings
LinvLib.Config.AdminGroups = { // Admin Group
    ["superadmin"] = true,
    ["admin"] = true,
    ["moderator"] = true,
    ["helper"] = true,
}

// -- // -- // -- // -- // -- // -- // -- //
//                                        //
//       Linventif Library Settings       //
//                                        //
// -- // -- // -- // -- // -- // -- // -- //

// General Settings
LinvLib.Config.Compatibility = { // Compatibility Settings (after the update run linvlib_refresh in the console server)
    ["one_hud"] = false,
    ["sentro_context"] = true,
}

// Monitor Settings
LinvLib.Config.MonitorShowEveryJoin = true // Monitor Show At Every Connection (true - false)
LinvLib.Config.MonitorShowIfNewUpdate = true // Monitor Show If New Update (true - false)
LinvLib.Config.MonitorShowIfNewAddon = true // Monitor Show If New Addon Detected (true - false)
LinvLib.Config.MonitorGroup = { // The group that can see the monitor
    ["superadmin"] = true,
    ["fondateur"] = true,
    ["fonda"] = true,
    ["owner"] = true
}

// Linventif Security Settings
LinvLib.Config.GlobalBan = true // Global Ban (true - false)
LinvLib.Config.PlayerTrustFactor = true // Player Trust Factor (true - false)
LinvLib.Config.MinPlayerTrustFactor = 50 // Min Player Trust Factor (0 to disable)

// -- // -- // -- // -- // -- // -- // -- //
//                                        //
//            ADVANCED SETTINGS           //
//                                        //
// -- // -- // -- // -- // -- // -- // -- //

LinvLib.Config.DebugMode = false // Debug (true - false)
LinvLib.Config.ForceLanguage = false // Force Language (false = auto detect, true = force to use the language in sh_language.lua)
LinvLib.Config.ForceMaterial = false // Force Redownload Material (true - false) (if you have a problem with the material, put it to true)
LinvLib.Config.MonitorCommands = { // Monitor Commands to open the monitor
    ["!monitor"] = true,
    ["/monitor"] = true,
    ["!moniteur"] = true,
    ["/moniteur"] = true
}
LinvLib.Config.AdminCommands = { // Admin Commands to open the admin menu
    ["!admin_menu"] = true,
    ["/admin_menu"] = true,
    ["!staff_menu"] = true,
    ["/staff_menu"] = true,
}

// -- // -- // -- // -- // -- // -- // -- //
//                                        //
//           RETRO-COMPATIBILITY          //
//                                        //
// -- // -- // -- // -- // -- // -- // -- //

LinvLib.Config.Language = "english" // Language (english - french)