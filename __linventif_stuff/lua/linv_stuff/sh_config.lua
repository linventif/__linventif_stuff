// -- // -- // -- // -- // -- // -- // -- // -- // -- //
// Please don't use a static version of this addon
// Please use the workshop version : https://steamcommunity.com/sharedfiles/filedetails/?id=2882747990
// If you don't use the workshop version, you will not receive any update and you will not be able to use new features or addons I will create.
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.Config.InGameSettings = true // Put to false if you want to change the configuration in this file

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                Appearance Settings                 //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

// Panel
LinvLib.Config.Theme = "linventif" // Theme (linventif - dark - grey - light) you can add your own theme in cl_theme.lua
LinvLib.Config.Rounded = 8 // Rounded (px 0 to disable)
LinvLib.Config.ShowSlider = true // Show Slider (true - false)

// Border
LinvLib.Config.Border = 0 // Border (px 0 to disable)
LinvLib.Config.CrossBorder = 0 // Cross Length (px) (0 to disable) (if < 1 it will be a percentage of the screen)

// Money Settings
LinvLib.Config.MoneySymbol = "€" // Money Symbol
LinvLib.Config.MoneySymbolPosition = "After" // Money Symbol Position (before - after)
LinvLib.Config.MoneySymbolSeparator = " " // Money Symbol between the number

// NPC Settings
LinvLib.Config.ShowName = true // Show NPC Name (true - false)

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                  Monitor Settings                  //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

// Monitor Settings
LinvLib.Config.MonitorShowEveryJoin = false // Monitor Show At Every Connection (true - false)
LinvLib.Config.MonitorShowIfNewUpdate = true // Monitor Show If New Update (true - false)
LinvLib.Config.MonitorShowIfNewAddon = true // Monitor Show If New Addon Detected (true - false)

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                 Security Settings                  //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

// Permission Settings
LinvLib.Config.SuperAdminGroups = { // Super Admin Group
    ["superadmin"] = true,
}
LinvLib.Config.AdminGroups = { // Admin Group
    ["superadmin"] = true,
    ["admin"] = true,
    ["moderator"] = true,
    ["helper"] = true,
    ["autre"] = true,
}

// Linventif Security Settings
LinvLib.Config.GlobalBan = true // Global Ban (true - false)

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                  ADVANCED SETTINGS                 //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.Config.DebugMode = false // Debug (true - false)

LinvLib.Config.ForceLanguage = false // Force Language (false = auto detect, true = force to use the language in sh_language.lua)
LinvLib.Config.ForceMaterial = false // Force Redownload Material (true - false) (if you have a problem with the material, put it to true)

LinvLib.Config.MonitorCommands = { // Commands to open the monitor
    ["!monitor"] = true,
    ["/monitor"] = true,
    ["!moniteur"] = true,
    ["/moniteur"] = true
}

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                FEATURE IN DEVELOPMENT              //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

// Linventif Security Settings
LinvLib.Config.PlayerTrustFactor = true // Player Trust Factor (true - false)
LinvLib.Config.MinPlayerTrustFactor = 50 // Min Player Trust Factor (0 to disable)

// Commands
LinvLib.Config.AdminCommands = { // Admin Commands to open the admin menu
    ["!admin_menu"] = true,
    ["/admin_menu"] = true,
    ["!staff_menu"] = true,
    ["/staff_menu"] = true,
}

// -- // -- // -- // -- // -- // -- // -- // -- // -- //
//                                                    //
//                 RETRO-COMPATIBILITY                //
//                                                    //
// -- // -- // -- // -- // -- // -- // -- // -- // -- //

LinvLib.Config.Language = "english" // Language (english - french)
LinvLib.Config.Blur = false // Use Blur (true - false)
LinvLib.Config.Compatibility = { // Compatibility Settings (after the update run linvlib_refresh in the console server)
    ["one_hud"] = false,
    ["sentro_context"] = true,
}
LinvLib.Config.MonitorGroup = { // The group that can see the monitor
    ["superadmin"] = true,
    ["fondateur"] = true,
    ["fonda"] = true,
    ["owner"] = true
}